<?php
require_once __DIR__ . '/../models/Request.php';
require_once __DIR__ . '/../models/RequestItem.php';
require_once __DIR__ . '/../models/Staff.php';
require_once __DIR__ . '/../models/Asset.php';    
require_once __DIR__ . '/../models/Supplier.php';
require_once __DIR__ . '/../models/Inventory.php';
class RequestController {
    private $requestModel;
    private $itemModel;

    public function __construct() {
        $this->requestModel = new Request();
        $this->itemModel = new RequestItem();
    }

    public function listRequests() {
        echo json_encode($this->requestModel->getAll());
    }

    public function getRequestItems() {
        if (!isset($_GET['requestID'])) {
            echo json_encode(["error" => "requestID required"]);
            return;
        }

        echo json_encode(
            $this->itemModel->getByRequestID($_GET['requestID'])
        );
    }

    // Create new request
    public function createRequest() {
        $data = json_decode(file_get_contents("php://input"), true);

        $requestID = $this->requestModel->create(
            $data['staffID'],
            $data['remarks'] ?? ''
        );

        foreach ($data['items'] as $item) {
            $item['requestID'] = $requestID;
            $this->itemModel->create($item);
        }

        echo json_encode([
            "status" => "success",
            "requestID" => $requestID
        ]);
    }

    // Get request details
    public function getRequestDetail() {
        if (!isset($_GET['requestID'])) {
            echo json_encode(["error" => "requestID required"]);
            return;
        }

        $requestID = $_GET['requestID'];

        // 1. Get request + staff info
        $request = $this->requestModel->getByID($requestID);
        if (!$request) {
            echo json_encode(["error" => "Request not found"]);
            return;
        }

        // 2. Get items with asset, supplier, inventory info
        $items = $this->itemModel->getFullDetailsByRequestID($requestID);
        // This method in RequestItem model will join with Assets, Inventory, Suppliers

        // 3. Build status history
        $status_history = [];
        if ($request['created_at']) $status_history[] = ['status'=>'Pending', 'date'=>$request['created_at']];
        if ($request['approved_at']) $status_history[] = ['status'=>'Approved', 'date'=>$request['approved_at']];
        if ($request['ordered_at']) $status_history[] = ['status'=>'Ordered', 'date'=>$request['ordered_at']];
        if ($request['completed_at']) $status_history[] = ['status'=>'Completed', 'date'=>$request['completed_at']];

        // 4. Merge
        $request['items'] = $items;
        $request['status_history'] = $status_history;

        echo json_encode($request);
    }

    // Get request ID by asset ID of inventory
    public function getRequestByAsset($assetID) {
        if (!$assetID) {
            echo json_encode(["error" => "AssetID is required"]);
            return;
        }

        // Get the latest request ID for this asset
        $requestID = $this->requestModel->getRequestIDByAsset($assetID);

        if (!$requestID) {
            echo json_encode([]); // no request found
            return;
        }

        // Reuse existing method to get full request details
        $this->getRequestDetailByID($requestID);
    }

    // helper function to fetch full details by requestID
    private function getRequestDetailByID($requestID) {
        $request = $this->requestModel->getByID($requestID);
        if (!$request) {
            echo json_encode(["error" => "Request not found"]);
            return;
        }

        $items = $this->itemModel->getFullDetailsByRequestID($requestID);

        // build status history
        $status_history = [];
        if ($request['created_at']) $status_history[] = ['status'=>'Pending','date'=>$request['created_at']];
        if ($request['approved_at']) $status_history[] = ['status'=>'Approved','date'=>$request['approved_at']];
        if ($request['ordered_at']) $status_history[] = ['status'=>'Ordered','date'=>$request['ordered_at']];
        if ($request['completed_at']) $status_history[] = ['status'=>'Completed','date'=>$request['completed_at']];

        $request['items'] = $items;
        $request['status_history'] = $status_history;

        echo json_encode($request);
    }

    public function createRequestWithNewAsset() {

        try {
            $data = json_decode(file_get_contents("php://input"), true);
            $staffID = $data['staffID'] ?? null;
            $asset_name = $data['asset_name'] ?? null;
            $description = $data['description'] ?? null;
            $category = $data['category'] ?? null;
            $remarks = $data['remarks'] ?? '';
            $unit_price = isset($data['unit_price']) ? floatval($data['unit_price']) : 0;
            $requested_qty = isset($data['requested_qty']) ? intval($data['requested_qty']) : 1;

            // Required fields check
            if (empty($staffID) || empty($asset_name) || empty($category)) {
                echo json_encode([
                    'status' => 'error',
                    'msg' => 'Please fill in Staff ID, Asset Name, and Category.'
                ]);
                exit;
            }

            try {
                $staffModel = new Staff();

                if (!$staffModel->exists($staffID)) {
                    echo json_encode([
                        'status' => 'error',
                        'msg' => 'The staff ID you entered does not exist. Please check and try again.'
                    ]);
                    exit;
                }
            } catch (Exception $e) {
                // Catch DB exceptions
                echo json_encode([
                    'status' => 'error',
                    'msg' => 'Something went wrong while checking staff ID. Please contact support.'
                ]);
                exit;
            }

            $assetModel = new Asset();
            $requestModel = $this->requestModel;
            $itemModel = $this->itemModel;

            // Create Asset
            $assetID = $assetModel->create([
                'asset_name' => $asset_name,
                'description' => $description,
                'category' => $category
            ]);
            if (!$assetID) throw new Exception("Could not create asset. Please try again.");
           
            // Create Request header (status = 'Pending')
            $requestID = $requestModel->create($staffID, $remarks);
            if (!$requestID) throw new Exception("Could not create request. Please try again.");
          

            // Create Request Item
            $itemData = [
                'requestID' => $requestID,
                'assetID' => $assetID,
                'supplierID' => null,
                'unit_price' => $unit_price,
                'total_price' => $unit_price * $requested_qty,
                'requested_qty' => $requested_qty,
                'ordered_qty' => 0
            ];

            $result = $itemModel->create($itemData);
            if (!$result) throw new Exception("Could not create request item. Please try again.");
         
            echo json_encode([
                'status' => 'success',
                'requestID' => $requestID,
                'assetID' => $assetID
            ]);
     

        } catch (Exception $e) {
            echo json_encode([
                'status' => 'error',
                'msg' => $e->getMessage() 
            ]);
        
            exit;
        }
    }


}