-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Dec 08. 21:54
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
  `apartman_id` int(5) NOT NULL,
  `owner_id` int(5) NOT NULL,
  `apartman_name` varchar(40) NOT NULL,
  `apartman_size` int(3) NOT NULL,
  `country_id` int(5) NOT NULL,
  `city_id` int(5) NOT NULL,
  `price` int(7) NOT NULL,
  `apartman_description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `apartmans`
--

INSERT INTO `apartmans` (`apartman_id`, `owner_id`, `apartman_name`, `apartman_size`, `country_id`, `city_id`, `price`, `apartman_description`) VALUES
(1, 2, 'Budapest Center Apartment', 55, 3, 7, 120, 'Kényelmes apartman a belváros szívében, közel a látnivalókhoz.'),
(2, 3, 'Szeged Riverside Loft', 65, 3, 8, 90, 'Modern loft a Tisza partján, erkélyes kilátással.'),
(3, 4, 'Debrecen Cozy Flat', 50, 3, 9, 80, 'Csendes lakás a belváros közelében, jól felszerelt konyhával.'),
(4, 5, 'Pécs Art Apartment', 60, 3, 103, 95, 'Stílusos apartman a Pécsi belvárosban, közel a kulturális központokhoz.'),
(5, 6, 'Győr Riverside Studio', 40, 3, 104, 70, 'Kis stúdió a Rába partján, ideális pároknak.'),
(6, 7, 'Tokyo Shinjuku Flat', 55, 1, 1, 150, 'Kényelmes apartman Shinjuku szívében, közel a metróhoz.'),
(7, 8, 'Osaka Modern Studio', 45, 1, 2, 130, 'Modern stúdió Osaka központjában, ideális rövid tartózkodásra.'),
(8, 9, 'Rome Colosseum View', 70, 2, 4, 180, 'Panorámás lakás a Colosseum közelében, erkélyes kilátással.'),
(9, 10, 'Milan Fashion Loft', 60, 2, 5, 200, 'Stílusos loft Milánó központjában, közel a divatnegyedhez.'),
(10, 11, 'Paris Eiffel Apartment', 50, 4, 10, 220, 'Romantikus apartman az Eiffel-torony közelében, erkélyes kilátással.'),
(11, 12, 'Barcelona Sea View Flat', 65, 5, 14, 180, 'Lakás a tengerpart közelében, panorámás kilátással.'),
(12, 13, 'Berlin Central Apartment', 55, 6, 16, 140, 'Kényelmes apartman Berlin központjában, jó közlekedéssel.'),
(13, 14, 'Athens Acropolis View', 60, 8, 22, 100, 'Lakás az Akropoliszra néző kilátással, központi elhelyezkedéssel.'),
(14, 15, 'Rio Copacabana Studio', 45, 10, 29, 130, 'Stúdió közvetlen közel a Copacabana strandra.'),
(15, 16, 'New York Manhattan Flat', 75, 12, 34, 250, 'Modern lakás Manhattan szívében, közel a Central Parkhoz.'),
(16, 17, 'Sydney Harbour Apartment', 70, 13, 37, 220, 'Panorámás apartman a kikötő közelében.'),
(17, 18, 'Seoul Gangnam Studio', 40, 14, 40, 120, 'Kis stúdió Gangnam központjában, jól felszerelt.'),
(18, 19, 'Beijing Modern Flat', 60, 15, 43, 180, 'Kényelmes lakás Peking központjában, metró közel.'),
(19, 20, 'Mumbai Sea View Apartment', 65, 16, 46, 160, 'Panorámás lakás a tengerre néző kilátással.'),
(20, 21, 'Lisbon Alfama Flat', 50, 18, 52, 140, 'Hagyományos apartman az Alfama negyedben.'),
(21, 22, 'Budapest Luxury Penthouse', 120, 3, 7, 350, 'Exkluzív penthouse a Duna partján, nagy terasszal.'),
(22, 23, 'Szeged Modern Loft', 70, 3, 8, 130, 'Modern loft a belvárosban, erkélyes és világos.'),
(23, 24, 'Debrecen Family Apartment', 80, 3, 9, 110, 'Tágas családi lakás közel a belvároshoz.'),
(24, 25, 'Pécs Cozy Studio', 35, 3, 103, 60, 'Kis stúdió a Pécsi kulturális központban.'),
(25, 2, 'Győr Central Apartment', 55, 3, 104, 90, 'Kényelmes lakás Győr belvárosában.');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `apartman_details`
--

CREATE TABLE `apartman_details` (
  `apartman_id` int(5) NOT NULL,
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

--
-- A tábla adatainak kiíratása `apartman_details`
--

INSERT INTO `apartman_details` (`apartman_id`, `kavefozo`, `vizforralo`, `mikrohullamu`, `alap_fuszerek`, `edenyek`, `extra_agynemu`, `sotetito`, `ejjelilampa`, `torolkozok`, `hajszarito`, `smart_tv`, `bluetooth_hangszoro`, `usb_tolto`, `munkaasztal`, `borondtarto`, `vasalo`, `szef`, `erkely`, `tarsasjatekok`, `free_wifi`, `auto_beallo`) VALUES
(1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0),
(2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1),
(3, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0),
(4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1),
(5, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0),
(6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0),
(7, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0),
(8, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0),
(9, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0),
(10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1),
(11, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0),
(12, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0),
(13, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1),
(14, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0),
(15, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0),
(16, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0),
(17, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0),
(18, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1),
(19, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0),
(20, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0),
(21, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0),
(22, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0),
(23, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1),
(24, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0),
(25, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `city`
--

CREATE TABLE `city` (
  `city_id` int(5) NOT NULL,
  `country_id` int(5) NOT NULL,
  `city_name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `city`
