-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 14, 2025 at 03:35 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bms_ussd`
--

-- --------------------------------------------------------

--
-- Table structure for table `donors`
--

CREATE TABLE `donors` (
  `donor_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `blood_type` varchar(5) NOT NULL,
  `last_donation_date` date DEFAULT NULL,
  `location` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `donors`
--

INSERT INTO `donors` (`donor_id`, `user_id`, `blood_type`, `last_donation_date`, `location`) VALUES
(12, 1, 'AB', '2025-03-21', 'Kicukiro'),
(15, 2, 'C', '2025-03-05', 'kamonyi'),
(21, 4, 'BB', '2025-03-21', 'Kicukiro'),
(22, 16, '', NULL, 'Musanze'),
(23, 18, '', NULL, 'Rubavu'),
(24, 19, '', NULL, 'Rulindo'),
(25, 20, '', NULL, 'Muhanga'),
(26, 21, '', NULL, 'hhyy'),
(27, 25, '', NULL, 'dsdd'),
(28, 26, '', NULL, '67888'),
(29, 28, '', NULL, 'Rubavu'),
(30, 31, '', NULL, 'bomi'),
(31, 32, '', NULL, 'nhttty'),
(32, 36, '', NULL, 'frtte'),
(33, 37, '', NULL, 'swe'),
(34, 38, '', NULL, 'etrrw'),
(35, 39, '', NULL, 'uehhddh'),
(36, 41, '', NULL, 'gssssssssss');

-- --------------------------------------------------------

--
-- Table structure for table `hospitals`
--

