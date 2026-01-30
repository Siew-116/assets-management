<?php
require_once __DIR__ . '/../config/db.php';

class Inventory {
    private $conn;
    private $table_name = "Inventory";

    public function __construct() {
        $database = new Database();
        $this->conn = $database->getConnection();
    }

    // Get all inventory items
    public function getAll() {
        $query = "
        SELECT i.*, a.asset_name, a.category AS asset_category, s.staff_name
        FROM Inventory i
        LEFT JOIN Assets a ON i.assetID = a.assetID
        LEFT JOIN Staffs s ON i.assignTo = s.staffID
        ";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Get inventory by ID
    public function getById($inventoryID) {
        $query = "
        SELECT i.*, a.asset_name, a.category AS asset_category, s.staff_name
        FROM Inventory i
        LEFT JOIN Assets a ON i.assetID = a.assetID
        LEFT JOIN Staffs s ON i.assignTo = s.staffID
        WHERE i.inventoryID = :inventoryID
        LIMIT 1
        ";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':inventoryID', $inventoryID, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}
?>