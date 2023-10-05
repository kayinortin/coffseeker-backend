-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- 主機： localhost
-- 產生時間： 2023 年 10 月 06 日 04:20
-- 伺服器版本： 10.4.28-MariaDB
-- PHP 版本： 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `coffseeker_db`
--

-- --------------------------------------------------------

--
-- 資料表結構 `users`
--

CREATE TABLE `users` (
  `id` int(7) UNSIGNED NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(50) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `email` varchar(30) NOT NULL,
  `birthday` date NOT NULL,
  `avatar` varchar(50) DEFAULT 'preset-icon.png',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `grade_id` int(1) NOT NULL DEFAULT 1,
  `valid` int(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `gender`, `phone`, `email`, `birthday`, `avatar`, `created_at`, `grade_id`, `valid`) VALUES
(1, '測試12345', 'pass123', 'Male', '0909987234', 'johndoe@example.com', '1992-02-02', 'logo1.png', '2023-07-13 12:00:00', 1, 1),
(2, 'Jane Smith', 'secret456', 'Female', '9876543210', 'janesmith@example.com', '1992-05-15', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(3, 'Edison Lee', 'pin1234', 'Male', '0970812816', 'kayinortin@hotmail.com', '1993-01-06', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(4, 'Sarah Williams', 'pass789', 'Female', '6666666666', 'sarahwilliams@example.com', '1995-08-22', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(5, 'Michael Brown', 'abc123', 'Male', '7777777777', 'michaelbrown@example.com', '1993-04-10', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(6, 'Emily Davis', 'def456', 'Female', '8888888888', 'emilydavis@example.com', '1991-09-05', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(7, 'Christopher Martinez', 'qwerty', 'Male', '9999999999', 'christophermartinez@example.co', '1989-03-20', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(8, 'Sophia Anderson', 'pass789', 'Female', '1111111111', 'sophiaanderson@example.com', '1994-06-12', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(9, 'Matthew Taylor', '123456', 'Male', '2222222222', 'matthewtaylor@example.com', '1996-02-28', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(10, '測試變更', 'abc789', 'Female', '0909123123', 'oliviathomas@example.com', '1992-07-25', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(11, 'James Hernandez', 'password123', 'Male', '4444444444', 'jameshernandez@example.com', '1987-12-10', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(13, 'Joseph Gonzalez', 'xyz789', 'Male', '6666666666', 'josephgonzalez@example.com', '1993-08-18', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(14, 'Mia Moore', 'secret123', 'Female', '7777777777', 'miamoore@example.com', '1989-01-02', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(15, 'William Lee', 'pass456', 'Male', '8888888888', 'williamlee@example.com', '1991-05-17', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(16, 'Isabella Harris', 'qwerty123', 'Female', '9999999999', 'isabellaharris@example.com', '1988-10-02', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(17, 'Daniel Clark', 'abc456', 'Male', '1111111111', 'danielclark@example.com', '1995-02-27', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(18, 'Emma Lewis', 'pass123', 'Female', '2222222222', 'emmalewis@example.com', '1994-07-24', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(19, 'Benjamin Young', 'xyz456', 'Male', '3333333333', 'benjaminyoung@example.com', '1991-12-09', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(20, 'Sofia Rodriguez', 'secret789', 'Female', '4444444444', 'sofiarodriguez@example.com', '1993-05-03', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(21, 'Elijah Walker', 'pass789', 'Male', '5555555555', 'elijahwalker@example.com', '1992-10-18', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(22, 'Avery Hall', 'abc123', 'Female', '6666666666', 'averyhall@example.com', '1990-03-04', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(23, 'Grace Allen', 'qwerty456', 'Female', '7777777777', 'graceallen@example.com', '1987-07-29', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(24, 'Samuel Hernandez', 'pass456', 'Male', '8888888888', 'samuelhernandez@example.com', '1995-01-14', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(25, 'Chloe Turner', 'xyz123', 'Female', '9999999999', 'chloeturner@example.com', '1993-06-28', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(26, 'Henry Parker', 'abc789', 'Male', '1111111111', 'henryparker@example.com', '1992-11-12', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(27, 'Victoria Coleman', 'password123', 'Female', '2222222222', 'victoriacoleman@example.com', '1990-04-29', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(28, 'Andrew Cook', 'pass789', 'Male', '3333333333', 'andrewcook@example.com', '1988-09-13', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(29, 'Scarlett Cooper', 'xyz789', 'Female', '4444444444', 'scarlettcooper@example.com', '1995-02-28', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(30, 'Josephine Hill', 'secret123', 'Female', '5555555555', 'josephinehill@example.com', '1991-07-15', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(31, 'Jack Wright', 'pass123', 'Male', '6666666666', 'jackwright@example.com', '1993-11-30', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(32, 'Penelope Ward', 'abc456', 'Female', '7777777777', 'penelopeward@example.com', '1989-04-16', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(33, 'Lucas Mitchell', 'pass789', 'Male', '8888888888', 'lucasmitchell@example.com', '1994-08-02', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(34, 'Aria Bell', 'xyz456', 'Female', '9999999999', 'ariabell@example.com', '1990-12-18', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(35, 'Gabriel Turner', 'secret789', 'Male', '1111111111', 'gabrielturner@example.com', '1992-05-03', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(36, 'Mila Scott', 'pass123', 'Female', '2222222222', 'milascott@example.com', '1995-09-17', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(37, 'Carter Morgan', 'abc123', 'Male', '3333333333', 'cartermorgan@example.com', '1987-02-02', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(38, 'Abigail Murphy', 'qwerty123', 'Female', '4444444444', 'abigailmurphy@example.com', '1993-07-18', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(39, 'Dylan Allen', 'pass456', 'Male', '5555555555', 'dylanallen@example.com', '1991-12-03', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(40, 'Sophie Adams', 'xyz789', 'Female', '6666666666', 'sophieadams@example.com', '1990-05-18', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(41, 'Owen Lewis', 'secret123', 'Male', '7777777777', 'owenlewis@example.com', '1988-10-02', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(42, 'Elizabeth Young', 'pass123', 'Female', '8888888888', 'elizabethyoung@example.com', '1993-02-16', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(43, 'Luke Hall', 'abc789', 'Male', '9999999999', 'lukehall@example.com', '1992-07-03', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(44, 'Scarlett Hill', 'qwerty456', 'Female', '1111111111', 'scarletthill@example.com', '1989-11-18', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(45, 'Julian Hernandez', 'pass456', 'Male', '2222222222', 'julianhernandez@example.com', '1994-04-05', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(46, 'Avery Rodriguez', 'xyz123', 'Female', '3333333333', 'averyrodriguez@example.com', '1991-08-20', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(47, 'Sofia Walker', 'secret789', 'Female', '4444444444', 'sofiawalker@example.com', '1993-01-05', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(48, 'Sebastian Turner', 'pass789', 'Male', '5555555555', 'sebastianturner@example.com', '1992-06-20', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(49, 'Lucy Foster', 'abc123', 'Female', '6666666666', 'lucyfoster@example.com', '1990-11-05', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(50, 'Connor Powell', 'qwerty789', 'Male', '7777777777', 'connorpowell@example.com', '1988-04-20', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(52, 'Jane Smith', 'secret456', 'Female', '9876543210', 'janesmith@example.com', '1992-05-15', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(53, 'David Johnson', 'password789', 'Male', '5555555555', 'davidjohnson@example.com', '1988-11-30', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(54, 'Sarah Williams', 'pass789', 'Female', '6666666666', 'sarahwilliams@example.com', '1995-08-22', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(55, 'Michael Brown', 'abc123', 'Male', '7777777777', 'michaelbrown@example.com', '1993-04-10', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(56, 'Emily Davis', 'def456', 'Female', '8888888888', 'emilydavis@example.com', '1991-09-05', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(57, 'Christopher Martinez', 'qwerty', 'Male', '9999999999', 'christophermartinez@example.co', '1989-03-20', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(58, 'Sophia Anderson', 'pass789', 'Female', '1111111111', 'sophiaanderson@example.com', '1994-06-12', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(59, 'Matthew Taylor', '123456', 'Male', '2222222222', 'matthewtaylor@example.com', '1996-02-28', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(60, 'Olivia Thomas', 'abc789', 'Female', '3333333333', 'oliviathomas@example.com', '1992-07-25', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(61, 'James Hernandez', 'password123', 'Male', '4444444444', 'jameshernandez@example.com', '1987-12-10', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(62, 'Ava Wilson', 'pass123', 'Female', '5555555555', 'avawilson@example.com', '1990-04-03', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(63, 'Joseph Gonzalez', 'xyz789', 'Male', '6666666666', 'josephgonzalez@example.com', '1993-08-18', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(64, 'Mia Moore', 'secret123', 'Female', '7777777777', 'miamoore@example.com', '1989-01-02', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(65, 'William Lee', 'pass456', 'Male', '8888888888', 'williamlee@example.com', '1991-05-17', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(66, 'Isabella Harris', 'qwerty123', 'Female', '9999999999', 'isabellaharris@example.com', '1988-10-02', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(67, 'Daniel Clark', 'abc456', 'Male', '1111111111', 'danielclark@example.com', '1995-02-27', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(68, 'Emma Lewis', 'pass123', 'Female', '2222222222', 'emmalewis@example.com', '1994-07-24', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(69, 'Benjamin Young', 'xyz456', 'Male', '3333333333', 'benjaminyoung@example.com', '1991-12-09', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(70, 'Sofia Rodriguez', 'secret789', 'Female', '4444444444', 'sofiarodriguez@example.com', '1993-05-03', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(71, 'Elijah Walker', 'pass789', 'Male', '5555555555', 'elijahwalker@example.com', '1992-10-18', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(72, 'Avery Hall', 'abc123', 'Female', '6666666666', 'averyhall@example.com', '1990-03-04', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(73, 'Grace Allen', 'qwerty456', 'Female', '7777777777', 'graceallen@example.com', '1987-07-29', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(74, 'Samuel Hernandez', 'pass456', 'Male', '8888888888', 'samuelhernandez@example.com', '1995-01-14', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(75, 'Chloe Turner', 'xyz123', 'Female', '9999999999', 'chloeturner@example.com', '1993-06-28', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(76, 'Henry Parker', 'abc789', 'Male', '1111111111', 'henryparker@example.com', '1992-11-12', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(77, 'Victoria Coleman', 'password123', 'Female', '2222222222', 'victoriacoleman@example.com', '1990-04-29', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(78, 'Andrew Cook', 'pass789', 'Male', '3333333333', 'andrewcook@example.com', '1988-09-13', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(79, 'Scarlett Cooper', 'xyz789', 'Female', '4444444444', 'scarlettcooper@example.com', '1995-02-28', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(80, 'Josephine Hill', 'secret123', 'Female', '5555555555', 'josephinehill@example.com', '1991-07-15', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(81, 'Jack Wright', 'pass123', 'Male', '6666666666', 'jackwright@example.com', '1993-11-30', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(82, 'Penelope Ward', 'abc456', 'Female', '7777777777', 'penelopeward@example.com', '1990-04-16', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(83, 'Lucas Mitchell', 'pass789', 'Male', '8888888888', 'lucasmitchell@example.com', '1994-08-02', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(84, 'Aria Bell', 'xyz456', 'Female', '9999999999', 'ariabell@example.com', '1990-12-18', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(85, 'Gabriel Turner', 'secret789', 'Male', '1111111111', 'gabrielturner@example.com', '1992-05-03', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(86, 'Mila Scott', 'pass123', 'Female', '2222222222', 'milascott@example.com', '1995-09-17', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(87, 'Carter Morgan', 'abc123', 'Male', '3333333333', 'cartermorgan@example.com', '1987-02-02', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(88, 'Abigail Murphy', 'qwerty123', 'Female', '4444444444', 'abigailmurphy@example.com', '1993-07-18', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(89, 'Dylan Allen', 'pass456', 'Male', '5555555555', 'dylanallen@example.com', '1991-12-03', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(90, 'Sophie Adams', 'xyz789', 'Female', '6666666666', 'sophieadams@example.com', '1990-05-18', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(91, 'Owen Lewis', 'secret123', 'Male', '7777777777', 'owenlewis@example.com', '1988-10-02', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(92, 'Elizabeth Young', 'pass123', 'Female', '8888888888', 'elizabethyoung@example.com', '1993-02-16', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(93, 'Luke Hall', 'abc789', 'Male', '9999999999', 'lukehall@example.com', '1992-07-03', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(94, 'Scarlett Hill', 'qwerty456', 'Female', '1111111111', 'scarletthill@example.com', '1989-11-18', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(95, 'Julian Hernandez', 'pass456', 'Male', '2222222222', 'julianhernandez@example.com', '1994-04-05', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(96, 'Avery Rodriguez', 'xyz123', 'Female', '3333333333', 'averyrodriguez@example.com', '1991-08-20', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(97, 'Sofia Walker', 'secret789', 'Female', '4444444444', 'sofiawalker@example.com', '1993-01-05', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(98, 'Sebastian Turner', 'pass789', 'Male', '5555555555', 'sebastianturner@example.com', '1992-06-20', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(99, 'Lucy Foster', 'abc123', 'Female', '6666666666', 'lucyfoster@example.com', '1990-11-05', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(100, 'Connor Powell', 'qwerty789', 'Male', '7777777777', 'connorpowell@example.com', '1988-04-20', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(101, 'Ahoyz', '123', 'Female', '0930920392', 'Ahoyz@test.com', '2023-07-17', 'preset-icon.png', '2023-07-17 10:29:11', 3, 1),
(103, 'yourMother', '12345', 'Female', '0909123333', 'nihao@test.com', '2020-02-02', 'preset-icon.png', '2023-10-05 23:27:57', 1, 1),
(104, '測試註冊', '12345', 'Male', '0909129873', 'trytry@email.com', '1925-04-01', 'preset-icon.png', '2023-10-05 23:47:59', 1, 1),
(105, 'LaiPinRuei', '0930006892', 'Male', '0930006892', 'zwilmin860924@gmail.com', '1944-04-04', 'preset-icon.png', '2023-10-05 23:55:48', 1, 1),
(106, '測試驗證拆分', '12345', 'Male', '0909123456', 'valiTest@test.com', '2021-02-03', 'preset-icon.png', '2023-10-06 03:29:50', 1, 1),
(107, '測試正規表達式', 'Q12345678', 'Male', '0912312312', 'TestRegeX@test.com', '1928-05-03', 'preset-icon.png', '2023-10-06 04:12:51', 1, 1);

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- 在傾印的資料表使用自動遞增(AUTO_INCREMENT)
--

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `users`
--
ALTER TABLE `users`
  MODIFY `id` int(7) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
