-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 12, 2024 at 10:59 AM
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
-- Database: `user_account`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `pepper` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `pepper`) VALUES
(1, 'Gerald Villaceran', 'gerald123@gmail.com', '$2b$12$PfRQjPrVcDeI/V1Nb1Vz0epEzlchMQGb5Igp.6z23f605u1lnv1a6', 'qwerty321'),
(2, 'Dixon Delos Santos', 'dixon123@gmail.com', '$2b$12$8q/rN/bUROmwZX08yZ.RaOzMTuQVYxiMU4KkYdJTwuw1rEITkbVty', 'qwerty321'),
(3, 'Hash 1', 'hash1@gmail.com', '$2b$12$f1D.W8iIPeNBOh/HEMDIruhgTeEmGELt5P4/5Dg3qorkd89KZ/GQC', 'qwerty321'),
(4, 'Hash 2', 'hash2@gmail.com', '$2b$12$Gh0UsSS7WZV5oUd/3vm0EeiDW3CIWJ0QRAQhjWEiXmD/V6hFmar5y', 'qwerty321'),
(5, 'Gerald & Dixon', 'hashing@gmail.com', '$2b$12$X6DvSRBueWR/mVtFPzWhLOVt80MyUs6UJDAgwcCuyu0BuLKPktoze', 'qwerty321');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
