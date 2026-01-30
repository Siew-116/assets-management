<?php
require_once __DIR__ . '/../config/db.php';
class RequestItem {
    private $conn;
    private $table = "Request_items";

    public function __construct() {
        $database = new Database();
        $this->conn = $database->getConnection();
    }

    // Create new request item
    public function create($data) {
        // Ensure nullable/default fields
        $data['supplierID'] = $data['supplierID'] ?? null;
        $data['ordered_qty'] = $data['ordered_qty'] ?? 0;
        $data['received_qty'] = 0;
        $data['accepted_qty'] = 0;
        $data['rejected_qty'] = 0;

        $sql = "
            INSERT INTO Request_items
            (requestID, assetID, supplierID, unit_price, total_price,
             requested_qty, ordered_qty, received_qty, accepted_qty, rejected_qty)
            VALUES
            (:requestID, :assetID, :supplierID, :unit_price, :total_price,
             :requested_qty, :ordered_qty, :received_qty, :accepted_qty, :rejected_qty)
        ";

        $stmt = $this->conn->prepare($sql);
        return $stmt->execute($data);
    }


    // Get respective request
    public function getByRequestID($requestID) {
        $sql = "
        SELECT 
            ri.*,
            a.asset_name,
            a.category,
            s.supplier_name
        FROM Request_items ri
        JOIN Assets a ON ri.assetID = a.assetID
        JOIN Suppliers s ON ri.supplierID = s.supplierID
        WHERE ri.requestID = ?
        ";

        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$requestID]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Get full details
    public function getFullDetailsByRequestID($requestID) {
    $sql = "
         SELECT 
            ri.request_itemID,
            ri.requestID,
            ri.assetID,
            ri.supplierID,
            ri.unit_price,
            ri.total_price,
            ri.requested_qty,
            ri.ordered_qty,
            ri.received_qty,
            ri.accepted_qty,
            ri.rejected_qty,

            a.asset_name,
            a.description,
            a.category AS asset_category,

            i.serial_number,
            i.location,

            s.supplier_name,
            s.company,
            s.phone AS supplier_phone,
            s.email AS supplier_email,

            r.remarks
        FROM Request_items ri
        LEFT JOIN Requests r 
            ON r.requestID = ri.requestID
        LEFT JOIN Assets a 
            ON ri.assetID = a.assetID
        LEFT JOIN Inventory i 
            ON i.assetID = ri.assetID
        LEFT JOIN Suppliers s 
            ON ri.supplierID = s.supplierID
        WHERE ri.requestID = ?
    ";

    $stmt = $this->conn->prepare($sql);
    $stmt->execute([$requestID]);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}
}