-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2026. Jan 28. 16:05
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
-- Tábla szerkezet ehhez a táblához `accommodations`
--

CREATE TABLE `accommodations` (
  `id` int(5) NOT NULL,
  `owner_id` int(5) DEFAULT NULL,
  `country_id` int(5) DEFAULT NULL,
  `city_id` int(5) DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `folder_name` varchar(40) NOT NULL,
  `size` int(3) NOT NULL,
  `price` int(7) NOT NULL,
  `description` text NOT NULL,
  `guest_number` int(2) NOT NULL,
  `bedroom` int(2) NOT NULL,
  `bed` int(2) NOT NULL,
  `bathroom` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `accommodations`
--

INSERT INTO `accommodations` (`id`, `owner_id`, `country_id`, `city_id`, `name`, `folder_name`, `size`, `price`, `description`, `guest_number`, `bedroom`, `bed`, `bathroom`) VALUES
(1, 3, 23, 67, 'Hangulatos lakás Prága szívében ', 'praga_hangulatos_lakas', 60, 65, 'Ez a kényelmes apartman Prága szívében minden igényt kielégít. A tágas szobák napfényesek, a bútorzat modern és stílusos. Ideális hely pároknak és családoknak egyaránt. A város főbb látnivalói és éttermei néhány perc sétára találhatók. Tökéletes választás a kikapcsolódásra és városnézésre.', 4, 1, 2, 1),
(2, 14, 23, 67, 'Hangulatos stúdió erkélyrel', 'praga_hangulatos_studio', 45, 91, 'Modern stúdió erkélyrel, ideális rövid városi tartózkodáshoz. A világos, otthonos belső tér minden kényelmet biztosít. Közel a közlekedéshez és a helyi éttermekhez. Tökéletes pároknak vagy üzleti utazóknak. Élvezze a város nyüzsgését a saját privát erkélyéről!', 2, 1, 1, 1),
(3, 50, 23, 67, 'Hangulatos lakás a központban', 'praga_kozponti_lakas', 50, 88, 'Napos, otthonos lakás Prága központjában. A lakás modern bútorokkal van felszerelve, és minden alapfelszereltséget biztosít a kényelmes tartózkodáshoz. A környék tele van látnivalókkal, kávézókkal és éttermekkel. Kiváló közlekedési lehetőségek, ideális bármilyen utazásra. Élvezze a városi élet minden pillanatát ebben a hangulatos lakásban.', 3, 1, 1, 2),
(4, 22, 7, 19, 'Charmantes Studio zentral', 'charmantes_studio', 45, 88, 'Stílusos, csendes stúdió Bécsben, minden szükséges felszereléssel. A modern belső terek kellemes légkört biztosítanak a pihenéshez. Ideális pároknak és rövid városi tartózkodásokhoz. A város nevezetességei és éttermei könnyen elérhetők. Tökéletes kiindulópont Bécs felfedezéséhez.', 2, 1, 1, 1),
(5, 12, 7, 19, 'Menő bécsi lakás', 'meno_becsi_lakas', 45, 82, 'Fiatalos, kényelmes lakás Bécs központjában, ideális városnézéshez. A világos és praktikus bútorozás minden igényt kielégít. Közel a tömegközlekedéshez és helyi éttermekhez. Nyugodt környék és kényelmes pihenés biztosított. Tökéletes választás baráti társaságoknak vagy pároknak.', 2, 1, 1, 1),
(6, 65, 3, 8, 'Pulz Apartman', 'pulz_apartman', 50, 41, 'Felújított apartman Szegeden, közel a belvároshoz és piachoz. Tágas és világos szobák, modern berendezés. Ideális családoknak és rövid tartózkodásokhoz. A környék tele van éttermekkel és kulturális látnivalókkal. Kényelmes és otthonos hangulat várja a vendégeket.', 4, 1, 3, 1),
(7, 4, 3, 7, 'Belváros, Budapest Szabadság Rezidencia ', 'budapest_szabadsag_rezidencia', 60, 54, 'Modern lakás Budapest belvárosában, kiváló elhelyezkedéssel. A lakás világos, jól felszerelt, ideális pároknak vagy üzleti utazóknak. A környék tele van éttermekkel, kávézókkal és látnivalókkal. Kényelmes hozzáférés a tömegközlekedéshez. Tökéletes választás városnézéshez és pihenéshez.', 2, 1, 1, 1),
(8, 3, 3, 7, 'Belvárosi apartman', 'belvarosi_apart', 45, 74, 'Kényelmes apartman Budapest szívében, otthonos hangulattal. A modern bútorok és a praktikus elrendezés minden igényt kielégít. Ideális családoknak vagy baráti társaságoknak. A közeli éttermek, boltok és látnivalók könnyen elérhetők. Tökéletes hely a városi élményekhez és a pihenéshez.', 4, 2, 2, 1),
(9, 4, 3, 7, 'Modern stúdió', 'modern_studio', 40, 68, 'Világos, modern stúdió Budapest központjában. Kényelmes bútorok, praktikus elrendezés és minden szükséges felszerelés. Ideális pároknak vagy üzleti utazóknak. A város nevezetességei és éttermei sétatávolságra találhatók. Tökéletes kombinációja a kényelemnek és a városi életnek.', 2, 1, 1, 1),
(10, 5, 3, 9, 'Panorámás lakás', 'panorama_lakas', 70, 84, 'Tágas lakás gyönyörű kilátással, ideális családoknak. A modern berendezés és kényelmes bútorok minden igényt kielégítenek. Közel a város központjához és látnivalóihoz. A környék csendes, nyugodt pihenést biztosít. Élvezze a panorámás kilátást a nap minden szakában.', 6, 3, 4, 2),
(13, 8, 7, 19, 'Bécsi belvárosi lakás', 'becsi_belvarosi', 60, 89, 'Elegáns lakás Bécs belvárosában, közel a látnivalókhoz. A tágas és világos belső tér ideális családoknak és pároknak. Modern bútorok és minden szükséges felszerelés. Sétatávolságra éttermek és kávézók. Kényelmes kiindulópont a város felfedezéséhez.', 5, 2, 3, 2),
(14, 9, 7, 19, 'Kompakt stúdió', 'kompakt_studio', 30, 55, 'Kompakt stúdió Bécsben, ideális rövid tartózkodásokhoz. A praktikus elrendezés és világos belső tér minden igényt kielégít. Közel a város főbb nevezetességeihez és közlekedéshez. Tökéletes pároknak vagy egyéni utazóknak. Kényelmes és otthonos hangulat várja a vendégeket.', 2, 1, 1, 1),
(15, 10, 5, 14, 'Tengerparti apartman', 'tengerparti_ap', 75, 100, 'Tengerparti apartman közvetlenül a strand mellett. Világos és tágas belső tér, modern bútorokkal. Ideális családoknak vagy baráti társaságoknak. A környék tele van éttermekkel és kikapcsolódási lehetőségekkel. Élvezze a nyári napfényes pihenést a part közelében.', 6, 3, 4, 2),
(16, 11, 5, 13, 'Városi stúdió', 'varosi_studio', 42, 66, 'Modern városi stúdió Madrid központjában. Világos és praktikus, minden szükséges felszereléssel. Ideális pároknak és üzleti utazóknak. Közel a főbb látnivalókhoz és közlekedési csomópontokhoz. Kényelmes és stílusos tartózkodás a városban.', 2, 1, 1, 1),
(17, 12, 4, 10, 'Romantikus lakás', 'romantikus_lakas', 48, 76, 'Romantikus lakás Párizsban, kiváló elhelyezkedéssel. A belső terek elegánsak, stílusosak és otthonosak. Ideális pároknak romantikus kiruccanáshoz. A környék tele van éttermekkel, kávézókkal és látnivalókkal. Élvezze a párizsi hangulat minden pillanatát.', 4, 2, 2, 1),
(18, 13, 4, 11, 'Erkélyes apartman', 'erkelyes_apart', 55, 82, 'Világos erkélyes apartman Párizsban. Modern bútorok és kényelmes elrendezés minden igényt kielégít. Ideális családoknak és baráti társaságoknak. Közel a város főbb nevezetességeihez. Élvezze a friss levegőt és a város látványát a privát erkélyről.', 5, 2, 3, 2),
(19, 14, 6, 16, 'Fiatalos stúdió', 'fiatalos_studio', 28, 63, 'Fiatalos stúdió Berlinben, modern felszereltséggel. Ideális pároknak és üzleti utazóknak. Világos és otthonos belső tér biztosítja a kényelmet. Közel a közlekedéshez és a helyi látnivalókhoz. Tökéletes rövid tartózkodásokhoz.', 2, 1, 1, 1),
(20, 3, 6, 17, 'Családi lakás', 'csaladi_lakas', 80, 95, 'Tágas családi lakás Berlinben. Modern bútorok és jól felszerelt konyha. Ideális nagyobb családoknak. Közel a város nevezetességeihez és parkjaihoz. Kényelmes, otthonos hely a pihenéshez és kikapcsolódáshoz.', 6, 3, 4, 2),
(21, 4, 18, 52, 'Tengerre néző apartman', 'tengerre_nez', 65, 87, 'Tengerre néző apartman, nyugodt környezetben. Tágas és világos belső tér, minden kényelmi felszereléssel. Ideális pároknak és családoknak. Közel a strandhoz és éttermekhez. Élvezze a nyugodt tengerparti pihenést.', 4, 2, 2, 1),
(23, 6, 21, 61, 'Hegyi apartman', 'hegyi_apartman', 72, 74, 'Hegyi apartman, természetközeli pihenéshez. Tágas és világos, modern bútorokkal. Ideális családoknak és baráti társaságoknak. A környék tele van kirándulási lehetőségekkel és látnivalókkal. Kényelmes és otthonos hely a kikapcsolódásra.', 6, 3, 4, 2),
(24, 7, 19, 55, 'Skandináv stúdió', 'skandinav_studio', 38, 68, 'Skandináv stúdió, letisztult dizájnnal. Modern felszereltség, kényelmes elrendezés. Ideális pároknak és üzleti utazóknak. Közel a város nevezetességeihez és éttermeihez. Praktikus és stílusos választás rövid tartózkodáshoz.', 2, 1, 1, 1),
(25, 8, 12, 34, 'Luxus lakosztály', 'luxus_lakosztaly', 120, 145, 'Luxus lakosztály New Yorkban, prémium felszereltséggel. Tágas és elegáns belső tér, kényelmes bútorokkal. Ideális családoknak és baráti társaságoknak. Közel a város látnivalóihoz. Élvezze a prémium pihenést a metropolisz szívében.', 8, 4, 5, 3),
(26, 9, 12, 36, 'Városi stúdió', 'varosi_studio', 34, 71, 'Városi stúdió New Yorkban, ideális üzleti utazóknak. Világos és modern belső tér, praktikus felszereltséggel. Közel a közlekedéshez és a város nevezetességeihez. Kényelmes és otthonos hely rövid tartózkodáshoz.', 2, 1, 1, 1),
(27, 10, 2, 4, 'Mediterrán apartman', 'mediterran_apart', 60, 82, 'Mediterrán apartman Rómában, hangulatos belső térrel. Tágas és világos, modern bútorokkal. Ideális családoknak és pároknak. Közel a város nevezetességeihez és éttermekhez. Élvezze az olasz életstílust kényelmes környezetben.', 4, 2, 3, 2),
(28, 11, 2, 5, 'Belvárosi lakás', 'belvarosi_lakas', 45, 76, 'Belvárosi lakás Milánóban, kényelmes és otthonos. Világos belső tér, jól felszerelt. Ideális pároknak és családoknak. Közel a város főbb látnivalóihoz és közlekedéshez. Tökéletes kiindulópont Milánó felfedezéséhez.', 4, 2, 2, 1),
(29, 12, 8, 22, 'Történelmi lakás', 'tortenelmi_lakas', 55, 68, 'Történelmi hangulatú görög lakás. Klasszikus berendezés, világos és tágas. Ideális családoknak és baráti társaságoknak. Közel a helyi látnivalókhoz és éttermekhez. Élvezze a tradicionális görög környezetet kényelmesen.', 5, 2, 3, 2),
(30, 13, 8, 23, 'Modern stúdió', 'modern_studio', 30, 55, 'Modern stúdió Görögországban, praktikus és kényelmes. Világos belső tér minden igényt kielégít. Ideális pároknak és rövid tartózkodáshoz. Közel a helyi látnivalókhoz és éttermekhez. Tökéletes választás a kikapcsolódásra.', 2, 1, 1, 1),
(31, 14, 3, 211, 'Hagymatikum közelében', 'hagymatikum_kozel', 50, 66, 'Kényelmes lakás Makón, közel a Hagymatikum fürdőhöz. Tágas és világos, modern bútorokkal. Ideális családoknak és pároknak. A környék tele van éttermekkel és látnivalókkal. Tökéletes hely a pihenésre és kikapcsolódásra.', 4, 2, 2, 1),
(32, 1, 23, 67, 'Prágai Panorama Lakás', 'pragai_panorama_lakas', 65, 95, 'Tágas és napfényes lakás Prága szívében. Modern bútorok, kényelmes ágyak és teljes felszereltség várja a vendégeket. Közel a híres látnivalókhoz, éttermekhez és kávézókhoz. Ideális családoknak és pároknak. Élvezze a városi élet minden pillanatát a panorámás ablakokból.', 4, 2, 3, 2),
(33, 2, 23, 68, 'Brnoi Stílus Apartman', 'brnoi_stilus_apart', 55, 88, 'Hangulatos és stílusos apartman Brno központjában. Világos terek, modern bútorok és kényelmes ágyak várják a vendégeket. Ideális pároknak és kis családoknak. Közel éttermekhez és közlekedési csomópontokhoz. Tökéletes választás városnézéshez és pihenéshez.', 3, 1, 2, 1),
(34, 3, 23, 69, 'České Budějovice Luxus Lakás', 'ceske_budejovice_luxus', 60, 90, 'Elegáns, modern lakás České Budějovice belvárosában. Tágas nappali, jól felszerelt konyha és kényelmes hálószoba. Ideális családoknak vagy baráti társaságoknak. Közel a város főbb nevezetességeihez. Élvezze a cseh városi élet minden pillanatát.', 4, 2, 2, 1),
(35, 4, 3, 7, 'Budapesti Luxus Lakás', 'budapesti_luxus_lakas', 80, 110, 'Tágas, modern lakás Budapest belvárosában. Elegáns bútorok, teljesen felszerelt konyha és kényelmes hálószobák. Ideális családoknak és baráti társaságoknak. Közel a látnivalókhoz és éttermekhez. Élvezze a főváros nyüzsgő életét minden pillanatban.', 6, 3, 4, 2),
(36, 5, 3, 8, 'Szegedi Belvárosi Apartman', 'szeged_belvarosi_apart', 70, 50, 'Világos és kényelmes apartman Szeged belvárosában. Modern bútorok és praktikus elrendezés. Közel piacokhoz, éttermekhez és kulturális helyszínekhez. Ideális családoknak és barátoknak. Tökéletes hely a pihenésre és városi élményekhez.', 5, 2, 3, 2),
(37, 6, 3, 9, 'Debreceni Panorama Lakás', 'debreceni_panorama_lakas', 65, 55, 'Tágas, modern lakás Debrecen központjában. Világos nappali és kényelmes hálószobák. Teljes felszereltség, ideális családoknak és pároknak. Sétatávolságra éttermekhez és bevásárlási lehetőségekhez. Élvezze a debreceni városi élet minden pillanatát.', 4, 2, 3, 2),
(38, 7, 2, 4, 'Római Elegancia Lakás', 'romai_elegancia_lakas', 75, 120, 'Elegáns, világos lakás Róma központjában. Modern berendezés, kényelmes ágyak, teljes felszereltség. Ideális pároknak vagy családoknak. Közel a történelmi látnivalókhoz. Tökéletes választás a romantikus városi sétákhoz.', 5, 2, 3, 2),
(39, 8, 2, 5, 'Milánói Stílus Apartman', 'milanoi_stilus_apart', 60, 100, 'Modern, elegáns lakás Milánó szívében. Világos és tágas nappali, kényelmes hálószobák. Ideális üzleti utazóknak vagy pároknak. Közel a közlekedéshez és a divatnevezetességekhez. Élvezze Milánó vibráló hangulatát.', 4, 2, 2, 1),
(40, 9, 2, 6, 'Nápolyi Tengerparti Lakás', 'napolyi_tengerparti', 70, 95, 'Világos és tágas apartman Nápoly tengerparti részén. Modern bútorok, teljes felszereltség, ideális családoknak. Közel éttermekhez és strandokhoz. Élvezze a napfényt és a tengeri panorámát minden nap.', 5, 2, 3, 2),
(41, 10, 6, 16, 'Berlin Modern Lakás', 'berlin_modern_lakas', 50, 80, 'Fiatalos, világos apartman Berlin központjában. Kényelmes ágyak és praktikus bútorok. Ideális pároknak vagy üzleti utazóknak. Közel tömegközlekedéshez és éttermekhez. Tökéletes városi pihenéshez.', 3, 1, 2, 1),
(42, 11, 6, 17, 'München Luxus Lakás', 'munchen_luxus_lakas', 60, 105, 'Elegáns, tágas lakás München szívében. Modern bútorok és jól felszerelt konyha. Ideális családoknak és barátoknak. Közel a főbb nevezetességekhez. Élvezze a bajor város hangulatát.', 4, 2, 3, 2),
(43, 12, 6, 18, 'Kölni Stílus Apartman', 'kolni_stilus_apart', 55, 90, 'Világos és modern lakás Köln belvárosában. Kényelmes ágyak és teljes felszereltség. Ideális pároknak és kis családoknak. Közel a látnivalókhoz és éttermekhez. Tökéletes választás rövid városi tartózkodáshoz.', 3, 1, 2, 1),
(44, 13, 7, 19, 'Bécsi Elegancia Lakás', 'becsi_elegancia_lakas', 65, 95, 'Tágas, elegáns lakás Bécs központjában. Modern bútorok és kényelmes ágyak. Ideális pároknak és üzleti utazóknak. Közel a látnivalókhoz, éttermekhez és kávézókhoz. Élvezze a bécsi élet minden pillanatát.', 4, 2, 3, 2),
(45, 14, 7, 20, 'Linzi Panorama Apartman', 'linzi_panorama_apart', 60, 85, 'Világos, modern apartman Linz belvárosában. Kényelmes bútorok, teljes felszereltség. Ideális családoknak és pároknak. Közel éttermekhez és kulturális látnivalókhoz. Élvezze a városi élet minden pillanatát.', 4, 2, 2, 1),
(46, 15, 7, 21, 'Salzburg Történelmi Lakás', 'salzburg_tortenelmi_lakas', 55, 90, 'Stílusos lakás Salzburg történelmi belvárosában. Világos nappali, kényelmes ágyak és jól felszerelt konyha. Ideális pároknak és kis családoknak. Sétatávolságra a főbb látnivalóktól. Élvezze a történelmi város hangulatát.', 4, 2, 2, 1),
(47, 16, 8, 22, 'Athéni Panorama Lakás', 'atheni_panorama_lakas', 60, 95, 'Tágas és világos lakás Athén szívében. Modern bútorok, kényelmes ágyak. Ideális pároknak és családoknak. Közel az ókori látnivalókhoz és éttermekhez. Élvezze a mediterrán élet minden pillanatát.', 4, 2, 3, 2),
(48, 17, 8, 23, 'Szaloniki Modern Lakás', 'szaloniki_modern_lakas', 55, 90, 'Világos, modern lakás Szalonikiben. Kényelmes ágyak, teljes felszereltség. Ideális pároknak és kis családoknak. Közel a város látnivalóihoz és éttermekhez. Élvezze a görög életstílust minden pillanatban.', 4, 2, 2, 1),
(49, 18, 8, 24, 'Rodoszi Tengerparti Lakás', 'rodoszi_tengerparti', 65, 100, 'Tágas apartman Rodosz szigetén, közel a tengerparthoz. Modern bútorok és kényelmes ágyak. Ideális családoknak és baráti társaságoknak. Közel éttermekhez és látnivalókhoz. Élvezze a napsütést és a tengerparti pihenést.', 5, 2, 3, 2),
(50, 19, 5, 13, 'Madrid Elegáns Apartman', 'madrid_elegans_apart', 60, 95, 'Világos, stílusos lakás Madrid központjában. Modern bútorok és kényelmes ágyak. Ideális pároknak és családoknak. Közel a város főbb látnivalóihoz és éttermekhez. Élvezze a spanyol városi élet minden pillanatát.', 4, 2, 2, 1),
(51, 20, 5, 14, 'Barcelona Tengerparti Lakás', 'barcelona_tengerparti', 65, 105, 'Tágas apartman Barcelona központjában, közel a tengerparthoz. Modern bútorok és teljes felszereltség. Ideális családoknak és barátoknak. Közel látnivalókhoz és éttermekhez. Élvezze a katalán városi életet és a tengerparti pihenést.', 5, 2, 3, 2),
(52, 21, 5, 15, 'Sevilla Romantikus Lakás', 'sevilla_romantikus_lakas', 55, 90, 'Stílusos, világos apartman Sevilla történelmi részén. Kényelmes bútorok és jól felszerelt konyha. Ideális pároknak és kis családoknak. Közel a város főbb nevezetességeihez és éttermekhez. Élvezze a spanyol hangulatot minden pillanatban.', 4, 2, 2, 1),
(53, 22, 1, 1, 'Tokió Modern Lakás', 'tokio_modern_lakas', 60, 110, 'Tágas, világos lakás Tokió központjában. Modern bútorok, kényelmes ágyak. Ideális pároknak és üzleti utazóknak. Közel éttermekhez, bevásárlóközpontokhoz és látnivalókhoz. Élvezze a japán nagyvárosi élet minden pillanatát.', 4, 2, 3, 2),
(55, 24, 1, 3, 'Szapporói Tengerparti Lakás', 'szapporoi_tengerparti', 60, 100, 'Tágas, világos lakás Szapporo városában. Modern bútorok és kényelmes ágyak. Ideális családoknak és barátoknak. Közel éttermekhez és látnivalókhoz. Élvezze a japán városi és természetközeli élményeket.', 4, 2, 3, 2),
(56, 25, 4, 10, 'Párizsi Luxus Lakás', 'parizsi_luxus_lakas', 70, 120, 'Elegáns, világos lakás Párizs központjában. Modern bútorok, teljes felszereltség. Ideális pároknak és családoknak. Közel a főbb nevezetességekhez, éttermekhez és kávézókhoz. Élvezze a romantikus francia hangulatot minden pillanatban.', 4, 2, 3, 2),
(57, 26, 4, 11, 'Lyoni Stílus Apartman', 'lyoni_stilus_apart', 60, 95, 'Világos, modern apartman Lyon központjában. Kényelmes ágyak, teljes felszereltség. Ideális pároknak és üzleti utazóknak. Közel éttermekhez és látnivalókhoz. Élvezze a francia városi élet minden pillanatát.', 4, 2, 2, 1),
(58, 27, 4, 12, 'Marseille Tengerparti Lakás', 'marseille_tengerparti', 65, 100, 'Tágas, világos apartman Marseille városában, közel a tengerparthoz. Modern bútorok, kényelmes ágyak és teljes felszereltség. Ideális családoknak és baráti társaságoknak. Közel éttermekhez és látnivalókhoz. Élvezze a mediterrán életet minden pillanatban.', 5, 2, 3, 2),
(59, 28, 5, 13, 'Madrid Elegancia Lakás', 'madrid_elegancia_lakas', 60, 95, 'Világos, stílusos lakás Madrid központjában. Kényelmes ágyak, modern bútorok. Ideális pároknak és családoknak. Közel látnivalókhoz és éttermekhez. Élvezze a spanyol városi élet minden pillanatát.', 4, 2, 2, 1),
(60, 29, 5, 14, 'Barcelona Panorama Lakás', 'barcelona_panorama_lakas', 65, 105, 'Tágas és világos apartman Barcelona központjában. Kényelmes bútorok, teljes felszereltség. Ideális családoknak és pároknak. Közel látnivalókhoz és éttermekhez. Élvezze a mediterrán élet minden pillanatát.', 5, 2, 3, 2),
(61, 30, 5, 15, 'Sevilla Romantikus Lakás', 'sevilla_romantikus_lakas', 55, 90, 'Stílusos apartman Sevilla történelmi részén. Kényelmes bútorok és teljes felszereltség. Ideális pároknak és kis családoknak. Közel látnivalókhoz és éttermekhez. Élvezze a spanyol hangulatot minden pillanatban.', 4, 2, 2, 1),
(62, 31, 12, 34, 'New York City Panorama Lakás', 'newyork_panorama_lakas', 80, 150, 'Tágas, világos apartman New York szívében. Modern bútorok, kényelmes ágyak és teljes felszereltség. Ideális családoknak és üzleti utazóknak. Közel a főbb nevezetességekhez és éttermekhez. Élvezze a nagyvárosi élet minden pillanatát.', 6, 3, 4, 2),
(63, 32, 12, 35, 'Los Angeles Modern Lakás', 'losangeles_modern_lakas', 75, 140, 'Világos és stílusos lakás Los Angeles központjában. Kényelmes ágyak és modern bútorok. Ideális pároknak és üzleti utazóknak. Közel a látnivalókhoz és strandokhoz. Élvezze a kaliforniai életstílust minden pillanatban.', 5, 2, 3, 2),
(64, 33, 12, 36, 'Chicago Elegancia Apartman', 'chicago_elegancia_apart', 70, 130, 'Tágas, világos lakás Chicago központjában. Modern bútorok és kényelmes ágyak. Ideális családoknak és üzleti utazóknak. Közel éttermekhez és látnivalókhoz. Élvezze az amerikai nagyvárosi élet minden pillanatát.', 5, 2, 3, 2),
(65, 34, 11, 31, 'Montreal Stílus Lakás', 'montreal_stilus_lakas', 65, 110, 'Világos, modern apartman Montreal központjában. Kényelmes ágyak, teljes felszereltség. Ideális pároknak és családoknak. Közel a főbb látnivalókhoz és éttermekhez. Élvezze a kanadai városi élet minden pillanatát.', 4, 2, 2, 1),
(66, 35, 11, 32, 'Toronto Panorama Lakás', 'toronto_panorama_lakas', 70, 115, 'Tágas, világos apartman Toronto városában. Modern bútorok és kényelmes ágyak. Ideális családoknak és baráti társaságoknak. Közel látnivalókhoz és éttermekhez. Élvezze a kanadai városi élet minden pillanatát.', 5, 2, 3, 2),
(67, 12, 12, 35, 'Los Angeles Napfény Lakás', 'losangeles_napfeny_lakas', 75, 130, 'Világos, tágas apartman Los Angeles szívében. Modern bútorok, kényelmes ágyak, teljes felszereltség. Ideális családoknak és baráti társaságoknak. Közel a város nevezetességeihez és éttermeihez. Élvezze a kaliforniai életstílust a saját lakásában.', 5, 2, 3, 2),
(68, 12, 12, 36, 'Chicago Skyline Lakás', 'chicago_skyline_lakas', 68, 120, 'Tágas, panorámás apartman Chicago központjában. Modern bútorok és kényelmes ágyak. Ideális üzleti utazóknak és családoknak. Közel éttermekhez, parkokhoz és látnivalókhoz. Élvezze a város pezsgő életét a kényelmes otthonából.', 4, 2, 2, 2),
(69, 19, 19, 55, 'Stockholm Design Lakás', 'stockholm_design_lakas', 70, 125, 'Modern, világos lakás Stockholm belvárosában. Kényelmes ágyak, tágas nappali és teljes felszereltség. Ideális pároknak és családoknak. Közel kávézókhoz, éttermekhez és múzeumokhoz. Élvezze a svéd városi élet kényelmét és stílusát.', 4, 2, 2, 2),
(70, 19, 19, 56, 'Malmö Tágas Apartman', 'malmo_tagas_apartman', 65, 110, 'Világos és tágas apartman Malmö szívében. Modern bútorok és kényelmes ágyak. Ideális családoknak és barátoknak. Közel a város látnivalóihoz és éttermeihez. Élvezze a svéd városi élet minden pillanatát a kényelmes apartmanból.', 5, 2, 3, 2),
(71, 19, 19, 57, 'Örebro Panoráma Lakás', 'orebro_panorama_lakas', 68, 115, 'Tágas, napfényes lakás Örebro központjában. Modern bútorok és kényelmes ágyak. Ideális családoknak és pároknak. Közel látnivalókhoz és éttermekhez. Élvezze a svéd városi élet kényelmét a saját otthonában.', 4, 2, 2, 2),
(72, 20, 20, 58, 'Oslo Modern Lakás', 'oslo_modern_lakas', 70, 120, 'Világos, tágas apartman Oslo központjában. Modern bútorok, kényelmes ágyak és teljes felszereltség. Ideális családoknak és pároknak. Közel a látnivalókhoz és éttermekhez. Élvezze a norvég városi élet minden pillanatát.', 5, 3, 3, 2),
(73, 20, 20, 59, 'Bergen Fjord Lakás', 'bergen_fjord_lakas', 65, 115, 'Tágas, világos lakás Bergen történelmi részén. Modern bútorok és kényelmes ágyak. Ideális pároknak és családoknak. Közel a város látnivalóihoz és éttermekhez. Élvezze a fjordok látványát és a norvég városi életet.', 4, 2, 2, 2),
(74, 20, 20, 60, 'Tromsø Arctic Stúdió', 'tromso_arctic_studio', 55, 100, 'Modern stúdió Tromsø központjában. Kényelmes ágy, világos belső tér. Ideális pároknak és egyéni utazóknak. Közel a város látnivalóihoz és éttermekhez. Élvezze az északi fény varázsát a saját stúdiójában.', 2, 1, 1, 1),
(75, 21, 21, 61, 'Helsinki Design Lakás', 'helsinki_design_lakas', 70, 120, 'Világos, modern apartman Helsinki belvárosában. Kényelmes ágyak és tágas nappali. Ideális családoknak és pároknak. Közel éttermekhez, kávézókhoz és múzeumokhoz. Élvezze a finn városi élet minden pillanatát.', 4, 2, 2, 2),
(76, 21, 21, 62, 'Tampere Panoráma Lakás', 'tampere_panorama_lakas', 65, 110, 'Tágas és világos apartman Tampere központjában. Modern bútorok és kényelmes ágyak. Ideális családoknak és pároknak. Közel a város látnivalóihoz és éttermeihez. Élvezze a finn városi életet a kényelmes otthonából.', 4, 2, 2, 2),
(77, 21, 21, 63, 'Oulu Arctic Lakás', 'oulu_arctic_lakas', 68, 115, 'Világos, modern apartman Oulu központjában. Tágas nappali, kényelmes ágyak. Ideális pároknak és családoknak. Közel látnivalókhoz és éttermekhez. Élvezze a finn városi életet és az északi hangulatot a saját otthonában.', 5, 2, 3, 2),
(78, 22, 22, 64, 'Varsó Elegáns Lakás', 'varso_elegans_lakas', 70, 120, 'Világos, tágas apartman Varsó központjában. Modern bútorok, kényelmes ágyak. Ideális családoknak és pároknak. Közel a város látnivalóihoz és éttermeihez. Élvezze a lengyel városi élet minden pillanatát.', 4, 2, 2, 2),
(79, 22, 22, 65, 'Krakkó Történelmi Lakás', 'krakko_tortenelmi_lakas', 65, 115, 'Tágas, világos lakás Krakkó történelmi részén. Modern bútorok és kényelmes ágyak. Ideális családoknak és pároknak. Közel a látnivalókhoz és éttermekhez. Élvezze a lengyel városi élet varázsát a saját otthonából.', 5, 2, 3, 2),
(80, 22, 22, 66, 'Gdańsk Panoráma Lakás', 'gdansk_panorama_lakas', 68, 118, 'Világos, modern apartman Gdańsk központjában. Tágas nappali, kényelmes ágyak. Ideális családoknak és pároknak. Közel látnivalókhoz és éttermekhez. Élvezze a lengyel városi élet minden pillanatát.', 4, 2, 2, 2),
(81, 23, 23, 68, 'Brno Modern Lakás', 'brno_modern_lakas', 65, 115, 'Tágas, világos apartman Brno belvárosában. Modern bútorok és kényelmes ágyak. Ideális pároknak és családoknak. Közel a város látnivalóihoz és éttermeihez. Élvezze a cseh városi élet minden pillanatát.', 4, 2, 2, 2),
(82, 23, 23, 69, 'České Budějovice Napfény Lakás', 'ceske_budejovice_napfeny_lakas', 70, 120, 'Világos, tágas apartman České Budějovice központjában. Modern bútorok, kényelmes ágyak. Ideális családoknak és pároknak. Közel a helyi látnivalókhoz és éttermekhez. Élvezze a cseh városi élet minden pillanatát.', 5, 2, 3, 2),
(83, 24, 24, 70, 'Pozsony Elegáns Lakás', 'pozsony_elegans_lakas', 68, 118, 'Modern, világos apartman Pozsony központjában. Kényelmes ágyak, tágas nappali. Ideális pároknak és családoknak. Közel a város látnivalóihoz és éttermeihez. Élvezze a szlovák városi élet kényelmét és stílusát.', 4, 2, 2, 2),
(84, 13, 13, 37, 'Sydney Harbour Lakás', 'sydney_harbour_lakas', 80, 140, 'Gyönyörű, modern apartman Sydney központjában, kilátással a kikötőre. Tágas nappali, kényelmes hálószobák. Ideális családoknak és pároknak. Közel éttermekhez és nevezetességekhez. Élvezze az ausztrál városi élet minden pillanatát.', 5, 3, 3, 2),
(85, 13, 13, 38, 'Melbourne Design Lakás', 'melbourne_design_lakas', 65, 125, 'Stílusos, modern lakás Melbourne szívében. Világos terek és kényelmes ágyak. Ideális pároknak és üzleti utazóknak. Közel kávézókhoz, éttermekhez és művészeti helyszínekhez. Élvezze a város kreatív hangulatát a saját apartmanjában.', 4, 2, 2, 1),
(86, 13, 13, 39, 'Brisbane Modern Lakás', 'brisbane_modern_lakas', 70, 118, 'Tágas és napfényes apartman Brisbane központjában. Modern bútorok, kényelmes ágyak és teljes felszereltség. Ideális családoknak és barátoknak. Közel a helyi látnivalókhoz és éttermekhez. Élvezze a város pezsgő életét a kényelmes otthonából.', 5, 2, 3, 2),
(87, 14, 14, 40, 'Szöul Panoráma Stúdió', 'seoul_panorama_studio', 40, 90, 'Világos stúdió Szöul központjában. Modern bútorok, kényelmes ágy. Ideális egyéni utazóknak vagy pároknak. Közel metróhoz és éttermekhez. Élvezze a város pezsgő életét a saját kényelmes lakásában.', 2, 1, 1, 1),
(88, 14, 14, 41, 'Puszan Tengerparti Apartman', 'puszan_tengerparti_ap', 60, 110, 'Tágas apartman Puszan tengerparti részén. Világos és modern bútorok, kényelmes ágyak. Ideális családoknak és baráti társaságoknak. Közel a strandhoz és éttermekhez. Élvezze a tengerparti hangulatot a városközpontban.', 4, 2, 2, 2),
(89, 14, 14, 42, 'Incshon Business Stúdió', 'inschon_business_studio', 38, 88, 'Modern, praktikus stúdió Incshon központjában. Kényelmes ágy, teljes felszereltség. Ideális üzleti utazóknak és pároknak. Közel a közlekedési csomópontokhoz és éttermekhez. Élvezze a város kényelmét a saját stúdiójában.', 2, 1, 1, 1),
(90, 15, 15, 43, 'Peking Történelmi Lakás', 'peking_tortenelmi_lakas', 75, 115, 'Gyönyörű, tágas lakás Peking történelmi negyedében. Modern bútorok, kényelmes ágyak. Ideális családoknak és pároknak. Közel a nevezetességekhez és helyi éttermekhez. Élvezze a kínai városi kultúrát kényelmes környezetben.', 5, 3, 3, 2),
(91, 15, 15, 44, 'Sanghaj Modern Lakás', 'sanghaj_modern_lakas', 70, 120, 'Világos, modern apartman Sanghaj központjában. Kényelmes bútorok, tágas hálószobák. Ideális családoknak és barátoknak. Közel üzletekhez és éttermekhez. Élvezze a kínai nagyvárosi élet minden pillanatát.', 4, 2, 2, 2),
(92, 15, 15, 45, 'Kuangcsou Panoráma Lakás', 'kuangcsou_panorama_lakas', 68, 118, 'Tágas és világos lakás Kuangcsou központjában. Modern bútorok és kényelmes ágyak. Ideális családoknak és üzleti utazóknak. Közel látnivalókhoz és éttermekhez. Élvezze a város pezsgő hangulatát a saját apartmanjában.', 5, 2, 3, 2),
(93, 16, 16, 46, 'Mumbai Luxus Apartman', 'mumbai_luxus_apartman', 80, 125, 'Tágas és elegáns apartman Mumbai központjában. Modern bútorok, kényelmes ágyak és teljes felszereltség. Ideális családoknak és pároknak. Közel a város látnivalóihoz és éttermeihez. Élvezze az indiai városi élet minden pillanatát.', 5, 3, 3, 2),
(94, 16, 16, 47, 'Bangalore Modern Lakás', 'bangalore_modern_lakas', 65, 110, 'Világos, modern lakás Bangalore központjában. Kényelmes ágyak és teljes felszereltség. Ideális pároknak és üzleti utazóknak. Közel éttermekhez, üzletekhez és nevezetességekhez. Élvezze az indiai városi életet kényelmes környezetben.', 4, 2, 2, 2),
(95, 16, 16, 48, 'Csennai Napfény Lakás', 'csennai_napfeny_lakas', 70, 115, 'Tágas, világos apartman Csennai központjában. Modern bútorok, kényelmes ágyak. Ideális családoknak és barátoknak. Közel látnivalókhoz és éttermekhez. Élvezze a városi élet minden pillanatát.', 5, 2, 3, 2),
(96, 17, 17, 49, 'Mexikóváros Stílus Lakás', 'mexikovaros_stilus_lakas', 75, 120, 'Modern, világos apartman Mexikóváros központjában. Tágas nappali, kényelmes ágyak. Ideális családoknak és pároknak. Közel a nevezetességekhez és éttermekhez. Élvezze a mexikói városi élet minden pillanatát.', 5, 3, 3, 2),
(97, 17, 17, 50, 'Guadalajara Design Lakás', 'guadalajara_design_lakas', 65, 110, 'Világos, modern lakás Guadalajarában. Kényelmes bútorok, teljes felszereltség. Ideális pároknak és üzleti utazóknak. Közel éttermekhez és látnivalókhoz. Élvezze a mexikói városi élet kényelmes környezetben.', 4, 2, 2, 1),
(98, 17, 17, 51, 'Monterrey Panoráma Lakás', 'monterrey_panorama_lakas', 70, 115, 'Tágas, világos apartman Monterrey központjában. Modern bútorok és kényelmes ágyak. Ideális családoknak és baráti társaságoknak. Közel a város látnivalóihoz és éttermeihez. Élvezze a mexikói városi élet minden pillanatát.', 5, 2, 3, 2),
(99, 18, 18, 52, 'Lisszabon Napfény Lakás', 'lisszabon_napfeny_lakas', 75, 120, 'Világos, tágas apartman Lisszabon történelmi központjában. Modern bútorok, kényelmes ágyak. Ideális családoknak és pároknak. Közel a nevezetességekhez és éttermekhez. Élvezze a portugál városi élet minden pillanatát.', 5, 3, 3, 2),
(100, 18, 18, 53, 'Porto Design Lakás', 'porto_design_lakas', 65, 110, 'Stílusos, modern lakás Porto központjában. Kényelmes ágyak, teljes felszereltség. Ideális pároknak és üzleti utazóknak. Közel látnivalókhoz és éttermekhez. Élvezze a portugál városi életet kényelmes környezetben.', 4, 2, 2, 2);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `accommodations_details`
--

CREATE TABLE `accommodations_details` (
  `apartman_id` int(5) NOT NULL,
  `coffee_maker` tinyint(1) DEFAULT 0,
  `kettle` tinyint(1) DEFAULT 0,
  `microwave` tinyint(1) DEFAULT 0,
  `basic_spices` tinyint(1) DEFAULT 0,
  `dishes` tinyint(1) DEFAULT 0,
  `extra_bed_linen` tinyint(1) DEFAULT 0,
  `darkening` tinyint(1) DEFAULT 0,
  `night_lamp` tinyint(1) DEFAULT 0,
  `towels` tinyint(1) DEFAULT 0,
  `hair_dryer` tinyint(1) DEFAULT 0,
  `smart_tv` tinyint(1) DEFAULT 0,
  `bluetooth_speaker` tinyint(1) DEFAULT 0,
  `usb_charger` tinyint(1) DEFAULT 0,
  `work_table` tinyint(1) DEFAULT 0,
  `suitcase_rack` tinyint(1) DEFAULT 0,
  `iron` tinyint(1) DEFAULT 0,
  `safe` tinyint(1) DEFAULT 0,
  `balcony` tinyint(1) DEFAULT 0,
  `board_games` tinyint(1) DEFAULT 0,
  `free_wifi` tinyint(1) DEFAULT 0,
  `parking_lot` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `accommodations_details`
--

INSERT INTO `accommodations_details` (`apartman_id`, `coffee_maker`, `kettle`, `microwave`, `basic_spices`, `dishes`, `extra_bed_linen`, `darkening`, `night_lamp`, `towels`, `hair_dryer`, `smart_tv`, `bluetooth_speaker`, `usb_charger`, `work_table`, `suitcase_rack`, `iron`, `safe`, `balcony`, `board_games`, `free_wifi`, `parking_lot`) VALUES
(1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0),
(2, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0),
(3, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0),
(4, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0),
(5, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(6, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(7, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0),
(8, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0),
(9, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(10, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1),
(13, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0),
(14, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(15, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1),
(16, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(17, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(18, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0),
(19, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(20, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1),
(21, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1),
(23, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1),
(24, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(25, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1),
(26, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(27, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(28, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(29, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(30, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(31, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1),
(32, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0),
(33, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0),
(34, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(35, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1),
(36, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(37, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(38, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(39, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1),
(40, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(41, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(42, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(43, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1),
(44, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(45, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(46, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(47, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1),
(48, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(49, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(50, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(51, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(52, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(53, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(55, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(56, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(57, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(58, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(59, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1),
(60, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(61, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(62, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(63, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(64, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1),
(65, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(66, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(67, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(68, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(69, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1),
(70, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(71, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(72, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(73, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(74, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1),
(75, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(76, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(77, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(78, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(79, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1),
(80, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(81, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(82, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(83, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(84, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1),
(85, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(86, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(87, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(88, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1),
(89, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(90, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(91, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(92, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(93, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1),
(94, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(95, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(96, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(97, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(98, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1),
(99, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(100, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `card_networks`
--

CREATE TABLE `card_networks` (
  `id` int(11) NOT NULL,
  `network_name` varchar(50) NOT NULL,
  `prefix` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `card_networks`
--

INSERT INTO `card_networks` (`id`, `network_name`, `prefix`) VALUES
(1, 'Visa', '4'),
(2, 'Mastercard', '5'),
(3, 'American Express', '34'),
(4, 'American Express', '37'),
(5, 'Diners Club', '30'),
(6, 'Diners Club', '36'),
(7, 'Diners Club', '38'),
(8, 'Discover', '6'),
(9, 'JCB', '35'),
(10, 'UnionPay', '62'),
(11, 'Maestro', '50'),
(12, 'Maestro', '56'),
(13, 'Maestro', '57'),
(14, 'Maestro', '58'),
(15, 'Maestro', '59'),
(16, 'Maestro', '6');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `cities`
--

CREATE TABLE `cities` (
  `id` int(5) NOT NULL,
  `country_id` int(5) DEFAULT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `cities`
--

INSERT INTO `cities` (`id`, `country_id`, `name`) VALUES
(1, 1, 'Tokió'),
(2, 11, 'Oszaka\r\n'),
(3, 1, 'Szapporo'),
(4, 2, 'Róma'),
(5, 2, 'Milánó'),
(6, 2, 'Nápoly'),
(7, 3, 'Budapest'),
(8, 3, 'Szeged'),
(9, 3, 'Debrecen'),
(10, 4, 'Párizs'),
(11, 4, 'Lyon'),
(12, 4, 'Marseille'),
(13, 5, 'Madrid'),
(14, 5, 'Barcelona'),
(15, 5, 'Sevilla'),
(16, 6, 'Berlin'),
(17, 6, 'München'),
(18, 6, 'Köln'),
(19, 7, 'Bécs'),
(20, 7, 'Linz'),
(21, 7, 'Salzburg'),
(22, 8, 'Athén'),
(23, 8, 'Szaloniki'),
(24, 8, 'Rodosz'),
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
(40, 14, 'Szöul'),
(41, 14, 'Puszan'),
(42, 14, 'Incshon'),
(43, 15, 'Peking'),
(44, 15, 'Sanghaj'),
(45, 15, 'Kuangcsou'),
(46, 16, 'Mumbai'),
(47, 16, 'Bangalore'),
(48, 16, 'Csennai'),
(49, 17, 'Mexikóváros'),
(50, 17, 'Guadalajara'),
(51, 17, 'Monterrey'),
(52, 18, 'Lisszabon'),
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
(64, 22, 'Varsó'),
(65, 22, 'Krakkó'),
(66, 22, 'Gdańsk'),
(67, 23, 'Prága'),
(68, 23, 'Brno'),
(69, 23, 'České Budějovice'),
(70, 24, 'Pozsony'),
(71, 24, 'Kassa'),
(72, 24, 'Besztercebánya'),
(73, 25, 'Bukarest'),
(74, 25, 'Kolozsvár'),
(75, 25, 'Brașov'),
(76, 26, 'Zágráb'),
(77, 26, 'Split'),
(78, 26, 'Rijeka'),
(79, 27, 'Ljubljana'),
(80, 27, 'Maribor'),
(81, 27, 'Koper'),
(82, 28, 'Belgrád'),
(83, 28, 'Niš'),
(84, 28, 'Novi Sad'),
(85, 29, 'Podgorica'),
(86, 29, 'Kotor'),
(87, 29, 'Bar'),
(88, 30, 'Szarajevó'),
(89, 30, 'Mostar'),
(90, 30, 'Tuzla'),
(91, 31, 'Tirana'),
(92, 31, 'Durrës'),
(93, 31, 'Vlorë'),
(94, 32, 'Szófia'),
(95, 32, 'Plovdiv'),
(96, 32, 'Varna'),
(97, 33, 'Isztambul'),
(98, 33, 'Ankara'),
(99, 33, 'Izmir'),
(100, 34, 'Kairó'),
(101, 34, 'Alexandria'),
(102, 34, 'Gíza'),
(103, 35, 'Marrákes'),
(104, 35, 'Fés'),
(105, 35, 'Rabat'),
(106, 36, 'Fokváros'),
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
(124, 42, 'Brüsszel'),
(125, 42, 'Ghent'),
(126, 42, 'Antwerpen'),
(127, 43, 'Amszterdam'),
(128, 43, 'Hágai'),
(129, 43, 'Rotterdam'),
(130, 44, 'Luxemburg'),
(131, 44, 'Esch-sur-Alzette'),
(132, 44, 'Differdange'),
(133, 45, 'Vaduz'),
(134, 45, 'Triesen'),
(135, 45, 'Eschen'),
(136, 46, 'Zürich'),
(137, 46, 'Bern'),
(138, 46, 'Genf'),
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
(154, 52, 'Tbiliszi'),
(155, 52, 'Kutaisi'),
(156, 52, 'Batumi'),
(157, 53, 'Kijev'),
(158, 53, 'Lviv'),
(159, 53, 'Dnipro'),
(160, 54, 'Minszk'),
(161, 54, 'Vitebsk'),
(162, 54, 'Grodno'),
(163, 55, 'Moszkva'),
(164, 55, 'Szentpétervár'),
(165, 55, 'Jekatyerinburg'),
(166, 56, 'Almaty'),
(167, 56, 'Asztana'),
(168, 56, 'Ssimkent'),
(169, 57, 'Szingapúr'),
(170, 57, 'Jurong East'),
(171, 57, 'Tampines'),
(172, 58, 'Kuala Lumpur'),
(173, 58, 'Johor Bahru'),
(174, 58, 'George Town'),
(175, 59, 'Jakarta'),
(176, 59, 'Bandung'),
(177, 59, 'Surabaya'),
(178, 60, 'Hanoi'),
(179, 60, 'Ho Chi Minh-város'),
(180, 60, 'Da Nang'),
(181, 61, 'Manila'),
(182, 61, 'Cebu-város'),
(183, 61, 'Davao-város'),
(184, 62, 'Iszlámábád'),
(185, 62, 'Lahore'),
(186, 62, 'Karachi'),
(187, 63, 'Kathmandu'),
(188, 63, 'Pokhara'),
(189, 63, 'Biratnagar'),
(190, 64, 'Colombo'),
(191, 64, 'Kandy'),
(192, 64, 'Galle'),
(193, 65, 'Teherán'),
(194, 65, 'Mashhad'),
(195, 65, 'Iszfahán'),
(196, 66, 'Bagdad'),
(197, 66, 'Basra'),
(198, 66, 'Erbil'),
(199, 67, 'Rijád'),
(200, 67, 'Dzsiddá'),
(201, 67, 'Dammam'),
(202, 68, 'Dubai'),
(203, 68, 'Abu Dhabi'),
(204, 68, 'Sharjah'),
(205, 69, 'Tel-Aviv'),
(206, 69, 'Jeruzsálem'),
(207, 69, 'Haifa'),
(208, 70, 'Auckland'),
(209, 70, 'Wellington'),
(210, 70, 'Dunedin'),
(211, 3, 'Makó'),
(212, 3, 'Apátfalva'),
(213, 3, 'Pécs'),
(214, 3, 'Győr');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `countries`
--

CREATE TABLE `countries` (
  `id` int(5) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `countries`
--

INSERT INTO `countries` (`id`, `name`) VALUES
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
-- Tábla szerkezet ehhez a táblához `currency`
--

CREATE TABLE `currency` (
  `id` int(5) NOT NULL,
  `full_name` varchar(50) NOT NULL,
  `multiplier` varchar(50) NOT NULL,
  `shorted_name` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `currency`
--

INSERT INTO `currency` (`id`, `full_name`, `multiplier`, `shorted_name`) VALUES
(1, 'Euro', '1', 'EUR'),
(2, 'Magyar forint', '390', 'HUF'),
(3, 'Szerb dinár', '117', 'RSD'),
(4, 'Amerikai dollár', '1.1', 'USD'),
(5, 'Svájci frank', '0.96', 'CHF'),
(6, 'Japán jen', '160', 'JPY'),
(7, 'Kínai jüan', '7.8', 'CNY'),
(8, 'Dél-koreai won', '1450', 'KRW'),
(9, 'Indiai rúpia', '90', 'INR'),
(10, 'Indonéz rúpia', '17000', 'IDR'),
(11, 'Szingapúri dollár', '1.45', 'SGD'),
(12, 'Thai baht', '39', 'THB'),
(13, 'Fülöp-szigeteki peso', '63', 'PHP'),
(14, 'Maláj ringgit', '5.1', 'MYR'),
(15, 'Vietnámi dong', '27000', 'VND'),
(16, 'Kanadai dollár', '1.48', 'CAD'),
(17, 'Ausztrál dollár', '1.62', 'AUD'),
(18, 'Új-zélandi dollár', '1.75', 'NZD'),
(19, 'Norvég korona', '11.5', 'NOK'),
(20, 'Svéd korona', '11.2', 'SEK'),
(21, 'Dán korona', '7.45', 'DKK'),
(22, 'Cseh korona', '25.5', 'CZK'),
(23, 'Lengyel zloty', '4.4', 'PLN'),
(24, 'Román lej', '5', 'RON'),
(25, 'Török líra', '35', 'TRY'),
(26, 'Brazil real', '6', 'BRL'),
(27, 'Argentin peso', '950', 'ARS'),
(28, 'Mexikói peso', '20', 'MXN'),
(29, 'Dél-afrikai rand', '20.5', 'ZAR'),
(30, 'Egyiptomi font', '50', 'EGP'),
(31, 'Szaúdi riál', '4.1', 'SAR'),
(32, 'Egyesült Arab Emírségek dirham', '4', 'AED'),
(33, 'Kuvaiti dinár', '0.3', 'KWD'),
(34, 'Katari riál', '4', 'QAR'),
(35, 'Hongkongi dollár', '8.6', 'HKD'),
(36, 'Taiwani új dollár', '34', 'TWD'),
(37, 'Pakisztáni rúpia', '310', 'PKR'),
(38, 'Bangladesi taka', '120', 'BDT'),
(39, 'Srí Lanka-i rúpia', '360', 'LKR'),
(40, 'Izraeli sékel', '4.2', 'ILS'),
(41, 'Angol font', '0.85', 'GBP');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `experiences`
--

CREATE TABLE `experiences` (
  `id` int(5) NOT NULL,
  `country_id` int(5) DEFAULT NULL,
  `city_id` int(5) DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `folder_name` varchar(40) NOT NULL,
  `price` int(7) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `experiences`
--

INSERT INTO `experiences` (`id`, `country_id`, `city_id`, `name`, `folder_name`, `price`, `description`) VALUES
(1, 3, 211, 'Hagymatikum Gyógyfürdő élmény', 'hagymatikum_furdo', 65, 'Fedezze fel Makó egyik legismertebb turisztikai vonzerejét, a Hagymatikum Gyógyfürdőt. A különleges Makovecz‑stílusú épület önmagában is különleges látványt nyújt. A gyógyvizes medencék és wellness részlegek egész napos kikapcsolódást kínálnak minden korosztálynak. Élvezze a wellness szolgáltatásokat, szaunaparkot és gyógyvizes fürdőket egyaránt. Tökéletes választás családoknak, pároknak és baráti társaságoknak egyaránt.'),
(2, 23, 67, 'Prágai óvárosi városnézés', 'praga_ovaros', 45, 'Fedezze fel Prága történelmi óvárosát egy részletes séta során, ahol a macskaköves utcák és történelmi épületek mesélnek a város múltjáról. Látogassa meg az Óvárosi teret, az Orloj asztronómiai órát és a közeli falusias sikátorokat. Az élmény során helyi történeteket és legendákat ismerhet meg. Prága különleges hangulatát a kávézók és bábjátékosok teszik feledhetetlenné. A nap végén egy helyi étteremben kóstolja meg a cseh konyha specialitásait.'),
(3, 23, 67, 'Prágai vár és Szent Vitus székesegyház', 'praga_var', 55, 'Látogassa meg Prága legismertebb történelmi komplexumát, ahol több évszázad eseményeit ismerheti meg. A Szent Vitus székesegyház impozáns gótikus építészete és részletes díszítése lenyűgöző. Sétáljon végig a vár falain, és csodálja meg a panorámát a városra. A környéken múzeumok és parkok is megtalálhatók. Az élmény különösen fotóbarát helyszínekkel gazdagítja a városnézést.'),
(4, 23, 67, 'Vltava hajókirándulás', 'vltava_hajo', 55, 'Ugorjon fel egy folyami hajóra és élvezze a Vltava folyó látványát Prágában. A Károly híd, a városi panoráma és a parti épületek egészen új perspektívából tárulnak fel. A fedélzeti idegenvezetés érdekes történeteket mesél a városról. A naplemente különösen romantikus a fedélzetről. Érdemes vacsorával kombinálni az élményt egy teljes napos programért.'),
(5, 7, 19, 'Bécsi klasszikus zenei est', 'becs_zene', 60, 'Merüljön el Bécs világhírű zenei életében egy klasszikus koncert során, ahol Mozart, Strauss és más nagy művészek művei csendülnek fel. A történelmi koncertterem csodás akusztikája és díszítése emlékezetes élményt nyújt. A koncert előtt sétáljon a környék bájos utcáin. A város kávéházaiban élvezheti a helyi süteményeket és kávékat. Ideális program kultúra és zene kedvelőknek.'),
(6, 7, 19, 'Schönbrunni kastély és kert', 'schonbrunn', 50, 'Fedezze fel a Schönbrunni kastély pompás termeit, amelyek az osztrák császári család egykori rezidenciáját idézik. A barokk stílusú kertek és parkok tökéletes helyet adnak egy pihentető sétához. Látogassa meg a kastély állatkertjét is, amely Európa egyik legrégebbi. A panoráma a kertből csodás kilátást nyújt Bécsre. A program tartalmaz fotószüneteket és idegenvezetést is.'),
(7, 7, 20, 'Linz Duna-parti séta', 'linz_duna', 30, 'Vegyen részt egy kellemes sétán a Duna partján Linz városában, ahol a modern és történelmi építészet találkozik. A Duna partja mentén kávézók és kilátópontok várják a látogatókat. A folyóparti sétány ideális piknikezéshez vagy pihenéshez. A város művészeti negyedét is érdemes felkeresni. A séta során megismerheti Linz kultúráját és hangulatát.'),
(8, 3, 7, 'Budapesti Parlament túra', 'parlament', 40, 'Ismerje meg Budapest ikonikus Parlament épületét egy izgalmas vezetett túra során. A neogótikus stílus belső termei lenyűgöznek minden látogatót. Megtekintheti a koronázási ékszereket és ritka történelmi relikviákat. A túra során sok érdekességet tudhat meg Magyarország történelméről. Ajánlott előfoglalással érkezni a nagy érdeklődés miatt.'),
(9, 3, 7, 'Duna esti hajózás', 'duna_hajo', 55, 'Élje át Budapest varázslatos esti panorámáját egy dunai hajókiránduláson keresztül. A kivilágított Lánchíd, Parlament és Budai Vár pazar látványt nyújtanak. A fedélzeten étel és ital is elérhető. A program romantikus hangulatot kínál pároknak vagy baráti társaságoknak egyaránt. Kiváló fotóhelyszínek minden irányban.'),
(10, 3, 7, 'Budai Várnegyed séta', 'budai_var', 40, 'Sétáljon végig a történelmi Budai Várnegyed utcáin, ahol a középkori falak és várfalak mesélnek a múlt századokról. A kilátás a városra és a Dunára egyedülálló. A nevezetességek között található a Halászbástya és Mátyás temploma. A környék tele van múzeumokkal és hangulatos kávézókkal. Ideális kulturális és pihentető napra.'),
(11, 3, 8, 'Szegedi belvárosi séta', 'szeged_seta', 30, 'Fedezze fel Szeged napfényes belvárosát, híres szecessziós épületeit és tágas tereit. A Dóm tér látványos katedrálisa különleges fotótémát kínál. A séta során felfedezheti a helyi kávézókat, parkokat és kulturális helyszíneket. A város gasztronómiája is megér egy próbát helyi specialitásokkal. A nyugodt utcák ideálisak egy kellemes délutáni programhoz.'),
(12, 3, 9, 'Debreceni Nagytemplom látogatás', 'debrecen_nagytemplom', 25, 'Ismerje meg Debrecen történelmi ékességét, a Nagytemplomot, amely a város szimbóluma. A hatalmas épület belső tere lenyűgöző és gazdag vallási örökséget hordoz. A templom környéke ideális sétára és pihenésre. Fedezze fel a helyi kulturális negyedet és kávézókat. A város más nevezetességekkel is várja a látogatókat.'),
(13, 4, 10, 'Eiffel‑torony látogatás', 'eiffel_torony', 55, 'Látogassa meg Párizs ikonikus Eiffel‑toronyját és élvezze a panorámát a városra minden szinten. A torony története több mint 130 éves és világszerte ismert. A közeli Champ de Mars park ideális piknikezéshez. A torony környezetében számos kávézó és étterem várja a látogatókat. A kilátóponton történő naplemente különösen lenyűgöző élmény.'),
(14, 4, 10, 'Szajna parti romantikus séta', 'szajna_seta', 35, 'Élvezze a Szajna folyó menti sétát Párizs szívében, ahol hídak és történelmi épületek sorakoznak. Kávézók és kis butikok tarkítják az útvonalat. A séta során megállhat a Louvre vagy a Notre‑Dame közelében. Ideális romantikus program egy napvégi vacsorával kombinálva. A hely varázsa minden évszakban érezhető.'),
(15, 6, 16, 'Berlin történelmi városnézés', 'berlin_tortenelem', 45, 'Fedezze fel Berlin történelmi központját, amely a modern és a múlt emlékeit egyaránt bemutatja. A Brandenburgi kapu, a berlini fal maradványai és a Reichstag épülete mind jelentős látnivalók. A város számos múzeuma és parkja egész napos programot biztosít. A helyi gasztronómia Berlin egyéni jellegét tükrözi. Ideális városlátogatás családoknak és barátoknak egyaránt.'),
(16, 6, 17, 'München sörkultúra túra', 'munchen_sor', 50, 'Ismerje meg München híres sörkultúráját egy tradicionális sörfőzde látogatással és kóstolóval. A bajor sörök világhírűek, és az autentikus hangulatot a helyi sörkertek adják. A túra során szakértő vezető mesél a sörfőzés történetéről és hagyományairól. A város történelmi terein és parkjain keresztül sétálva még több látványosságot fedezhet fel. Kiváló élmény baráti társaságoknak vagy sörkedvelőknek.'),
(17, 2, 4, 'Római Colosseum felfedezés', 'colosseum', 60, 'Fedezze fel az ókori Róma egyik legismertebb történelmi emlékét, a Colosseumot. A hatalmas amfiteátrum gladiátorjátékainak emlékét idézi fel. A vezetett túra során a részletes történetek még mélyebbé teszik az élményt. A közeli Forum Romanum és Palatinus domb is felfedezésre vár. Ideális program történelem iránt érdeklődőknek.'),
(18, 2, 5, 'Milánói divatnegyed séta', 'milano_divat', 45, 'Fedezze fel Milánó világmárkák által uralt divatnegyedét, ahol a legújabb trendeket követő üzletek sorakoznak. A séta során a Dóm tér és az elegáns bevásárlóutcák is útba esnek. A helyi kávézók és designer üzletek kiváló programot kínálnak vásárlóknak és látogatóknak. A város kulturális és történelmi helyszínei egyaránt elérhetők gyalogosan vagy tömegközlekedéssel. A divat és történelem különleges keveréke minden látogatót lenyűgöz.'),
(19, 8, 22, 'Athéni Akropolisz látogatás', 'athen_akropolisz', 55, 'Látogassa meg Athén ókori dombját, ahol az Akropolisz áll, és csodálja meg a Parthenón lenyűgöző maradványait. A helyszín több évezredes történelmet hordoz, és a városra nyíló panoráma sehol máshol nem hasonlítható. A görög mitológia nagyszerű történeteivel teli túra különösen izgalmas. A környék tele van múzeumokkal és kültéri piacokkal, ahol helyi finomságokat kóstolhat. Az élmény egész napos programot kínál művészet és történelem szerelmeseinek.'),
(20, 8, 24, 'Rodoszi tengerparti pihenés', 'rodosz_part', 50, 'Élvezze Rodosz szigetén a homokos tengerpartok pihentető hangulatát és a kristálytiszta vizet. A strandok ideálisak úszásra, napozásra és vízi sportokra. A környéken bárok és éttermek kínálnak mediterrán ízeket és hűsítő italokat. A naplemente látványa a tenger felett felejthetetlen élmény. Ez a program tökéletes választás nyári pihenésre vágyóknak.'),
(21, 19, 55, 'Stockholmi óvárosi séta', 'stockholm_ovaros', 45, 'Fedezze fel Stockholm történelmi óvárosát, Gamla Stant, ahol szűk utcák, színes házak és hangulatos teraszok várják. A város gazdag történelmének megismerése során múzeumok és látogatói központok is szerepelnek a programban. A parti kilátás és a skandináv stílusú kávézók különleges hangulatot adnak az élménynek. Séta közben érdemes helyi kézműves termékeket és specialitásokat kóstolni. Stockholm kulturális és természeti értékeket egyaránt kínál látogatói számára.'),
(22, 19, 56, 'Malmö modern városnézés', 'malmo_modern', 35, 'Ismerje meg Malmö modern arcát, ahol a városfenntartó és dizájn megoldások egyedi hangulatot teremtenek. A város zöld parkjai és innovative városi terei ideálisak sétához. A helyi utcai művészetek és kávéházak hangulata különleges élményt nyújt. A város a tengerpart közelségével és kikötőivel kombinálja a fiatalos életérzést. Ideális többnapos városnézéshez vagy pihentető programhoz.'),
(23, 20, 58, 'Oslo fjord túra', '', 60, 'Látogassa meg Oslo híres fjordját és élvezze a norvég természet közelségét a városi környezetben. Hajókiránduláson keresztül fedezheti fel a fjord nyújtotta panorámát és különleges öblöket. A fjord menti túrák során vízre néző kávézók és éttermek is várják a látogatókat. A levegő tisztasága és a hegyvidéki kilátás felejthetetlen élményt kínál. Az egész napos program alkalmas természet és városi élet kombinálására.'),
(24, 21, 61, 'Helsinki design városnézés', 'helsinki_design', 40, 'Fedezze fel Helsinki modern designkultúráját, amely világhírű az építészet és kreatív terek terén. A város letisztult épületei, galériái és múzeumai inspiráló élményt nyújtanak. Séta közben látogassa meg a helyi dizájnboltokat és kávézókat. A tengerparti sétányok és parkok nyugodt hangulatot biztosítanak a pihenéshez. Helsinkiben a kultúra és a természet harmonikusan egyesül. '),
(25, 22, 64, 'Varsói történelmi központ', 'varso_ovaros', 35, 'Fedezze fel Varsó történelmi belvárosát, ahol újjáépített óvárosi terek és kávézók várják a látogatókat. A város gazdag történelméről rengeteg információ található helyi múzeumokban. Séta közben fedezze fel a királyi palotát és a városfal maradványait. A lengyel konyha ízei és helyi borai remekül kiegészítik a programot. Ideális kombinált városnézéshez és pihenéshez.'),
(26, 7, 19, 'Bécsi Prater vidámpark élmény', 'becsi_prater', 55, 'A Bécsi Prater vidámpark egy legendás szórakoztató terület Bécsben, ahol minden korosztály talál kedvére való attrakciót. A park ikonikus óriáskereke, a Riesenrad különleges panorámát nyújt a városra, melyet nem érdemes kihagyni. A vidámparkban számos hullámvasút, játék és étterem várja a látogatókat egész napos szórakozással. A hely története több mint egy évszázados, így nemcsak szórakozás, hanem történelmi élmény is. Ideális családoknak és baráti társaságoknak egyaránt, napközbeni vagy esti programnak is.'),
(27, 7, 19, 'Bécsi karácsonyi vásár', 'becsi_karacsonyi_vasar', 45, 'Ha Bécsben jársz november végétől decemberig, ne hagyd ki a híres karácsonyi vásárokat, ahol több tucat kézműves stand vár tradicionális ajándékokkal és finomságokkal. A Rathausplatzon megrendezett vásárban helyi ételeket, forralt bort és ünnepi kézműves termékeket kóstolhatsz. A hangulatot élő zene, fények és családi programok teszik felejthetetlenné. A vásárok a város több pontján is megtalálhatók, így könnyen beilleszthetők egy szélesebb városnéző napba. A karácsonyi forgatag Bécs kulturális tradíciójának egyik csúcspontja. '),
(28, 23, 67, 'Prágai Károly híd esti séta', 'praga_karoly_hid', 40, 'Sétálj át a történelmi Károly hídon, amely a 14. században épült és ma Prága egyik legismertebb nevezetessége. A híd felett idegenvezetés nélkül is gyönyörű kilátás nyílik a Vltava folyóra, valamint a város látképére naplementekor különösen lenyűgöző. A híd mentén utcai művészek és hangszeres zenészek adnak autentikus prágai hangulatot. A környék szűk utcái és hangulatos kávézói remek kiegészítők egy esti programhoz. Ez a séta tökéletes kezdete lehet Prága történelmi felfedezésének. '),
(29, 23, 67, 'Prágai Nemzeti Színház estje', 'praga_nemzeti_szinhaz', 60, 'Élvezd a klasszikus cseh kultúrát a prágai Nemzeti Színház egyik előadásán, ahol opera, balett vagy dráma várja a közönséget. A történelmi épület díszes belső terei és kiváló akusztikája egyaránt hozzájárulnak az élményhez. A helyi művészek és vendégfellépők előadásai nemcsak helyiek, hanem látogatók számára is felejthetetlen élményt nyújtanak. A program egyaránt szól a művészetek iránt elkötelezetteknek és azoknak, akik új kulturális élményekre vágynak. Foglalj jegyet előre a legjobb helyekre. '),
(30, 23, 67, 'Prágai sörkóstoló túra', 'praga_sorkostolo', 45, 'Fedezd fel a prágai sörkultúrát egy vezetett sörkóstoló túra során, ahol több helyi sörözőt is meglátogatsz. Csehország híres kiváló söréről és ez a túra lehetőséget ad megkóstolni többféle stílust egy estére egybefűzve. Az idegenvezetők mesélnek a sörfőzés történetéről és a helyi tradíciókról. A részvétel baráti társaságoknak vagy egyedi gasztroprogramnak is kiváló. A séta mellett helyi falatokat is ajánlott kóstolni. '),
(31, 7, 19, 'Bécsi művészeti galériák', 'becsi_muveszet', 50, 'Bécs gazdag múzeumi és galériás kultúrával rendelkezik, ahol a klasszikus és modern művészetek találkoznak. Látogass el a város híres múzeumaiba, ahol többek között festmények, szobrok és kiállítások várják a látogatókat. A Kunsthistorisches és Albertina gyűjtemények kifejezetten izgalmasak a művészetek iránt érdeklődők számára. A galériák között sétálva megismerheted a Habsburg uralkodók műgyűjteményét is. A program egész napos kulturális kiegészítője lehet egy városnézésnek. '),
(32, 3, 7, 'Széchenyi termálfürdő és wellness', 'budapest_szechenyi', 50, 'Tapasztald meg Budapest híres termálfürdőjének, a Széchenyi Fürdőnek a pihentető élményét, amely Európa egyik legnagyobb gyógyfürdő komplexuma. A neo‑barokk épület gyógyvizes medencéi és wellness szolgáltatásai egész napos pihenést kínálnak. A fürdőben szaunák, gőzfürdők és masszázs szolgáltatások is elérhetők. A hely különleges hangulatát a helyiek és a turisták egyaránt szeretik. A fürdőzés után érdemes egy tradicionális magyar éttermet is kipróbálni a környéken. '),
(33, 3, 7, 'Budapesti városnéző biciklitúra', 'budapest_bicikli', 35, 'Fedezd fel Budapest nevezetességeit két keréken egy vezetett biciklitúra során. Az útvonal magában foglalja a Parlamentet, a Budai Várat, a Duna partot és több ikonikus helyszínt. A túra során helyi történeteket és érdekességeket is hallhatsz a város múltjáról. A bicikli lehetőséget ad arra, hogy több látnivalót fedezz fel rövidebb idő alatt. Kényelmes tempó, ideális kezdőknek és városi felfedezőknek egyaránt. '),
(34, 3, 7, 'Budapesti gasztro piac kóstoló', 'budapest_gasztro_piac', 30, 'Látogasd meg Budapest híres Nagy Vásárcsarnokát, ahol a helyi termékek, sajtok és élelmiszerek kavalkádja vár. A piac tetején már éttermek is találhatók, ahol tradicionális magyar ételeket kóstolhatsz. Ismerd meg a helyi konyhaművészetet, valamint a tradicionális magyar ízeket. A piac környékén sétálva további helyi éttermeket és kávézókat fedezhetsz fel. Ideális gasztro élmény egy városnéző nap után. '),
(35, 6, 16, 'Berlin Múzeum-sziget nap', 'berlin_museum_sziget', 60, 'Berlin híres Múzeum‑szigete világhírű gyűjteményekkel vár minden művészet és történelem iránt érdeklődőt. Több ikonikus múzeumot foglal magában, amelyekben műkincsek és történeti kiállítások találhatók. A helyszín egy UNESCO világarvasi terület része, így a látogatás akár egész napos program is lehet. A gyűjtemények között ókori és modern alkotások is megtalálhatók. A környék kávézóival és parkjaival együtt kiváló kulturális élmény vár. '),
(36, 6, 16, 'Berlin street art séta', 'berlin_street_art', 40, 'Fedezd fel Berlin alternatív arcát egy vezetett street art sétán keresztül, ahol a város híres falfestményeit és graffiti kultúráját ismerheted meg. A túra során helyi művészek munkáin keresztül bepillantást nyerhetsz a kortárs berlini kultúrába. A séta olyan kerületeket is érint, ahol a kreatív közösségek és kávézók találhatók. A program interaktív és inspiráló élmény minden művészet iránt érdeklődő számára. A túra után érdemes helyi kávézóban pihenni. '),
(37, 2, 4, 'Római Fórum és Palatinus', 'roma_forum', 50, 'Látogasd meg Róma ókori világának szívét, ahol a Fórum és a Palatinus domb maradványai várják a látogatókat. Ezek a helyszínek az ókori Róma politikai és társadalmi életének központjai voltak. A séták során megismerheted az ókori építészet és kultúra lenyűgöző részleteit. A helyszín panorámás kilátást is kínál a városra. Történelmi és kulturális élmény egyben. '),
(38, 2, 6, 'Nápolyi tengerpart esti program', 'napoly_tengerpart', 45, 'Élvezd Nápoly tengerpartjának esti hangulatát, ahol éttermek, bárok és sétányok várnak a látogatókat. A tengerpart menti sétány különleges mediterrán hangulatot ad a városnézéshez. A naplemente látványa a Vezúv felé lenyűgöző. A környék tele van gelato bárokkal és helyi pizzériákkal, amelyek autentikus pizzát kínálnak. Ez az élmény ideális romantikus vacsora vagy baráti est programnak. '),
(39, 2, 5, 'Milánó divatnap', 'milano_divatnap', 50, 'Látogasd meg Milánó híres divatnegyedét, ahol a világ márkái és elegáns üzletek sorakoznak egymás mellett. Ez az élmény lehetőséget kínál arra, hogy betekintést nyerj a világ divatkultúrájába. A Dóm tér és a Galleria Vittorio Emanuele II közelsége kiegészíti a programot ikonikus építészeti látványokkal. A séta után egy olasz kávézó ideális hely a pihenéshez. Ez a nap tökéletes program divatszeretőknek és stílusos városnézőknek. '),
(40, 8, 22, 'Athén ókori kikötő és agora', 'athen_agora', 50, 'Fedezd fel Athén ókori kikötőjét és az agorát, ahol az ókor életének központjai zajlottak. A helyszín tele van történelmi romokkal, és életre kelti a görög mitológia történeteit. Az agora közösségi tere mindig pezsgő volt az üzlettel és beszélgetéssel. Ma múzeumok és kiállítások egészítik ki az élményt. A program ideális történelem iránt érdeklődőknek. '),
(41, 8, 24, 'Rodosz óvárosi séta', 'rodosz_ovaros', 45, 'Fedezze fel Rodosz óvárosát, mely UNESCO világhagyaték része történelmi falakkal, keskeny utcákkal és gazdag múzeumi kiállításokkal. A séta során a középkori utcakép és a lovagvár maradványai különleges hangulatot adnak. A környező parkok és kávézók ideálisak pihenéshez. A helyi piacok különleges helyi termékeket kínálnak. Ez az élmény remek kombinációja a történelemnek és a pihenésnek. '),
(42, 19, 55, 'Stockholm vízi túra', 'stockholm_vizi', 50, 'Látogasd meg Stockholm híres vízi útjait hajóval, ahol a város különleges szigetei és épületei a vízről is lenyűgöző látványt nyújtanak. A hajóút során a történelmi és modern részletek együtt alkotnak felejthetetlen panorámát. A túra ideális családoknak és barátoknak egyaránt. A kikötők mentén éttermek és kávézók kínálnak helyi finomságokat. A vízi kaland egy egész napos programhoz is kiváló kiegészítő. '),
(43, 19, 56, 'Malmö design séta', 'malmo_design', 40, 'Fedezd fel Malmö modern építészetét és design negyedét, ahol a város letisztult stílusú terekkel és kreatív terekkel vár. A séta során kortárs művészeti létesítmények és üzletek is találhatók. A városi parkok és terek ideális helyet kínálnak egy pihentető naphoz. A helyi kávézók különleges ízeket kínálnak. Ez az élmény kombinálja a kreativitást és városnézést. '),
(44, 20, 58, 'Oslo fjord naplemente túra', 'oslo_naplemente', 60, 'Fedezd fel Oslo híres fjordját egy hajókirándulással naplemente idején, ahol a táj és a tenger találkozása különleges hangulatot ad a túrának. A fjord mentén a norvég természet csodálatos látványa tárul fel, miközben a város panorámája is kivehető. A program ideális romantikus esti programnak vagy családi kirándulásnak. A fedélzeten kávé és helyi harapnivalók is fogyaszthatók. Ez egy izgalmas kombinációja a természeti és városi élményeknek. '),
(45, 21, 61, 'Helsinki múzeumi nap', 'helsinki_muzeum', 40, 'Látogasd meg Helsinki művészeti és történelmi múzeumait, ahol a finn kultúra és történelem gazdag gyűjteménye várja a látogatókat. A múzeumok közel vannak egymáshoz, így könnyen teljes napot tölthetsz velük. A kiállítások interaktív elemeket és helytörténeti részleteket is tartalmaznak. A múzeumi nap kiegészíthető egy tengerparti sétával vagy helyi kávézók meglátogatásával. Ideális program rossz idő esetén is. '),
(46, 22, 64, 'Varsói történelmi múzeum', 'varso_tortenelem', 35, 'Látogasd meg Varsó történelmi múzeumát, ahol a lengyel főváros és környékének gazdag történetét ismerheted meg. A kiállítások részletesen bemutatják a város fejlődését a középkortól napjainkig. A múzeum belső tere modern és interaktív. A környéken sétálva könnyen meglátogathatók további történelmi helyszínek. A program ideális történelem iránt érdeklődők számára. '),
(47, 3, 7, 'Budapesti Lánchíd esti séta', 'budapest_lanchid', 30, 'Sétálj át a világhírű Széchenyi Lánchídon, amely a Duna két partját, Budát és Pestet köti össze. Ez az egyik legismertebb budapesti ikon, amely este különösen hangulatos a kivilágított várossal és folyóparttal. A híd története az 1840‑es évekre nyúlik vissza, és ma a város szimbólumaként is szolgál. Sétálj végig rajta, miközben csodálod a város panorámáját és a város fő látványosságait. A környék tele van éttermekkel és kávézókkal egy kellemes esti programhoz. '),
(48, 3, 7, 'Budai Vár és Királyi Palota', 'budai_var_palota', 55, 'Látogass el a történelmi Budai Várba, ahol a Királyi Palota és a várnegyed gazdag történelmi emlékeket kínál. A komplexum részét képezi a Magyar Nemzeti Galéria és a Budapesti Történeti Múzeum is. A vár teraszairól csodás kilátás nyílik a Dunára és Pest városrészére. A helyszín UNESCO világörökségi része, így kulturális és történelmi élmény egyaránt. Fedezd fel a középkori és barokk kori építészetet, valamint sétálj a vár falai mentén. '),
(49, 3, 7, 'Szent István‑bazilika & kilátó', 'budapest_bazilika', 40, 'Ismerd meg Budapest harmadik legnagyobb templomát, a Szent István‑bazilikát, amely egyben az egyik legszebb neoklasszikus épület is. A bazilika belsejében megtekinthető Magyarország első királyának, Szent Istvánnak a jobb keze is. A torony kilátójából 360°‑os panoráma nyílik a városra, különösen naplementekor látványos. A templom rendszeresen ad organikus koncerteket, amelyek hangulatát érdemes átélni. Ez a helyszín történelmi és spirituális élményt egyaránt kínál. :contentReference[oaicite:1]{index=1}'),
(50, 3, 7, 'Memento Park szabadtéri múzeum', 'budapest_memento_park', 35, 'Fedezd fel Budapest egyik egyedi múzeumát, a Memento Parkot, ahol a kommunizmus idején állított szobrok és emlékművek várnak szabadtéri kiállítással. A park egy történelmi időszakot idéz meg, amikor a szocialista rendszer emlékeit gyűjtötték itt össze. Látogasd meg az impozáns Lenin‑ és Marx‑szobrokat is, amelyek a múlt erejét és a demokrácia jelentőségét emelik ki. A hely interaktív módon mutatja be az elmúlt korszak társadalmi történetét. Ideális program történelem iránt érdeklődők számára. :contentReference[oaicite:2]{index=2}'),
(51, 3, 7, 'Gellért‑hegyi barlang & kilátás', 'budapest_gellert-barlang', 30, 'Látogasd meg a Gellért‑hegy barlangját, amely egy természetes barlangrendszer a város egyik legszebb panorámájú pontján. A barlang történelme egy hermita legendájához kötődik, ahol a természet gyógyító erejét is megismerheted. A hegy tetejéről csodás kilátás nyílik a Duna folyóra és a városra. A barlang mellett a Gellért fürdő és a hegy környéke is remek pihenési lehetőséget kínál. A kirándulás kombinálja a természetet, történelmet és városi panorámát. :contentReference[oaicite:3]{index=3}'),
(52, 3, 8, 'Szegedi Dóm tér koncert & séta', 'szeged_dom_esti', 25, 'Látogass el a szegedi Dóm térre egy esti sétára és koncertre, ahol a város híres főtere különleges hangulatot kínál. A monumentális katedrális és a környék építészete egyedülálló látványt nyújt. Sokszor rendeznek klasszikus és könnyűzenei esteket a téren vagy a közelben található színpadokon. A program során élvezheted a város építészeti szépségét és a helyi kulturális életet. A tér mentén hangulatos kávézók és éttermek is várnak. '),
(53, 3, 9, 'Debreceni Nagyerdei Élménypark', 'debrecen_nagyerdei', 30, 'Fedezd fel Debrecen zöld szívét, a Nagyerdőt, ahol szabadtéri programok és élménypark is várja a látogatókat. A parkban sétálva rengeteg pihenőhely és kulturális esemény kínálkozik. Gyermekbarát játékok és sportlehetőségek teszik különlegessé a helyet. A Nagyerdőben gyakran rendeznek zenei eseményeket és kulturális vásárokat is. Ideális hely családi vagy baráti kikapcsolódásra. '),
(54, 4, 10, 'Louvre esti séta & kiállítás', 'parizs_louvre_esti', 55, 'Sétálj végig a világhírű Louvre Múzeum környezetében Párizsban, ahol a múzeum épülete és kertjei már önmagukban műalkotások. A világ egyik legnagyobb és leggazdagabb művészeti gyűjteménye itt található, mely festmények és szobrok sokaságát foglalja magában. Az esti kivilágítás különleges hangulatot ad a környéknek. A környező kávézók és teraszok ideális helyszínt kínálnak pihenéshez. A séta történelmi és kulturális élményt nyújt egyaránt. '),
(55, 4, 10, 'Montmartre művészeti séta', 'parizs_montmartre', 45, 'Fedezd fel Montmartre dombjának művészeti negyedét, ahol festőművészek, galériák és hangulatos utcák várják a látogatót. A hely különleges bohém atmoszférát áraszt, és a Sacré‑Cœur bazilika panorámát nyújt Párizsra. Éttermek, kávézók és kis butikok teszik teljessé az élményt. A séta során megismerheted a város művészeti történelmét és jelenlegi kreatív életét. Ideális napközbeni vagy esti programnak. '),
(56, 6, 16, 'Berlin Brandenburgi kapu esti fotózás', 'berlin_brandenburg', 35, 'Látogasd meg Berlin híres Brandenburgi kapuját egy esti séta során, amikor a kivilágított emlékmű különösen impozáns látványt nyújt. Ez a kapu a város egyik legismertebb szimbóluma, amely a német történelem fontos pontjait idézi fel. A környéken számos étterem és bár is található, ahol kikapcsolódhatsz. A fotózás mellett hallhatsz történeteket is a hely történelméről egy vezetett sétán. Berlin dinamikus hangulata minden időszakban érezhető. '),
(57, 6, 16, 'Berlin panoráma kilátó', 'berlin_panorama_kilato', 40, 'Fedezd fel Berlin legjobb panorámáját egy modern kilátóteraszról, ahonnan egész városra ráláthatsz. A kilátó arról híres, hogy naplemente idején egészen különleges fényeket ad a város látképének. A program kombinálja a városnézést és fotózást, miközben megismerheted Berlin sokszínű építészetét. A kilátó környéke üzletekkel és kávézókkal is várja a látogatókat. Ideális fiataloknak és családoknak egyaránt. '),
(58, 2, 4, 'Római Pantheon látogatás', 'roma_pantheon', 40, 'Látogasd meg Rómában a Pantheont, az ókori római építészet egyik legjobban megőrzött művét. Az épület kupolája különleges akusztikát és fényhatásokat kínál. A belső térben több történelmi síremlék is található. A Pantheon az építészeti kiválóság és az ókori kultúra emlékműve. A környék éttermei és kávézói teszik teljessé a látogatást. '),
(59, 2, 6, 'Nápoly & Vezúv panoráma túra', 'napoly_vezuv', 50, 'Fedezd fel Nápoly városát és környékét egy panorámás túrán keresztül, ahol a híres Vezúv tűzhányóra is kilátást kapsz. A környék mediterrán hangulata és a tengerpart közelsége teszi különlegessé a programot. A túra során látogass el történelmi helyszínekhez és kilátóponthoz is. A Vezúv környéki kilátás különösen naplementekor lenyűgöző. A nap túrával és tengerparti pihenéssel egészíthető ki. '),
(60, 2, 5, 'Milánói dóm templom', 'milano_dom', 45, 'Látogasd meg Milánó egyik legismertebb nevezetességét, a milánói dómot, amely egy hatalmas gótikus stílusú katedrális. A tetőteraszra felmenve fantasztikus kilátás nyílik a városra és a környező tájakra. A templom belső díszítése és szobrai egyaránt lenyűgözők. A környéken rengeteg kávézó és kis üzlet várja a látogatókat. Ez az élmény mind történelmi, mind kulturális szempontból emlékezetes. '),
(61, 8, 22, 'Athéni ókori múzeum', 'athen_muzeum', 45, 'Látogasd meg Athén egyik legismertebb múzeumát, ahol az ókori görög kultúra gazdag tárgyi emlékei várják. A kiállított tárgyak részletesen bemutatják az ókor mindennapi életét és művészetét. A múzeum közelében éttermek és kávézók találhatók, így a látogatás könnyen kombinálható egy hosszabb sétával is. Ideális program művelődni vágyóknak. '),
(62, 8, 24, 'Rodoszi vízi sport nap', 'rodosz_vizi_sport', 50, 'Élvezd Rodosz szigetén a vízi sportok kínálta izgalmakat, ahol jet ski, szörf és egyéb vizes programok várnak. A kristálytiszta tenger és a part közelsége ideális feltételeket biztosít minden korosztálynak. A program során helyi oktatók segítenek a biztonságos részvételben. A vízi sportok után pihenhetsz a parton, vagy egy helyi taverna teraszán. Ez a nap aktív pihenést kínál a tengerparti élményhez. '),
(63, 19, 55, 'Stockholmi múzeum túra', 'stockholm_muzeum', 50, 'Fedezd fel Stockholm kulturális életét egy múzeumi és galéria túrán keresztül, ahol modern és klasszikus művészetek is várnak. A város múzeumai széles gyűjteményeket tartalmaznak több stílusban is. A túra során lehetőséged nyílik interaktív és történelmi kiállítások megtekintésére. A program ideális kültéri sétával is kombinálható. A város part menti közelsége különleges hangulatot ad az egész napos programnak. '),
(64, 19, 56, 'Malmö éjszakai városnézés', 'malmo_ejszakai', 35, 'Fedezd fel Malmö éjszakai életét és városnézését egy esti sétán keresztül, ahol a város modern épületei, fények és kávézók különleges hangulatot kínálnak. Az éjszakai séta során a város főtere és parkjai kivilágítva még varázslatosabbak. Találj helyi éttermeket ebben a hangulatban. Ez egy kellemes esti program a városi kultúra felfedezésére. '),
(65, 20, 58, 'Oslo Opera & fjord panoráma', 'oslo_opera_fjord', 60, 'Látogasd meg az Oslo ikonikus Operaházát, amely modern építészetével lenyűgöz és egyben panorámás kilátást kínál a fjordra. A tetőtérre felmenve csodás kilátás nyílik a fjord és a város felett. A program során sétálj a vízparti sétányok mentén is. Az opera előtti területek tökéletesek egy piknikezéshez vagy naplemente élményhez. Ez az élmény kombinálja a modern építészetet és a természeti panorámát. '),
(66, 21, 61, 'Helsinki tengerparti séta', 'helsinki_tengerpart', 40, 'Fedezd fel Helsinki tengerparti sétányait, ahol a tengeri levegő és parkosított sétautak ideális feltételeket kínálnak a pihenéshez és a látványhoz. A vízparti sétány mentén kis éttermek és kávézók találhatók, ahol helyi specialitásokat kóstolhatsz. Ez egy kellemes napközbeni program, amely ötvözi a természetet és a városi élményt. '),
(67, 22, 64, 'Varsói gasztro & városnézés', 'varso_gasztro', 35, 'Fedezd fel Varsó történelmi központját egy gasztro és városnéző programmal, ahol helyi éttermek, ételkóstolók és séták váltják egymást. A város történelmi tereit és parkjait is érintheted. A program során megismerheted a lengyel konyha különlegességeit és a helyi piacokat. Ez az élmény ideális kombinációja a kulináris és városi felfedezésnek. '),
(68, 19, 55, 'Stockholmi Gamla Stan óvárosi séta', 'stockholm_gamla_stan', 45, 'Fedezd fel Stockholm történelmi óvárosát, Gamla Stan‑t, ahol kanyargó, macskaköves utcák és régi épületek találkoznak a modern városi élettel. A terület a 13. század óta játszik központi szerepet a svéd főváros építészetében és történetében, és számos ikonikus épületet foglal magába, mint a Nobel Múzeum és a Királyi Palota. Sétálj végig a Stortorget főtéren, nézd meg a régi árkádos házakat, majd kóstolj helyi svéd specialitásokat a hangulatos kávézók egyikében. Ez az élmény kombinálja a történelmet, kultúrát és a városi hangulatot egyaránt. :contentReference[oaicite:1]{index=1}'),
(69, 19, 55, 'Stockholmi modern múzeum túra', 'stockholm_modern_muzeum', 50, 'Látogasd meg Stockholm izgalmas modern múzeumait, ahol kortárs művészeti és technikai kiállítások várnak. A város kulturális kínálata számos gyűjteményből áll, melyek között történeti, modern és interaktív kiállítások is szerepelnek. A múzeumok közötti séta jól kombinálható egy kikötői panorámaúttal vagy városi gasztro kóstolóval. Ez a program ideális városi kulturális kaland mindenkinek. '),
(70, 19, 56, 'Malmö múzeumi és történelmi kastély látogatás', 'malmo_muzeum_kastely', 40, 'Fedezd fel Malmö kulturális oldalát a Malmö Múzeumban, amelynek kiállításai a város technikai, történelmi és természeti örökségét mutatják be. A múzeum fő helyszíne a történelmi Malmö Castle komplexum, ahol többek között a régészeti és maritime gyűjtemények is megtalálhatók. A kiállítások mellett sétálj a parkosított kastélykertben és ismerkedj a város történelmével. Malmö izgalmas kombinációja a múlt és jelen kultúrájának. :contentReference[oaicite:2]{index=2}'),
(71, 20, 58, 'Oslo fjordparti esti séta', 'oslo_fjordparti_seta', 45, 'Élvezd az Oslo fjord menti sétány nyugodt hangulatát, ahol a tengerpart és a modern városi élet találkozik. A sétány ideális hely egy romantikus estére vagy baráti társasággal eltöltött programra, miközben a város panorámája és a víz közelsége különleges légkört ad a városi kalandnak. A környéken számos étterem és kávézó vár helyi specialitásokkal. Ez a program ötvözi a természeti szépséget és a városi élményt. '),
(72, 20, 58, 'Oslo skandináv gasztro túra', 'oslo_gasztro', 50, 'Merülj el az oslói gasztrokultúrában egy helyi ízeket bemutató városi túra során. Kóstold meg a norvég specialitásokat, friss halételeket és tradicionális fogásokat a fjord parti éttermekben. A gasztro túra során helyi piacokat és modernebb bisztrókat is meglátogatsz. Ez a program különleges kombinációja a kulináris élménynek és a városi felfedezésnek. '),
(73, 21, 61, 'Helsinki design séta', 'helsinki_design_seta', 40, 'Helsinki az északi design és modern építészet fellegvára, melyet érdemes gyalogosan felfedezni. A város különleges épületei és sztenderd tervezési példái megmutatják a skandináv kreativitást. A séták során megismerheted a helyi design múzeumokat, galériákat és butikokat. Ez a kulturális élmény ötvözi a kreativitást, városi parkokat és tengerparti panorámát is. '),
(74, 21, 61, 'Helsinki naplemente hajókirándulás', 'helsinki_hajo', 55, 'Fedezd fel Helsinki tengerparti panorámáját egy naplemente hajókirándulás során, ahol a város látképe a vízről különleges élményt nyújt. A fedélzeti kávézóban helyi harapnivalókat is kóstolhatsz, miközben a lenyugvó nap fényei megvilágítják a kikötőt és a várost. Ez a program romantikus élményként és városi kiruccanásként egyaránt ideális. '),
(75, 22, 64, 'Varsói Királyi Kastély és park', 'varso_kiralyi_kastely', 45, 'Látogasd meg a varsói Királyi Kastélyot, ahol a lengyel történelem és királyi élet lenyűgöző emlékei várnak. A kastély gyönyörű termei, díszes szobái és környező parkjai ideális helyszínt biztosítanak egy hosszabb városi sétahoz. A környéken éttermek és kávézók sora található, így könnyen egész napos programot tervezhetsz. Ez az élmény történelmi és kulturális dimenziót ad a városi túrához. '),
(76, 22, 64, 'Varsói modern művészet galéria', 'varso_modern_galeria', 40, 'Fedezd fel Varsó vibráló modern művészeti életét egy galéria látogatás során, ahol kortárs lengyel és nemzetközi alkotások várnak. A kiállítások sokszínűsége és kreatív hangulata inspiráló élményt kínál minden művészetkedvelő számára. A környék éttermei és kávézói további kulturális felfedezést tesznek lehetővé. '),
(77, 24, 70, 'Pozsonyi Óváros történelmi séta', 'pozsony_ovaros', 35, 'Fedezd fel Pozsony történelmi óvárosát, ahol középkori utcák, hangulatos terek és gazdag építészeti örökség vár. A Fő tér és a régi városháza különleges hangulatot ad az egész napos sétának. Ismerd meg a város történelmét és legendáit egy idegenvezetéssel vagy önállóan. A séta ideális program egy hosszabb városi kiruccanáshoz. :contentReference[oaicite:3]{index=3}'),
(78, 24, 70, 'Pozsonyi zenei esték & kulturális program', 'pozsony_zene', 45, 'Vegyél részt egy kulturális estén Pozsonyban, ahol klasszikus zenei koncert vagy helyi jazz est vár. A program kombinálja a helyi zenészek műsorát és a város hangulatos légkörét, ideális esti kikapcsolódásra. Ez az élmény remekül illeszthető vacsorához vagy városnézéshez. '),
(79, 23, 69, 'České Budějovice Black Tower kilátó', 'ceske_budejovice_blacktower', 30, 'Látogasd meg České Budějovice történelmi Black Tower kilátóját, amely a város egyik legjellegzetesebb látnivalója. A tornyot a 16. században építették védekező célokra és ma panorámás kilátót kínál a városra. A közeli középkori épületek és hangulatos utcák ideális környezetet adnak a városi felfedezéshez. A kilátóból lenyűgöző panoráma nyílik a város tetejéről. :contentReference[oaicite:4]{index=4}'),
(80, 23, 69, 'České Budějovice Iron Maiden Tower', 'ceske_budejovice_ironmaiden', 35, 'Fedezd fel az Iron Maiden tornyot, egy középkori börtön és erődített rész, ahol történelmi fegyverek és kiállítások várnak. A torony egykor a város védelmében szolgált, ma pedig izgalmas kulturális programot kínál a látogatóknak. A környező óváros és kávézók ideális hely egy hosszabb délutáni sétára. :contentReference[oaicite:5]{index=5}'),
(81, 23, 68, 'Brno gasztro & városnézés', 'brno_gasztro', 40, 'Fedezd fel Brno hangulatos éttermeit és kávézóit egy helyi gasztro túra során, miközben a város történelmi központját is megismered. A séta során helyi specialitásokat kóstolhatsz, miközben a város történelmi tereit és épületeit is megcsodálod. Ez az élmény ideális gasztronómiai és városi felfedezésre egyaránt. '),
(82, 23, 68, 'Brno zenei & rendezvény est', 'brno_zenei_est', 45, 'Vegyél részt egy helyi zenei esten Brnóban, ahol helyi előadók koncertjei és rendezvények várnak a városi kulturális térben. A hangulatos helyszínek és bárok kombinációja ideális esti programot biztosít. Ez a helyi élmény autentikus betekintést ad Brno zenei és kulturális életébe, és felejthetetlen élményt nyújt a látogatóknak.');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `favourite`
--

CREATE TABLE `favourite` (
  `id` int(5) NOT NULL,
  `user_id` int(5) DEFAULT NULL,
  `apartman_id` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `favourite`
--

INSERT INTO `favourite` (`id`, `user_id`, `apartman_id`) VALUES
(10, 2, 35),
(43, 3, 60),
(27, 4, 30),
(11, 6, 10),
(24, 7, 72),
(30, 9, 98),
(48, 11, 56),
(45, 12, 88),
(15, 18, 74),
(9, 20, 31),
(34, 21, 69),
(42, 23, 76),
(17, 25, 74),
(6, 26, 16),
(49, 26, 17),
(4, 26, 58),
(12, 31, 97),
(25, 32, 83),
(33, 38, 18),
(3, 42, 42),
(36, 43, 72),
(18, 43, 86),
(46, 46, 45),
(29, 47, 21),
(38, 49, 19),
(31, 51, 10),
(44, 54, 55),
(28, 59, 6),
(1, 59, 42),
(22, 59, 93),
(50, 61, 30),
(35, 61, 93),
(20, 66, 89),
(41, 70, 65),
(40, 71, 28),
(19, 73, 84),
(14, 76, 94),
(8, 86, 41),
(2, 87, 9),
(39, 88, 17),
(32, 88, 23),
(5, 88, 69),
(21, 90, 45),
(26, 91, 6),
(7, 92, 72),
(16, 95, 18),
(47, 99, 45);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `history`
--

CREATE TABLE `history` (
  `id` int(5) NOT NULL,
  `renter_id` int(5) DEFAULT NULL,
  `owner_id` int(5) DEFAULT NULL,
  `accommodation_id` int(5) DEFAULT NULL,
  `price` int(7) NOT NULL,
  `payment_type` varchar(20) NOT NULL DEFAULT '''''''unpaid''''''',
  `card_number` varchar(19) DEFAULT NULL,
  `expiration` varchar(7) DEFAULT NULL,
  `cvv` int(3) DEFAULT NULL,
  `rent_date` date DEFAULT NULL,
  `rent_beginning` date NOT NULL,
  `rent_end` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `history`
--

INSERT INTO `history` (`id`, `renter_id`, `owner_id`, `accommodation_id`, `price`, `payment_type`, `card_number`, `expiration`, `cvv`, `rent_date`, `rent_beginning`, `rent_end`) VALUES
(1, 4, 3, 1, 780, 'paid', '4111111111111111', '07/27', 321, '2025-01-02', '2025-01-05', '2025-01-08'),
(2, 5, 14, 2, 364, 'paid', '453210000000002', '09/27', 102, '2025-01-03', '2025-01-06', '2025-01-08'),
(3, 6, 50, 3, 792, 'paid', '5555444433332222', '11/28', 654, '2025-01-05', '2025-01-09', '2025-01-12'),
(4, 7, 22, 4, 352, 'paid', '453210000000003', '10/29', 103, '2025-01-07', '2025-01-10', '2025-01-12'),
(5, 8, 12, 5, 328, 'paid', '4000123412341234', '06/26', 456, '2025-01-10', '2025-01-12', '2025-01-14'),
(6, 9, 65, 6, 820, 'paid', '453210000000004', '11/28', 104, '2025-01-12', '2025-01-15', '2025-01-20'),
(7, 10, 4, 7, 324, 'paid', '4222222222222', '08/26', 778, '2025-01-15', '2025-01-18', '2025-01-21'),
(8, 11, 3, 8, 888, 'paid', '453210000000005', '12/27', 105, '2025-01-18', '2025-01-22', '2025-01-25'),
(9, 12, 4, 9, 408, 'paid', '5555666677778888', '02/29', 321, '2025-01-20', '2025-01-23', '2025-01-26'),
(10, 13, 5, 10, 1512, 'paid', '453210000000006', '01/30', 106, '2025-01-22', '2025-01-25', '2025-01-28'),
(11, 14, 8, 13, 890, 'paid', '4012888888881881', '09/29', 741, '2025-02-01', '2025-02-04', '2025-02-07'),
(12, 15, 9, 14, 330, 'paid', '453210000000007', '02/29', 107, '2025-02-03', '2025-02-06', '2025-02-09'),
(13, 16, 10, 15, 1800, 'paid', '4111111111111111', '08/27', 321, '2025-02-05', '2025-02-10', '2025-02-13'),
(14, 17, 11, 16, 396, 'paid', '453210000000008', '03/28', 108, '2025-02-07', '2025-02-11', '2025-02-14'),
(15, 18, 12, 17, 912, 'paid', '5555555555554444', '07/26', 234, '2025-02-10', '2025-02-13', '2025-02-17'),
(16, 19, 13, 18, 1230, 'paid', '453210000000009', '04/27', 109, '2025-02-12', '2025-02-15', '2025-02-19'),
(17, 20, 14, 19, 378, 'paid', '4000000000000002', '12/26', 888, '2025-02-15', '2025-02-18', '2025-02-21'),
(18, 21, 3, 20, 1710, 'paid', '453210000000010', '05/29', 110, '2025-02-18', '2025-02-22', '2025-02-27'),
(19, 22, 4, 21, 696, 'paid', '4012333444555666', '06/28', 555, '2025-02-20', '2025-02-24', '2025-02-28'),
(20, 23, 6, 23, 888, 'paid', '453210000000011', '06/30', 111, '2025-02-22', '2025-02-26', '2025-03-01'),
(21, 24, 7, 24, 408, 'paid', '5555444433331111', '08/28', 654, '2025-03-01', '2025-03-04', '2025-03-07'),
(22, 25, 8, 25, 3480, 'paid', '453210000000012', '07/28', 112, '2025-03-03', '2025-03-08', '2025-03-11'),
(23, 26, 9, 26, 426, 'paid', '4444333322229999', '09/27', 345, '2025-03-05', '2025-03-09', '2025-03-12'),
(24, 27, 10, 27, 984, 'paid', '453210000000013', '08/29', 113, '2025-03-07', '2025-03-11', '2025-03-14'),
(25, 28, 11, 28, 912, 'paid', '4111222233334444', '10/28', 777, '2025-03-10', '2025-03-14', '2025-03-18'),
(51, 21, 3, 1, 780, 'paid', '4111111111111111', '07/27', 321, '2025-01-02', '2025-01-05', '2025-01-08'),
(52, 6, 14, 2, 364, 'paid', '453210000000002', '09/27', 102, '2025-01-06', '2025-01-10', '2025-01-12'),
(53, 7, 50, 3, 792, 'paid', '5555444433332222', '11/28', 654, '2025-01-15', '2025-01-18', '2025-01-21'),
(54, 9, 22, 4, 352, 'paid', '453210000000003', '10/29', 103, '2025-01-20', '2025-01-23', '2025-01-25'),
(55, 11, 12, 5, 328, 'paid', '4222222222222', '06/26', 456, '2025-02-01', '2025-02-04', '2025-02-06'),
(56, 14, 65, 6, 656, 'paid', '453210000000005', '12/27', 105, '2025-02-05', '2025-02-08', '2025-02-12'),
(57, 15, 4, 7, 324, 'paid', '4444333322221111', '08/26', 778, '2025-02-10', '2025-02-13', '2025-02-16'),
(58, 16, 3, 8, 592, 'paid', '453210000000009', '04/27', 109, '2025-02-15', '2025-02-18', '2025-02-22'),
(59, 18, 4, 9, 272, 'paid', '453210000000007', '02/29', 107, '2025-02-20', '2025-02-22', '2025-02-24'),
(60, 19, 5, 10, 1512, 'paid', '4012888888881881', '03/28', 889, '2025-03-01', '2025-03-04', '2025-03-07'),
(61, 20, 8, 13, 1335, 'paid', '453210000000008', '03/28', 108, '2025-03-05', '2025-03-08', '2025-03-12'),
(62, 22, 9, 14, 330, 'paid', '5555666677778888', '09/29', 741, '2025-03-10', '2025-03-12', '2025-03-15'),
(63, 23, 10, 15, 1800, 'paid', '453210000000010', '05/29', 110, '2025-03-15', '2025-03-18', '2025-03-21'),
(64, 24, 11, 16, 396, 'paid', '4000000000000002', '07/26', 234, '2025-03-20', '2025-03-23', '2025-03-26'),
(65, 25, 12, 17, 912, 'paid', '453210000000011', '06/30', 111, '2025-03-25', '2025-03-28', '2025-04-01'),
(66, 26, 13, 18, 1230, 'paid', '5555555555554444', '12/26', 888, '2025-04-01', '2025-04-04', '2025-04-08'),
(67, 27, 14, 19, 378, 'paid', '453210000000004', '11/28', 104, '2025-04-05', '2025-04-07', '2025-04-10'),
(68, 28, 3, 20, 1710, 'paid', '4111111111111111', '08/27', 321, '2025-04-10', '2025-04-13', '2025-04-17'),
(69, 29, 4, 21, 696, 'paid', '453210000000014', '11/28', 114, '2025-04-15', '2025-04-18', '2025-04-21'),
(70, 30, 6, 23, 888, 'paid', '5555666677779999', '06/27', 215, '2025-04-20', '2025-04-23', '2025-04-27'),
(71, 31, 7, 24, 408, 'paid', '4111111111111111', '07/27', 321, '2025-05-01', '2025-05-03', '2025-05-06'),
(72, 32, 8, 25, 3480, 'paid', '453210000000015', '05/29', 115, '2025-05-05', '2025-05-08', '2025-05-11'),
(73, 33, 9, 26, 284, 'paid', '4000123412341234', '08/28', 456, '2025-05-10', '2025-05-12', '2025-05-14'),
(74, 34, 10, 27, 1312, 'paid', '453210000000016', '09/28', 116, '2025-05-15', '2025-05-18', '2025-05-22'),
(75, 35, 11, 28, 912, 'paid', '4012888888881881', '10/29', 889, '2025-05-20', '2025-05-23', '2025-05-26');

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
  `password` varchar(40) NOT NULL,
  `phone_number` varchar(40) NOT NULL,
  `gender` char(1) NOT NULL,
  `user_type` char(1) NOT NULL DEFAULT 'U',
  `card_number` varchar(19) DEFAULT NULL,
  `expiration` varchar(7) DEFAULT NULL,
  `cvv` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `middle_name`, `email`, `password`, `phone_number`, `gender`, `user_type`, `card_number`, `expiration`, `cvv`) VALUES
(1, 'Máté', 'Herczeg', 'János', 'herczeg.mate-2021@keri.mako.hu', 'Admin1234', '06304432357', 'M', 'A', NULL, NULL, NULL),
(2, 'Bence', 'Guvat', 'József', 'guvat.bence-2021@keri.mako.hu', 'Admin1234', '06303527456', 'M', 'A', NULL, NULL, NULL),
(3, 'John', 'Smith', NULL, 'john.smith01@gmail.com', 'Js01!pass', '+12025550001', 'M', 'U', '453210000000001', '08/28', 101),
(4, 'Emily', 'Johnson', 'Anne', 'emily.j02@gmail.com', 'EmJ#02', '+12025550002', 'F', 'U', NULL, NULL, NULL),
(5, 'Carlos', 'Ramirez', NULL, 'c.ramirez03@gmail.com', 'CarRam03', '+34600000003', 'M', 'U', '453210000000002', '09/27', 102),
(6, 'Sofia', 'Martinez', NULL, 'sofia.m04@gmail.com', 'Sofi@04', '+34600000004', 'F', 'U', NULL, NULL, NULL),
(7, 'Luca', 'Bianchi', 'Marco', 'luca.bianchi05@gmail.com', 'LucB05!', '+39349000005', 'M', 'U', '453210000000003', '10/29', 103),
(8, 'Anna', 'Rossi', NULL, 'a.rossi06@gmail.com', 'ARossi06', '+39349000006', 'F', 'U', NULL, NULL, NULL),
(9, 'Mate', 'Kovacs', NULL, 'mate.k07@gmail.com', 'MKov07', '+36300000007', 'M', 'U', '453210000000004', '11/28', 104),
(10, 'Eszter', 'Nagy', 'Judit', 'eszter.nagy08@gmail.com', 'ENagy08!', '+36300000008', 'F', 'U', NULL, NULL, NULL),
(11, 'David', 'Miller', NULL, 'd.miller09@gmail.com', 'DMill09', '+13120000009', 'M', 'U', '453210000000005', '12/27', 105),
(12, 'Olivia', 'Brown', NULL, 'olivia.b10@gmail.com', 'OBrown10', '+13120000010', 'F', 'U', NULL, NULL, NULL),
(13, 'James', 'Wilson', NULL, 'j.wilson11@gmail.com', 'JW11!', '+13120000011', 'M', 'U', '453210000000006', '01/30', 106),
(14, 'Emma', 'Taylor', NULL, 'emma.t12@gmail.com', 'ETay12', '+13120000012', 'F', 'U', NULL, NULL, NULL),
(15, 'Daniel', 'Anderson', 'Lee', 'dan.and13@gmail.com', 'DAnd13', '+44770000013', 'M', 'U', '453210000000007', '02/29', 107),
(16, 'Sophia', 'Thomas', NULL, 'soph.th14@gmail.com', 'SThom14', '+44770000014', 'F', 'U', NULL, NULL, NULL),
(17, 'Mark', 'Moore', NULL, 'mark.m15@gmail.com', 'MMoore15', '+44770000015', 'M', 'U', '453210000000008', '03/28', 108),
(18, 'Laura', 'Martin', 'Claire', 'laura.m16@gmail.com', 'LMart16!', '+33600000016', 'F', 'U', NULL, NULL, NULL),
(19, 'Pierre', 'Dubois', NULL, 'p.dubois17@gmail.com', 'PDub17', '+33600000017', 'M', 'U', '453210000000009', '04/27', 109),
(20, 'Chloe', 'Bernard', NULL, 'chloe.b18@gmail.com', 'CBern18', '+33600000018', 'F', 'U', NULL, NULL, NULL),
(21, 'Luis', 'Garcia', NULL, 'l.garcia19@gmail.com', 'LGarc19', '+34600000019', 'M', 'U', '453210000000010', '05/29', 110),
(22, 'Maria', 'Lopez', 'Isabel', 'maria.l20@gmail.com', 'MLope20', '+34600000020', 'F', 'U', NULL, NULL, NULL),
(23, 'Kenji', 'Tanaka', NULL, 'kenji.t21@gmail.com', 'KTana21', '+81900000021', 'M', 'U', '453210000000011', '06/30', 111),
(24, 'Yuki', 'Sato', NULL, 'yuki.s22@gmail.com', 'YSato22', '+81900000022', 'F', 'U', NULL, NULL, NULL),
(25, 'Min', 'Park', NULL, 'min.p23@gmail.com', 'MPark23', '+82100000023', 'M', 'U', '453210000000012', '07/28', 112),
(26, 'Ji', 'Kim', 'Hoon', 'ji.kim24@gmail.com', 'JKim24', '+82100000024', 'F', 'U', NULL, NULL, NULL),
(27, 'Wei', 'Zhang', NULL, 'wei.z25@gmail.com', 'WZhan25', '+86130000025', 'M', 'U', '453210000000013', '08/29', 113),
(28, 'Ling', 'Chen', NULL, 'ling.c26@gmail.com', 'LChen26', '+86130000026', 'F', 'U', NULL, NULL, NULL),
(29, 'Raj', 'Patel', NULL, 'raj.p27@gmail.com', 'RPat27', '+91980000027', 'M', 'U', '453210000000014', '09/28', 114),
(30, 'Anita', 'Sharma', 'Devi', 'anita.s28@gmail.com', 'AShar28', '+91980000028', 'F', 'U', NULL, NULL, NULL),
(31, 'Ahmed', 'Hassan', NULL, 'ahmed.h29@gmail.com', 'AHass29', '+20100000029', 'M', 'U', '453210000000015', '10/30', 115),
(32, 'Aisha', 'Khan', NULL, 'aisha.k30@gmail.com', 'AKhan30', '+20100000030', 'F', 'U', NULL, NULL, NULL),
(33, 'Lucas', 'Silva', NULL, 'lucas.s31@gmail.com', 'LSil31', '+55110000031', 'M', 'U', '453210000000016', '11/29', 116),
(34, 'Ana', 'Costa', 'Maria', 'ana.c32@gmail.com', 'ACost32', '+55110000032', 'F', 'U', NULL, NULL, NULL),
(35, 'Diego', 'Fernandez', NULL, 'diego.f33@gmail.com', 'DFern33', '+54110000033', 'M', 'U', '453210000000017', '12/28', 117),
(36, 'Camila', 'Rojas', NULL, 'camila.r34@gmail.com', 'CRoja34', '+54110000034', 'F', 'U', NULL, NULL, NULL),
(37, 'Mateo', 'Gomez', NULL, 'mateo.g35@gmail.com', 'MGome35', '+57110000035', 'M', 'U', '453210000000018', '01/29', 118),
(38, 'Valentina', 'Perez', NULL, 'val.p36@gmail.com', 'VPere36', '+57110000036', 'F', 'U', NULL, NULL, NULL),
(39, 'Noah', 'Williams', NULL, 'noah.w37@gmail.com', 'NWili37', '+14150000037', 'M', 'U', '453210000000019', '02/28', 119),
(40, 'Ava', 'Davis', NULL, 'ava.d38@gmail.com', 'ADavi38', '+14150000038', 'F', 'U', NULL, NULL, NULL),
(41, 'Ethan', 'Clark', NULL, 'ethan.c39@gmail.com', 'EClar39', '+14150000039', 'M', 'U', '453210000000020', '03/30', 120),
(42, 'Mia', 'Hall', NULL, 'mia.h40@gmail.com', 'MHall40', '+14150000040', 'F', 'U', NULL, NULL, NULL),
(43, 'Oscar', 'Reed', NULL, 'oscar.r41@gmail.com', 'OReed41', '+14150000041', 'M', 'U', '453210000000021', '04/29', 121),
(44, 'Lily', 'Scott', NULL, 'lily.s42@gmail.com', 'LScott42', '+14150000042', 'F', 'U', NULL, NULL, NULL),
(45, 'Victor', 'Hugo', NULL, 'victor.h43@gmail.com', 'VHugo43', '+33600000043', 'M', 'U', '453210000000022', '05/28', 122),
(46, 'Eva', 'Novak', 'Maria', 'eva.n44@gmail.com', 'ENova44', '+42070000044', 'F', 'U', NULL, NULL, NULL),
(47, 'Tomas', 'Horvat', NULL, 't.horvat45@gmail.com', 'THor45', '+38591000045', 'M', 'U', '453210000000023', '06/27', 123),
(48, 'Nina', 'Petrovic', NULL, 'nina.p46@gmail.com', 'NPet46', '+38160000046', 'F', 'U', NULL, NULL, NULL),
(49, 'Andrei', 'Popescu', NULL, 'andrei.p47@gmail.com', 'APop47', '+40720000047', 'M', 'U', '453210000000024', '07/29', 124),
(50, 'Ioana', 'Ionescu', NULL, 'ioana.i48@gmail.com', 'IIon48', '+40720000048', 'F', 'U', NULL, NULL, NULL),
(51, 'Marko', 'Kovac', NULL, 'marko.k49@gmail.com', 'MKov49', '+38591000049', 'M', 'U', '453210000000025', '08/28', 125),
(52, 'Sara', 'Blanc', NULL, 'sara.b50@gmail.com', 'SBlan50', '+33600000050', 'F', 'U', NULL, NULL, NULL),
(53, 'Oliver', 'King', NULL, 'oliver.k51@gmail.com', 'OKing51', '+44110000051', 'M', 'U', '453210000000026', '09/29', 126),
(54, 'Amelia', 'Wright', NULL, 'amelia.w52@gmail.com', 'AWrig52', '+44110000052', 'F', 'U', NULL, NULL, NULL),
(55, 'Henry', 'Lopez', NULL, 'henry.l53@gmail.com', 'HLop53', '+12120000053', 'M', 'U', '453210000000027', '10/28', 127),
(56, 'Isabella', 'Turner', 'Rose', 'isabella.t54@gmail.com', 'ITurn54', '+12120000054', 'F', 'U', NULL, NULL, NULL),
(57, 'Sebastian', 'Muller', NULL, 'seb.m55@gmail.com', 'SMull55', '+49170000055', 'M', 'U', '453210000000028', '11/30', 128),
(58, 'Hanna', 'Schmidt', NULL, 'hanna.s56@gmail.com', 'HSch56', '+49170000056', 'F', 'U', NULL, NULL, NULL),
(59, 'Leo', 'Fischer', NULL, 'leo.f57@gmail.com', 'LFisc57', '+49170000057', 'M', 'U', '453210000000029', '12/29', 129),
(60, 'Mila', 'Weber', NULL, 'mila.w58@gmail.com', 'MWeb58', '+49170000058', 'F', 'U', NULL, NULL, NULL),
(61, 'Aron', 'Szabo', NULL, 'aron.sz59@gmail.com', 'ASza59', '+36300000059', 'M', 'U', '453210000000030', '01/30', 130),
(62, 'Kata', 'Toth', 'Anna', 'kata.t60@gmail.com', 'KToth60', '+36300000060', 'F', 'U', NULL, NULL, NULL),
(63, 'Ivan', 'Petrov', NULL, 'ivan.p61@gmail.com', 'IPet61', '+79160000061', 'M', 'U', '453210000000031', '02/29', 131),
(64, 'Elena', 'Ivanova', NULL, 'elena.i62@gmail.com', 'EIva62', '+79160000062', 'F', 'U', NULL, NULL, NULL),
(65, 'Marek', 'Nowak', NULL, 'marek.n63@gmail.com', 'MNow63', '+48120000063', 'M', 'U', '453210000000032', '03/28', 132),
(66, 'Anna', 'Kowalska', NULL, 'anna.k64@gmail.com', 'AKow64', '+48120000064', 'F', 'U', NULL, NULL, NULL),
(67, 'Pavel', 'Novak', NULL, 'pavel.n65@gmail.com', 'PNov65', '+42070000065', 'M', 'U', '453210000000033', '04/27', 133),
(68, 'Lucie', 'Svobodova', NULL, 'lucie.s66@gmail.com', 'LSvo66', '+42070000066', 'F', 'U', NULL, NULL, NULL),
(69, 'Nikola', 'Jovanovic', NULL, 'nikola.j67@gmail.com', 'NJov67', '+38160000067', 'M', 'U', '453210000000034', '05/29', 134),
(70, 'Milica', 'Stojanovic', NULL, 'milica.s68@gmail.com', 'MSto68', '+38160000068', 'F', 'U', NULL, NULL, NULL),
(71, 'Bogdan', 'Ionescu', NULL, 'bogdan.i69@gmail.com', 'BIon69', '+40720000069', 'M', 'U', '453210000000035', '06/30', 135),
(72, 'Alina', 'Popa', NULL, 'alina.p70@gmail.com', 'APop70', '+40720000070', 'F', 'U', NULL, NULL, NULL),
(73, 'Yaroslav', 'Bondarenko', NULL, 'yaroslav.b71@gmail.com', 'YBon71', '+38050000071', 'M', 'U', '453210000000036', '07/28', 136),
(74, 'Olena', 'Shevchenko', NULL, 'olena.s72@gmail.com', 'OShe72', '+38050000072', 'F', 'U', NULL, NULL, NULL),
(75, 'Mustafa', 'Demir', NULL, 'mustafa.d73@gmail.com', 'MDem73', '+90530000073', 'M', 'U', '453210000000037', '08/29', 137),
(76, 'Elif', 'Kaya', NULL, 'elif.k74@gmail.com', 'EKay74', '+90530000074', 'F', 'U', NULL, NULL, NULL),
(77, 'Omar', 'Saleh', NULL, 'omar.s75@gmail.com', 'OSal75', '+97150000075', 'M', 'U', '453210000000038', '09/30', 138),
(78, 'Layla', 'Haddad', NULL, 'layla.h76@gmail.com', 'LHadd76', '+97150000076', 'F', 'U', NULL, NULL, NULL),
(79, 'Rami', 'Nasser', NULL, 'rami.n77@gmail.com', 'RNass77', '+96270000077', 'M', 'U', '453210000000039', '10/28', 139),
(80, 'Dina', 'Khalil', NULL, 'dina.k78@gmail.com', 'DKha78', '+96270000078', 'F', 'U', NULL, NULL, NULL),
(81, 'Samuel', 'Green', NULL, 'samuel.g79@gmail.com', 'SGree79', '+15120000079', 'M', 'U', '453210000000040', '11/29', 140),
(82, 'Grace', 'Hill', NULL, 'grace.h80@gmail.com', 'GHill80', '+15120000080', 'F', 'U', NULL, NULL, NULL),
(83, 'Aaron', 'Baker', NULL, 'aaron.b81@gmail.com', 'ABake81', '+15120000081', 'M', 'U', '453210000000041', '12/30', 141),
(84, 'Natalie', 'Cooper', NULL, 'natalie.c82@gmail.com', 'NCoop82', '+15120000082', 'F', 'U', NULL, NULL, NULL),
(85, 'Julian', 'Price', NULL, 'julian.p83@gmail.com', 'JPri83', '+15120000083', 'M', 'U', '453210000000042', '01/29', 142),
(86, 'Sienna', 'Foster', NULL, 'sienna.f84@gmail.com', 'SFos84', '+15120000084', 'F', 'U', NULL, NULL, NULL),
(87, 'Victor', 'Long', NULL, 'victor.l85@gmail.com', 'VLong85', '+15120000085', 'M', 'U', '453210000000043', '02/28', 143),
(88, 'Ivy', 'Reynolds', NULL, 'ivy.r86@gmail.com', 'IRey86', '+15120000086', 'F', 'U', NULL, NULL, NULL),
(89, 'Thomas', 'Carter', NULL, 'thomas.c87@gmail.com', 'TCart87', '+15120000087', 'M', 'U', '453210000000044', '03/30', 144),
(90, 'Ruby', 'Collins', NULL, 'ruby.c88@gmail.com', 'RColl88', '+15120000088', 'F', 'U', NULL, NULL, NULL),
(91, 'Benjamin', 'Evans', NULL, 'ben.e89@gmail.com', 'BEvan89', '+15120000089', 'M', 'U', '453210000000045', '04/29', 145),
(92, 'Zoe', 'Mitchell', NULL, 'zoe.m90@gmail.com', 'ZMit90', '+15120000090', 'F', 'U', NULL, NULL, NULL),
(93, 'Caleb', 'Turner', NULL, 'caleb.t91@gmail.com', 'CTurn91', '+15120000091', 'M', 'U', '453210000000046', '05/28', 146),
(94, 'Naomi', 'Parker', NULL, 'naomi.p92@gmail.com', 'NPark92', '+15120000092', 'F', 'U', NULL, NULL, NULL),
(95, 'Adrian', 'Cole', NULL, 'adrian.c93@gmail.com', 'ACole93', '+15120000093', 'M', 'U', '453210000000047', '06/27', 147),
(96, 'Freya', 'Morris', NULL, 'freya.m94@gmail.com', 'FMor94', '+15120000094', 'F', 'U', NULL, NULL, NULL),
(97, 'Leon', 'Watson', NULL, 'leon.w95@gmail.com', 'LWat95', '+15120000095', 'M', 'U', '453210000000048', '07/29', 148),
(98, 'Poppy', 'Wood', NULL, 'poppy.w96@gmail.com', 'PWoo96', '+15120000096', 'F', 'U', NULL, NULL, NULL),
(99, 'Nathan', 'Brooks', NULL, 'nathan.b97@gmail.com', 'NBro97', '+15120000097', 'M', 'U', '453210000000049', '08/28', 149),
(100, 'Ella', 'Russell', NULL, 'ella.r98@gmail.com', 'ERus98', '+15120000098', 'F', 'U', NULL, NULL, NULL);

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `accommodations`
--
ALTER TABLE `accommodations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner_id` (`owner_id`),
  ADD KEY `city_id` (`city_id`),
  ADD KEY `country_id` (`country_id`);

--
-- A tábla indexei `accommodations_details`
--
ALTER TABLE `accommodations_details`
  ADD PRIMARY KEY (`apartman_id`);

--
-- A tábla indexei `card_networks`
--
ALTER TABLE `card_networks`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `city_name` (`name`),
  ADD KEY `country_id` (`country_id`);

--
-- A tábla indexei `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `country_name` (`name`);

--
-- A tábla indexei `currency`
--
ALTER TABLE `currency`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `shorted_name` (`shorted_name`);

--
-- A tábla indexei `experiences`
--
ALTER TABLE `experiences`
  ADD PRIMARY KEY (`id`),
  ADD KEY `country_id` (`country_id`),
  ADD KEY `city_name` (`city_id`);

--
-- A tábla indexei `favourite`
--
ALTER TABLE `favourite`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`,`apartman_id`),
  ADD KEY `apartman_id` (`apartman_id`);

--
-- A tábla indexei `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `renter_id` (`renter_id`,`owner_id`,`accommodation_id`),
  ADD KEY `apartman_id` (`accommodation_id`),
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
-- AUTO_INCREMENT a táblához `accommodations`
--
ALTER TABLE `accommodations`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT a táblához `card_networks`
--
ALTER TABLE `card_networks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT a táblához `cities`
--
ALTER TABLE `cities`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=215;

--
-- AUTO_INCREMENT a táblához `countries`
--
ALTER TABLE `countries`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT a táblához `currency`
--
ALTER TABLE `currency`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT a táblához `experiences`
--
ALTER TABLE `experiences`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT a táblához `favourite`
--
ALTER TABLE `favourite`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT a táblához `history`
--
ALTER TABLE `history`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `accommodations`
--
ALTER TABLE `accommodations`
  ADD CONSTRAINT `accommodations_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `accommodations_ibfk_2` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `accommodations_ibfk_3` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `accommodations_details`
--
ALTER TABLE `accommodations_details`
  ADD CONSTRAINT `accommodations_details_ibfk_1` FOREIGN KEY (`apartman_id`) REFERENCES `accommodations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `cities`
--
ALTER TABLE `cities`
  ADD CONSTRAINT `cities_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Megkötések a táblához `experiences`
--
ALTER TABLE `experiences`
  ADD CONSTRAINT `experiences_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `experiences_ibfk_2` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `favourite`
--
ALTER TABLE `favourite`
  ADD CONSTRAINT `favourite_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `favourite_ibfk_2` FOREIGN KEY (`apartman_id`) REFERENCES `accommodations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `history`
--
ALTER TABLE `history`
  ADD CONSTRAINT `history_ibfk_2` FOREIGN KEY (`owner_id`) REFERENCES `accommodations` (`owner_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `history_ibfk_3` FOREIGN KEY (`renter_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `history_ibfk_4` FOREIGN KEY (`accommodation_id`) REFERENCES `accommodations` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
