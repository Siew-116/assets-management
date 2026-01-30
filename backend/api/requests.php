<?php
header("Content-Type: application/json");

require_once '../controllers/RequestController.php';

$controller = new RequestController();
$action = $_GET['action'] ?? '';

switch ($action) {
    case 'list_requests':
        $controller->listRequests();
        break;

    case 'get_items':
        $controller->getRequestItems();
        break;

    case 'create':
        $controller->createRequest();
        break;

    default:
        echo json_encode(["error" => "Invalid action"]);
}