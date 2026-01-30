-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 30, 2026 at 07:40 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `assets-manage`
--

-- --------------------------------------------------------

--
-- Table structure for table `assets`
--

CREATE TABLE `assets` (
  `assetID` int(11) NOT NULL,
  `asset_name` varchar(100) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assets`
--

INSERT INTO `assets` (`assetID`, `asset_name`, `category`, `description`, `created_at`) VALUES
(1, 'Laptop Dell XPS', 'Electronics', 'High-end laptop for office work', '2026-01-01 09:00:00'),
(2, 'Office Chair', 'Furniture', 'Ergonomic chair for staff comfort', '2026-01-02 10:30:00'),
(3, 'Projector Epson', 'Electronics', '1080p projector for meeting rooms', '2026-01-03 14:45:00'),
(4, 'Whiteboard', 'Stationery', 'Magnetic whiteboard for presentations', '2026-01-04 11:15:00'),
(5, 'Printer HP Laser', 'Electronics', 'Laser printer for documents', '2026-01-05 16:20:00'),
(6, 'Filing Cabinet', 'Furniture', '4-drawer metal cabinet', '2026-01-06 09:50:00'),
(7, 'Conference Table', 'Furniture', 'Large table for meeting room', '2026-01-07 13:10:00'),
(8, 'Router TP-Link', 'Electronics', 'Wi-Fi router for office network', '2026-01-08 08:30:00'),
(9, 'Smartphone iPhone', 'Electronics', 'Company-issued phone', '2026-01-09 12:45:00'),
(10, 'Laptop MacBook Pro', 'Electronics', 'Developer laptop for coding projects', '2026-01-10 15:00:00'),
(11, 'Desk Lamp', 'Electronics', 'LED lamp for personal desk lighting', '2026-01-11 09:25:00'),
(12, 'Conference Mic', 'Electronics', 'Microphone for meetings', '2026-01-12 11:40:00'),
(13, 'Bookshelf', 'Furniture', 'Wooden shelf for documents and books', '2026-01-13 10:15:00'),
(14, 'Mouse Logitech', 'Electronics', 'Wireless mouse for office laptops', '2026-01-14 14:50:00'),
(15, 'Keyboard Mechanical', 'Electronics', 'Mechanical keyboard for programmers', '2026-01-15 13:35:00'),
(16, 'Laptop Dell XPS', 'Laptop', 'Dell XPS 13', '2026-01-31 02:11:31'),
(17, 'Office Chair', 'Furniture', 'Standard Office Chair', '2026-01-31 02:11:31'),
(18, 'Projector Epson', 'Electronics', 'Epson Home Projector', '2026-01-31 02:11:31'),
(19, 'Whiteboard', 'Office Supplies', 'Small whiteboard', '2026-01-31 02:11:31'),
(20, 'Printer HP Laser', 'Printer', 'HP LaserJet Pro', '2026-01-31 02:11:31'),
(46, 'Microphone', 'Office use', '', '2026-01-31 02:33:51');

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `inventoryID` int(11) NOT NULL,
  `assetID` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `status` varchar(50) DEFAULT 'Available',
  `serial_number` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `assignTo` int(11) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`inventoryID`, `assetID`, `created_at`, `status`, `serial_number`, `location`, `assignTo`, `img`) VALUES
(32, 1, '2026-01-31 02:21:35', 'AVAILABLE', 'SN001', 'Office 101', 1, 'placeholder.png'),
(33, 2, '2026-01-31 02:21:35', 'IN_USE', 'SN002', 'Office 102', 2, 'placeholder.png'),
(34, 3, '2026-01-31 02:21:35', 'IN_REPAIR', 'SN003', 'Office 103', 3, 'placeholder.png'),
(35, 4, '2026-01-31 02:21:35', 'DISPOSED', 'SN004', 'Office 104', 2, 'placeholder.png'),
(36, 5, '2026-01-31 02:21:35', 'AVAILABLE', 'SN005', 'Office 105', 3, 'placeholder.png'),
(37, 6, '2026-01-31 02:21:35', 'IN_USE', 'SN006', 'Office 106', 1, 'placeholder.png'),
(38, 7, '2026-01-31 02:21:35', 'IN_REPAIR', 'SN007', 'Office 107', 2, 'placeholder.png'),
(39, 8, '2026-01-31 02:21:35', 'DISPOSED', 'SN008', 'Office 108', 3, 'placeholder.png'),
(40, 9, '2026-01-31 02:21:35', 'AVAILABLE', 'SN009', 'Office 109', 2, 'placeholder.png'),
(41, 10, '2026-01-31 02:21:35', 'IN_USE', 'SN010', 'Office 110', 2, 'placeholder.png'),
(42, 11, '2026-01-31 02:21:35', 'IN_REPAIR', 'SN011', 'Office 101', 1, 'placeholder.png'),
(43, 12, '2026-01-31 02:21:35', 'DISPOSED', 'SN012', 'Office 102', 2, 'placeholder.png'),
(44, 13, '2026-01-31 02:21:35', 'AVAILABLE', 'SN013', 'Office 103', 3, 'placeholder.png'),
(45, 14, '2026-01-31 02:21:35', 'IN_USE', 'SN014', 'Office 104', 2, 'placeholder.png'),
(46, 15, '2026-01-31 02:21:35', 'IN_REPAIR', 'SN015', 'Office 105', 3, 'placeholder.png'),
(47, 16, '2026-01-31 02:21:35', 'DISPOSED', 'SN016', 'Office 106', 1, 'placeholder.png'),
(48, 17, '2026-01-31 02:21:35', 'AVAILABLE', 'SN017', 'Office 107', 1, 'placeholder.png'),
(49, 18, '2026-01-31 02:21:35', 'IN_USE', 'SN018', 'Office 108', 2, 'placeholder.png'),
(50, 19, '2026-01-31 02:21:35', 'IN_REPAIR', 'SN019', 'Office 109', 2, 'placeholder.png'),
(51, 20, '2026-01-31 02:21:35', 'DISPOSED', 'SN020', 'Office 110', 1, 'placeholder.png');

-- --------------------------------------------------------

--
-- Table structure for table `requests`
--

CREATE TABLE `requests` (
  `requestID` int(11) NOT NULL,
  `staffID` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `approved_at` datetime DEFAULT NULL,
  `ordered_at` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `remarks` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `requests`
--

INSERT INTO `requests` (`requestID`, `staffID`, `status`, `created_at`, `approved_at`, `ordered_at`, `completed_at`, `remarks`) VALUES
(1, 1, 'Pending', '2026-01-01 09:00:00', NULL, NULL, NULL, 'Request for Laptop Dell XPS'),
(2, 2, 'Approved', '2026-01-02 10:30:00', '2026-01-03 09:00:00', NULL, NULL, 'Request for Office Chair'),
(3, 3, 'Rejected', '2026-01-03 11:00:00', '2026-01-04 08:30:00', NULL, NULL, 'Request for Projector Epson'),
(4, 1, 'Received', '2026-01-04 12:15:00', '2026-01-05 09:00:00', '2026-01-06 10:00:00', NULL, 'Request for Whiteboard'),
(5, 2, 'Returned', '2026-01-05 14:00:00', '2026-01-06 08:30:00', '2026-01-07 09:30:00', NULL, 'Request for Printer HP Laser'),
(6, 3, 'Inspected', '2026-01-06 09:45:00', '2026-01-07 08:00:00', '2026-01-08 10:00:00', NULL, 'Request for Filing Cabinet'),
(7, 2, 'Completed', '2026-01-07 10:00:00', '2026-01-08 09:30:00', '2026-01-09 11:00:00', '2026-01-10 15:00:00', 'Request for Conference Table'),
(8, 2, 'Pending', '2026-01-08 09:20:00', NULL, NULL, NULL, 'Request for Router TP-Link'),
(9, 2, 'Approved', '2026-01-09 11:10:00', '2026-01-10 08:30:00', NULL, NULL, 'Request for Smartphone iPhone'),
(10, 1, 'Rejected', '2026-01-10 12:45:00', '2026-01-11 09:00:00', NULL, NULL, 'Request for Laptop MacBook Pro'),
(11, 1, 'Received', '2026-01-11 14:00:00', '2026-01-12 08:30:00', '2026-01-13 09:30:00', NULL, 'Request for Desk Lamp'),
(12, 2, 'Returned', '2026-01-12 09:00:00', '2026-01-13 08:30:00', '2026-01-14 10:00:00', NULL, 'Request for Conference Mic'),
(13, 3, 'Inspected', '2026-01-13 10:30:00', '2026-01-14 09:00:00', '2026-01-15 10:00:00', NULL, 'Request for Bookshelf'),
(14, 1, 'Completed', '2026-01-14 11:00:00', '2026-01-15 08:45:00', '2026-01-16 09:30:00', '2026-01-17 14:00:00', 'Request for Mouse Logitech'),
(15, 3, 'Pending', '2026-01-15 09:15:00', NULL, NULL, NULL, 'Request for Keyboard Mechanical'),
(16, 3, 'Approved', '2026-01-16 10:45:00', '2026-01-17 09:00:00', NULL, NULL, 'Request for Laptop Dell XPS'),
(17, 3, 'Rejected', '2026-01-17 11:30:00', '2026-01-18 08:30:00', NULL, NULL, 'Request for Office Chair'),
(18, 2, 'Received', '2026-01-18 12:00:00', '2026-01-19 08:45:00', '2026-01-20 10:00:00', NULL, 'Request for Projector Epson'),
(19, 1, 'Returned', '2026-01-19 09:30:00', '2026-01-20 09:00:00', '2026-01-21 10:30:00', NULL, 'Request for Whiteboard'),
(20, 2, 'Inspected', '2026-01-20 10:15:00', '2026-01-21 08:45:00', '2026-01-22 09:30:00', NULL, 'Request for Printer HP Laser'),
(45, 3, 'Pending', '2026-01-31 02:33:52', NULL, NULL, NULL, 'For meetings');

-- --------------------------------------------------------

--
-- Table structure for table `request_items`
--

CREATE TABLE `request_items` (
  `request_itemID` int(11) NOT NULL,
  `requestID` int(11) NOT NULL,
  `assetID` int(11) NOT NULL,
  `supplierID` int(11) DEFAULT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `total_price` decimal(12,2) NOT NULL,
  `requested_qty` int(11) NOT NULL,
  `ordered_qty` int(11) DEFAULT 0,
  `received_qty` int(11) DEFAULT 0,
  `accepted_qty` int(11) DEFAULT 0,
  `rejected_qty` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `request_items`
--

INSERT INTO `request_items` (`request_itemID`, `requestID`, `assetID`, `supplierID`, `unit_price`, `total_price`, `requested_qty`, `ordered_qty`, `received_qty`, `accepted_qty`, `rejected_qty`) VALUES
(1, 1, 1, NULL, 5000.00, 5000.00, 1, 0, 0, 0, 0),
(2, 2, 2, 1, 300.00, 300.00, 1, 1, 0, 0, 0),
(3, 3, 3, NULL, 2000.00, 2000.00, 1, 0, 0, 0, 1),
(4, 4, 4, 2, 150.00, 150.00, 1, 1, 1, 1, 0),
(5, 5, 5, 1, 800.00, 800.00, 1, 1, 0, 0, 1),
(6, 6, 6, 2, 400.00, 400.00, 1, 1, 1, 1, 0),
(7, 7, 7, 1, 2000.00, 2000.00, 1, 1, 1, 1, 0),
(8, 8, 8, NULL, 100.00, 100.00, 1, 0, 0, 0, 0),
(9, 9, 9, 2, 3500.00, 3500.00, 1, 1, 1, 1, 0),
(10, 10, 10, NULL, 7000.00, 7000.00, 1, 0, 0, 0, 1),
(11, 11, 11, 1, 50.00, 50.00, 1, 1, 1, 1, 0),
(12, 12, 12, 2, 120.00, 120.00, 1, 1, 0, 0, 1),
(13, 13, 13, 1, 250.00, 250.00, 1, 1, 1, 1, 0),
(14, 14, 14, 2, 150.00, 150.00, 1, 1, 1, 1, 0),
(15, 15, 15, NULL, 120.00, 120.00, 1, 0, 0, 0, 0),
(16, 16, 16, 1, 5000.00, 5000.00, 1, 1, 0, 0, 0),
(17, 17, 17, NULL, 300.00, 300.00, 1, 0, 0, 0, 1),
(18, 18, 18, 2, 2000.00, 2000.00, 1, 1, 1, 1, 0),
(19, 19, 19, 1, 150.00, 150.00, 1, 1, 0, 0, 1),
(20, 20, 20, 2, 800.00, 800.00, 1, 1, 1, 1, 0),
(32, 45, 46, NULL, 50.00, 50.00, 1, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `staffs`
--

CREATE TABLE `staffs` (
  `staffID` int(11) NOT NULL,
  `staff_name` varchar(100) NOT NULL,
  `department` varchar(100) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staffs`
--

INSERT INTO `staffs` (`staffID`, `staff_name`, `department`, `position`, `phone`, `email`) VALUES
(1, 'Alice', 'IT', 'Manager', '0123456789', 'alice@company.com'),
(2, 'Bob', 'Finance', 'Staff', '0987654321', 'bob@company.com'),
(3, 'Carol', 'HR', 'Staff', '0112233445', 'carol@company.com');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `supplierID` int(11) NOT NULL,
  `supplier_name` varchar(100) NOT NULL,
  `company` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`supplierID`, `supplier_name`, `company`, `phone`, `email`) VALUES
