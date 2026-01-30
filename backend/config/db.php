<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
class Database {
    private $host = "localhost";      // MySQL host
    private $db_name = "assets-manage";  // Database name
    private $username = "root";       // MySQL username
    private $password = "";           // MySQL password
    public $conn;

    // Get database connection
    public function getConnection() {
        $this->conn = null;

        try {
            $this->conn = new PDO(
                "mysql:host=".$this->host.";dbname=".$this->db_name,
                $this->username,
                $this->password
            );
            $this->conn->exec("set names utf8");
        } catch(PDOException $exception) {
            echo "Database connection error: " . $exception->getMessage();
            exit;
        }

        return $this->conn;
    }
}
?>