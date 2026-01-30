<?php
require_once __DIR__ . '/../config/db.php';

class Supplier {
    private $conn;
    private $table_name = "Suppliers";

    public function __construct() {
        $database = new Database();
        $this->conn = $database->getConnection();
    }

    // Get all suppliers
    public function getAll() {
        $query = "SELECT * FROM " . $this->table_name;
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Get supplier by ID
    public function getById($supplierID) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE supplierID = :supplierID LIMIT 1";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':supplierID', $supplierID, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}
?>