CREATE TABLE `hospitals` (
  `hospital_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `hospital_name` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `contact_person` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hospitals`
--

INSERT INTO `hospitals` (`hospital_id`, `user_id`, `hospital_name`, `address`, `contact_person`) VALUES
(3, 8, 'Gisenyi Hosipital', 'Rubavu district', '0780037017'),
(4, 9, 'Kibuye Hosipital', 'Kalongi District', '0798063990'),
(5, 10, 'Ruhengeri Hosipital', 'Musanze District', '0788402907');

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `patient_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `blood_needed` varchar(5) NOT NULL,
  `hospital_id` int(11) NOT NULL,
  `request_status` enum('pending','approved','fulfilled') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`patient_id`, `user_id`, `blood_needed`, `hospital_id`, `request_status`) VALUES
(1, 10, 'O', 3, 'pending'),
(2, 11, 'AB', 3, 'approved');

-- --------------------------------------------------------

--
-- Table structure for table `sms_subscribers`
--

CREATE TABLE `sms_subscribers` (
  `id` int(11) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sms_subscribers`
--

INSERT INTO `sms_subscribers` (`id`, `phone_number`, `status`, `created_at`, `updated_at`) VALUES
(1, '+250780037017', 'active', '2025-05-13 22:20:56', '2025-05-13 22:20:56');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `role` enum('admin','donor','hospital','patient') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `phone`, `role`, `created_at`) VALUES
(1, 'UWIMPUHWE Hyacinthe Mireille', 'uwmireille55@gmail.com', '$2y$10$TsfLwKnHCohdA9RLh7ncreJKTVJKyxl2PFK0RSMq9jPSSBRCrGWT.', '0780037017', 'donor', '2025-03-11 05:22:44'),
(2, 'Canirinyana Diane', 'cana@gmail.com', '$2y$10$OVGy/vFJRVxp6L9kuweQIOZQPmiQy7RZFkJFi0sVWbmKyV3ArW4uu', '0783456100', 'donor', '2025-03-11 05:27:16'),
(3, 'uwase claudine', 'uwase@gmail.com', '$2y$10$yEqDGrfZkS7x4c2qq0FbIeIrnLjYQCynMId390H.0EoPmoEfzUWr.', '0783200124', 'hospital', '2025-03-11 05:34:02'),
(4, 'CYIZA Honore', 'cyiza@123', '$2y$10$TmhKYy84WfoosQVgdFqgR.kKk0S30thmpdIfwx/tY4VX4ImUKQvga', '0788402907', 'donor', '2025-03-11 08:06:55'),
(5, 'ISHIMWE Alice', 'ishimweali@gmail.com', '$2y$10$arekmF97DTnQ82uCBfGMyetUDeEwnZUyt0FPJzN6wBFYAJMs42IEK', '0788402907', 'hospital', '2025-03-11 17:57:24'),
(6, 'INEZA Ange', 'ineza@gmail.com', '$2y$10$9Mw3pieGN8CW/ikoJ7mACOAuHrHjQ6rWbxuUpFSsSB0H/lcNSXU0.', '0792300123', 'hospital', '2025-03-11 18:01:31'),
(7, 'BARAKA Tony', 'toni11@gmail.com', '$2y$10$IyVW4yVt.FHLfPNi6u0Ug.7iDftvWtwz8nSDZeIytumMSFPFb/h.q', '0782001180', 'hospital', '2025-03-11 18:19:33'),
(8, 'MUGISHA Evode', 'mugisha@gmail.com', '$2y$10$MKzWW5ClLwEOA9Pmh9dTKex3fR8HLqydLdo4SQ1OQv4geuw9lFori', '0788402907', 'hospital', '2025-03-11 19:17:07'),
(9, 'INSHUTI Lily', 'liliane@gmail.com', '$2y$10$WpUqOLkBqTang5fG26JxouXnEipMCXjHPGKKQzrqB330zkvxgJKMC', '0792300123', 'hospital', '2025-03-11 19:17:40'),
(10, 'IKUZE Cheilla', 'ikuze@gmail.com', '$2y$10$xNCxNwWdXanBBprSbuh8m.DFoKCDqrMC/2YmN3laN8/DYgG3Qllny', '0783456100', 'hospital', '2025-03-11 19:19:30'),
(11, 'INGABIRE Ange', 'ange22@gmail.com', '$2y$10$srWFYGG26k59YB8PFu8WgOFWSWjt7SIFILU6z7yWVXMBmpn09yhum', '0783456100', 'patient', '2025-03-12 02:05:13'),
(13, 'INGABIRE Jeanne Pauline', 'plnngbr@gmail.com', '$2y$10$Dq1LG.cOOiIOMR7Ry2i.2OW5hf8i0kMSiUtdXZzOt2JQAT8X8y6G6', '0788402907', 'admin', '2025-03-12 03:51:57'),
(14, 'mimi', 'mimi@gmail.com', '$2y$10$vBtZpM.g7kcV8ypi9RzCbuoFwXt8.0ygX4x2LTbVGeoGI7g4jKiki', '0783632522', 'admin', '2025-05-13 02:24:08'),
(16, 'UWASE Claudine', 'cldnuwase@gmail.com', '$2y$10$cEWKfkinhmi0bRFP8Bb9Qu8UZejYnOjC9V4DC5wGZIIS7sIDCd0cO', '+250780037017', 'donor', '2025-05-13 04:23:21'),
(18, 'BARAKA Tony', 'barakatony11@gmail.com', '$2y$10$7tZmrF5AOp9xCJngbK57XOVtyQFCSOgXNbb4fD3xevSoCp/tfIELS', '+250780037017', 'donor', '2025-05-13 05:47:01'),
(19, 'Hyacinthe Mireille', 'hyacinthemireille@gmail.com', '$2y$10$Rg/OaQ.EkapGo5myLXC//.3w3JseQZt0daYV7UI.29VBgFQFupmvS', '+250780037017', 'donor', '2025-05-13 06:11:49'),
(20, 'Mimmy Mireille', 'mimi123@gmail.com', '$2y$10$adkLHrVl7/9OrWE4y9J3hexZnm5epbZw25ACL2Xb3.KmFOXGMmYsG', '+250780037017', 'donor', '2025-05-13 06:20:09'),
(21, 'hhhh', 'laira123@gmail.com', '$2y$10$Tt9T3CXMZOEHQFp0doCBt.dOqeWBer0MuAU6vOz/RTjOoHZTCH3Hi', '+250780037017', 'donor', '2025-05-13 06:32:59'),
(25, 'fdrrr', 'antoine123@gmail.com', '$2y$10$ddBmFFEjPbCd0TYTxTQW..ehHXqtATOCW0rq0uERhoWq0Vm43D3sW', '+250780037017', 'donor', '2025-05-13 06:53:03'),
(26, 'hyyyuu', 'amina@gmail.com', '$2y$10$AUp.3TI0u0UO2wkrSo2TRu3znPAlGjFmZQzx4zbCFLNoMNdqNu86q', '+250780037017', 'donor', '2025-05-13 07:25:31'),
(28, 'Anitha Uwimana', 'uwanitha@gmail.com', '$2y$10$RvCZxllM3T9mEoPqietTreXADJpB9DDBdvSwiwuNyRBx9Ihwb4.l.', '+250780037017', 'donor', '2025-05-13 17:29:40'),
(31, 'Mama M', 'mama123@gmail.com', '$2y$10$D6ONCYBHiYkOK3/MQRhRx.LgCQnLksJmNWI5F2a/0Z.ZW2VZKZAUG', '+250780037017', 'donor', '2025-05-13 19:55:16'),
(32, 'htyyy', 'hyytuuu', '$2y$10$4zWU9NWWjW8YD7TKNSLqGuncE0rhBpk2GBJFphX1GyA0jFGdy094O', '+250780037017', 'donor', '2025-05-13 20:10:20'),
(36, 'frtt', 'vggttt@gmail.com', '$2y$10$AQGQSKSOlj8l7GH81jOGHO5TYwGX3G0K6NsmadPejhIxD/hpPDhWq', '+250780037017', 'donor', '2025-05-13 20:33:56'),
(37, 'ffsssssssss', 'nhy@gmail.com', '$2y$10$V8dQ.Mv9OTc1kNEXYPQMseENUZR8voPsmzDe0sQ4hG9biZ5LJbqjK', '+250780037017', 'donor', '2025-05-13 20:52:07'),
(38, 'gttrr', 'sttt@gmail.com', '$2y$10$E7YQYI2mZSVHDY/bbF2m9e77nkTCiX2ohD9BxG1s6gHYQV7pGumiK', '+250780037017', 'donor', '2025-05-13 21:04:31'),
(39, 'ghrtyty', 'weehh@gmail.com', '$2y$10$rbgy9lPKRSfClm8OCFuC8uXsAWV5diyAXN7F9rJgBLhjuPLTd7eie', '+250780037017', 'donor', '2025-05-13 21:08:16'),
(41, 'ingabire', 'urttt@gmail.com', '$2y$10$gObCbzbn.2x63K3p/FOMPuJHcpt/1V3CUtOvfGhYSYFW/3QFGD/EK', '+250780037017', 'donor', '2025-05-13 22:18:55');

