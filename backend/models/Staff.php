<?php
require_once __DIR__ . '/../config/db.php';
class Staff {
    private $conn;
    private $table_name = "Staffs";

    public function __construct() {
        $database = new Database();
        $this->conn = $database->getConnection();
    }

    // Get all staff
    public function getAll() {
        $query = "SELECT * FROM " . $this->table_name;
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Get staff by ID
    public function getById($staffID) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE staffID = :staffID LIMIT 1";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':staffID', $staffID, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function exists($staffID) {
        $sql = "SELECT COUNT(*) FROM Staffs WHERE staffID = :staffID";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':staffID', $staffID);
        $stmt->execute();
        return $stmt->fetchColumn() > 0;
    }


}
?>