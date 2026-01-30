<?php
require_once __DIR__ . '/../models/Inventory.php';

class InventoryController {
    private $model;

    public function __construct() {
        $this->model = new Inventory();
    }

    // Return all inventory items
    public function index() {
        $data = $this->model->getAll();
        header('Content-Type: application/json');
        echo json_encode($data);
    }

    // Return a single inventory item by ID
    public function show($id) {
        $data = $this->model->getById($id);
        if ($data) {
            header('Content-Type: application/json');
            echo json_encode($data);
        } else {
            header('Content-Type: application/json', true, 404);
            echo json_encode(['error' => 'Inventory item not found']);
        }
    }
}
?>