--

INSERT INTO `city` (`city_id`, `country_id`, `city_name`) VALUES
(1, 1, 'Tokyo'),
(2, 1, 'Osaka'),
(3, 1, 'Sapporo'),
(4, 2, 'Rome'),
(5, 2, 'Milan'),
(6, 2, 'Naples'),
(7, 3, 'Budapest'),
(8, 3, 'Szeged'),
(9, 3, 'Debrecen'),
(10, 4, 'Paris'),
(11, 4, 'Lyon'),
(12, 4, 'Marseille'),
(13, 5, 'Madrid'),
(14, 5, 'Barcelona'),
(15, 5, 'Seville'),
(16, 6, 'Berlin'),
(17, 6, 'Munich'),
(18, 6, 'Cologne'),
(19, 7, 'Vienna'),
(20, 7, 'Linz'),
(21, 7, 'Salzburg'),
(22, 8, 'Athens'),
(23, 8, 'Thessaloniki'),
(24, 8, 'Rhodes'),
(25, 9, 'Bangkok'),
(26, 9, 'Phuket'),
(27, 9, 'Chiang Mai'),
(28, 10, 'São Paulo'),
(29, 10, 'Rio de Janeiro'),
(30, 10, 'Brasília'),
(31, 11, 'Montreal'),
(32, 11, 'Toronto'),
(33, 11, 'Vancouver'),
(34, 12, 'New York'),
(35, 12, 'Los Angeles'),
(36, 12, 'Chicago'),
(37, 13, 'Sydney'),
(38, 13, 'Melbourne'),
(39, 13, 'Brisbane'),
(40, 14, 'Seoul'),
(41, 14, 'Busan'),
(42, 14, 'Incheon'),
(43, 15, 'Beijing'),
(44, 15, 'Shanghai'),
(45, 15, 'Guangzhou'),
(46, 16, 'Mumbai'),
(47, 16, 'Bangalore'),
(48, 16, 'Chennai'),
(49, 17, 'Mexico City'),
(50, 17, 'Guadalajara'),
(51, 17, 'Monterrey'),
(52, 18, 'Lisbon'),
(53, 18, 'Porto'),
(54, 18, 'Faro'),
(55, 19, 'Stockholm'),
(56, 19, 'Malmö'),
(57, 19, 'Örebro'),
(58, 20, 'Oslo'),
(59, 20, 'Bergen'),
(60, 20, 'Tromsø'),
(61, 21, 'Helsinki'),
(62, 21, 'Tampere'),
(63, 21, 'Oulu'),
(64, 22, 'Warsaw'),
(65, 22, 'Kraków'),
(66, 22, 'Gdańsk'),
(67, 23, 'Prague'),
(68, 23, 'Brno'),
(69, 23, 'České Budějovice'),
(70, 24, 'Bratislava'),
(71, 24, 'Košice'),
(72, 24, 'Banská Bystrica'),
(73, 25, 'Bucharest'),
(74, 25, 'Cluj-Napoca'),
(75, 25, 'Brașov'),
(76, 26, 'Zagreb'),
(77, 26, 'Split'),
(78, 26, 'Rijeka'),
(79, 27, 'Ljubljana'),
(80, 27, 'Maribor'),
(81, 27, 'Koper'),
(82, 28, 'Belgrade'),
(83, 28, 'Niš'),
(84, 28, 'Novi Sad'),
(85, 29, 'Podgorica'),
(86, 29, 'Kotor'),
(87, 29, 'Bar'),
(88, 30, 'Sarajevo'),
(89, 30, 'Mostar'),
(90, 30, 'Tuzla'),
(91, 31, 'Tirana'),
(92, 31, 'Durrës'),
(93, 31, 'Vlorë'),
(94, 32, 'Sofia'),
(95, 32, 'Plovdiv'),
(96, 32, 'Varna'),
(97, 33, 'Istanbul'),
(98, 33, 'Ankara'),
(99, 33, 'Izmir'),
(100, 34, 'Cairo'),
(101, 34, 'Alexandria'),
(102, 34, 'Giza'),
(103, 35, 'Marrakesh'),
(104, 35, 'Fes'),
(105, 35, 'Rabat'),
(106, 36, 'Cape Town'),
(107, 36, 'Johannesburg'),
(108, 36, 'Durban'),
(109, 37, 'Buenos Aires'),
(110, 37, 'Córdoba'),
(111, 37, 'Rosario'),
(112, 38, 'Santiago'),
(113, 38, 'Valparaíso'),
(114, 38, 'Concepción'),
(115, 39, 'Lima'),
(116, 39, 'Cusco'),
(117, 39, 'Arequipa'),
(118, 40, 'Bogotá'),
(119, 40, 'Medellín'),
(120, 40, 'Cali'),
(121, 41, 'Dublin'),
(122, 41, 'Cork'),
(123, 41, 'Galway'),
(124, 42, 'Brussels'),
(125, 42, 'Ghent'),
(126, 42, 'Antwerp'),
(127, 43, 'Amsterdam'),
(128, 43, 'The Hague'),
(129, 43, 'Rotterdam'),
(130, 44, 'Luxembourg'),
(131, 44, 'Esch-sur-Alzette'),
(132, 44, 'Differdange'),
(133, 45, 'Vaduz'),
(134, 45, 'Triesen'),
(135, 45, 'Eschen'),
(136, 46, 'Zurich'),
(137, 46, 'Bern'),
(138, 46, 'Geneva'),
(139, 47, 'Tallinn'),
(140, 47, 'Tartu'),
(141, 47, 'Pärnu'),
(142, 48, 'Riga'),
(143, 48, 'Liepāja'),
(144, 48, 'Jelgava'),
(145, 49, 'Vilnius'),
(146, 49, 'Kaunas'),
(147, 49, 'Šiauliai'),
(148, 50, 'Valletta'),
(149, 50, 'Sliema'),
(150, 50, 'St. Julian’s'),
(151, 51, 'Reykjavik'),
(152, 51, 'Akureyri'),
(153, 51, 'Selfoss'),
(154, 52, 'Tbilisi'),
(155, 52, 'Kutaisi'),
(156, 52, 'Batumi'),
(157, 53, 'Kyiv'),
(158, 53, 'Lviv'),
(159, 53, 'Dnipro'),
(160, 54, 'Minsk'),
(161, 54, 'Vitebsk'),
(162, 54, 'Grodno'),
(163, 55, 'Moscow'),
(164, 55, 'Saint Petersburg'),
(165, 55, 'Yekaterinburg'),
(166, 56, 'Almaty'),
(167, 56, 'Astana'),
(168, 56, 'Shymkent'),
(169, 57, 'Singapore'),
(170, 57, 'Jurong East'),
(171, 57, 'Tampines'),
(172, 58, 'Kuala Lumpur'),
(173, 58, 'Johor Bahru'),
(174, 58, 'George Town'),
(175, 59, 'Jakarta'),
(176, 59, 'Bandung'),
(177, 59, 'Surabaya'),
(178, 60, 'Hanoi'),
(179, 60, 'Ho Chi Minh City'),
(180, 60, 'Da Nang'),
(181, 61, 'Manila'),
(182, 61, 'Cebu City'),
(183, 61, 'Davao City'),
(184, 62, 'Islamabad'),
(185, 62, 'Lahore'),
(186, 62, 'Karachi'),
(187, 63, 'Kathmandu'),
(188, 63, 'Pokhara'),
(189, 63, 'Biratnagar'),
(190, 64, 'Colombo'),
(191, 64, 'Kandy'),
(192, 64, 'Galle'),
(193, 65, 'Tehran'),
(194, 65, 'Mashhad'),
(195, 65, 'Isfahan'),
(196, 66, 'Baghdad'),
(197, 66, 'Basra'),
(198, 66, 'Erbil'),
(199, 67, 'Riyadh'),
(200, 67, 'Jeddah'),
(201, 67, 'Dammam'),
(202, 68, 'Dubai'),
(203, 68, 'Abu Dhabi'),
(204, 68, 'Sharjah'),
(205, 69, 'Tel Aviv'),
(206, 69, 'Jerusalem'),
(207, 69, 'Haifa'),
(208, 70, 'Auckland'),
(209, 70, 'Wellington'),
(210, 70, 'Dunedin'),
(211, 3, 'Makó'),
(212, 3, 'Apátfalva');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `country`
--

