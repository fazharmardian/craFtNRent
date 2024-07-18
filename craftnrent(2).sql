-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 18, 2024 at 08:05 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `craftnrent`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telephone` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `email`, `telephone`, `password`) VALUES
(1, 'Randi', 'randi@email.com', '+62-847-834-943', 'password'),
(2, 'Razi', 'razi@email.com', '+62-856-543-125', 'password');

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `image` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `brand` varchar(50) NOT NULL,
  `stock` int(11) NOT NULL,
  `status` varchar(50) NOT NULL
) ;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`id`, `name`, `image`, `type`, `brand`, `stock`, `status`) VALUES
(1, 'Plastic Student Chair', '712-plastic-student-chair.jpg', 'Chair', 'Napoleon', 600, 'available'),
(2, 'Plastic Teacher Chair', '7-plastic-teacher-chair.jpg', 'Chair', 'Napoleon', 46, 'available'),
(3, 'Wooden Student Desk', '331-wooden-student-desk.jpg', 'Desk', 'Napoleon', 258, 'available'),
(4, 'Speaker Portabel TWS Nirkabel', '793-speaker-portabel-tws-nirkabel.jpg', 'Speaker', 'Mongolian Star', 5, 'available'),
(5, 'Wireless Bluetooth PC Speaker', '628-pc-wireless-speaker.jpg', 'Speaker', 'Neon', 2, 'available'),
(6, 'Laptop ROG Strix G16 (G614)', '588-rog-g16-laptop.jpg', 'Laptop', 'ROG', 200, 'available'),
(7, 'ROG Strix SCAR 17 SE', '8-rog-strix-scar.jpg', 'Laptop', 'ROG', 200, 'available'),
(8, 'Gaming Chair (RB) GC003', '343-gaming-chair-gc003.jpg', 'Chair', 'Eka Chair', 20, 'available'),
(11, 'Sweeping Mop', '314-sweep-mop.jpg', 'Cleaning Tools', 'Ergia Solar', 500, 'available'),
(21, 'Terminal', '768-terminal.jpg', 'Terminal', 'Terminal 2', 100, 'available');

-- --------------------------------------------------------

--
-- Table structure for table `lending`
--

CREATE TABLE `lending` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_item` int(11) NOT NULL,
  `total_request` int(11) NOT NULL,
  `lend_date` date NOT NULL,
  `return_date` date NOT NULL,
  `actual_return_date` date DEFAULT NULL,
  `status` varchar(50) NOT NULL
) ;

--
-- Dumping data for table `lending`
--

INSERT INTO `lending` (`id`, `id_user`, `id_item`, `total_request`, `lend_date`, `return_date`, `actual_return_date`, `status`) VALUES
(31, 1, 2, 4, '2024-07-18', '2024-07-19', NULL, 'lent');

-- --------------------------------------------------------

--
-- Table structure for table `request`
--

CREATE TABLE `request` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_item` int(11) NOT NULL,
  `total_request` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `rent_id` int(11) DEFAULT NULL,
  `request_date` date NOT NULL,
  `status` varchar(50) NOT NULL CHECK (`status` in ('pending','approved','rejected')),
  `return_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `request`
--

INSERT INTO `request` (`id`, `id_user`, `id_item`, `total_request`, `type`, `rent_id`, `request_date`, `status`, `return_date`) VALUES
(20, 1, 1, 100, 'renting', NULL, '2024-06-03', 'approved', '2024-06-05'),
(21, 1, 1, 100, 'returning', NULL, '2024-06-03', 'approved', '2024-06-05'),
(22, 1, 1, 100, 'returning', NULL, '2024-06-03', 'approved', '2024-06-05'),
(26, 9, 8, 100, 'renting', NULL, '2024-06-04', 'approved', '2024-06-05'),
(28, 1, 1, 100, 'renting', NULL, '2024-06-04', 'approved', '2024-06-05'),
(35, 1, 1, 100, 'returning', 28, '2024-06-04', 'approved', '2024-06-05'),
(36, 1, 1, 100, 'renting', NULL, '2024-06-04', 'approved', '2024-06-11'),
(37, 1, 1, 100, 'returning', 29, '2024-06-04', 'approved', '2024-06-11'),
(38, 1, 1, 100, 'renting', NULL, '2024-06-04', 'approved', '2024-06-05'),
(39, 1, 1, 100, 'returning', 30, '2024-06-04', 'approved', '2024-06-05'),
(40, 22, 1, 10, 'renting', NULL, '2024-07-17', 'pending', '2024-07-17'),
(41, 1, 2, 4, 'renting', NULL, '2024-07-18', 'approved', '2024-07-19');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `telephone` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `telephone`, `password`) VALUES
(1, 'Faz\'n', 'f', '+62-881-0237-94621', '1'),
(2, 'Ristanto', 'ristanto@email.com', '+62-865-432-535', 'realaadad'),
(3, 'name', 'email@gemail.com', '088853605', 'password'),
(4, 'real', 'real@real.com', '+62-865-965-053', 'password'),
(5, 'sixmonths', 'venom@gmail.com', '088853605', 'password'),
(7, 'adi', 'bogeng@gmail.com', '08887366434', 'password'),
(8, 'Ukam', 'zul@gmail.com', '0884239423', 'password'),
(9, 'akasha', 'allknowing@gmail.com', '999999999', 'password'),
(11, 'fazrr', 'faz@gmail.com', '888888888', '1234'),
(14, 'fazee', 'faz22@gmail.com', '8994302740', '1234567'),
(15, 'dajdakdads', 'dkadjsk@gmail.com', '089283723932', '123456'),
(18, 'freaky', 'fsaad@gmail.com', '2222222222222', 'password'),
(19, 'faz', 'f@gmail.com', '8888888888888888', '8888888888888888888'),
(20, 'DIki', 'kuyun@gmail.com', '08239973913', 'password'),
(21, 'Real Tek', 'fajaeer@gmail.com', '088893484348', 'password'),
(22, 'rrerere', 'r@gmail.com', '0832891390432', 'password');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lending`
--
ALTER TABLE `lending`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lending_item` (`id_item`),
  ADD KEY `lending_user` (`id_user`);

--
-- Indexes for table `request`
--
ALTER TABLE `request`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_item` (`id_item`),
  ADD KEY `request_ibfk_3` (`rent_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `item`
--
ALTER TABLE `item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lending`
--
ALTER TABLE `lending`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `request`
--
ALTER TABLE `request`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `lending`
--
ALTER TABLE `lending`
  ADD CONSTRAINT `lending_item` FOREIGN KEY (`id_item`) REFERENCES `item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lending_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `request`
--
ALTER TABLE `request`
  ADD CONSTRAINT `request_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `request_ibfk_2` FOREIGN KEY (`id_item`) REFERENCES `item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `update_overdue_status` ON SCHEDULE EVERY 1 DAY STARTS '2024-06-08 10:41:53' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE lending
  SET status = 'overdue'
  WHERE return_date < CURDATE() AND (status IS NULL OR status != 'overdue')$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