-- --------------------------------------------------------

--
-- Table structure for table `ussd_sessions`
--

CREATE TABLE `ussd_sessions` (
  `session_id` varchar(255) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `session_data` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ussd_sessions`
--

INSERT INTO `ussd_sessions` (`session_id`, `phone_number`, `session_data`, `created_at`) VALUES
('ATUid_00c30c3159ee8bebcbd95b4919951d08', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 21:00:30'),
('ATUid_021fb530dc760dcf8a10efa639b43378', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 20:59:04'),
('ATUid_04f5b130964d3ad340be04e630caad63', '+250780037017', '{\"registration_step\":\"location\",\"name\":\"fdrrr\",\"email\":\"antoine123@gmail.com\",\"location\":\"dsdd\"}', '2025-05-13 06:52:39'),
('ATUid_07b6878f6bda71ae4f54624911335c71', '+250780037017', '[]', '2025-05-13 06:50:08'),
('ATUid_097f590c9adf9e02d7b39c42615381e4', '+250780037017', '{\"registration_step\":\"location\",\"name\":\"diane\",\"email\":\"uwmireille55@gmail.com\"}', '2025-05-13 17:26:45'),
('ATUid_1161e9a11c556ae1bc1332e6c5e2a305', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 20:46:56'),
('ATUid_1256ca4265f5e16c7f82c5a0eb1c7ddb', '+250780037017', '{\"registration_step\":\"location\",\"name\":\"hhhhh\",\"email\":\"ishimweali@gmail.com\"}', '2025-05-13 06:40:09'),
('ATUid_12bc177f771b55beed2e1b6f4680dbdf', '+250780037017', '{\"registration_step\":\"location\",\"name\":\"saw\",\"email\":\"ishimweali@gmail.com\"}', '2025-05-13 20:30:21'),
('ATUid_12f11680bc5a6f25159e8d1f51a30d35', '+250780037017', '[]', '2025-05-13 05:49:31'),
('ATUid_19176e6e25ae7f19b3ced8c8b90cba67', '+250780037017', '{\"registration_step\":\"location\",\"name\":\"UWIMPUHWE Hyacinthe Mireille\",\"email\":\"uwmireille55@gmail.com\"}', '2025-05-13 04:18:24'),
('ATUid_1a044d16bcd70251ab20f3d67cafee69', '+250780037017', '{\"registration_step\":\"location\",\"name\":\"Mama M\",\"email\":\"mama123@gmail.com\",\"location\":\"bomi\"}', '2025-05-13 19:54:36'),
('ATUid_1e0de7d6c213f416c744efcecd29fc12', '+250780037017', '{\"registration_step\":\"location\",\"name\":\"Inshuti\",\"email\":\"ishimweali@gmail.com\"}', '2025-05-13 19:26:21'),
('ATUid_1e9c12fa1d8a652bcd496a2857476e80', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 22:20:09'),
('ATUid_222951b32a130cb483b12438eb503990', '+250780037017', '[]', '2025-05-13 17:27:53'),
('ATUid_257fa6c470df221131ccb13e37d2c88d', '+250780037017', '[]', '2025-05-13 20:37:53'),
('ATUid_2ac12e72051de5da5b09ece7d0c5d82b', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 21:10:27'),
('ATUid_2f839f6f2a9494badbd5ebc0166be360', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"blood_type\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 20:40:34'),
('ATUid_31901e5b7f70776d429bbfcd9f69cfb4', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 20:53:20'),
('ATUid_3241887d9c21b1901c932c48be8f998b', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 21:00:42'),
('ATUid_3859884e296345d4d42af7b21536637d', '+250780037017', '[]', '2025-05-13 05:52:06'),
('ATUid_40e4fe656cb60740e4377b772be27eb8', '+250780037017', '{\"registration_step\":\"location\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"gttrr\",\"email\":\"sttt@gmail.com\",\"location\":\"etrrw\"}', '2025-05-13 21:04:05'),
('ATUid_478cb6f2611cd9981df4a7a036804863', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 20:42:27'),
('ATUid_49611530c38cf2a471561b115054a69f', '+250780037017', '{\"request_step\":\"blood_type\"}', '2025-05-13 06:37:39'),
('ATUid_4973a89d3a78f9d00425a94513ad5ef9', '+250780037017', '{\"registration_step\":\"location\",\"name\":\"kamanzi\",\"email\":\"laira123@gmail.com\"}', '2025-05-13 20:29:05'),
('ATUid_4b7dae9642f854276db6d9fbe3ab6327', '+250780037017', '{\"sms_step\":\"emergency_message\"}', '2025-05-13 05:50:01'),
('ATUid_4ba892bd542709adaaa6a50d34adeb26', '+250780037017', '{\"registration_step\":\"location\",\"name\":\"hyyyuu\",\"email\":\"amina@gmail.com\",\"location\":\"67888\"}', '2025-05-13 07:25:01'),
('ATUid_4dba62161e8c20b1453fcd86a45b2695', '+250780037017', '[]', '2025-05-13 04:21:28'),
('ATUid_51371786c9dc6beb888470cd32429a86', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 21:05:04'),
('ATUid_5291c85f7ebd81d48fd846495fc2e1e0', '+250780037017', '{\"registration_step\":\"location\",\"name\":\"hhhhuy\",\"email\":\"ishimweali@gmail.com\"}', '2025-05-13 06:50:23'),
('ATUid_55d714174c5cefc57cacb93d73bb49a7', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 22:19:13'),
('ATUid_56a8400623caacfa4ab46ad4dd65595b', '+250780037017', '{\"request_step\":\"blood_type\"}', '2025-05-13 05:48:18'),
('ATUid_58242cdccf985949abf55d0e57d6b02f', '+250780037017', '{\"registration_step\":\"location\",\"name\":\"fg\",\"email\":\"laira123@gmail.com\"}', '2025-05-13 20:14:16'),
('ATUid_58317d3dc30292bd93a4dfd139852f55', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 20:59:16'),
('ATUid_59450d6e266efbbaa8f6070e84937ebf', '+250780037017', '{\"registration_step\":\"location\",\"name\":\"Anitha Uwimana\",\"email\":\"uwanitha@gmail.com\",\"location\":\"Rubavu\"}', '2025-05-13 17:28:52'),
('ATUid_5abd2efb347c0b70cc47662322c3a1ad', '+250780037017', '[]', '2025-05-13 20:14:50'),
('ATUid_5e075a8b108f122063595aa3840dae01', '+250780037017', '{\"registration_step\":\"location\",\"name\":\"Rafiki Laira\",\"email\":\"laira123@gmail.com\"}', '2025-05-13 19:22:53'),
('ATUid_615070dd5d08fb755a7ffcb2b6d2ce5e', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 22:20:25'),
('ATUid_6276d0012739da06b5b8bab525fc3e76', '+250780037017', '{\"registration_step\":\"name\"}', '2025-05-13 17:27:34'),
('ATUid_66f7770670450c21060ef380c22d6035', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 20:58:21'),
('ATUid_67c62178d5e8b8116b4495fd83ab6469', '+250780037017', '{\"registration_step\":\"location\",\"name\":\"frtt\",\"email\":\"vggttt@gmail.com\",\"location\":\"frtte\"}', '2025-05-13 20:33:31'),
('ATUid_690504c86d389dc54af4ae22fb42acb4', '+250780037017', '{\"registration_step\":\"name\"}', '2025-05-13 19:23:43'),
('ATUid_719bd5d569f1c4b8fba9c168b97389a9', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 21:02:28'),
('ATUid_719e5001c7445389c84acc6673b41331', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"blood_type\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 22:19:24'),
('ATUid_78e561df93b52adf082e65889c1ed67a', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 20:45:50'),
('ATUid_79033db8a986f4a97a5c43f9f361c97b', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 21:11:09'),
('ATUid_8020399161dd7a8cb0ee861759d0e3d5', '+250780037017', '{\"registration_step\":\"location\",\"name\":\"BARAKA Tony\",\"email\":\"barakatony11@gmail.com\",\"location\":\"Rubavu\"}', '2025-05-13 05:46:20'),
('ATUid_80e747d2023409f09a440cab262f139e', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"blood_type\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 21:03:40'),
('ATUid_82661f1bbe27a235d6b58c75801fef07', '+250780037017', '{\"registration_step\":\"location\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"ffsssssssss\",\"email\":\"nhy@gmail.com\",\"location\":\"swe\"}', '2025-05-13 20:51:35'),
('ATUid_82875a9699ec4ebb27cbcd96a68f6bfe', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"blood_type\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 20:52:24'),
('ATUid_84893b6f1446038513dfff71e533fdd6', '+250780037017', '{\"registration_step\":\"email\",\"name\":\"da\"}', '2025-05-13 20:29:49'),
('ATUid_85265a70ccf2eb286050ca56059b3488', '+250780037017', '[]', '2025-05-13 05:47:47'),
('ATUid_85bc84eba94638535013863f662297c8', '+250780037017', '{\"registration_step\":\"location\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"INGABIRE Jeanne Pauline\",\"email\":\"plnngbr@gmail.com\",\"location\":\"\"}', '2025-05-13 22:17:38'),
('ATUid_8917a8e7331143302f03689309baf86a', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 20:55:32'),
('ATUid_8db427ecf2ec2babe430949819638dc4', '+250780037017', '{\"registration_step\":\"location\",\"name\":\"Hyacinthe Mireille\",\"email\":\"hyacinthemireille@gmail.com\",\"location\":\"Rulindo\"}', '2025-05-13 06:11:01'),
('ATUid_91dd6ab0a42d7c217506cb146868a3a8', '+250780037017', '{\"request_step\":\"blood_type\"}', '2025-05-13 06:53:22'),
('ATUid_93facaef5cbc6d8d708fdcf830164e97', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 20:53:45'),
('ATUid_97df8f2aaca4b3671ba93e12933ab683', '+250780037017', '{\"request_step\":\"blood_type\"}', '2025-05-13 20:35:21'),
('ATUid_a589cac3c3448840d349c3dbe392cea4', '+250780037017', '{\"request_step\":\"blood_type\"}', '2025-05-13 04:20:49'),
('ATUid_a7d08825e2d12783ebb5af75af757185', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 20:41:10'),
('ATUid_acebbdb92277f66c40e641f8617240fc', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 20:53:30'),
('ATUid_ad6890d301019ba0691a0ec2e6eaff3a', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 22:19:50'),
('ATUid_b08faa7828d54751144335ed45c91ec4', '+250780037017', '[]', '2025-05-13 04:20:29'),
('ATUid_b3f5d895e7507f906f6186e47964d36e', '+250780037017', '[]', '2025-05-13 05:51:34'),
('ATUid_b59f5d79513b7db4ea92d76083323972', '+250780037017', '[]', '2025-05-13 06:04:40'),
('ATUid_b75653e53734d30ee8e63710d8f8f9fc', '+250780037017', '[]', '2025-05-13 05:48:55'),
('ATUid_b85c031142470b666442bb9a65fcd753', '+250780037017', '{\"registration_step\":\"name\"}', '2025-05-13 06:48:23'),
('ATUid_bbd027c20fb72d5915be6f6b4667422b', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 22:20:44'),
('ATUid_c07f5e35b04d8067345c689a83d06382', '+250780037017', '{\"registration_step\":\"location\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"ghrtyty\",\"email\":\"weehh@gmail.com\",\"location\":\"uehhddh\"}', '2025-05-13 21:07:50'),
('ATUid_c1c62e92e78057bf1df5ed4516a84573', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 20:50:27'),
('ATUid_c89519b3fb58df352a8d0d70e46bcd52', '+250780037017', '{\"registration_step\":\"location\",\"name\":\"hhhh\",\"email\":\"laira123@gmail.com\",\"location\":\"hhyy\"}', '2025-05-13 06:32:22'),
('ATUid_caf63ece402f3ff83c7d415a1655f313', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 20:52:45'),
('ATUid_d0f33f396d45c6079568d586c33d14e5', '+250780037017', '{\"registration_step\":\"location\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"ingabire\",\"email\":\"urttt@gmail.com\",\"location\":\"gssssssssss\"}', '2025-05-13 22:18:24'),
('ATUid_d17b4ce9047af03702f944fc3dc5b8e6', '+250780037017', '[]', '2025-05-13 06:40:59'),
('ATUid_d3664282e131c822aa104a9e4c007b2d', '+250780037017', '[]', '2025-05-13 04:19:29'),
('ATUid_d47afe598c4a05f6ab5b1b6845a68012', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 20:58:42'),
('ATUid_d590039bf02e6318166db662532bd750', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 21:10:42'),
('ATUid_d7f1dc20a7ce3006086d64f07ec77bd9', '+250780037017', '{\"registration_step\":\"location\",\"name\":\"ISHIMWE Antoin\",\"email\":\"ishimweali@gmail.com\"}', '2025-05-13 05:24:38'),
('ATUid_d9a17dc98e960efa58e423b98bb0517a', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"blood_type\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 21:09:54'),
('ATUid_e080e57a9c60d6b16ed370594885fbd5', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"blood_type\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 21:08:36'),
('ATUid_e41cda1fc1f298e639a9eb5193d79300', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 21:07:16'),
('ATUid_e63345d8d59d9fe49dadc1c4331960da', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 21:04:43'),
('ATUid_e65843dad972a75412a1ba79625875b0', '+250780037017', '{\"registration_step\":\"location\",\"name\":\"Mimmy Mireille\",\"email\":\"mimi123@gmail.com\",\"location\":\"Muhanga\"}', '2025-05-13 06:19:13'),
('ATUid_e76a64e4ae36a18f0e29b32ec31923b2', '+250780037017', '{\"registration_step\":\"location\",\"name\":\"htyyy\",\"email\":\"hyytuuu\",\"location\":\"nhttty\"}', '2025-05-13 20:09:49'),
('ATUid_ec2c81d12301c123fd04dc9afe4b2e24', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 21:11:08'),
('ATUid_ed387a9e5528ae5bb9e4ea90bee1515d', '+250780037017', '[]', '2025-05-13 05:51:19'),
('ATUid_edce578689458351e735c68b2a64b660', '+250780037017', '{\"registration_step\":\"location\",\"name\":\"uuuu\",\"email\":\"laira123@gmail.com\"}', '2025-05-13 06:36:58'),
('ATUid_f21b71f91b809eae3e1ee34e1bba8a1a', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 22:19:13'),
('ATUid_f945c6dde7df32d29913332af08d8dfa', '+250780037017', '{\"request_step\":\"blood_type\"}', '2025-05-13 20:35:38'),
('ATUid_fed15aec9e9bf9662a1c5328344d3842', '+250780037017', '{\"registration_step\":\"\",\"request_step\":\"\",\"sms_step\":\"\",\"name\":\"\",\"email\":\"\",\"location\":\"\"}', '2025-05-13 20:44:26');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `donors`
--
ALTER TABLE `donors`
  ADD PRIMARY KEY (`donor_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `hospitals`
--
ALTER TABLE `hospitals`
  ADD PRIMARY KEY (`hospital_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`patient_id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `hospital_id` (`hospital_id`);

--
-- Indexes for table `sms_subscribers`
--
ALTER TABLE `sms_subscribers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phone_number` (`phone_number`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `ussd_sessions`
--
ALTER TABLE `ussd_sessions`
  ADD PRIMARY KEY (`session_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `donors`
--
ALTER TABLE `donors`
  MODIFY `donor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `hospitals`
--
ALTER TABLE `hospitals`
  MODIFY `hospital_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sms_subscribers`
--
ALTER TABLE `sms_subscribers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `donors`
--
ALTER TABLE `donors`
  ADD CONSTRAINT `donors_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `hospitals`
--
ALTER TABLE `hospitals`
  ADD CONSTRAINT `hospitals_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `patients_ibfk_2` FOREIGN KEY (`hospital_id`) REFERENCES `hospitals` (`hospital_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