CREATE TABLE `country` (
  `country_id` int(5) NOT NULL,
  `country_name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `country`
--

INSERT INTO `country` (`country_id`, `country_name`) VALUES
(31, 'Albánia'),
(37, 'Argentína'),
(13, 'Ausztrália'),
(7, 'Ausztria'),
(42, 'Belgium'),
(30, 'Bosznia-Hercegovina'),
(10, 'Brazília'),
(32, 'Bulgária'),
(38, 'Chile'),
(23, 'Csehország'),
(36, 'Dél-afrikai Köztársaság'),
(14, 'Dél-Korea'),
(12, 'Egyesült Államok'),
(68, 'Egyesült Arab Emírségek'),
(34, 'Egyiptom'),
(47, 'Észtország'),
(54, 'Fehéroroszország'),
(21, 'Finnország'),
(4, 'Franciaország'),
(61, 'Fülöp-szigetek'),
(8, 'Görögország'),
(52, 'Grúzia'),
(43, 'Hollandia'),
(26, 'Horvátország'),
(16, 'India'),
(59, 'Indonézia'),
(66, 'Irak'),
(65, 'Irán'),
(41, 'Írország'),
(51, 'Izland'),
(69, 'Izrael'),
(1, 'Japán'),
(11, 'Kanada'),
(56, 'Kazahsztán'),
(15, 'Kína'),
(40, 'Kolumbia'),
(22, 'Lengyelország'),
(48, 'Lettország'),
(45, 'Liechtenstein'),
(49, 'Litvánia'),
(44, 'Luxemburg'),
(3, 'Magyarország'),
(58, 'Malajzia'),
(50, 'Málta'),
(35, 'Marokkó'),
(17, 'Mexikó'),
(29, 'Montenegró'),
(6, 'Németország'),
(63, 'Nepál'),
(20, 'Norvégia'),
(2, 'Olaszország'),
(55, 'Oroszország'),
(62, 'Pakisztán'),
(39, 'Peru'),
(18, 'Portugália'),
(25, 'Románia'),
(5, 'Spanyolország'),
(64, 'Srí Lanka'),
(46, 'Svájc'),
(19, 'Svédország'),
(67, 'Szaúd-Arábia'),
(28, 'Szerbia'),
(57, 'Szingapúr'),
(24, 'Szlovákia'),
(27, 'Szlovénia'),
(9, 'Thaiföld'),
(33, 'Törökország'),
(70, 'Új-Zéland'),
(53, 'Ukrajna'),
(60, 'Vietnam');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `experiences`
--

CREATE TABLE `experiences` (
  `experience_id` int(5) NOT NULL,
  `country_id` int(5) NOT NULL,
  `city_id` int(5) NOT NULL,
  `name` varchar(150) NOT NULL,
  `price` int(7) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `experiences`
--

INSERT INTO `experiences` (`experience_id`, `country_id`, `city_id`, `name`, `price`, `description`) VALUES
(1, 1, 1, 'Tokyo Night Food Tour', 85, 'Fedezd fel Tokyo utcai étkezésének különleges világát egy helyi idegenvezetővel.'),
(2, 2, 4, 'Colosseum és Római Fórum séta', 50, 'Történelmi séta az ókori Róma legikonikusabb helyszínein.'),
(3, 3, 7, 'Budapest Thermal Spa Nap', 35, 'Pihentető nap a híres Széchenyi Gyógyfürdőben, fürdők és masszázsok.'),
(4, 4, 10, 'Paris Seine hajókázás', 40, 'Romantikus esti hajókirándulás a Szajna folyón, vacsorával és zenével.'),
(5, 5, 14, 'Barcelona Tapas Est', 55, 'Gasztro-túra a legjobb tapas bárokban, helyi borok kóstolásával.'),
(6, 6, 16, 'Berlin Street Art Tour', 25, 'Városi túra Berlin híres street art negyedeiben, alternatív kultúrával.'),
(7, 8, 22, 'Athéni Akropolisz látogatás', 30, 'Látogatás az Akropoliszhoz és az ősi görög templomokhoz idegenvezetővel.'),
(8, 10, 29, 'Rio de Janeiro Favela Experience', 60, 'Kulturális kaland Rio színes faveláiban, helyi idegenvezetővel.'),
(9, 12, 34, 'New York Central Park Bike Tour', 45, 'Kerékpártúra a Central Parkban, profi túravezetővel.'),
(10, 13, 37, 'Sydney Harbour Cruise', 70, 'Látványos hajókázás a Sydney-öbölben naplementekor.'),
(11, 14, 40, 'Seoul Street Food Walking Tour', 35, 'Kóstolj meg autentikus koreai street food ételeket Myeongdong utcáin.'),
(12, 15, 43, 'Great Wall of China túra', 100, 'Egynapos kirándulás a Nagy Falhoz, idegenvezetővel és ebéddel.'),
(13, 16, 46, 'Mumbai Bollywood Studio látogatás', 45, 'Tekints be az indiai filmipar kulisszái mögé.'),
(14, 18, 52, 'Lisbon Fado Night', 50, 'Élő Fado est vacsorával a történelmi Alfama negyedben.'),
(15, 33, 97, 'Istanbul Bosphorus Cruise', 40, 'Fedezd fel Isztambul látképét a Boszporuszról, naplementében.'),
(16, 3, 101, 'Szegedi Halászlé Főzőest', 25, 'Tanulj meg autentikus szegedi halászlevet készíteni helyi szakács segítségével.'),
(17, 3, 102, 'Pécsi Borkóstoló Túra', 45, 'Barangolás a villányi borvidéken, 5 bor kóstolása és sajttálas kísérettel.'),
(18, 3, 103, 'Debreceni Virágkarnevál Élmény', 30, 'Különleges belépő a híres virágkarneválra, helyi idegenvezetővel.'),
(19, 3, 104, 'Győri Történelmi Városnézés', 20, 'Séta a barokk belvárosban és a Rába-parton idegenvezetővel.');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `favourite`
--

CREATE TABLE `favourite` (
  `user_id` int(5) NOT NULL,
  `apartman_id` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `favourite`
--

INSERT INTO `favourite` (`user_id`, `apartman_id`) VALUES
(2, 1),
(2, 24),
(2, 25),
(3, 1),
(3, 2),
(3, 25),
(4, 2),
(4, 3),
(5, 3),
(5, 4),
(6, 4),
(6, 5),
(7, 5),
(7, 6),
(8, 6),
(8, 7),
(9, 7),
(9, 8),
(10, 8),
(10, 9),
(11, 9),
(11, 10),
(12, 10),
(12, 11),
(13, 11),
(13, 12),
(14, 12),
(14, 13),
(15, 13),
(15, 14),
(16, 14),
(16, 15),
(17, 15),
(17, 16),
(18, 16),
(18, 17),
(19, 17),
(19, 18),
(20, 18),
(20, 19),
(21, 19),
(21, 20),
(22, 20),
(22, 21),
(23, 21),
(23, 22),
(24, 22),
(24, 23),
(25, 23),
(25, 24);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `rents`
--

CREATE TABLE `rents` (
  `rent_id` int(5) NOT NULL,
  `renter_id` int(5) NOT NULL,
  `owner_id` int(5) NOT NULL,
  `apartman_id` int(5) NOT NULL,
  `price` int(7) NOT NULL,
  `payment_type` varchar(20) NOT NULL DEFAULT '''''''unpaid''''''',
  `card_number` int(11) DEFAULT NULL,
  `expiration` varchar(7) DEFAULT NULL,
  `cvv` int(3) DEFAULT NULL,
  `rent_date` date DEFAULT NULL,
  `rent_beginning` date NOT NULL,
  `rent_end` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `rents`
--

INSERT INTO `rents` (`rent_id`, `renter_id`, `owner_id`, `apartman_id`, `price`, `payment_type`, `card_number`, `expiration`, `cvv`, `rent_date`, `rent_beginning`, `rent_end`) VALUES
(1, 3, 2, 1, 120, 'paid', 2147483647, '11/27', 241, '2025-08-06', '2025-08-12', '2025-08-19'),
(2, 4, 20, 2, 90, 'paid', 2147483647, '04/26', 522, '2025-07-11', '2025-07-20', '2025-07-25'),
(3, 5, 21, 3, 80, 'paid', 2147483647, '09/28', 113, '2025-05-22', '2025-06-15', '2025-06-20'),
(4, 6, 22, 4, 95, 'paid', 2147483647, '02/27', 448, '2025-05-04', '2025-05-10', '2025-05-17'),
(5, 7, 23, 5, 70, 'paid', 2147483647, '06/29', 772, '2025-08-23', '2025-09-05', '2025-09-12'),
(6, 8, 2, 6, 150, 'paid', 2147483647, '12/26', 399, '2025-08-07', '2025-08-22', '2025-08-29');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `id` int(5) NOT NULL,
  `first_name` varchar(40) NOT NULL,
  `last_name` varchar(40) NOT NULL,
  `middle_name` varchar(40) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `password` varchar(30) NOT NULL,
  `phone_number` varchar(40) NOT NULL,
  `gender` char(1) NOT NULL,
  `user_type` char(1) NOT NULL DEFAULT 'U',
  `card_number` int(11) DEFAULT NULL,
  `expiration` varchar(7) DEFAULT NULL,
  `cvv` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `middle_name`, `email`, `password`, `phone_number`, `gender`, `user_type`, `card_number`, `expiration`, `cvv`) VALUES
(1, 'Admin', 'Admin', NULL, 'admin@gmail.com', 'admin123', '+36304443358', 'M', 'A', NULL, NULL, NULL),
(2, 'Hiroshi', 'Tanaka', NULL, 'hiroshi.tanaka@gmail.com', 'HiroshiT21', '+818012345678', 'M', 'U', NULL, NULL, NULL),
(3, 'Giulia', 'Rossi', 'Elena', 'giulia.rossi@gmail.com', 'GiuliaR34', '+393471234567', 'F', 'U', 2147483647, '11/27', 241),
(4, 'Bence', 'Kovács', NULL, 'bence.kovacs@gmail.com', 'BenceK77', '+36301234567', 'M', 'U', 2147483647, '04/26', 522),
(5, 'Camille', 'Lefevre', NULL, 'camille.lefevre@gmail.com', 'CamilleL56', '+33612345678', 'F', 'U', 2147483647, '09/28', 113),
(6, 'Diego', 'Martinez', 'Alejandro', 'diego.martinez@gmail.com', 'DiegoM09', '+34612345678', 'M', 'U', 2147483647, '02/27', 448),
(7, 'Hans', 'Müller', 'Peter', 'hans.muller@gmail.com', 'HansM88', '+4915123456789', 'M', 'U', 2147483647, '06/29', 772),
(8, 'Anna', 'Schmidt', NULL, 'anna.schmidt@gmail.com', 'AnnaS15', '+4917123456789', 'F', 'U', 2147483647, '12/26', 399),
(9, 'Maria', 'Papadopoulos', 'Eleni', 'maria.papad@gmail.com', 'MariaP63', '+306931234567', 'F', 'U', NULL, NULL, NULL),
(10, 'Kenji', 'Sato', NULL, 'kenji.sato@gmail.com', 'KenjiS22', '+818043218765', 'M', 'U', NULL, NULL, NULL),
(11, 'Sophie', 'Dubois', NULL, 'sophie.dubois@gmail.com', 'SophieD71', '+33723456789', 'F', 'U', NULL, NULL, NULL),
(12, 'Luca', 'Bianchi', 'Marco', 'luca.bianchi@gmail.com', 'LucaB05', '+393482345678', 'M', 'U', NULL, NULL, NULL),
(13, 'Dóra', 'Tóth', NULL, 'dora.toth@gmail.com', 'DoraT39', '+36206543210', 'F', 'U', NULL, NULL, NULL),
(14, 'Carlos', 'Fernandez', NULL, 'carlos.fernandez@gmail.com', 'CarlosF58', '+34622987654', 'M', 'U', NULL, NULL, NULL),
(15, 'Eva', 'Novak', NULL, 'eva.novak@gmail.com', 'EvaN13', '+436609876543', 'F', 'U', NULL, NULL, NULL),
(16, 'Peter', 'Hansen', 'Oskar', 'peter.hansen@gmail.com', 'PeterH46', '+47998765432', 'M', 'U', NULL, NULL, NULL),
(17, 'Emily', 'Johnson', NULL, 'emily.johnson@gmail.com', 'EmilyJ90', '+12125557890', 'F', 'U', NULL, NULL, NULL),
(18, 'Liam', 'Smith', NULL, 'liam.smith@gmail.com', 'LiamS11', '+16465553210', 'M', 'U', NULL, NULL, NULL),
(19, 'Sakura', 'Yamamoto', 'Aiko', 'sakura.yamamoto@gmail.com', 'SakuraY77', '+819098765432', 'F', 'U', NULL, NULL, NULL),
(20, 'Mateo', 'Silva', NULL, 'mateo.silva@gmail.com', 'MateoS66', '+5511987654321', 'M', 'U', NULL, NULL, NULL),
(21, 'Eszter', 'Szabó', NULL, 'eszter.szabo@gmail.com', 'EszterS89', '+36209876543', 'F', 'U', NULL, NULL, NULL),
(22, 'Levente', 'Horváth', NULL, 'levente.horvath@gmail.com', 'LeventeH25', '+36308887777', 'M', 'U', NULL, NULL, NULL),
(23, 'Zsófia', 'Kiss', 'Réka', 'zsofia.kiss@gmail.com', 'ZsofiaK91', '+36702223333', 'F', 'U', NULL, NULL, NULL),
(24, 'Ádám', 'Nagy', NULL, 'adam.nagy@gmail.com', 'AdamN55', '+36201112222', 'M', 'U', NULL, NULL, NULL),
(25, 'Gábor', 'Molnár', NULL, 'gabor.molnar@gmail.com', 'GaborM42', '+36704445555', 'M', 'U', NULL, NULL, NULL);

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
  ADD UNIQUE KEY `city_name` (`city_name`),
  ADD KEY `country_id` (`country_id`);

--
-- A tábla indexei `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`country_id`),
  ADD UNIQUE KEY `country_name` (`country_name`);

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
  ADD PRIMARY KEY (`rent_id`),
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
  MODIFY `apartman_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT a táblához `city`
--
ALTER TABLE `city`
  MODIFY `city_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=213;

--
-- AUTO_INCREMENT a táblához `country`
--
ALTER TABLE `country`
  MODIFY `country_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT a táblához `experiences`
--
ALTER TABLE `experiences`
  MODIFY `experience_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT a táblához `rents`
--
ALTER TABLE `rents`
  MODIFY `rent_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `apartmans`
--
ALTER TABLE `apartmans`
  ADD CONSTRAINT `apartmans_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`),
  ADD CONSTRAINT `apartmans_ibfk_2` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`),
  ADD CONSTRAINT `apartmans_ibfk_3` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`);

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