(1, 'John Lim', 'Tech Supplies Sdn Bhd', '0129988776', 'john@techsupplies.com'),
(2, 'Mary Chen', 'Office Equip Co', '0116677889', 'mary@officeequip.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assets`
--
ALTER TABLE `assets`
  ADD PRIMARY KEY (`assetID`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`inventoryID`),
  ADD UNIQUE KEY `serial_number` (`serial_number`),
  ADD KEY `assetID` (`assetID`),
  ADD KEY `assignTo` (`assignTo`);

--
-- Indexes for table `requests`
--
ALTER TABLE `requests`
  ADD PRIMARY KEY (`requestID`),
  ADD KEY `staffID` (`staffID`);

--
-- Indexes for table `request_items`
--
ALTER TABLE `request_items`
  ADD PRIMARY KEY (`request_itemID`),
  ADD KEY `requestID` (`requestID`),
  ADD KEY `assetID` (`assetID`),
  ADD KEY `supplierID` (`supplierID`);

--
-- Indexes for table `staffs`
--
ALTER TABLE `staffs`
  ADD PRIMARY KEY (`staffID`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplierID`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assets`
--
ALTER TABLE `assets`
  MODIFY `assetID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `inventoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `requests`
--
ALTER TABLE `requests`
  MODIFY `requestID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `request_items`
--
ALTER TABLE `request_items`
  MODIFY `request_itemID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `staffs`
--
ALTER TABLE `staffs`
  MODIFY `staffID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplierID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`assetID`) REFERENCES `assets` (`assetID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`assignTo`) REFERENCES `staffs` (`staffID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `requests`
--
ALTER TABLE `requests`
  ADD CONSTRAINT `requests_ibfk_1` FOREIGN KEY (`staffID`) REFERENCES `staffs` (`staffID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `request_items`
--
ALTER TABLE `request_items`
  ADD CONSTRAINT `request_items_ibfk_1` FOREIGN KEY (`requestID`) REFERENCES `requests` (`requestID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `request_items_ibfk_2` FOREIGN KEY (`assetID`) REFERENCES `assets` (`assetID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `request_items_ibfk_3` FOREIGN KEY (`supplierID`) REFERENCES `suppliers` (`supplierID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
