<?php
require_once 'models/Staff.php';

class StaffController {

    public function index() {
        $staffModel = new Staff();
        $staffs = $staffModel->getAll();
        header('Content-Type: application/json');
        echo json_encode($staffs);
    }

    public function show($id) {
        $staffModel = new Staff();
        $staff = $staffModel->getById($id);

        header('Content-Type: application/json');
        echo json_encode($staff);
    }
}
?>