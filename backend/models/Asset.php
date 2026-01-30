<?php
require_once __DIR__ . '/../config/db.php';

class Asset {
    private $conn;
    private $table_name = "Assets";

    public function __construct() {
        $database = new Database();
        $this->conn = $database->getConnection();
    }


    // Create new asset
    public function create($data) {
        $sql = "INSERT INTO Assets (asset_name, description, category) 
                VALUES (:asset_name, :description, :category)";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':asset_name', $data['asset_name']);
        $stmt->bindParam(':description', $data['description']);
        $stmt->bindParam(':category', $data['category']);
        $stmt->execute();

        return $this->conn->lastInsertId(); // return assetID
    }


    // Get all assets
    public function getAll() {
        $query = "SELECT * FROM " . $this->table_name;
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Get asset by ID
    public function getById($assetID) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE assetID = :assetID LIMIT 1";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':assetID', $assetID, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}
?>