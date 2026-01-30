# Asset Management System
Asset Management System is a web-based platform to manage assets, inventory, and purchase requests for an organization. It provides a dashboard to track requests, view detailed request items, manage inventory, and monitor asset status. The system is designed for easy use by staff and admins.

# Live Demo
If hosted locally, the system can be accessed via: http://localhost:3000/

#Tech Stack
Frontend: React, HTML, CSS, JS
Backend: PHP
Database: MySQL
Server: XAMPP (Apache + MySQL)
Other: Axios for API calls

# Features
- Dashboard for asset requests and inventory
- Request tracking with detailed item view
- Status updates for requests#
- Inventory management with asset status

# How to Set Up
## 1. Install Prerequisites
- XAMPP for Apache and MySQL (or any local LAMP stack)
- Node.js & npm for React frontend

## 2. Database Setup
> Open phpMyAdmin or MySQL CLI
> Create a new database:
```bash
CREATE DATABASE `assets_manage`;
```
> Import the *assets-manage.sql*
> Ensure credentials match the backend config (backend/config.php):
```bash
// EXAMPLE
$host = "localhost";
$db   = "assets_manage";
$user = "root";
$pass = "";
```
## 3. Backend (PHP)
> Place the backend folder in your htdocs directory:
```bash
C:\xampp\htdocs\assets-management\backend
```
> Ensure Apache is running in XAMPP

### 4. Frontend (React)
> Navigate to the frontend folder:
```bash
cd C:\xampp\htdocs\assets-management\frontend
```
> Install dependencies (optional):
```bash
npm install
```
> Start the development server:
```bash
npm start
```
The frontend should open automatically at http://localhost:3000

# Usage
- Requests Tab: View all asset requests, filter by status, click to view details, create new request
- Inventory Tab: Track inventory, see inventory details, and inventory status
- Request Details: Shows staff info, item details, supplier info, and status history
- Inventory Details: Shows asset info, assigned staff, images, and associated request info

# Notes
Default credentials for MySQL with XAMPP: root / empty password
React frontend runs on port 3000; backend PHP runs on localhost (XAMPP default: port 80)
All sample images use placeholder.png

# Future Improvements
Add authentication for staff and admin accounts
Improve reporting dashboards
Add inventory management

# License
This project is for educational/demo purposes only. Contact the author for reuse or modifications.
