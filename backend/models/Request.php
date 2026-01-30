<?php
require_once __DIR__ . '/../config/db.php';
class Request {
    private $conn;
    private $table = "Requests";

    // Transaction helpers
    public function beginTransaction() {
        $this->conn->beginTransaction();
    }

    public function commit() {
        $this->conn->commit();
    }

    public function rollBack() {
        $this->conn->rollBack();
    }

    public function __construct() {
        $database = new Database();
        $this->conn = $database->getConnection();
    }

    // Create new request
    public function create($staffID, $remarks = '') {
        $sql = "INSERT INTO Requests (staffID, status, created_at, remarks)
                VALUES (:staffID, 'Pending', NOW(), :remarks)";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':staffID', $staffID);
        $stmt->bindParam(':remarks', $remarks);
        $stmt->execute();

        return $this->conn->lastInsertId(); // return requestID
    }

        
    // Get request list
    public function getAll() {
        $sql = "
        SELECT 
            r.requestID,
            r.status,
            r.created_at,
            r.approved_at,
            r.ordered_at,
            r.completed_at,
            r.remarks,
            s.staff_name,
            a.asset_name,
            COUNT(ri.request_itemID) AS total_items,
            SUM(ri.total_price) AS total_amount
        FROM Requests r
        LEFT JOIN Staffs s ON r.staffID = s.staffID
        LEFT JOIN Request_items ri ON r.requestID = ri.requestID
        LEFT JOIN Assets a ON ri.assetID = a.assetID
        GROUP BY r.requestID
        ORDER BY r.created_at DESC
        ";

        $stmt = $this->conn->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    

    public function updateStatus($requestID, $status) {
        $fields = "status = :status";

        if ($status === "Approved") $fields .= ", approved_at = NOW()";
        if ($status === "Ordered") $fields .= ", ordered_at = NOW()";
        if ($status === "Completed") $fields .= ", completed_at = NOW()";

        $sql = "UPDATE Requests SET $fields WHERE requestID = :requestID";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':status', $status);
        $stmt->bindParam(':requestID', $requestID);
        return $stmt->execute();
    }

    // Get specific record
    public function getByID($requestID) {
        $sql = "
            SELECT r.*, s.staff_name, s.department, s.position, s.phone AS staff_phone, s.email AS staff_email
            FROM Requests r
            LEFT JOIN Staffs s ON r.staffID = s.staffID
            WHERE r.requestID = ?
            LIMIT 1
        ";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$requestID]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function getRequestIDByAsset($assetID) {
        $sql = "
            SELECT r.requestID
            FROM Request_items ri
            INNER JOIN Requests r ON ri.requestID = r.requestID
            WHERE ri.assetID = :assetID
            ORDER BY r.created_at DESC
            LIMIT 1
        ";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':assetID', $assetID);
        $stmt->execute();
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        return $row['requestID'] ?? null;
    }
}