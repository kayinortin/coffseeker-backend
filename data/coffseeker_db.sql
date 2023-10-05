-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- 主機： 127.0.0.1
-- 產生時間： 2023-10-05 21:18:31
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
-- 資料表結構 `categories`
--

CREATE TABLE `categories` (
  `categories_id` int(3) NOT NULL,
  `categories_name` varchar(20) NOT NULL,
  `valid` tinyint(2) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `categories`
--

INSERT INTO `categories` (`categories_id`, `categories_name`, `valid`) VALUES
(1, '精選咖啡豆', 1),
(2, '咖啡綜合禮品', 1),
(3, '咖啡用具', 1),
(4, '咖啡飲用器具', 1),
(5, '咖啡機台', 1),
(6, '其他咖啡機具 ', 1),
(7, '咖啡書籍', 1),
(8, '咖啡課程', 1),
(9, 'test', 0),
(10, 'Test2', 0),
(11, 'Ahoyz', 0);

-- --------------------------------------------------------

--
-- 資料表結構 `categories_item`
--

CREATE TABLE `categories_item` (
  `items_id` int(3) NOT NULL,
  `items_name` varchar(20) NOT NULL,
  `valid` tinyint(4) NOT NULL DEFAULT 1,
  `categories_id` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `categories_item`
--

INSERT INTO `categories_item` (`items_id`, `items_name`, `valid`, `categories_id`) VALUES
(1, '咖啡豆', 1, 1),
(2, '咖啡粉', 1, 1),
(3, '濾掛式咖啡包', 1, 1),
(4, '即溶式咖啡', 1, 1),
(5, '咖啡豆禮盒', 1, 2),
(6, '咖啡粉禮盒', 1, 2),
(7, '濾掛式禮盒', 1, 2),
(8, '綜合大禮盒', 1, 2),
(9, '盎司杯', 1, 3),
(10, '濾杯', 1, 3),
(11, '濾紙', 1, 3),
(12, '咖啡豆/粉專用勺', 1, 3),
(13, '拉花杯', 1, 3),
(14, '電子溫度計', 1, 3),
(15, '電子定時器', 1, 3),
(16, '電子磅秤', 1, 3),
(17, '咖啡壺', 1, 4),
(18, '咖啡杯', 1, 4),
(19, '滴漏式咖啡機', 1, 5),
(20, '半自動義式咖啡機', 1, 5),
(21, '全自動義式咖啡機', 1, 5),
(22, '膠囊咖啡機', 1, 5),
(23, '手動磨豆機', 1, 6),
(24, '烘豆機', 1, 6),
(26, '奶泡機', 1, 6),
(27, '虹吸機', 1, 6),
(33, '咖啡膠囊', 1, 1),
(34, '冷萃咖啡', 1, 1),
(35, '咖啡碟', 1, 4),
(36, '拿鐵杯', 1, 4),
(37, '雙層玻璃杯', 1, 4),
(38, '陶瓷杯', 1, 4),
(39, '不鏽鋼杯', 1, 4),
(40, '馬克杯', 1, 4),
(41, '冰咖啡杯', 1, 4),
(42, '咖啡瓶', 1, 4),
(43, '手動磨豆機', 1, 3),
(44, '電動磨豆機', 1, 6),
(45, '咖啡壓縮器', 1, 6),
(46, '咖啡杯稱重器', 1, 3),
(47, '冷萃器', 1, 3),
(48, '咖啡水壺', 1, 3),
(49, '咖啡工具禮盒', 1, 2),
(50, 'test2', 1, 1),
(51, 'test', 0, 10);

-- --------------------------------------------------------

--
-- 資料表結構 `coffseeker_teachers`
--

CREATE TABLE `coffseeker_teachers` (
  `teacher_id` int(6) NOT NULL,
  `teacher_name` text NOT NULL,
  `teacher_phone` varchar(13) NOT NULL,
  `teacher_gender` text NOT NULL,
  `teacher_mail` text NOT NULL,
  `teacher_qualification` longtext NOT NULL,
  `teacher_experience` int(11) NOT NULL,
  `teacher_specialty` text NOT NULL,
  `created_at` date NOT NULL,
  `valid` tinyint(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `coffseeker_teachers`
--

INSERT INTO `coffseeker_teachers` (`teacher_id`, `teacher_name`, `teacher_phone`, `teacher_gender`, `teacher_mail`, `teacher_qualification`, `teacher_experience`, `teacher_specialty`, `created_at`, `valid`) VALUES
(1, '張小蘭', '0912-345678', '女', 'zhangxiaolan@example.com ', '咖啡師證照', 5, '特色咖啡調製', '2020-02-15', 1),
(2, '王大明', '0921-987654', '男', 'wangdaming@example.com', '咖啡品鑑師', 8, '咖啡品質控制', '2021-07-21', 1),
(3, '李小雪', '0933-246810', '女', 'lixiaoxue@example.com', '咖啡萃取師', 3, '手沖咖啡', '2019-09-12', 1),
(4, '陳志豪', '0988-135790', '男', 'chenzhihao@example.com', '咖啡烘焙師', 6, '特殊風味咖啡', '2022-05-27', 1),
(5, '林美玲', '0955-864209', '女', 'linmeiling@example.com', '咖啡萃取師', 4, '義式濃縮咖啡', '2023-02-06', 1),
(6, '黃建國', '0977-567890', '男', 'huangjianguo@example.com', '咖啡師證照', 7, '手工調製咖啡', '2022-02-10', 1),
(7, '劉小婷', '0966-123456', '女', 'liuxiaoting@example.com', '咖啡品鑑師', 9, '咖啡品質控制', '2019-07-06', 1),
(8, '張宏偉', '0944-789012', '男', 'zhanghongwei@example.com', '咖啡烘焙師', 5, '香草風味咖啡', '2021-05-20', 1),
(9, '李佳玲', '0922-567891', '女', 'lijialing@example.com', '咖啡萃取師', 2, '摩卡風味咖啡', '2020-11-13', 1),
(10, '王俊宏', '0931-234567', '男', 'wangjunhong@example.com', '咖啡師證照', 4, '花香風味咖啡', '2019-09-30', 1),
(11, '蔡淑芳', '0937-258513', '女', ' shaufang@example.com', '咖啡烘焙師', 6, '深焙咖啡', '2021-07-10', 1),
(12, '陳建平', '0955-518447', '男', 'chienping@example.com', '咖啡萃取師', 4, '冰滴咖啡', '2019-11-23', 1),
(25, 'Tommy', '0978787878', '男', 'tommy@test.com', 'tommy', 3, '特色咖啡調製', '2023-07-15', 1),
(64, 'YENTE', '0970812816', '男', 'kayinortin@hotmail.com', '咖啡師證照, 咖啡品鑑師', 3, '睡覺', '2023-07-16', 1),
(65, 'YEN', '09708128', '男', 'kayinor@hotmail.com', '咖啡萃取師, 咖啡烘焙師, 睡覺', 5, '睡覺唷', '2023-07-16', 1);

-- --------------------------------------------------------

--
-- 資料表結構 `coupon`
--

CREATE TABLE `coupon` (
  `coupon_id` int(5) NOT NULL,
  `coupon_name` text NOT NULL,
  `coupon_code` varchar(10) NOT NULL,
  `coupon_valid` tinyint(4) NOT NULL,
  `valid_description` varchar(255) NOT NULL,
  `discount_type` text NOT NULL,
  `discount_value` varchar(10) NOT NULL,
  `start_at` date NOT NULL,
  `expires_at` date NOT NULL,
  `created_at` date NOT NULL,
  `updated_at` date NOT NULL,
  `max_usage` int(5) NOT NULL,
  `used_times` int(5) NOT NULL,
  `price_min` int(11) NOT NULL,
  `usage_restriction` varchar(50) NOT NULL,
  `user_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `coupon`
--

INSERT INTO `coupon` (`coupon_id`, `coupon_name`, `coupon_code`, `coupon_valid`, `valid_description`, `discount_type`, `discount_value`, `start_at`, `expires_at`, `created_at`, `updated_at`, `max_usage`, `used_times`, `price_min`, `usage_restriction`, `user_id`) VALUES
(2, '春暖花開', 'fsdfaa', 0, '已刪除', '金額', '30', '2023-07-19', '2023-07-28', '2023-07-11', '2023-07-11', 10, 0, 100, '限定商店使用', 0),
(3, '現金折價卷', 'fsdfaa', 0, '已刪除', '金額', '30', '2023-07-19', '2023-08-24', '2023-07-11', '2023-07-16', 1, 0, 100, '資策會限定', 0),
(4, '買一送一卷', 'VKARK445a', -1, '已停用', '百分比', '50%', '2023-06-26', '2023-06-29', '2023-07-11', '2023-07-19', 3, 0, 100, '想望咖啡', 0),
(5, '外送免運卷', 'rjofkjo816', 1, '可使用', '金額', '50', '2023-07-20', '2023-07-27', '2023-07-11', '2023-07-19', 5, 0, 100, 'PR咖啡', 0),
(6, '外送免運卷', 'rjofkja816', 0, '已刪除', '金額', '30', '2023-07-19', '2023-07-27', '2023-07-11', '2023-07-11', 15, 0, 100, '炎炎夏日', 0),
(7, '外送免運卷', 'rjofkja816', 0, '已刪除', '金額', '3', '2023-07-21', '2023-07-27', '2023-07-11', '2023-07-19', 5, 0, 200, 'PR咖啡', 0),
(8, '春光佐茶', 'Ed875daA95', 1, '可使用', '百分比', '100%', '2023-07-19', '2023-07-28', '2023-07-11', '2023-07-19', 1, 0, 100, 'PR咖啡', 0),
(9, '春暖花開', 'EAFASF5412', -1, '已停用', '百分比', '99%', '2023-07-19', '2023-07-20', '2023-07-11', '2023-07-19', 1, 0, 200, '想望咖啡', 0),
(10, '春暖花開', 'KLPcoXwYSQ', 0, '已刪除', '金額', '200', '2023-07-18', '2023-08-03', '2023-07-12', '2023-07-19', 1, 0, 100, 'PR咖啡', 0),
(11, '外送好事多', 'UnNqaTu1oX', -1, '已停用', '金額', '10', '2023-07-19', '2023-08-03', '2023-07-16', '2023-07-16', 1, 0, 100, '春暖花開', 0),
(12, '週末逛大街', 'ziLHYA6dOM', -1, '已停用', '金額', '50', '2023-07-19', '2023-08-04', '2023-07-16', '2023-07-16', 1, 0, 100, '夏季大賞', 0),
(13, '週末喝咖啡', 'xJd5lik9Ta', 1, '可使用', '百分比', '2%', '2023-07-19', '2023-08-19', '2023-07-16', '2023-07-16', 1, 0, 100, '夏季大賞', 0),
(14, '週末下午茶', 'ntuAVo3wj8', -1, '已停用', '金額', '799', '2023-07-19', '2023-08-04', '2023-07-16', '2023-07-19', 1, 0, 10000, 'PR咖啡', 0),
(15, '週末逛大街', 'jsOsuTnnm7', 1, '可使用', '金額', '300', '2023-07-19', '2023-08-04', '2023-07-16', '2023-07-16', 1, 0, 100, '夏季大賞', 0),
(16, '外送好事多', 'KtiRPP3RVQ', 1, '可使用', '金額', '300', '2023-07-19', '2023-07-29', '2023-07-16', '2023-07-16', 1, 0, 100, '單筆消費滿10000', 0),
(17, '春暖花開', 'xAmJxhhjPx', 1, '可使用', '百分比', '2%', '2023-07-19', '2023-08-03', '2023-07-16', '2023-07-16', 1, 0, 100, '單筆消費滿10000', 0),
(18, '春暖花開', 'LI2FM5MBhU', -1, '已停用', '百分比', '2%', '2023-07-19', '2023-08-03', '2023-07-16', '2023-07-16', 4, 0, 100, '單筆消費滿10000', 0),
(19, '春暖花開', 'LI2FM5MBhU', 0, '已刪除', '百分比', '2%', '2023-07-19', '2023-08-03', '2023-07-16', '2023-07-16', 4, 0, 100, '單筆消費滿10000', 0),
(20, '週末逛大街', 'xg06hv9OAr', -1, '已停用', '金額', '100', '2023-07-19', '2023-08-03', '2023-07-16', '2023-07-16', 4, 0, 100, '單筆消費滿10000', 0),
(21, '陽光海灘', '2hvHh9RFQp', 1, '可使用', '金額', '200', '2023-07-01', '2023-07-20', '2023-07-19', '2023-07-19', 2, 0, 500, '薩圖爾精品咖啡', 0),
(22, '春暖花開', 'yyigUl7qPq', 1, '可使用', '金額', '300', '2023-07-19', '2023-08-05', '2023-07-19', '2023-07-19', 2, 0, 500, '黑浮咖啡', 0),
(23, '春暖花開', 'ID8rHaGfjW', 1, '可使用', '百分比', '2%', '2023-07-19', '2023-07-31', '2023-07-19', '2023-07-19', 1, 0, 100, 'PR咖啡', 0),
(24, '春暖花開', 'CY46ALIfDM', -1, '已停用', '百分比', '2%', '2023-07-20', '2023-08-05', '2023-07-19', '2023-07-19', 4, 0, 100, '奎克咖啡', 0),
(25, '春暖花開', 'Ly4WYG5xEV', 1, '可使用', '百分比', '5%', '2023-07-20', '2023-07-20', '2023-07-19', '2023-07-19', 4, 0, 500, '奎克咖啡', 0),
(26, '春暖花開', 'Pc29j2acwD', -1, '已停用', '百分比', '2%', '2023-07-12', '2023-07-15', '2023-07-19', '2023-07-19', 1, 0, 200, '薩圖爾精品咖啡', 0),
(27, '春暖花開', 'mknxQIzIz5', -1, '已停用', '百分比', '2%', '2023-07-12', '2023-07-15', '2023-07-19', '2023-07-19', 2, 0, 500, '黑浮咖啡', 0),
(28, '春暖花開', 'Zy65RvfDgE', -1, '已停用', '百分比', '2%', '2023-07-16', '2023-07-18', '2023-07-19', '2023-07-19', 1, 0, 200, '哈本咖啡 Happen Coffee', 0),
(29, '外送免運卷', 'cTq2xTFzha', -1, '已停用', '百分比', '2%', '2023-07-20', '2023-07-27', '2023-07-19', '2023-07-19', 1, 0, 500, 'JC咖啡', 0),
(30, '週末逛大街', 'WcHL2RGNF4', -1, '已停用', '百分比', '2%', '2023-06-25', '2023-06-30', '2023-07-19', '2023-07-19', 4, 0, 500, 'Simple Kaffa 興波咖啡', 0),
(31, '週末逛大街', 'faacnZqSAn', -1, '已停用', '金額', '100', '2023-07-02', '2023-07-06', '2023-07-19', '2023-07-19', 1, 0, 222, 'Simple Kaffa 興波咖啡', 0),
(32, '春暖花開', 'ovAs7ytNFV', -1, '已停用', '百分比', '2%', '2023-06-27', '2023-06-30', '2023-07-19', '2023-07-19', 5, 0, 500, 'Simple Kaffa 興波咖啡', 0),
(33, '春暖花開', 'Ap5BqLt7Im', -1, '已停用', '金額', '200', '2023-07-03', '2023-07-05', '2023-07-19', '2023-07-19', 2, 0, 500, 'CoFeel凱飛', 0),
(34, '週末下午茶', 't4CHneNeMF', -1, '已停用', '百分比', '5%', '2023-06-27', '2023-07-01', '2023-07-19', '2023-07-19', 4, 0, 200, 'Simple Kaffa 興波咖啡', 0);

-- --------------------------------------------------------

--
-- 資料表結構 `course`
--

CREATE TABLE `course` (
  `course_id` int(10) NOT NULL,
  `course_name` varchar(26) NOT NULL,
  `course_type_id` int(10) NOT NULL,
  `course_level_id` int(5) NOT NULL,
  `teacher_id` int(10) NOT NULL,
  `course_price` int(10) NOT NULL,
  `sign_start_date` date NOT NULL,
  `sign_end_date` date NOT NULL,
  `course_start_date` date NOT NULL,
  `course_end_date` date NOT NULL,
  `course_location_id` int(5) NOT NULL,
  `course_capacity` int(5) NOT NULL,
  `course_description` text NOT NULL,
  `course_image` varchar(50) NOT NULL,
  `course_created_at` datetime NOT NULL,
  `course_valid` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `course`
--

INSERT INTO `course` (`course_id`, `course_name`, `course_type_id`, `course_level_id`, `teacher_id`, `course_price`, `sign_start_date`, `sign_end_date`, `course_start_date`, `course_end_date`, `course_location_id`, `course_capacity`, `course_description`, `course_image`, `course_created_at`, `course_valid`) VALUES
(1, '咖啡拉花入門班', 1, 1, 1, 1000, '2023-07-01', '2023-07-13', '2023-07-15', '2023-07-16', 1, 10, '入門咖啡拉花班，開啟你的咖啡藝術之旅！\n\n渴望在咖啡的世界中展現獨特的風采嗎？想要掌握咖啡拉花的技巧，成為一位優秀的咖啡師傅嗎？現在就加入我們的入門咖啡拉花班，讓我們一起點亮你的咖啡之夢！\n\n無論你是想在咖啡店工作、開設咖啡店，或者僅僅是想深入了解咖啡的世界，咖啡拉花入門班將是你打開大門的鑰匙。趕快加入我們，開始你的咖啡藝術之旅吧！', 'latte_1_1.jpg', '2023-04-01 09:24:30', 2),
(2, '咖啡拉花入門班', 1, 1, 3, 1000, '2023-07-01', '2023-07-13', '2023-07-15', '2023-07-16', 3, 10, '入門咖啡拉花班，開啟你的咖啡藝術之旅！  渴望在咖啡的世界中展現獨特的風采嗎？想要掌握咖啡拉花的技巧，成為一位優秀的咖啡師傅嗎？現在就加入我們的入門咖啡拉花班，讓我們一起點亮你的咖啡之夢！  無論你是想在咖啡店工作、開設咖啡店，或者僅僅是想深入了解咖啡的世界，咖啡拉花入門班將是你打開大門的鑰匙。趕快加入我們，開始你的咖啡藝術之旅吧！', 'latte_1_1.jpg', '2023-04-01 09:24:30', 1),
(3, '咖啡拉花入門班', 1, 1, 2, 1000, '2023-07-08', '2023-07-20', '2023-07-22', '2023-07-23', 2, 10, '入門咖啡拉花班，開啟你的咖啡藝術之旅！\r\n\r\n渴望在咖啡的世界中展現獨特的風采嗎？想要掌握咖啡拉花的技巧，成為一位優秀的咖啡師傅嗎？現在就加入我們的入門咖啡拉花班，讓我們一起點亮你的咖啡之夢！\r\n\r\n無論你是想在咖啡店工作、開設咖啡店，或者僅僅是想深入了解咖啡的世界，咖啡拉花入門班將是你打開大門的鑰匙。趕快加入我們，開始你的咖啡藝術之旅吧！', 'latte_1_2.jpg', '2023-04-01 09:24:30', 1),
(4, '咖啡拉花入門班', 1, 1, 10, 1000, '2023-07-08', '2023-07-20', '2023-07-22', '2023-07-23', 4, 10, '入門咖啡拉花班，開啟你的咖啡藝術之旅！\n\n渴望在咖啡的世界中展現獨特的風采嗎？想要掌握咖啡拉花的技巧，成為一位優秀的咖啡師傅嗎？現在就加入我們的入門咖啡拉花班，讓我們一起點亮你的咖啡之夢！\n\n無論你是想在咖啡店工作、開設咖啡店，或者僅僅是想深入了解咖啡的世界，咖啡拉花入門班將是你打開大門的鑰匙。趕快加入我們，開始你的咖啡藝術之旅吧！', 'latte_1_3.jpg', '2023-04-01 09:24:30', 1),
(5, '咖啡拉花進階班', 1, 2, 1, 1500, '2023-07-14', '2023-07-27', '2023-07-29', '2023-07-30', 1, 10, '進階咖啡拉花班，提升你的咖啡藝術境界！\r\n\r\n尋求咖啡拉花技藝的進一步提升？渴望在咖啡藝術領域中展現卓越才華？現在就加入我們的精緻咖啡拉花進階課程，將你的咖啡技術提升到更高層次！', 'latte_2_1.jpg', '2023-04-04 09:24:30', 1),
(6, '咖啡拉花進階班', 1, 2, 2, 1500, '2023-07-14', '2023-07-27', '2023-07-29', '2023-07-30', 2, 10, '進階咖啡拉花班，提升你的咖啡藝術境界！\r\n\r\n尋求咖啡拉花技藝的進一步提升？渴望在咖啡藝術領域中展現卓越才華？現在就加入我們的精緻咖啡拉花進階課程，將你的咖啡技術提升到更高層次！', 'latte_2_2.jpg', '2023-04-04 09:24:30', 1),
(7, '咖啡拉花進階班', 1, 2, 3, 1500, '2023-07-14', '2023-07-27', '2023-07-29', '2023-07-30', 3, 10, '進階咖啡拉花班，提升你的咖啡藝術境界！\r\n\r\n尋求咖啡拉花技藝的進一步提升？渴望在咖啡藝術領域中展現卓越才華？現在就加入我們的精緻咖啡拉花進階課程，將你的咖啡技術提升到更高層次！', 'latte_2_3.jpg', '2023-04-04 09:24:30', 1),
(8, '咖啡拉花高階班', 1, 3, 1, 1500, '2023-07-14', '2023-08-03', '2023-08-05', '2023-08-06', 1, 10, '進階咖啡拉花班，提升你的咖啡藝術境界！\n\n尋求咖啡拉花技藝的進一步提升？渴望在咖啡藝術領域中展現卓越才華？現在就加入我們的精緻咖啡拉花進階課程，將你的咖啡技術提升到更高層次！', 'latte_3_1.jpg', '2023-04-06 09:24:30', 1),
(9, '咖啡拉花高階班', 1, 3, 2, 1500, '2023-07-14', '2023-08-03', '2023-08-05', '2023-08-06', 2, 10, '進階咖啡拉花班，提升你的咖啡藝術境界！\r\n\r\n尋求咖啡拉花技藝的進一步提升？渴望在咖啡藝術領域中展現卓越才華？現在就加入我們的精緻咖啡拉花進階課程，將你的咖啡技術提升到更高層次！', 'latte_3_2.jpg', '2023-04-06 09:24:30', 1),
(10, '咖啡拉花高階班', 1, 3, 3, 1500, '2023-07-14', '2023-08-03', '2023-08-05', '2023-08-06', 3, 10, '進階咖啡拉花班，提升你的咖啡藝術境界！\r\n\r\n尋求咖啡拉花技藝的進一步提升？渴望在咖啡藝術領域中展現卓越才華？現在就加入我們的精緻咖啡拉花進階課程，將你的咖啡技術提升到更高層次！', 'latte_3_3.jpg', '2023-04-06 09:24:30', 1),
(11, '咖啡手沖入門班', 2, 1, 4, 4000, '2023-07-01', '2023-07-13', '2023-07-15', '2023-07-16', 1, 10, '咖啡手沖入門班，啟迪你的手沖咖啡之旅！\r\n\r\n對於咖啡的風味和品質有極高要求嗎？想要親自體驗手沖咖啡的獨特魅力嗎？現在就加入我們的咖啡手沖入門班，開啟你的咖啡沖煮之旅！\r\n\r\n不論你是咖啡愛好者還是對咖啡店工作充滿熱情，我們的課程都能夠滿足你的需求。我們提供實際操作的機會，讓你在專業的環境中磨練手沖技巧，並獲得寶貴的實踐經驗。', 'pour_1_1.jpg', '2023-04-01 09:24:30', 2),
(12, '咖啡手沖入門班', 2, 1, 4, 4000, '2023-07-08', '2023-07-20', '2023-07-22', '2023-07-23', 1, 10, '咖啡手沖入門班，啟迪你的手沖咖啡之旅！\r\n\r\n對於咖啡的風味和品質有極高要求嗎？想要親自體驗手沖咖啡的獨特魅力嗎？現在就加入我們的咖啡手沖入門班，開啟你的咖啡沖煮之旅！\r\n\r\n不論你是咖啡愛好者還是對咖啡店工作充滿熱情，我們的課程都能夠滿足你的需求。我們提供實際操作的機會，讓你在專業的環境中磨練手沖技巧，並獲得寶貴的實踐經驗。', 'pour_1_1.jpg', '2023-04-01 09:24:30', 1),
(13, '咖啡手沖入門班', 2, 1, 5, 4000, '2023-07-08', '2023-07-20', '2023-07-22', '2023-07-23', 2, 10, '咖啡手沖入門班，啟迪你的手沖咖啡之旅！\r\n\r\n對於咖啡的風味和品質有極高要求嗎？想要親自體驗手沖咖啡的獨特魅力嗎？現在就加入我們的咖啡手沖入門班，開啟你的咖啡沖煮之旅！\r\n\r\n不論你是咖啡愛好者還是對咖啡店工作充滿熱情，我們的課程都能夠滿足你的需求。我們提供實際操作的機會，讓你在專業的環境中磨練手沖技巧，並獲得寶貴的實踐經驗。', 'pour_1_2.jpg', '2023-04-01 09:24:30', 1),
(14, '咖啡手沖入門班', 2, 1, 6, 1000, '2023-07-08', '2023-07-21', '2023-07-22', '2023-07-23', 3, 10, '咖啡手沖入門班，啟迪你的手沖咖啡之旅！\r\n\r\n對於咖啡的風味和品質有極高要求嗎？想要親自體驗手沖咖啡的獨特魅力嗎？現在就加入我們的咖啡手沖入門班，開啟你的咖啡沖煮之旅！\r\n\r\n不論你是咖啡愛好者還是對咖啡店工作充滿熱情，我們的課程都能夠滿足你的需求。我們提供實際操作的機會，讓你在專業的環境中磨練手沖技巧，並獲得寶貴的實踐經驗。', 'pour_1_3.jpg', '2023-04-01 09:24:30', 1),
(15, '咖啡手沖進階班', 2, 2, 4, 1500, '2023-07-14', '2023-07-28', '2023-07-29', '2023-07-30', 1, 10, '咖啡手沖進階班，探索咖啡的無限深度！\n\n你已經熟練掌握了基本的手沖咖啡技巧嗎？渴望進一步挑戰咖啡的藝術極限嗎？現在就加入我們的咖啡手沖進階班，開啟你咖啡沖煮的新境界！\n\n無論你是追求沖煮藝術的卓越完美，還是渴望在咖啡行業中取得更大成就，咖啡手沖進階班將為你實現這些理想打下堅實的基礎。立即加入我們，一同探索咖啡的無限深度！', 'pour_2_1.jpg', '2023-04-15 09:24:30', 1),
(16, '咖啡手沖進階班', 2, 2, 5, 1500, '2023-07-14', '2023-07-28', '2023-07-29', '2023-07-30', 2, 10, '咖啡手沖進階班，探索咖啡的無限深度！\r\n\r\n你已經熟練掌握了基本的手沖咖啡技巧嗎？渴望進一步挑戰咖啡的藝術極限嗎？現在就加入我們的咖啡手沖進階班，開啟你咖啡沖煮的新境界！\r\n\r\n無論你是追求沖煮藝術的卓越完美，還是渴望在咖啡行業中取得更大成就，咖啡手沖進階班將為你實現這些理想打下堅實的基礎。立即加入我們，一同探索咖啡的無限深度！', 'pour_2_2.jpg', '2023-04-15 09:24:30', 1),
(17, '咖啡手沖進階班', 2, 2, 6, 1500, '2023-07-14', '2023-07-28', '2023-07-29', '2023-07-30', 3, 10, '咖啡手沖進階班，探索咖啡的無限深度！\r\n\r\n你已經熟練掌握了基本的手沖咖啡技巧嗎？渴望進一步挑戰咖啡的藝術極限嗎？現在就加入我們的咖啡手沖進階班，開啟你咖啡沖煮的新境界！\r\n\r\n無論你是追求沖煮藝術的卓越完美，還是渴望在咖啡行業中取得更大成就，咖啡手沖進階班將為你實現這些理想打下堅實的基礎。立即加入我們，一同探索咖啡的無限深度！', 'pour_2_3.jpg', '2023-04-15 09:24:30', 1),
(18, '咖啡手沖高階班', 2, 3, 4, 5000, '2023-07-14', '2023-08-03', '2023-08-05', '2023-08-06', 1, 10, '咖啡手沖高階班，超越極致的咖啡沖煮之境！\n\n你已經掌握了手沖咖啡的精髓技巧嗎？追求在咖啡藝術的巔峰超越自我嗎？現在就加入我們的咖啡手沖高階班，啟迪你對咖啡沖煮的極致探索！', 'pour_3_1.jpg', '2023-04-15 09:24:30', 1),
(19, '咖啡手沖高階班', 2, 3, 5, 5000, '2023-07-14', '2023-08-03', '2023-08-05', '2023-08-06', 2, 10, '咖啡手沖高階班，超越極致的咖啡沖煮之境！\n\n你已經掌握了手沖咖啡的精髓技巧嗎？追求在咖啡藝術的巔峰超越自我嗎？現在就加入我們的咖啡手沖高階班，啟迪你對咖啡沖煮的極致探索！', 'pour_3_2.jpg', '2023-04-15 09:24:30', 1),
(20, '咖啡手沖高階班', 2, 3, 6, 5000, '2023-07-14', '2023-08-03', '2023-08-05', '2023-08-06', 3, 10, '咖啡手沖高階班，超越極致的咖啡沖煮之境！\n\n你已經掌握了手沖咖啡的精髓技巧嗎？追求在咖啡藝術的巔峰超越自我嗎？現在就加入我們的咖啡手沖高階班，啟迪你對咖啡沖煮的極致探索！', 'pour_3_3.jpg', '2023-04-15 09:24:30', 1),
(21, '咖啡感官入門班', 5, 1, 7, 1000, '2023-07-12', '2023-07-19', '2023-07-20', '2023-07-21', 1, 10, '一起來參加咖啡感官入門班課程吧！', '', '2023-07-13 12:39:43', 1),
(23, '咖啡綜合入門班', 6, 1, 6, 2000, '2023-07-14', '2023-07-28', '2023-07-29', '2023-07-30', 1, 10, '一起來參加咖啡綜合入門班吧！', '', '2023-07-14 13:12:07', 2);

-- --------------------------------------------------------

--
-- 資料表結構 `course_level`
--

CREATE TABLE `course_level` (
  `course_level_id` int(5) NOT NULL,
  `course_level_name` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `course_level`
--

INSERT INTO `course_level` (`course_level_id`, `course_level_name`) VALUES
(1, '入門'),
(2, '進階'),
(3, '高階'),
(4, '證照');

-- --------------------------------------------------------

--
-- 資料表結構 `course_location`
--

CREATE TABLE `course_location` (
  `course_location_id` int(5) NOT NULL,
  `course_location_name` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `course_location`
--

INSERT INTO `course_location` (`course_location_id`, `course_location_name`) VALUES
(1, '北部'),
(2, '中部'),
(3, '南部'),
(4, '線上');

-- --------------------------------------------------------

--
-- 資料表結構 `course_type`
--

CREATE TABLE `course_type` (
  `course_type_id` int(5) NOT NULL,
  `course_type_name` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `course_type`
--

INSERT INTO `course_type` (`course_type_id`, `course_type_name`) VALUES
(1, '拉花'),
(2, '手沖'),
(3, '烘焙'),
(4, '萃取'),
(5, '感官'),
(6, '綜合');

-- --------------------------------------------------------

--
-- 資料表結構 `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `order_products` varchar(300) NOT NULL,
  `order_amount` varchar(50) NOT NULL,
  `order_price` int(10) NOT NULL,
  `order_user` varchar(30) NOT NULL,
  `order_created_at` datetime NOT NULL,
  `order_state` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `orders`
--

INSERT INTO `orders` (`order_id`, `order_products`, `order_amount`, `order_price`, `order_user`, `order_created_at`, `order_state`) VALUES
(1, '拉斯布魯哈斯 瑰夏水洗 2022 COFFEE HUNTERS ,\r\n聖米格爾農園 自然處理 (San Miguel Natural),\r\n伊凡的回憶(Recuerdo de Ivan),', '1,2,3', 3000, 'John Doe', '2023-07-15 11:27:54', 2),
(2, '拉斯布魯哈斯 瑰夏水洗 2022 COFFEE HUNTERS ,\r\n聖米格爾農園 自然處理 (San Miguel Natural),\r\n伊凡的回憶(Recuerdo de Ivan),', '1,2,3', 3000, 'Jane Smith', '2023-07-15 11:27:54', 2),
(3, '拉斯布魯哈斯 瑰夏水洗 2022 COFFEE HUNTERS ,\r\n聖米格爾農園 自然處理 (San Miguel Natural),\r\n伊凡的回憶(Recuerdo de Ivan),', '1,2,3', 3000, 'David Johnson', '2023-07-15 11:27:54', 3),
(4, '拉斯布魯哈斯 瑰夏水洗 2022 COFFEE HUNTERS ,\r\n聖米格爾農園 自然處理 (San Miguel Natural),\r\n伊凡的回憶(Recuerdo de Ivan),', '1,2,3', 3000, 'Sarah Williams', '2023-07-15 11:27:54', 4),
(5, '拉斯布魯哈斯 瑰夏水洗 2022 COFFEE HUNTERS ,\r\n聖米格爾農園 自然處理 (San Miguel Natural),\r\n伊凡的回憶(Recuerdo de Ivan),', '1,2,3', 3000, 'Michael Brown', '2023-07-15 11:27:54', 0),
(6, '拉斯布魯哈斯 瑰夏水洗 2022 COFFEE HUNTERS ,\r\n聖米格爾農園 自然處理 (San Miguel Natural),\r\n伊凡的回憶(Recuerdo de Ivan),', '1,2,3', 3000, 'Emily Davis', '2023-07-15 11:27:54', -1);

-- --------------------------------------------------------

--
-- 資料表結構 `order_states`
--

CREATE TABLE `order_states` (
  `states_id` int(11) NOT NULL,
  `states_valid` tinyint(4) NOT NULL,
  `states` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `order_states`
--

INSERT INTO `order_states` (`states_id`, `states_valid`, `states`) VALUES
(1, -1, '訂單完成'),
(2, 0, '訂單取消'),
(3, 1, '下訂完成'),
(4, 2, '訂單確認'),
(5, 3, '整貨中'),
(6, 4, '已出貨');

-- --------------------------------------------------------

--
-- 資料表結構 `otp`
--

CREATE TABLE `otp` (
  `id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `token` int(200) DEFAULT NULL,
  `exp_timestamp` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `otp`
--

INSERT INTO `otp` (`id`, `user_id`, `email`, `token`, `exp_timestamp`) VALUES
(1, 3, 'kayinortin@hotmail.com', 101680, 1695580715584),
(2, 3, 'kayinortin@hotmail.com', 668619, 1695581161613),
(4, 3, 'kayinortin@hotmail.com', 742980, 1695581767384),
(5, 3, 'kayinortin@hotmail.com', 369321, 1695581807130),
(6, 3, 'kayinortin@hotmail.com', 807361, 1695582168912),
(7, 3, 'kayinortin@hotmail.com', 868751, 1695582198044),
(8, 3, 'kayinortin@hotmail.com', 858946, 1695582273317),
(9, 3, 'kayinortin@hotmail.com', 570746, 1695582407774),
(10, 3, 'kayinortin@hotmail.com', 334055, 1695582579811),
(11, 3, 'kayinortin@hotmail.com', 522109, 1695582615142),
(14, 3, 'kayinortin@hotmail.com', 826063, 1696186035660),
(15, 3, 'kayinortin@hotmail.com', 826063, 1696186037102),
(16, 3, 'kayinortin@hotmail.com', 454804, 1696370199705),
(17, 3, 'kayinortin@hotmail.com', 716068, 1696405954741);

-- --------------------------------------------------------

--
-- 資料表結構 `product`
--

CREATE TABLE `product` (
  `id` int(4) NOT NULL,
  `name` varchar(50) NOT NULL,
  `image` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`image`)),
  `image_main` varchar(255) NOT NULL,
  `brand` varchar(20) NOT NULL,
  `amount` int(10) NOT NULL,
  `price` int(10) NOT NULL,
  `discountPrice` int(11) NOT NULL,
  `description` text NOT NULL,
  `product_category` int(5) NOT NULL,
  `popularity` int(11) NOT NULL,
  `views` int(11) NOT NULL,
  `dateAdded` date NOT NULL,
  `valid` int(4) NOT NULL,
  `origin` varchar(255) NOT NULL,
  `manor` varchar(255) NOT NULL,
  `Production area` varchar(255) NOT NULL,
  `Processing` varchar(255) NOT NULL,
  `altitude` varchar(255) NOT NULL,
  `Variety` varchar(255) NOT NULL,
  `Roast_degree` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `product`
--

INSERT INTO `product` (`id`, `name`, `image`, `image_main`, `brand`, `amount`, `price`, `discountPrice`, `description`, `product_category`, `popularity`, `views`, `dateAdded`, `valid`, `origin`, `manor`, `Production area`, `Processing`, `altitude`, `Variety`, `Roast_degree`) VALUES
(1, '巴拿馬 翡翠莊園 Jaramillo 綠標瑰夏 日曬', '[\"images/1-1.jpg\", \"images/1-2.jpg\", \"images/1-3.jpg\",\"images/1-4.jpg\"]', 'images/1-1.jpg', 'PR咖啡', 20, 500, 400, '莊園配方職人尋味系列', 1, 0, 0, '2023-10-02', 1, '', '', '', '', '', '', ''),
(2, '綜合濾掛咖啡禮盒', '', '', 'JC咖啡', 50, 800, 650, '濃縮烘焙咖啡豆義式配方\n', 2, 0, 0, '2023-10-25', 1, '', '', '', '', '', '', ''),
(3, '莊園濾掛咖啡', '', '', 'JC咖啡', 30, 1000, 800, '哥倫比亞\n', 1, 0, 0, '2023-10-03', 1, '', '', '', '', '', '', ''),
(4, '日常禮盒 x 日日好日 x 濾掛咖啡12入', '', '', 'Sit Down Plz Coffee ', 50, 500, 450, '\n\n材質｜350 磅象牙卡印刷\n尺寸｜25 x 18 x 7 cm\n容量｜12 包濾掛咖啡\n\n', 2, 205, 156, '1900-01-02', 1, '', '', '', '', '', '', ''),
(5, '鑽石山水洗 / 巴拿馬翡翠莊園 / 經典 / 咖啡豆 / 濾掛 /', '', '', 'Sit Down Plz Coffee', 73, 180, 100, '西當短評｜輕輕鬆鬆，酸甜好入喉～', 1, 100, 156, '2023-10-03', 1, '', '', '', '', '', '', ''),
(6, '救國者一號 / 配方豆 / 濾掛咖啡 / 咖啡豆', '', '', 'Sit Down Plz Coffee', 60, 900, 600, '風味描述｜茶花、牛奶糖、榛果、紅茶\n', 1, 100, 156, '2023-10-29', 1, '', '', '', '', '', '', ''),
(7, '小兔戰隊【濾掛咖啡】禮盒', '', '', 'Sit Down Plz Coffee', 20, 700, 600, '禮盒內容物\n酒香、荔枝、藝伎香、柑橘、經典、香草薰香！\n每款口味各二，一共 12包 + 紙製提袋', 2, 200, 156, '2023-10-17', 1, '', '', '', '', '', '', ''),
(8, '墨西哥 皮納塔 彩虹小馬 水洗 中深焙', '', '', '香馥咖啡豆專賣店', 10, 360, 240, '風味特色： 堅果、巧克力、榛果醬、乳脂感、酸甜平衡、圓潤滑順、甜感佳\n', 1, 200, 156, '2023-10-24', 1, '', '', '', '', '', '', ''),
(9, '巴西 喜拉朵 日曬 中焙', '', '', '香馥咖啡豆專賣店', 15, 220, 100, '風味特色：堅果可可風味、甜香中略帶點柑橘果酸\n', 1, 202, 156, '2023-10-26', 1, '', '', '', '', '', '', ''),
(10, '巴西 摩吉安娜 COE冠軍莊園 皇后莊園 去果皮日曬 中焙', '', '', '香馥咖啡豆專賣店', 60, 390, 190, '風味特色： 入口為堅果、柑橘香，餘韻為巧克力、榛果、黑糖、奶油風味，口感札實、平衡滑順。\n', 1, 210, 156, '0000-00-00', 1, '', '', '', '', '', '', ''),
(11, '黑浮咖啡-衣索比亞 瑰秘藝妓(日曬淺培)', '', '', '黑浮咖啡', 40, 500, 350, '風味 : 黑莓、紅石榴、柑橘', 1, 203, 156, '2023-10-18', 1, '', '', '', '', '', '', ''),
(12, '奎克咖啡-美國夏威夷/香草堅果(深培水洗)', '', '', '奎克咖啡', 60, 270, 200, '風味：獨特香草與堅果風味，喉韻回甘渾厚圓滿', 1, 200, 156, '1900-01-29', 1, '', '', '', '', '', '', ''),
(13, '奎克咖啡-哥倫比亞薇拉省/百果盛宴(特殊處理淺培)', '', '', '奎克咖啡', 111, 270, 100, '風味：青蘋果、百香果、接骨木花', 1, 800, 156, '2023-10-25', 1, '', '', '', '', '', '', ''),
(14, '黑浮咖啡-獨家配方豆', '', '', '黑浮咖啡', 50, 600, 400, '風味：明顯巧克力堅果及紅酒香氣，口感濃厚，尾韻回甘。', 1, 200, 156, '2023-10-30', 1, '', '', '', '', '', '', ''),
(15, '【新品上市】蜂蜜酒酒漬咖啡掛耳10入 | 中焙 | 自用款', '', '', '哈本咖啡 Happen Coffee', 40, 680, 490, '咖啡產區 ：巴拿馬、衣索比亞\n', 1, 200, 156, '2023-10-24', 1, '', '', '', '', '', '', ''),
(16, '【期間限定組合】獨家配方 + 世界風味 | 掛耳咖啡組合', '', '', '哈本咖啡 Happen Coffee', 20, 745, 500, '| 內容物\n(1) 獨家配方掛耳包 10g x 10入\n(2) 世界風味綜合精選掛耳包 10g x 10入', 1, 200, 156, '0000-00-00', 1, '', '', '', '', '', '', ''),
(17, '獨家配方 小黑貓 | 深焙 | 甘甜平衡 | 咖啡豆 200g', '', '', '哈本咖啡 Happen Coffee', 56, 400, 280, '風味筆記 : 可可、堅果、莓果微酸。', 1, 200, 156, '0000-00-00', 1, '', '', '', '', '', '', ''),
(18, '獨家配方 黑皮野驢 | 中焙 | 野性花香 | 咖啡豆 200g', '', '', '哈本咖啡 Happen Coffee', 89, 450, 300, '風味筆記 ： 紅茶、柑橘、帶點野性的花香和麥芽糖甜感', 0, 200, 156, '0000-00-00', 1, '', '', '', '', '', '', ''),
(19, '獨家配方 鐵道司令 | 深焙 | 醇厚香濃 | 咖啡豆 200g', '', '', '哈本咖啡 Happen Coffee', 4, 400, 200, '風味筆記 : 苦甜香濃、飽滿厚重、香料味。', 0, 200, 156, '0000-00-00', 1, '', '', '', '', '', '', ''),
(20, '哥斯大黎加 寶藏莊園 | 淺焙 | 黑蜜處理 | 咖啡豆 200g', '', '', '哈本咖啡 Happen Coffee', 11, 550, 430, '豐富酸甜感，糖蜜、香草、葡萄乾氣息，尾韻帶雪莉酒香', 0, 200, 156, '2023-10-25', 1, '', '', '', '', '', '', ''),
(21, '宏都拉斯 瓜拉拉佩 | 中焙 | 水洗 | 掛耳10入', '', '', '哈本咖啡 Happen Coffee', 32, 400, 300, '沉穩的木質香氣、甘蔗甜感、堅果香氣，低酸度並帶著黑巧克力的優質苦感，非常適合製成義式咖啡或加入牛奶', 0, 200, 156, '0000-00-00', 1, '', '', '', '', '', '', ''),
(22, 'CoFeel凱飛 我的貓BOSS │耶加雪菲│單品濾掛咖啡│10g', '', '', 'CoFeel凱飛', 23, 400, 350, '【參考風味】\r\n柑橘、橘子皮、花香、甜度高', 0, 200, 156, '0000-00-00', 1, '', '', '', '', '', '', ''),
(23, 'CoFeel凱飛 我的貓BOSS │黃金曼特寧│單品濾掛咖啡│10g', '', '', 'CoFeel凱飛', 9, 500, 300, '【參考風味】\r\n松木、焦糖奶油，尾韻甘甜', 0, 208, 156, '2023-10-19', 1, '', '', '', '', '', '', ''),
(24, 'CoFeel凱飛 我的貓BOSS │瓜地馬拉花神│單品濾掛咖啡│10g', '', '', 'CoFeel凱飛', 30, 600, 400, '【參考風味】\r\n香草香氣、烤焦糖香、白柚、龍眼乾、苦甜巧克力', 0, 200, 156, '1900-01-10', 1, '', '', '', '', '', '', ''),
(25, '想望咖啡【獨家】翡翠 低因咖啡豆200g/水洗/中焙', '', '', '想望咖啡', 20, 520, 430, '風味：無花果、杏桃、焦糖布丁', 0, 200, 156, '1900-01-16', 1, '', '', '', '', '', '', ''),
(26, '想望咖啡【北歐之道】卡蘿玫瑰精品咖啡豆200g/水洗/淺焙', '', '', '想望咖啡', 15, 600, 490, '風味筆記：玫瑰、白葡萄、橙花、白茶', 0, 200, 156, '0000-00-00', 1, '', '', '', '', '', '', ''),
(27, '想望咖啡【頂級90+】野薑花藝伎/乾發酵水洗/淺焙/咖啡豆', '', '', '想望咖啡', 80, 900, 720, '風味筆記：野薑花、荔枝、人參、茉莉花茶', 0, 200, 156, '0000-00-00', 1, '', '', '', '', '', '', ''),
(28, '想望咖啡【獨家風味】蒙馬特的午後咖啡豆 200g/莓果/酒感', '', '', '想望咖啡', 2, 320, 220, '風味筆記：莓果、橙皮、白酒香', 0, 200, 156, '0000-00-00', 1, '', '', '', '', '', '', ''),
(29, '想望咖啡-頂級藍 咖啡豆200g/日曬/中焙/伊帕內瑪莊園頂級', '', '', '想望咖啡', 5, 800, 700, '風味筆記：堅果、蔗糖、奶油餅乾、可可蛋糕', 0, 200, 156, '0000-00-00', 1, '', '', '', '', '', '', ''),
(30, '寶格麗午茶園咖啡豆100g/200g/延長發酵水洗/淺焙', '', '', '想望咖啡', 7, 500, 400, '風味筆記：金盞花，白柚，糖漬檸檬，鐵觀音茶', 0, 207, 156, '0000-00-00', 1, '', '', '', '', '', '', ''),
(31, '想望咖啡【頂級金】黃金年代 精品咖啡豆200g/日曬/中焙', '', '', '想望咖啡', 56, 750, 350, '風味筆記：杏仁、 焦糖、 蜜棗', 0, 204, 156, '0000-00-00', 1, '', '', '', '', '', '', ''),
(32, '想望咖啡【90+頂級藝伎濾掛】咖啡掛耳禮盒18入', '', '', '想望咖啡', 5, 3960, 3000, '✶ 組合內容：以下咖啡品項各9包 ✶\r\n\r\n．茱麗葉藝伎（淺焙．乾發酵/半日曬）巴拿馬 - 風味：橙皮、香草、白桃\r\n．野薑花藝伎（淺焙．乾發酵/水洗）巴拿馬 - 風味：野薑花、荔枝、人參、茉莉花茶', 0, 200, 156, '0000-00-00', 1, '', '', '', '', '', '', ''),
(33, '想望咖啡【免運禮盒】珍稀藝伎 精品咖啡掛耳18入/濾掛/生日禮物', '', '', '想望咖啡', 10, 2560, 2000, '✶ 組合內容：以下咖啡品項各 6 包 ✶\r\n\r\n．翡翠莊園．綠標藝伎（淺焙．水洗）巴拿馬 - 風味：佛手柑、茉莉花、柳橙、荔枝、綠茶**\r\n．亞歷山大藝伎（淺焙．水洗）哥倫比亞 - 風味：小白菊、佛手柑、水蜜桃、檸檬茶**\r\n．莫拉藝伎（淺焙．水洗）哥倫比亞 - 風味：白花、水蜜桃、烏龍茶**', 0, 200, 156, '0000-00-00', 1, '', '', '', '', '', '', ''),
(34, '想望咖啡【獨家風味】想望禮盒 精品咖啡掛耳20入 早晨&午後', '', '', '想望咖啡', 12, 920, 800, '✶ 組合內容 ✶\r\n\r\n．波西塔諾的早晨（中深焙．蜜處理）薩爾瓦多、瓜地馬拉 - 風味：焦糖、肉桂蘋果、黑巧克力\r\n．蒙馬特的午後（淺焙．厭氧日曬）薩爾瓦多、巴拿馬 - 風味：莓果、橙皮、白酒\r\n', 0, 200, 156, '0000-00-00', 1, '', '', '', '', '', '', ''),
(35, 'Simple Kaffa 興波咖啡 | 世界冠軍濾掛式咖啡禮盒', '', '', 'Simple Kaffa 興波咖啡', 18, 860, 800, ' 阿寶綜合 / 深焙配方，榛果、焦糖、巧克力調性，甜感十足\r\n 衣索比亞日曬 / 淺焙單品，鳳梨、芒果乾、洋甘菊、紅茶\r\n 衣索比亞水洗 / 淺焙單品，佛手柑，白花，萊姆，紅茶', 0, 199, 156, '0000-00-00', 1, '', '', '', '', '', '', ''),
(36, '【SATUR】 農神之禮 結實紺藍 熟豆組', '', '', '薩圖爾精品咖啡', 1, 980, 450, '● 經典系列\r\n【產地】[ 哥倫比亞 ] 哥倫比亞；[ 迦佑曼特寧 ] 印尼；[ 耶加雪菲 ] 衣索比亞；[ 安提瓜 ] 瓜地馬拉\r\n\r\n● 神系列\r\n【產地】 [ 馬廄 ] 台灣東山；[ 中央山谷 ] 哥斯大黎加；[ 翡翠莊園鑽石山] 巴拿馬', 0, 206, 156, '0000-00-00', 1, '', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- 資料表結構 `product_category`
--

CREATE TABLE `product_category` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `product_category`
--

INSERT INTO `product_category` (`id`, `name`) VALUES
(1, '咖啡豆'),
(2, '咖啡禮盒'),
(3, '咖啡機台'),
(4, '咖啡器具'),
(5, '咖啡飲用器具');

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
  `avatar` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `grade_id` int(1) NOT NULL,
  `valid` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `gender`, `phone`, `email`, `birthday`, `avatar`, `created_at`, `grade_id`, `valid`) VALUES
(1, 'John Doe', 'pass123', 'Male', '1234567890', 'johndoe@example.com', '1990-01-01', 'logo1.png', '2023-07-13 12:00:00', 1, 1),
(2, 'Jane Smith', 'secret456', 'Female', '9876543210', 'janesmith@example.com', '1992-05-15', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(3, 'Edison Lee', 'pin1234', 'Male', '0970812816', 'kayinortin@hotmail.com', '1993-01-06', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(4, 'Sarah Williams', 'pass789', 'Female', '6666666666', 'sarahwilliams@example.com', '1995-08-22', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(5, 'Michael Brown', 'abc123', 'Male', '7777777777', 'michaelbrown@example.com', '1993-04-10', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(6, 'Emily Davis', 'def456', 'Female', '8888888888', 'emilydavis@example.com', '1991-09-05', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(7, 'Christopher Martinez', 'qwerty', 'Male', '9999999999', 'christophermartinez@example.co', '1989-03-20', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(8, 'Sophia Anderson', 'pass789', 'Female', '1111111111', 'sophiaanderson@example.com', '1994-06-12', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(9, 'Matthew Taylor', '123456', 'Male', '2222222222', 'matthewtaylor@example.com', '1996-02-28', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
(10, 'Olivia Thomas', 'abc789', 'Female', '3333333333', 'oliviathomas@example.com', '1992-07-25', 'preset-icon.png', '2023-07-13 12:00:00', 1, 1),
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
(101, 'Ahoyz', '123', 'Female', '0930920392', 'Ahoyz@test.com', '2023-07-17', 'preset-icon.png', '2023-07-17 10:29:11', 3, 1);

-- --------------------------------------------------------

--
-- 資料表結構 `user_grade`
--

CREATE TABLE `user_grade` (
  `grade_id` int(10) UNSIGNED NOT NULL,
  `grade` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `user_grade`
--

INSERT INTO `user_grade` (`grade_id`, `grade`) VALUES
(1, '一般會員'),
(2, 'VIP'),
(3, '未認證');

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`categories_id`);

--
-- 資料表索引 `categories_item`
--
ALTER TABLE `categories_item`
  ADD PRIMARY KEY (`items_id`);

--
-- 資料表索引 `coffseeker_teachers`
--
ALTER TABLE `coffseeker_teachers`
  ADD PRIMARY KEY (`teacher_id`);

--
-- 資料表索引 `coupon`
--
ALTER TABLE `coupon`
  ADD PRIMARY KEY (`coupon_id`);

--
-- 資料表索引 `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`course_id`);

--
-- 資料表索引 `course_level`
--
ALTER TABLE `course_level`
  ADD PRIMARY KEY (`course_level_id`);

--
-- 資料表索引 `course_location`
--
ALTER TABLE `course_location`
  ADD PRIMARY KEY (`course_location_id`);

--
-- 資料表索引 `course_type`
--
ALTER TABLE `course_type`
  ADD PRIMARY KEY (`course_type_id`);

--
-- 資料表索引 `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`);

--
-- 資料表索引 `order_states`
--
ALTER TABLE `order_states`
  ADD PRIMARY KEY (`states_id`);

--
-- 資料表索引 `otp`
--
ALTER TABLE `otp`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `product_category`
--
ALTER TABLE `product_category`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `user_grade`
--
ALTER TABLE `user_grade`
  ADD PRIMARY KEY (`grade_id`);

--
-- 在傾印的資料表使用自動遞增(AUTO_INCREMENT)
--

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `categories`
--
ALTER TABLE `categories`
  MODIFY `categories_id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `categories_item`
--
ALTER TABLE `categories_item`
  MODIFY `items_id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `coffseeker_teachers`
--
ALTER TABLE `coffseeker_teachers`
  MODIFY `teacher_id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `coupon`
--
ALTER TABLE `coupon`
  MODIFY `coupon_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `course`
--
ALTER TABLE `course`
  MODIFY `course_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `otp`
--
ALTER TABLE `otp`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `product_category`
--
ALTER TABLE `product_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
