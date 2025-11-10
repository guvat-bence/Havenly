-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Nov 10. 18:04
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `havenly`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `apartmans`
--

CREATE TABLE `apartmans` (
  `apartman_id` int(200) NOT NULL,
  `owner_id` int(200) NOT NULL,
  `apartman_name` varchar(40) NOT NULL,
  `apartman_details` text NOT NULL,
  `apartman_size` int(3) NOT NULL,
  `country_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `apartman_details`
--

CREATE TABLE `apartman_details` (
  `apartman_id` int(11) NOT NULL,
  `kavefozo` tinyint(1) DEFAULT 0,
  `vizforralo` tinyint(1) DEFAULT 0,
  `mikrohullamu` tinyint(1) DEFAULT 0,
  `alap_fuszerek` tinyint(1) DEFAULT 0,
  `edenyek` tinyint(1) DEFAULT 0,
  `extra_agynemu` tinyint(1) DEFAULT 0,
  `sotetito` tinyint(1) DEFAULT 0,
  `ejjelilampa` tinyint(1) DEFAULT 0,
  `torolkozok` tinyint(1) DEFAULT 0,
  `hajszarito` tinyint(1) DEFAULT 0,
  `smart_tv` tinyint(1) DEFAULT 0,
  `bluetooth_hangszoro` tinyint(1) DEFAULT 0,
  `usb_tolto` tinyint(1) DEFAULT 0,
  `munkaasztal` tinyint(1) DEFAULT 0,
  `borondtarto` tinyint(1) DEFAULT 0,
  `vasalo` tinyint(1) DEFAULT 0,
  `szef` tinyint(1) DEFAULT 0,
  `erkely` tinyint(1) DEFAULT 0,
  `tarsasjatekok` tinyint(1) DEFAULT 0,
  `free_wifi` tinyint(1) DEFAULT 0,
  `auto_beallo` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `city`
--

CREATE TABLE `city` (
  `city_id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `postal_code` varchar(11) NOT NULL,
  `city_name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `city`
--

INSERT INTO `city` (`city_id`, `country_id`, `postal_code`, `city_name`) VALUES
(1, 1, '100-0001', 'Tokyo'),
(2, 1, '530-0001', 'Osaka'),
(3, 1, '060-0001', 'Sapporo'),
(4, 2, '00184', 'Rome'),
(5, 2, '20121', 'Milan'),
(6, 2, '80100', 'Naples'),
(7, 3, '1011', 'Budapest'),
(8, 3, '6720', 'Szeged'),
(9, 3, '4026', 'Debrecen'),
(10, 4, '75001', 'Paris'),
(11, 4, '69001', 'Lyon'),
(12, 4, '13001', 'Marseille'),
(13, 5, '28001', 'Madrid'),
(14, 5, '08001', 'Barcelona'),
(15, 5, '41001', 'Seville'),
(16, 6, '10115', 'Berlin'),
(17, 6, '80331', 'Munich'),
(18, 6, '50667', 'Cologne'),
(19, 7, '1010', 'Vienna'),
(20, 7, '4020', 'Linz'),
(21, 7, '5020', 'Salzburg'),
(22, 8, '10552', 'Athens'),
(23, 8, '54621', 'Thessaloniki'),
(24, 8, '85100', 'Rhodes'),
(25, 9, '10330', 'Bangkok'),
(26, 9, '83110', 'Phuket'),
(27, 9, '50100', 'Chiang Mai'),
(28, 10, '01000-000', 'São Paulo'),
(29, 10, '20000-000', 'Rio de Janeiro'),
(30, 10, '70000-000', 'Brasília'),
(31, 11, 'H3A 1A2', 'Montreal'),
(32, 11, 'M5H 2N2', 'Toronto'),
(33, 11, 'V6B 1V2', 'Vancouver'),
(34, 12, '10001', 'New York'),
(35, 12, '90001', 'Los Angeles'),
(36, 12, '60601', 'Chicago'),
(37, 13, '2000', 'Sydney'),
(38, 13, '3000', 'Melbourne'),
(39, 13, '4000', 'Brisbane'),
(40, 14, '04524', 'Seoul'),
(41, 14, '61100', 'Busan'),
(42, 14, '54853', 'Incheon'),
(43, 15, '100000', 'Beijing'),
(44, 15, '200000', 'Shanghai'),
(45, 15, '510000', 'Guangzhou'),
(46, 16, '400001', 'Mumbai'),
(47, 16, '560001', 'Bangalore'),
(48, 16, '600001', 'Chennai'),
(49, 17, '06000', 'Mexico City'),
(50, 17, '44100', 'Guadalajara'),
(51, 17, '64000', 'Monterrey'),
(52, 18, '1100-001', 'Lisbon'),
(53, 18, '4000-001', 'Porto'),
(54, 18, '8000-001', 'Faro'),
(55, 19, '11120', 'Stockholm'),
(56, 19, '21120', 'Malmö'),
(57, 19, '70361', 'Örebro'),
(58, 20, '0150', 'Oslo'),
(59, 20, '5003', 'Bergen'),
(60, 20, '8006', 'Tromsø'),
(61, 21, '00100', 'Helsinki'),
(62, 21, '33100', 'Tampere'),
(63, 21, '90100', 'Oulu'),
(64, 22, '00-001', 'Warsaw'),
(65, 22, '31-000', 'Kraków'),
(66, 22, '80-001', 'Gdańsk'),
(67, 23, '11000', 'Prague'),
(68, 23, '60200', 'Brno'),
(69, 23, '37001', 'České Budějovice'),
(70, 24, '81101', 'Bratislava'),
(71, 24, '04001', 'Košice'),
(72, 24, '97401', 'Banská Bystrica'),
(73, 25, '010101', 'Bucharest'),
(74, 25, '400001', 'Cluj-Napoca'),
(75, 25, '500001', 'Brașov'),
(76, 26, '10000', 'Zagreb'),
(77, 26, '21000', 'Split'),
(78, 26, '51000', 'Rijeka'),
(79, 27, '1000', 'Ljubljana'),
(80, 27, '2000', 'Maribor'),
(81, 27, '6000', 'Koper'),
(82, 28, '11000', 'Belgrade'),
(83, 28, '18000', 'Niš'),
(84, 28, '21000', 'Novi Sad'),
(85, 29, '81000', 'Podgorica'),
(86, 29, '85310', 'Kotor'),
(87, 29, '85000', 'Bar'),
(88, 30, '71000', 'Sarajevo'),
(89, 30, '88000', 'Mostar'),
(90, 30, '76100', 'Tuzla'),
(91, 31, '1001', 'Tirana'),
(92, 31, '9401', 'Durrës'),
(93, 31, '6001', 'Vlorë'),
(94, 32, '1000', 'Sofia'),
(95, 32, '4000', 'Plovdiv'),
(96, 32, '9000', 'Varna'),
(97, 33, '34000', 'Istanbul'),
(98, 33, '06000', 'Ankara'),
(99, 33, '35210', 'Izmir'),
(100, 34, '11511', 'Cairo'),
(101, 34, '21500', 'Alexandria'),
(102, 34, '70000', 'Giza'),
(103, 35, '40000', 'Marrakesh'),
(104, 35, '30000', 'Fes'),
(105, 35, '10000', 'Rabat'),
(106, 36, '8001', 'Cape Town'),
(107, 36, '2000', 'Johannesburg'),
(108, 36, '4001', 'Durban'),
(109, 37, 'C1000', 'Buenos Aires'),
(110, 37, '5000', 'Córdoba'),
(111, 37, '2000', 'Rosario'),
(112, 38, '8320000', 'Santiago'),
(113, 38, '1100000', 'Valparaíso'),
(114, 38, '4000000', 'Concepción'),
(115, 39, '15001', 'Lima'),
(116, 39, '20001', 'Cusco'),
(117, 39, '30001', 'Arequipa'),
(118, 40, '110111', 'Bogotá'),
(119, 40, '500001', 'Medellín'),
(120, 40, '760001', 'Cali'),
(121, 41, 'D01', 'Dublin'),
(122, 41, 'T12', 'Cork'),
(123, 41, 'H91', 'Galway'),
(124, 42, '1000', 'Brussels'),
(125, 42, '9000', 'Ghent'),
(126, 42, '2000', 'Antwerp'),
(127, 43, '1012', 'Amsterdam'),
(128, 43, '2511', 'The Hague'),
(129, 43, '3011', 'Rotterdam'),
(130, 44, 'L-1009', 'Luxembourg'),
(131, 44, 'L-3401', 'Esch-sur-Alzette'),
(132, 44, 'L-5501', 'Differdange'),
(133, 45, '9490', 'Vaduz'),
(134, 45, '9485', 'Triesen'),
(135, 45, '9492', 'Eschen'),
(136, 46, '8001', 'Zurich'),
(137, 46, '3000', 'Bern'),
(138, 46, '1200', 'Geneva'),
(139, 47, '10111', 'Tallinn'),
(140, 47, '51013', 'Tartu'),
(141, 47, '93815', 'Pärnu'),
(142, 48, 'LV-1050', 'Riga'),
(143, 48, 'LV-3601', 'Liepāja'),
(144, 48, 'LV-5001', 'Jelgava'),
(145, 49, 'LT-01100', 'Vilnius'),
(146, 49, 'LT-44200', 'Kaunas'),
(147, 49, 'LT-77101', 'Šiauliai'),
(148, 50, 'VLT 1111', 'Valletta'),
(149, 50, 'VLT 2000', 'Sliema'),
(150, 50, 'VLT 3000', 'St. Julian’s'),
(151, 51, '101', 'Reykjavik'),
(152, 51, '600', 'Akureyri'),
(153, 51, '850', 'Selfoss'),
(154, 52, '0108', 'Tbilisi'),
(155, 52, '4600', 'Kutaisi'),
(156, 52, '6000', 'Batumi'),
(157, 53, '01001', 'Kyiv'),
(158, 53, '79000', 'Lviv'),
(159, 53, '49000', 'Dnipro'),
(160, 54, '220030', 'Minsk'),
(161, 54, '212030', 'Vitebsk'),
(162, 54, '230030', 'Grodno'),
(163, 55, '101000', 'Moscow'),
(164, 55, '190000', 'Saint Petersburg'),
(165, 55, '620000', 'Yekaterinburg'),
(166, 56, '050000', 'Almaty'),
(167, 56, '010000', 'Astana'),
(168, 56, '090000', 'Shymkent'),
(169, 57, '238165', 'Singapore'),
(170, 57, '189720', 'Jurong East'),
(171, 57, '529889', 'Tampines'),
(172, 58, '50000', 'Kuala Lumpur'),
(173, 58, '80000', 'Johor Bahru'),
(174, 58, '10400', 'George Town'),
(175, 59, '10110', 'Jakarta'),
(176, 59, '40115', 'Bandung'),
(177, 59, '60293', 'Surabaya'),
(178, 60, '700000', 'Hanoi'),
(179, 60, '700000', 'Ho Chi Minh City'),
(180, 60, '550000', 'Da Nang'),
(181, 61, '1000', 'Manila'),
(182, 61, '6000', 'Cebu City'),
(183, 61, '8000', 'Davao City'),
(184, 62, '44000', 'Islamabad'),
(185, 62, '54000', 'Lahore'),
(186, 62, '74200', 'Karachi'),
(187, 63, '44600', 'Kathmandu'),
(188, 63, '57300', 'Pokhara'),
(189, 63, '97700', 'Biratnagar'),
(190, 64, '00100', 'Colombo'),
(191, 64, '40000', 'Kandy'),
(192, 64, '80000', 'Galle'),
(193, 65, '11369', 'Tehran'),
(194, 65, '70000', 'Mashhad'),
(195, 65, '50000', 'Isfahan'),
(196, 66, '10001', 'Baghdad'),
(197, 66, '44001', 'Basra'),
(198, 66, '32001', 'Erbil'),
(199, 67, '11564', 'Riyadh'),
(200, 67, '21442', 'Jeddah'),
(201, 67, '31952', 'Dammam'),
(202, 68, '00000', 'Dubai'),
(203, 68, '00000', 'Abu Dhabi'),
(204, 68, '00000', 'Sharjah'),
(205, 69, '91999', 'Tel Aviv'),
(206, 69, '91000', 'Jerusalem'),
(207, 69, '32000', 'Haifa'),
(208, 70, '6011', 'Auckland'),
(209, 70, '3000', 'Wellington'),
(210, 70, '9010', 'Dunedin');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `country`
--

CREATE TABLE `country` (
  `country_id` int(11) NOT NULL,
  `country_name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `country`
--

INSERT INTO `country` (`country_id`, `country_name`) VALUES
(1, 'Japán'),
(2, 'Olaszország'),
(3, 'Magyarország'),
(4, 'Franciaország'),
(5, 'Spanyolország'),
(6, 'Németország'),
(7, 'Ausztria'),
(8, 'Görögország'),
(9, 'Thaiföld'),
(10, 'Brazília'),
(11, 'Kanada'),
(12, 'Egyesült Államok'),
(13, 'Ausztrália'),
(14, 'Dél-Korea'),
(15, 'Kína'),
(16, 'India'),
(17, 'Mexikó'),
(18, 'Portugália'),
(19, 'Svédország'),
(20, 'Norvégia'),
(21, 'Finnország'),
(22, 'Lengyelország'),
(23, 'Csehország'),
(24, 'Szlovákia'),
(25, 'Románia'),
(26, 'Horvátország'),
(27, 'Szlovénia'),
(28, 'Szerbia'),
(29, 'Montenegró'),
(30, 'Bosznia-Hercegovina'),
(31, 'Albánia'),
(32, 'Bulgária'),
(33, 'Törökország'),
(34, 'Egyiptom'),
(35, 'Marokkó'),
(36, 'Dél-afrikai Köztársaság'),
(37, 'Argentína'),
(38, 'Chile'),
(39, 'Peru'),
(40, 'Kolumbia'),
(41, 'Írország'),
(42, 'Belgium'),
(43, 'Hollandia'),
(44, 'Luxemburg'),
(45, 'Liechtenstein'),
(46, 'Svájc'),
(47, 'Észtország'),
(48, 'Lettország'),
(49, 'Litvánia'),
(50, 'Málta'),
(51, 'Izland'),
(52, 'Grúzia'),
(53, 'Ukrajna'),
(54, 'Fehéroroszország'),
(55, 'Oroszország'),
(56, 'Kazahsztán'),
(57, 'Szingapúr'),
(58, 'Malajzia'),
(59, 'Indonézia'),
(60, 'Vietnam'),
(61, 'Fülöp-szigetek'),
(62, 'Pakisztán'),
(63, 'Nepál'),
(64, 'Srí Lanka'),
(65, 'Irán'),
(66, 'Irak'),
(67, 'Szaúd-Arábia'),
(68, 'Egyesült Arab Emírségek'),
(69, 'Izrael'),
(70, 'Új-Zéland');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `experiences`
--

CREATE TABLE `experiences` (
  `experience_id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `name` varchar(40) NOT NULL,
  `price` int(10) NOT NULL,
  `description` varchar(400) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `favourite`
--

CREATE TABLE `favourite` (
  `user_id` int(11) NOT NULL,
  `apartman_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `rents`
--

CREATE TABLE `rents` (
  `renter_id` int(20) NOT NULL,
  `owner_id` int(20) NOT NULL,
  `apartman_id` int(11) NOT NULL,
  `rent_date` date NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `id` int(200) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `middle_name` varchar(20) NOT NULL,
  `email` varchar(20) NOT NULL,
  `password` varchar(30) NOT NULL,
  `phone_number` varchar(40) NOT NULL,
  `gender` varchar(1) NOT NULL,
  `user_type` char(1) NOT NULL DEFAULT 'U'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `apartmans`
--
ALTER TABLE `apartmans`
  ADD PRIMARY KEY (`apartman_id`),
  ADD KEY `owner_id` (`owner_id`),
  ADD KEY `city_id` (`city_id`),
  ADD KEY `country_id` (`country_id`);

--
-- A tábla indexei `apartman_details`
--
ALTER TABLE `apartman_details`
  ADD PRIMARY KEY (`apartman_id`);

--
-- A tábla indexei `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`city_id`),
  ADD UNIQUE KEY `city_name` (`city_name`) USING HASH,
  ADD KEY `country_id` (`country_id`);

--
-- A tábla indexei `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`country_id`),
  ADD UNIQUE KEY `country_name` (`country_name`) USING HASH;

--
-- A tábla indexei `experiences`
--
ALTER TABLE `experiences`
  ADD PRIMARY KEY (`experience_id`),
  ADD KEY `country_id` (`country_id`),
  ADD KEY `city_name` (`city_id`);

--
-- A tábla indexei `favourite`
--
ALTER TABLE `favourite`
  ADD KEY `user_id` (`user_id`,`apartman_id`),
  ADD KEY `apartman_id` (`apartman_id`);

--
-- A tábla indexei `rents`
--
ALTER TABLE `rents`
  ADD KEY `renter_id` (`renter_id`,`owner_id`,`apartman_id`),
  ADD KEY `apartman_id` (`apartman_id`),
  ADD KEY `owner_id` (`owner_id`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `apartmans`
--
ALTER TABLE `apartmans`
  MODIFY `apartman_id` int(200) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `city`
--
ALTER TABLE `city`
  MODIFY `city_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=211;

--
-- AUTO_INCREMENT a táblához `country`
--
ALTER TABLE `country`
  MODIFY `country_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT a táblához `experiences`
--
ALTER TABLE `experiences`
  MODIFY `experience_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `id` int(200) NOT NULL AUTO_INCREMENT;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `apartmans`
--
ALTER TABLE `apartmans`
  ADD CONSTRAINT `apartmans_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`),
  ADD CONSTRAINT `apartmans_ibfk_2` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`);

--
-- Megkötések a táblához `apartman_details`
--
ALTER TABLE `apartman_details`
  ADD CONSTRAINT `apartman_details_ibfk_1` FOREIGN KEY (`apartman_id`) REFERENCES `apartmans` (`apartman_id`);

--
-- Megkötések a táblához `city`
--
ALTER TABLE `city`
  ADD CONSTRAINT `city_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`);

--
-- Megkötések a táblához `experiences`
--
ALTER TABLE `experiences`
  ADD CONSTRAINT `experiences_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`),
  ADD CONSTRAINT `experiences_ibfk_2` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`);

--
-- Megkötések a táblához `favourite`
--
ALTER TABLE `favourite`
  ADD CONSTRAINT `favourite_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `favourite_ibfk_2` FOREIGN KEY (`apartman_id`) REFERENCES `apartmans` (`apartman_id`);

--
-- Megkötések a táblához `rents`
--
ALTER TABLE `rents`
  ADD CONSTRAINT `rents_ibfk_1` FOREIGN KEY (`apartman_id`) REFERENCES `apartmans` (`apartman_id`),
  ADD CONSTRAINT `rents_ibfk_2` FOREIGN KEY (`owner_id`) REFERENCES `apartmans` (`owner_id`),
  ADD CONSTRAINT `rents_ibfk_3` FOREIGN KEY (`renter_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
