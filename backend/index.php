<?php
// CORS headers for React
header("Access-Control-Allow-Origin: http://localhost:3000");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') exit(0);

// API ROUTER
require_once 'controllers/StaffController.php';
require_once 'controllers/RequestController.php';
require_once 'controllers/InventoryController.php';

$staffController = new StaffController();
$requestController = new RequestController();
$inventoryController = new InventoryController();

// Get query parameters
$resource = $_GET['resource'] ?? null;
$action = $_GET['action'] ?? null;

header('Content-Type: application/json');

if ($resource === 'staff') {
    if ($action === "list") {
        $staffController->index();
    } elseif ($action === "show" && isset($_GET['id'])) {
        $staffController->show($_GET['id']);
    } else {
        echo json_encode(["error" => "Invalid staff action"]);
    }
} elseif ($resource === 'request') {
    if ($action === "list") {
        $requestController->listRequests();
    } elseif ($action === "getDetail" && isset($_GET['requestID'])) {
        $requestController->getRequestDetail();
    } elseif ($action === "getByAsset" && isset($_GET['assetID'])) {
        $requestController->getRequestByAsset($_GET['assetID']);
    } elseif ($action === "create") {
        $requestController->createRequest();
    } elseif ($action === "createRequestWithNewAsset") {
        $requestController->createRequestWithNewAsset();
    } else {
        echo json_encode(["error" => "Invalid request action"]);
    }
} elseif ($resource === 'inventory') {
    if ($action === "list") {
        $inventoryController->index();
    } elseif ($action === "show" && isset($_GET['id'])) {
        $inventoryController->show($_GET['id']);
    } else {
        echo json_encode(["error" => "Invalid inventory action"]);
    }
} else {
    echo json_encode(["message" => "API is running"]);
}
?>