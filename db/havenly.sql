-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2026. Jan 04. 18:37
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
  `name` varchar(40) NOT NULL,
  `folder_name` varchar(40) NOT NULL,
  `size` int(3) NOT NULL,
  `price` int(7) NOT NULL,
  `description` text NOT NULL,
  `guest_number` int(2) NOT NULL,
  `bedroom` int(1) NOT NULL,
  `bed` int(1) NOT NULL,
  `bathroom` int(1) NOT NULL
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
(11, 6, 23, 70, 'Történelmi apartman', 'tortenelmi_apart', 50, 79, 'Hangulatos apartman Prága óvárosában, tökéletes romantikus tartózkodásokhoz. A belső terek stílusosak és otthonosak, minden alapfelszereltséggel ellátva. Közel a történelmi látnivalókhoz és kávézókhoz. Ideális pároknak vagy kis családoknak. Élvezze a városi élet varázsát kényelmes környezetben.', 4, 2, 2, 1),
(12, 7, 23, 70, 'Csendes stúdió', 'csendes_studio', 35, 58, 'Nyugodt stúdió Prága csendes részén. A világos és modern belső tér tökéletes pihenést biztosít. Közel a város főbb látnivalóihoz és közlekedési csomópontokhoz. Ideális rövid tartózkodáshoz vagy üzleti útra. Kényelmes és praktikus minden igény kielégítésére.', 2, 1, 1, 1),
(13, 8, 7, 19, 'Bécsi belvárosi lakás', 'becsi_belvarosi', 60, 89, 'Elegáns lakás Bécs belvárosában, közel a látnivalókhoz. A tágas és világos belső tér ideális családoknak és pároknak. Modern bútorok és minden szükséges felszerelés. Sétatávolságra éttermek és kávézók. Kényelmes kiindulópont a város felfedezéséhez.', 5, 2, 3, 2),
(14, 9, 7, 19, 'Kompakt stúdió', 'kompakt_studio', 30, 55, 'Kompakt stúdió Bécsben, ideális rövid tartózkodásokhoz. A praktikus elrendezés és világos belső tér minden igényt kielégít. Közel a város főbb nevezetességeihez és közlekedéshez. Tökéletes pároknak vagy egyéni utazóknak. Kényelmes és otthonos hangulat várja a vendégeket.', 2, 1, 1, 1),
(15, 10, 5, 14, 'Tengerparti apartman', 'tengerparti_ap', 75, 100, 'Tengerparti apartman közvetlenül a strand mellett. Világos és tágas belső tér, modern bútorokkal. Ideális családoknak vagy baráti társaságoknak. A környék tele van éttermekkel és kikapcsolódási lehetőségekkel. Élvezze a nyári napfényes pihenést a part közelében.', 6, 3, 4, 2),
(16, 11, 5, 13, 'Városi stúdió', 'varosi_studio', 42, 66, 'Modern városi stúdió Madrid központjában. Világos és praktikus, minden szükséges felszereléssel. Ideális pároknak és üzleti utazóknak. Közel a főbb látnivalókhoz és közlekedési csomópontokhoz. Kényelmes és stílusos tartózkodás a városban.', 2, 1, 1, 1),
(17, 12, 4, 10, 'Romantikus lakás', 'romantikus_lakas', 48, 76, 'Romantikus lakás Párizsban, kiváló elhelyezkedéssel. A belső terek elegánsak, stílusosak és otthonosak. Ideális pároknak romantikus kiruccanáshoz. A környék tele van éttermekkel, kávézókkal és látnivalókkal. Élvezze a párizsi hangulat minden pillanatát.', 4, 2, 2, 1),
(18, 13, 4, 11, 'Erkélyes apartman', 'erkelyes_apart', 55, 82, 'Világos erkélyes apartman Párizsban. Modern bútorok és kényelmes elrendezés minden igényt kielégít. Ideális családoknak és baráti társaságoknak. Közel a város főbb nevezetességeihez. Élvezze a friss levegőt és a város látványát a privát erkélyről.', 5, 2, 3, 2),
(19, 14, 6, 16, 'Fiatalos stúdió', 'fiatalos_studio', 28, 63, 'Fiatalos stúdió Berlinben, modern felszereltséggel. Ideális pároknak és üzleti utazóknak. Világos és otthonos belső tér biztosítja a kényelmet. Közel a közlekedéshez és a helyi látnivalókhoz. Tökéletes rövid tartózkodásokhoz.', 2, 1, 1, 1),
(20, 3, 6, 17, 'Családi lakás', 'csaladi_lakas', 80, 95, 'Tágas családi lakás Berlinben. Modern bútorok és jól felszerelt konyha. Ideális nagyobb családoknak. Közel a város nevezetességeihez és parkjaihoz. Kényelmes, otthonos hely a pihenéshez és kikapcsolódáshoz.', 6, 3, 4, 2),
(21, 4, 18, 52, 'Tengerre néző apartman', 'tengerre_nez', 65, 87, 'Tengerre néző apartman, nyugodt környezetben. Tágas és világos belső tér, minden kényelmi felszereléssel. Ideális pároknak és családoknak. Közel a strandhoz és éttermekhez. Élvezze a nyugodt tengerparti pihenést.', 4, 2, 2, 1),
(22, 5, 18, 55, 'Belvárosi stúdió', 'belvarosi_studio', 32, 61, 'Belvárosi stúdió a város szívében. Kompakt, jól felszerelt és világos. Ideális rövid tartózkodásokhoz vagy üzleti útra. Közel a közlekedéshez és a város látnivalóihoz. Praktikus és kényelmes választás.', 2, 1, 1, 1),
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
(54, 23, 1, 2, 'Oszakai Stílus Apartman', 'oszakai_stilus_apart', 55, 95, 'Világos, modern apartman Oszaka központjában. Kényelmes bútorok és ágyak. Ideális pároknak és kis családoknak. Közel látnivalókhoz és éttermekhez. Élvezze a japán városi életet minden pillanatban.', 3, 1, 2, 1),
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
(11, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(12, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(13, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0),
(14, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(15, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1),
(16, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(17, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(18, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0),
(19, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
(20, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1),
(21, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1),
(22, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
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
(54, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1),
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
-- Tábla szerkezet ehhez a táblához `cities`
--

CREATE TABLE `cities` (
  `id` int(5) NOT NULL,
  `country_id` int(5) DEFAULT NULL,
  `name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `cities`
--

INSERT INTO `cities` (`id`, `country_id`, `name`) VALUES
(1, 1, 'Tokió'),
(2, 1, 'Oszaka'),
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
  `name` varchar(40) NOT NULL
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
(1, 1, 1, 'Budapesti városnéző séta', 'budapest_varosnezo', 50, 'Budapest történelmi városrészei a Duna két partján helyezkednek el, lenyűgöző látványt nyújtva. Fedezd fel a Budai Várnegyedet, a Halászbástyát és a Lánchidat, miközben a város múltját ismered meg. Sétálj a Váci utcán, ahol a helyi üzletek és kávézók hangulata elvarázsol. Tanuld meg a város történetét egy tapasztalt idegenvezetővel. Ez a túra a történelem, kultúra és városi élet kombinációját kínálja.'),
(2, 1, 2, 'Budapesti gasztronómiai túra', 'budapest_gasztro', 55, 'Budapest kulináris élményei minden látogatót lenyűgöznek. Kóstold meg a hagyományos magyar ételeket, például a gulyást, lángost és kürtőskalácsot. Fedezd fel a Nagyvásárcsarnok ínycsiklandó kínálatát. Tanulj a helyi ízek és receptek történetéről egy szakértő vezetésével. Ez a túra ízek, kultúra és helyi tradíciók felfedezését kínálja.'),
(3, 2, 3, 'Prágai történelmi séta', 'praga_tortenelmi', 60, 'Prága a középkori városok varázsát hordozza, gyönyörű építészeti remekekkel. Sétálj a Károly hídon és fedezd fel a régi város főterét, ahol a város történelmi hangulata él. Látogasd meg az Óvárosi Csillagvizsgálót és a Prágai várat. Tanulj a cseh történelemről és kultúráról egy tapasztalt idegenvezetőtől. Ez a séta a történelem és a városi élet felfedezését nyújtja.'),
(4, 2, 4, 'Prágai gasztronómiai túra', 'praga_gasztro', 65, 'Prága kulináris élményei felfedezésre várnak minden látogatót. Kóstold meg a tradicionális cseh ételeket, például a svíčkovát és a knédliket. Fedezd fel a helyi piacokat és kézműves pékségeket. Ismerd meg a cseh sörkultúra történetét és ízeit. Ez a túra a helyi ízek és kultúra gazdag kombinációját kínálja.'),
(5, 3, 5, 'Bécsi művészeti túra', 'bécs_muveszet', 70, 'Bécs a művészetek és zenetörténet fellegvára, ahol minden sarkon találkozhatsz kulturális értékekkel. Látogasd meg a Belvedere palotát és a Kunsthistorisches Múzeumot. Fedezd fel a város zenetörténetét, Bach, Mozart és Beethoven nyomában járva. Sétálj a Ringstraße sugárúton és élvezd az építészeti remekeket. Ez a túra a művészet, történelem és városi élet harmonikus kombinációját nyújtja.'),
(6, 3, 6, 'Bécsi kávéházi élmény', 'bécs_kavehaz', 75, 'Bécs híres kávéházai a múlt és jelen hangulatát ötvözik. Kóstold meg a helyi süteményeket, például a Sachertortát és Apfelstrudelt. Fedezd fel a kávéházak történetét és kultúráját szakértő vezetésével. Élvezd a bécsi kávé művészetét a hangulatos belső terekben. Ez a túra a gasztronómia, kultúra és történelem élményét kínálja egyszerre.'),
(7, 4, 7, 'London történelmi séta', 'london_tortenelmi', 80, 'London gazdag történelemmel és ikonikus látnivalókkal rendelkezik. Sétálj a Tower hídon, látogasd meg a Tower of Londont és a Westminster apátságot. Ismerd meg a brit monarchia és város történelmét. Fedezd fel a város különböző negyedeit és hangulatát. Ez a túra a történelem, kultúra és városi élet kombinált élményét nyújtja.'),
(8, 4, 8, 'London gasztronómiai túra', 'london_gasztro', 85, 'London gasztronómiai élete rendkívül változatos és izgalmas. Kóstold meg a tradicionális angol ételeket, mint a fish and chips és a Sunday roast. Fedezd fel a város piacait, ahol nemzetközi ízekkel találkozhatsz. Tanulj a helyi ételkultúráról szakértő vezetésével. Ez a túra ízek, kultúra és városi felfedezés élményét kínálja.'),
(9, 5, 9, 'Párizsi városnéző séta', 'parizs_varosnezo', 90, 'Párizs a romantika és művészet fővárosa, ahol minden sarkon történelmi értékek várnak. Sétálj a Szajna partján, látogasd meg a Notre-Dame-ot és a Louvre-ot. Élvezd a párizsi utcák hangulatát és a helyi kávézók báját. Ismerd meg a város történelmét és kultúráját idegenvezető segítségével. Ez a túra Párizs történelmének, kultúrájának és hangulatának felfedezését nyújtja.'),
(10, 5, 10, 'Párizsi gasztronómiai túra', 'parizs_gasztro', 95, 'Párizs gasztronómiája világhírű, különleges ízeket kínál minden látogatónak. Kóstold meg a croissant-t, a francia sajtokat és a helyi borokat. Fedezd fel a piacokat és cukrászdákat, ahol a friss alapanyagok és édességek várnak. Tanulj a francia konyha történetéről és hagyományairól. Ez a túra ízek, kultúra és párizsi hangulat élményét adja.'),
(11, 6, 11, 'Római történelmi séta', 'roma_tortenelmi', 100, 'Róma az ókori történelem és építészet egyik központja. Látogasd meg a Colosseumot, a Forum Romanumot és a Pantheont. Sétálj a város történelmi utcáin, miközben a múlt titkait fedezed fel. Kóstold meg az olasz specialitásokat egy helyi étteremben. Ez a túra Róma művészeti és történelmi örökségének teljes felfedezését kínálja.'),
(12, 6, 12, 'Római gasztronómiai túra', 'roma_gasztro', 105, 'Róma gasztronómiája a világ egyik legizgalmasabb élménye. Kóstold meg a tradicionális ételeket, mint a pasta carbonara és a gelato. Fedezd fel a helyi piacokat és éttermeket, miközben a római ízek titkait tanulod. Élvezd a város hangulatát a helyi konyha tükrében. Ez a túra a római kultúra és gasztronómia harmonikus élményét nyújtja.'),
(13, 7, 13, 'Amszterdami csatornahajózás', 'amsterdam_hajo', 110, 'Amszterdam híres csatornarendszeréről és bájos városképeiről. Hajózz végig a csatornákon, miközben a város történelmét és építészetét ismered meg. Fedezd fel a város híres múzeumait és piacait. Tanulj a helyi kultúráról és mindennapi életről idegenvezető segítségével. Ez a túra látványos, kulturális és pihentető élményt kínál.'),
(14, 7, 14, 'Amszterdami kerékpártúra', 'amsterdam_bike', 115, 'Amszterdam a kerékpáros közlekedésről híres, így a város két keréken fedezhető fel a legjobban. Kerékpározz a csatornák mentén, látogasd meg a város legfontosabb látnivalóit. Ismerd meg a holland kultúrát és történelmet kerékpáros szemszögből. Állj meg helyi piacokon és kávézókban, hogy megkóstold a tradicionális ízeket. Ez a túra aktív kikapcsolódást és kulturális élményt nyújt egyszerre.'),
(15, 8, 15, 'Berlini történelmi séta', 'berlin_tortenelmi', 120, 'Berlin a történelem és modern kultúra találkozása, ahol minden sarkon nyomot hagyott a múlt. Sétálj a Brandenburgi kapuhoz, látogasd meg a Reichstag épületét és a Berlini fal emlékhelyét. Ismerd meg a város történelmét a 20. század eseményein keresztül. Fedezd fel a város kulturális negyedeit és hangulatát. Ez a túra Berlin múltját, jelenét és kulturális gazdagságát mutatja be.'),
(16, 8, 16, 'Berlini street art túra', 'berlin_streetart', 125, 'Berlin híres a street art kultúrájáról és kreatív negyedeiről. Fedezd fel a város falfestményeit és graffiti művészetét. Ismerd meg a helyi művészek történetét és a művészet társadalmi üzeneteit. Sétálj a város különböző kerületeiben, miközben a modern berlini kultúrát ismered meg. Ez a túra a művészet, kreativitás és városi élet kombinációját kínálja.'),
(17, 9, 17, 'Athéni történelmi séta', 'athen_tortenelmi', 130, 'Athén az ókori görög kultúra központja, tele történelmi emlékekkel. Látogasd meg az Akropoliszt és a Parthenont, miközben a város múltját tanulmányozod. Sétálj a Plaka negyed hangulatos utcáin, ahol a helyi élet és kultúra ötvöződik. Kóstold meg a tradicionális görög ételeket, mint a souvlaki és tzatziki. Ez a túra a történelem, kultúra és gasztronómia felfedezését kínálja.'),
(18, 9, 18, 'Athéni gasztronómiai túra', 'athen_gasztro', 135, 'Athén gazdag kulináris élményei minden látogatót elbűvölnek. Fedezd fel a város piacait, kóstold meg a friss alapanyagokat és tradicionális ételeket. Ismerd meg a görög konyha történelmét és jellegzetességeit. Sétálj a város hangulatos utcáin, miközben a helyi ízeket élvezed. Ez a túra Athén ízeinek és kultúrájának gazdag bemutatását kínálja.'),
(19, 10, 19, 'Barcelona kulturális séta', 'barcelona_kultura', 140, 'Barcelona a művészet és építészet városa, ahol Gaudí alkotásai minden sarkon elvarázsolnak. Látogasd meg a Sagrada Famíliát, a Park Güellt és a gótikus negyedet. Sétálj a Rambla sugárúton, ahol a város hangulata és művészete ötvöződik. Kóstold meg a katalán ételeket és tapasokat a helyi éttermekben. Ez a túra Barcelona kultúrájának és történelmének átfogó felfedezését kínálja.'),
(20, 10, 20, 'Barcelona gasztronómiai túra', 'barcelona_gasztro', 145, 'Fedezd fel Barcelona gazdag gasztronómiai világát, miközben a város kulturális látnivalóit is meglátogatod. Kóstold meg a tapasokat, paellát és a helyi tengeri ételeket. Ismerd meg a katalán konyha történelmét és hagyományait. Sétálj a város piacain, miközben a helyi ízeket élvezed. Ez a túra ízek, kultúra és városi élet harmonikus kombinációját kínálja.'),
(21, 11, 21, 'Római művészeti túra', 'roma_muveszet', 150, 'Róma művészeti öröksége lenyűgöző, ahol a múzeumok és szobrok történelmet mesélnek el. Látogasd meg a Vatikán Múzeumait, a Sixtus-kápolnát és a város híres szobrait. Sétálj a történelmi utcákon, miközben a város művészeti múltja és jelenlegi életstílusa ötvöződik. Kóstold meg az olasz ételeket egy helyi étteremben, miközben a művészet és gasztronómia találkozik. Ez a túra a művészet minden aspektusát bemutatja Rómában.'),
(22, 11, 22, 'Velencei romantikus hajózás', 'velence_romantika', 155, 'Velence romantikus hangulatát a város csatornái és történelmi épületei adják. Hajózz gondolán a Grand Canalon, miközben a város látványában gyönyörködsz. Fedezd fel a Szent Márk teret és a Dózse-palotát, ahol a történelem és kultúra ötvöződik. Kóstold meg a helyi specialitásokat, miközben a velencei élet ritmusát érzed. Ez a túra a romantika, kultúra és városi élmény tökéletes kombinációját nyújtja.'),
(23, 12, 23, 'Velencei művészeti felfedezés', 'velence_muveszet', 160, 'Velence művészete minden látogatót lenyűgöz. Látogasd meg a város galériáit, múzeumait és történelmi épületeit. Sétálj a macskaköves utcákon, ahol a város hangulata és művészeti öröksége ötvöződik. Kóstold meg a helyi specialitásokat, miközben a velencei életstílust ismered meg. Ez a túra inspiráló élményt nyújt minden művészetkedvelő számára.'),
(24, 13, 24, 'Madrid történelmi túra', 'madrid_tortenelmi', 125, 'Madrid gazdag történelmi és kulturális látnivalókkal várja látogatóit. Fedezd fel a Királyi Palotát, a Prado Múzeumot és a Retiro Parkot. Sétálj a város történelmi utcáin, miközben a spanyol történelem titkaiba nyersz betekintést. Kóstold meg a helyi tapasokat és édességeket, miközben élvezed a város pezsgő életét. Ez a túra Madrid múltját, kultúráját és gasztronómiáját ötvözi.'),
(25, 13, 25, 'Madrid gasztronómiai túra', 'madrid_gasztro', 130, 'Madrid gasztronómiája izgalmas és változatos, ahol a tradicionális ízek találkoznak a modern konyhával. Kóstold meg a híres tapasokat, paellát és churrost helyi specialitásokkal. Fedezd fel a piacokat, éttermeket és cukrászdákat, miközben a spanyol ízeket élvezed. Tanulj a helyi ételek történetéről és hagyományairól idegenvezető segítségével. Ez a túra a gasztronómia, kultúra és városi élet kombinációját kínálja.'),
(26, 14, 26, 'Lisszaboni városnéző séta', 'lisszabon_varosnezo', 140, 'Lisszabon történelmi negyedei, a dombos utcák és a tengerpart közelsége csodálatos élményt nyújt. Sétálj az Alfama és Bairro Alto negyedben, miközben a város múltját és kultúráját ismered meg. Fedezd fel a város híres kilátópontjait, ahonnan gyönyörű panorámát láthatsz. Kóstold meg a helyi ételeket, mint a pastel de nata és bacalhau. Ez a túra Lisszabon történelmének, kultúrájának és ízeinek teljes felfedezését kínálja.'),
(27, 14, 27, 'Lisszaboni gasztronómiai túra', 'lisszabon_gasztro', 145, 'Lisszabon kulináris élete rendkívül gazdag, ahol a tenger gyümölcsei és helyi specialitások dominálnak. Kóstold meg a friss halakat, tenger gyümölcseit és a híres édességeket. Fedezd fel a piacokat és hagyományos éttermeket, miközben a portugál konyha történetét tanulod. Élvezd a város hangulatát a helyi ízek tükrében. Ez a túra a gasztronómia, kultúra és városi élmény harmonikus kombinációját kínálja.'),
(28, 15, 28, 'Isztambuli történelmi séta', 'isztambul_tortenelmi', 150, 'Isztambul az ókori civilizációk és a kultúrák találkozási pontja, ahol kelet és nyugat keveredik. Látogasd meg a Hagia Sophiát, a Kék Mecsetet és a Topkapi palotát. Sétálj a város piacain, ahol az illatok, színek és hangulatok egyedülálló élményt nyújtanak. Tanulj a város történelméről és vallási hagyományairól. Ez a túra Isztambul történelmi és kulturális gazdagságát tárja fel.'),
(29, 15, 29, 'Isztambuli gasztronómiai túra', 'isztambul_gasztro', 155, 'Isztambul ízvilága keleti fűszerekben és hagyományos ételekben gazdag. Kóstold meg a kebabot, baklavát, helyi édességeket és italokat. Fedezd fel a bazárokat, piacokat és helyi éttermeket, miközben a török konyha titkait ismered meg. Tanulj a helyi étkezési szokásokról és történelmükről idegenvezető segítségével. Ez a túra a gasztronómia és kultúra élményét egyaránt nyújtja.'),
(30, 16, 30, 'Szentpétervári múzeumi túra', 'szentpetervar_muzeum', 160, 'Szentpétervár a művészet és történelem városa, tele lenyűgöző múzeumokkal és palotákkal. Látogasd meg az Ermitázst, a Téli Palotát és a Fabergé-múzeumot. Sétálj a város történelmi utcáin, miközben a cári múltat és az orosz kultúrát ismered meg. Kóstold meg a helyi ételeket, miközben a város hangulatát élvezed. Ez a túra a művészet, történelem és kultúra átfogó élményét kínálja.'),
(31, 16, 31, 'Szentpétervári csatornahajózás', 'szentpetervar_hajo', 165, 'A város csatornái és folyói különleges perspektívát nyújtanak Szentpétervárra. Hajózz végig a Neva folyón, miközben a város ikonikus épületeit és hidjait csodálhatod. Ismerd meg a város történelmét és kulturális örökségét idegenvezető segítségével. Kóstold meg a helyi finomságokat a hajóút alatt. Ez a túra látványos, pihentető és kulturális élményt kínál egyszerre.'),
(32, 17, 32, 'Moszkvai történelmi túra', 'moszkva_tortenelmi', 170, 'Moszkva Oroszország politikai és történelmi központja, ahol a múlt és jelen találkozik. Látogasd meg a Vörös teret, a Kremlt és a Szent Bazil székesegyházat. Sétálj a történelmi utcákon, miközben a város múltját és kultúráját ismered meg. Kóstold meg a helyi ételeket egy autentikus étteremben. Ez a túra Moszkva történelmének, kultúrájának és gasztronómiájának felfedezését kínálja.'),
(33, 17, 33, 'Moszkvai metró- és művészeti túra', 'moszkva_metro', 175, 'Moszkva metróállomásai az orosz művészet és történelem lenyűgöző példái. Fedezd fel a város híres metróállomásait, szobrait és mozaikjait. Tanulj a város történelméről és az állomások építészeti jelentőségéről. Kóstold meg a helyi specialitásokat, miközben a városi életet tapasztalod. Ez a túra művészetet, kultúrát és városi felfedezést kínál egyszerre.'),
(34, 18, 34, 'Koppenhágai kerékpártúra', 'koppenhaga_bike', 180, 'Koppenhága a kerékpáros közlekedés és fenntartható városi élet mintája. Kerékpározz a város híres kerékpárútjain, miközben a város látványosságait ismered meg. Fedezd fel a Nyhavn negyedet, a kis csatornákat és a helyi piacokat. Tanulj a város történelméről és kultúrájáról idegenvezető segítségével. Ez a túra aktív kikapcsolódást és városi felfedezést kínál egyszerre.'),
(35, 18, 35, 'Koppenhágai gasztronómiai túra', 'koppenhaga_gasztro', 185, 'Koppenhága gasztronómiája a modern skandináv konyhát és tradicionális ételeket ötvözi. Kóstold meg a friss tengeri ételeket, helyi péksüteményeket és tradicionális dán fogásokat. Fedezd fel a piacokat és éttermeket, miközben a dán konyha titkait tanulod. Élvezd a város hangulatát a gasztronómiai élmények tükrében. Ez a túra a kulináris élmény és városi kultúra kombinációját kínálja.'),
(36, 19, 36, 'Oslo fjord hajózás', 'oslo_hajo', 190, 'Az Oslo-fjord festői tájai lenyűgözőek, miközben a város történelmét és kultúráját ismerheted meg. Hajózz a fjordon, látogasd meg a közeli szigeteket és történelmi helyszíneket. Tanulj Norvégia kultúrájáról és a város múltjáról idegenvezető segítségével. Kóstold meg a helyi tengeri ételeket és specialitásokat. Ez a túra látványos, pihentető és kulturális élményt kínál egyszerre.'),
(37, 19, 37, 'Oslo városnéző séta', 'oslo_varosnezo', 195, 'Oslo történelmi és modern látnivalókkal várja a látogatókat. Sétálj a városközpontban, látogasd meg a Vigeland szoborparkot és az Operaházat. Ismerd meg a norvég kultúrát, történelmet és építészetet. Kóstold meg a helyi ételeket a város hangulatos éttermeiben. Ez a túra Oslo történelmének, kultúrájának és gasztronómiájának felfedezését nyújtja.'),
(38, 20, 38, 'Helsinki design túra', 'helsinki_design', 200, 'Helsinki a modern dizájn és építészet városa, tele kreatív energiával. Fedezd fel a város híres design negyedeit, múzeumait és galériáit. Ismerd meg a finn dizájn történetét és kultúráját idegenvezető segítségével. Sétálj a város hangulatos utcáin, miközben a modern művészetet és építészetet élvezed. Ez a túra a design, kultúra és városi élet kombinációját nyújtja.'),
(39, 20, 39, 'Helsinki gasztronómiai túra', 'helsinki_gasztro', 205, 'Helsinki gasztronómiája a friss, helyi alapanyagokra és skandináv ízekre épül. Kóstold meg a tradicionális ételeket, mint a lohi és karjalanpiirakka. Fedezd fel a piacokat és éttermeket, miközben a finn konyha történelmét tanulod. Élvezd a város hangulatát a helyi ízek tükrében. Ez a túra ízek, kultúra és városi felfedezés élményét kínálja.'),
(40, 21, 40, 'Reykjavíki geotermikus túra', 'reykjavik_geothermal', 210, 'Reykjavík környéke lenyűgöző geotermikus tájakban gazdag, ahol a természet csodái várnak. Fedezd fel a forró forrásokat, gejzíreket és vulkanikus képződményeket. Ismerd meg Izland történelmét, kultúráját és természeti jellegzetességeit idegenvezető segítségével. Kóstold meg a helyi specialitásokat, miközben a természet közelségét élvezed. Ez a túra természet, kultúra és kaland élményét kínálja.'),
(41, 21, 41, 'Reykjavíki városnézés', 'reykjavik_varos', 215, 'Reykjavík modern városi élet és izlandi kultúra keverékét kínálja. Sétálj a város főterén, látogasd meg a Hallgrímskirkja templomot és a Harpa koncerttermet. Ismerd meg a város történelmét, kultúráját és művészetét idegenvezető segítségével. Kóstold meg a helyi ételeket, miközben a város hangulatát élvezed. Ez a túra Reykjavíki kultúra és városi élet felfedezését kínálja.'),
(42, 22, 42, 'Edinburgh kastélytúra', 'edinburgh_kastely', 220, 'Edinburgh gazdag történelmi örökséggel rendelkezik, ahol a kastély és a középkori utcák lenyűgözőek. Látogasd meg az Edinburgh-i kastélyt, a Royal Mile-t és a város történelmi negyedeit. Ismerd meg Skócia történelmét, legendáit és kultúráját. Kóstold meg a helyi whiskyt és tradicionális ételeket. Ez a túra történelmet, kultúrát és gasztronómiát ötvöz.'),
(43, 22, 43, 'Edinburgh kísértettúra', 'edinburgh_kiseret', 225, 'Edinburgh régi utcái és alagutai számos titkot és legendát rejtenek. Fedezd fel a város kísértetjárta helyeit és hallgasd a történeteket idegenvezető segítségével. Ismerd meg a város sötét múltját és mítoszait. Kóstold meg a helyi specialitásokat egy hangulatos kávézóban. Ez a túra izgalmas, misztikus és kulturális élményt kínál.'),
(44, 23, 44, 'Dublini történelmi séta', 'dublin_tortenelmi', 230, 'Dublin gazdag irodalmi és történelmi örökséggel rendelkezik. Sétálj a Temple Bar negyedben, látogasd meg a Trinity College könyvtárát és a Guinness Storehouse-t. Ismerd meg Írország történelmét, kultúráját és irodalmi hagyományait. Kóstold meg a helyi ételeket és italokat a város hangulatos éttermeiben. Ez a túra történelmet, kultúrát és gasztronómiát ötvöz.'),
(45, 23, 45, 'Dublini irodalmi séta', 'dublin_irodalom', 235, 'Dublin híres irodalmi örökségéről, ahol a város utcái híres írókról mesélnek. Fedezd fel a James Joyce, Oscar Wilde és Samuel Beckett életének nyomait. Ismerd meg a város irodalmi múltját és kultúráját idegenvezető segítségével. Kóstold meg a helyi ételeket a város hangulatos éttermeiben. Ez a túra irodalmat, kultúrát és városi felfedezést ötvöz.'),
(46, 24, 46, 'Brüsszeli csokoládétúra', 'brusszel_csokolade', 240, 'Brüsszel híres csokoládéjáról és gasztronómiai különlegességeiről. Látogasd meg a helyi csokoládégyártókat és kóstold meg a legfinomabb csokoládékat. Ismerd meg a csokoládékészítés történelmét és hagyományait. Sétálj a város utcáin, miközben a belga kultúrát ismered meg. Ez a túra ízek, kultúra és városi élet élményét nyújtja.'),
(47, 24, 47, 'Brüsszeli városnéző séta', 'brusszel_varosnezo', 245, 'Brüsszel gazdag történelmi és kulturális látnivalókkal vár. Fedezd fel a Nagytemplomot, a Grand Place teret és a királyi palotát. Ismerd meg a város történelmét, építészetét és kultúráját. Kóstold meg a belga specialitásokat a város hangulatos éttermeiben. Ez a túra Brüsszel történelmének, kultúrájának és gasztronómiájának felfedezését kínálja.'),
(48, 25, 48, 'Amszterdami éjszakai túra', 'amsterdam_ejszaka', 250, 'Amszterdam éjszakai fényei és hangulata különleges élményt kínálnak. Fedezd fel a város csatornáit, kávézóit és éjszakai életét szakértő vezetésével. Ismerd meg a város történelmét és kulturális életét az esti fények tükrében. Kóstold meg a helyi ételeket és italokat egy hangulatos helyen. Ez a túra éjszakai városi élményt, kultúrát és gasztronómiát kínál.'),
(49, 25, 49, 'Amszterdami művészeti túra', 'amsterdam_muveszet', 255, 'Amszterdam híres művészeti életéről és múzeumairól ismert. Látogasd meg a Van Gogh Múzeumot, a Rijksmuseumot és a helyi galériákat. Sétálj a város utcáin, miközben a holland művészet és kultúra titkait tanulod. Kóstold meg a helyi specialitásokat, miközben a város művészeti életét élvezed. Ez a túra művészet, kultúra és városi felfedezés élményét kínálja.'),
(50, 26, 50, 'Amszterdami piac- és ízutazás', 'amsterdam_piac', 260, 'Amszterdam piacai a város ízeinek és kultúrájának központjai. Fedezd fel a helyi piacokat, kóstold meg a holland sajtokat, süteményeket és tengeri ételeket. Tanulj a helyi ételek történelméről és hagyományairól idegenvezető segítségével. Sétálj a város hangulatos utcáin, miközben a gasztronómiai élményt élvezed. Ez a túra ízek, kultúra és városi élet kombinált élményét nyújtja.'),
(51, 3, 7, 'Budapest Városi Kaland', 'budapest_varosi_kaland', 45, 'Fedezze fel Budapest rejtett kincseit egy személyre szabott városi túrán. Látogassa meg a történelmi nevezetességeket, miközben ínycsiklandó helyi ételeket kóstolhat. Tapasztalja meg a Duna-parti sétány varázsát, és fedezze fel a város hangulatos kávézóit. Az út során helyi szakértők mesélnek a város múltjáról és kultúrájáról. Tökéletes program pároknak és családoknak egyaránt.'),
(52, 23, 68, 'Brno Kulturális Felfedezés', 'brno_kulturalis_felfedezes', 38, 'Fedezze fel Brno kulturális életét helyi idegenvezetővel. Látogassa meg a város múzeumait, galériáit és történelmi helyszíneit. Élvezze a város gasztronómiáját a hangulatos éttermekben, és kóstolja meg a helyi specialitásokat. Sétáljon Brno macskaköves utcáin, miközben megismeri a város gazdag történelmét. Egyedülálló élmény a kultúra és a városi élet felfedezésére.'),
(53, 23, 69, 'České Budějovice Történelmi Túra', 'ceske_budejovice_tortenelmi_tura', 42, 'Fedezze fel České Budějovice történelmi központját egy vezetett túra keretében. Ismerje meg a város híres épületeit és tereit, miközben érdekes történeteket hallhat a helyi múltról. Kóstolja meg a tradicionális ételeket és a híres sört a közeli éttermekben. Fedezze fel a város kulturális életét, piacait és kis üzleteit. Tökéletes választás történelem iránt érdeklődő utazóknak.'),
(54, 7, 19, 'Bécsi Gasztronómiai Élmény', 'becsi_gasztro_elmeny', 50, 'Vegyen részt egy ízletes gasztronómiai túrán Bécs utcáin. Kóstolja meg a helyi specialitásokat, péksüteményeket és tradicionális ételeket. Ismerje meg a város híres kávéházi kultúráját, miközben élvezetes sétát tesz a történelmi utcákon. Tapasztalja meg a bécsi életstílust és hangulatot autentikus helyszíneken. Egy élmény minden érzék számára.'),
(55, 3, 7, 'Budapesti Éjszakai Kaland', 'budapesti_ejszakai_kaland', 55, 'Fedezze fel Budapest éjszakai életét egy izgalmas túrán. Látogassa meg a város ikonikus hídjait és fényárban úszó nevezetességeit. Élvezze a helyi bárakat és éttermeket, miközben a város történelméről is hallhat érdekességeket. Tapasztalja meg a Dunai panorámát egy esti hajózás során. Tökéletes választás baráti társaságoknak és pároknak.'),
(56, 23, 67, 'Prágai Kézműves Élmény', 'pragai_kezmuves_elmeny', 48, 'Vegyen részt egy autentikus prágai kézműves workshopon, ahol saját szuvenírt készíthet. Ismerje meg a helyi mesterségek hagyományait és technikáit. Kóstolja meg a tradicionális cseh ételeket és italokat a közeli kávézókban. Fedezze fel Prága hangulatos utcáit és történelmi tereit a workshop mellett. Élmény és kultúra egy helyen, ideális családoknak és barátoknak.'),
(57, 23, 70, 'Prágai Óváros Felfedezés', 'pragai_ovaros_felfedezes', 52, 'Fedezze fel Prága történelmi óvárosát egy helyi idegenvezető segítségével. Látogassa meg a híres csillagvizsgálót, a régi városházát és a történelmi tereket. Ismerje meg a város múltját érdekes történetek és legendák segítségével. Élvezze a város hangulatos kávézóit és éttermeit egy rövid pihenő alatt. Tökéletes program a kultúra és történelem kedvelőinek.'),
(58, 7, 19, 'Bécsi Zenei Élmény', 'becsi_zenei_elmeny', 45, 'Élvezze Bécs híres zenei örökségét egy interaktív túra keretében. Látogasson el a híres koncerttermekbe és operaházakba. Ismerje meg a város klasszikus zenéjének történetét és híres zeneszerzőit. Tapasztalja meg a bécsi zenei kultúrát autentikus helyszíneken. Egy felejthetetlen élmény minden zenerajongónak.'),
(59, 3, 8, 'Szegedi Kulturális Élmény', 'szegedi_kulturalis_elmeny', 40, 'Fedezze fel Szeged kulturális életét, látogasson el múzeumokba és történelmi helyszínekre. Tapasztalja meg a város egyedülálló építészeti stílusát. Kóstolja meg a helyi ételeket és specialitásokat a város híres éttermeiben. Vegyen részt interaktív programokon és workshopokon, ahol a helyi kultúrával ismerkedhet. Tökéletes program családoknak és egyéni utazóknak.'),
(60, 3, 7, 'Budapesti Művészeti Élmény', 'budapesti_muveszeti_elmeny', 50, 'Fedezze fel Budapest kortárs és klasszikus művészetét egy vezetett túra során. Látogasson el galériákba, múzeumokba és kiállításokra. Ismerje meg a város híres művészeit és alkotásaikat. Élvezze a város kulturális életét interaktív workshopokkal és programokkal. Egyedülálló élmény a művészet szerelmeseinek.'),
(61, 23, 68, 'Brno Gasztronómiai Túra', 'brno_gasztro_tura', 47, 'Fedezze fel Brno ízvilágát egy helyi séf vezetésével. Kóstolja meg a tradicionális cseh ételeket és italokat autentikus helyszíneken. Ismerje meg a város kulináris történelmét és különlegességeit. Tapasztalja meg a piacok, éttermek és kávézók hangulatát. Tökéletes program ínyenceknek és családoknak.'),
(62, 23, 69, 'České Budějovice Városi Séta', 'ceske_budejovice_varosi_seta', 43, 'Fedezze fel České Budějovice macskaköves utcáit egy vezetett városi sétán. Látogasson el történelmi helyszínekre, templomokra és terekre. Ismerje meg a város legendáit és érdekességeit. Kóstolja meg a helyi ételeket és italokat a séta során. Egy élmény minden korosztálynak.'),
(63, 7, 20, 'Bécsi Gasztronómiai Workshop', 'becsi_gasztro_workshop', 50, 'Vegyen részt egy gasztronómiai workshopon Bécs központjában, ahol megtanulhat tradicionális recepteket. Ismerje meg a helyi ételek történetét és alapanyagait. Kóstolja meg a saját készítésű ételeket, miközben új ízeket fedez fel. Tapasztalja meg a város kulturális életét autentikus módon. Tökéletes program barátoknak és családoknak.'),
(64, 3, 8, 'Szegedi Gasztronómiai Élmény', 'szegedi_gasztro_elmeny', 42, 'Fedezze fel Szeged ízvilágát helyi séf vezetésével. Kóstolja meg a híres helyi ételeket és specialitásokat. Ismerje meg a város kulináris történelmét és hagyományait. Vegyen részt interaktív workshopokon és főzőprogramokon. Élmény minden ínyencnek és családoknak.'),
(65, 3, 7, 'Budapesti Történelmi Túra', 'budapesti_tortenelmi_tura', 55, 'Fedezze fel Budapest történelmi helyszíneit egy idegenvezető segítségével. Látogassa meg a híres épületeket, tereket és múzeumokat. Ismerje meg a város múltját érdekes történetek és legendák által. Tapasztalja meg a város hangulatát séták és programok során. Tökéletes program történelem iránt érdeklődő utazóknak.'),
(66, 23, 67, 'Prágai Esti Séta', 'pragai_esti_seta', 50, 'Fedezze fel Prága esti fényárban úszó utcáit egy romantikus sétán. Látogassa meg a történelmi hidakat és tereket, miközben a város mesés hangulatát élvezi. Kóstolja meg a helyi süteményeket és italokat egy hangulatos kávézóban. Tapasztalja meg Prága éjszakai életét autentikus módon. Egy élmény pároknak és barátoknak.'),
(67, 23, 70, 'Prágai Gasztronómiai Túra', 'pragai_gasztro_tura', 48, 'Fedezze fel Prága ízvilágát helyi szakértő vezetésével. Kóstolja meg a tradicionális cseh ételeket, süteményeket és italokat. Ismerje meg a város kulináris történelmét és helyi különlegességeit. Tapasztalja meg a piacok és éttermek hangulatát a városi felfedezés során. Egyedülálló élmény minden gasztronómia kedvelőnek.'),
(68, 7, 19, 'Bécsi Történelmi Túra', 'becsi_tortenelmi_tura', 45, 'Fedezze fel Bécs történelmét egy helyi idegenvezetővel. Látogassa meg a város híres épületeit, tereit és múzeumait. Ismerje meg a város múltját érdekes történetek és legendák által. Élvezze a hangulatos kávézókat és helyi éttermeket a túra során. Tökéletes program történelem és kultúra iránt érdeklődőknek.'),
(69, 3, 8, 'Szegedi Esti Élmény', 'szegedi_esti_elmeny', 40, 'Fedezze fel Szeged esti fényekben úszó utcáit egy romantikus sétán. Kóstolja meg a helyi specialitásokat hangulatos éttermekben. Tapasztalja meg a város kulturális és gasztronómiai életét autentikus módon. Élvezze a folyóparti sétát és a helyi művészeti eseményeket. Tökéletes program pároknak és családoknak.'),
(70, 3, 7, 'Budapesti Kortárs Művészet', 'budapesti_kortars_muveszet', 50, 'Fedezze fel Budapest kortárs művészeti helyszíneit egy vezetett túrán. Látogasson el galériákba, kiállításokra és művészeti központokba. Ismerje meg a helyi művészek munkáit és alkotásait. Tapasztalja meg a város művészeti életét interaktív programokon keresztül. Egyedülálló élmény művészetkedvelőknek.'),
(71, 23, 68, 'Brno Esti Gasztronómia', 'brno_esti_gasztro', 47, 'Fedezze fel Brno ízvilágát esti fényekben, egy gasztronómiai túra keretében. Kóstolja meg a helyi ételeket és italokat autentikus helyszíneken. Ismerje meg a város kulináris hagyományait. Élvezze a hangulatos utcák és éttermek atmoszféráját. Tökéletes program barátoknak és pároknak.'),
(72, 23, 69, 'České Budějovice Kultúra és Történelem', 'ceske_budejovice_kultura', 42, 'Fedezze fel České Budějovice kulturális és történelmi helyszíneit egy idegenvezetővel. Látogasson el múzeumokba, templomokba és történelmi terekre. Ismerje meg a város legendáit és érdekességeit. Kóstolja meg a helyi specialitásokat a városi séták során. Élmény minden korosztálynak.'),
(73, 7, 20, 'Bécsi Kortárs Művészeti Élmény', 'becsi_kortars_muveszet', 50, 'Fedezze fel Bécs kortárs művészeti helyszíneit egy vezetett túrán. Látogasson el galériákba és kiállításokra. Ismerje meg a helyi művészek munkáit és stílusát. Élvezze a város kulturális életét autentikus környezetben. Tökéletes program művészetkedvelőknek.'),
(74, 3, 8, 'Szegedi Történelmi Túra', 'szegedi_tortenelmi_tura', 40, 'Fedezze fel Szeged történelmét egy idegenvezető segítségével. Látogasson el múzeumokba, történelmi épületekhez és emlékhelyekhez. Ismerje meg a város múltját érdekes történetek által. Tapasztalja meg a város kulturális életét séták és programok során. Tökéletes program történelem iránt érdeklődőknek.'),
(75, 3, 7, 'Budapesti Gasztronómiai Élmény', 'budapesti_gasztro_elmeny', 55, 'Fedezze fel Budapest ízvilágát egy helyi séf vezetésével. Kóstolja meg a tradicionális magyar ételeket és italokat autentikus helyszíneken. Ismerje meg a város kulináris történelmét. Tapasztalja meg a piacok, éttermek és kávézók hangulatát. Egyedülálló élmény minden gasztronómia kedvelőnek.'),
(76, 23, 67, 'Prágai Kortárs Élmény', 'pragai_kortars_elmeny', 50, 'Fedezze fel Prága kortárs művészeti helyszíneit egy vezetett túrán. Látogasson el galériákba, kiállításokra és művészeti központokba. Ismerje meg a helyi művészek munkáit és alkotásait. Tapasztalja meg a város kulturális életét interaktív programokon keresztül. Tökéletes élmény művészetkedvelőknek.'),
(77, 23, 70, 'Prágai Éjszakai Kaland', 'pragai_ejszakai_kaland', 52, 'Fedezze fel Prága éjszakai életét egy izgalmas túra keretében. Látogassa meg a város híres tereit és hidakat este fényárban. Élvezze a helyi bárokat, kávézókat és éttermeket. Tapasztalja meg a város hangulatát esti séták során. Tökéletes program barátoknak és pároknak.'),
(78, 7, 19, 'Bécsi Éjszakai Élmény', 'becsi_ejszakai_elmeny', 45, 'Fedezze fel Bécs éjszakai életét egy vezetett túra keretében. Látogassa meg a város híres tereit, kávézóit és bárait. Ismerje meg Bécs történelmét esti fényekben. Élvezze a város hangulatát és zenei kultúráját autentikus helyszíneken. Tökéletes élmény pároknak és barátoknak.'),
(79, 3, 8, 'Szegedi Éjszakai Túra', 'szegedi_ejszakai_tura', 40, 'Fedezze fel Szeged éjszakai hangulatát egy romantikus vagy baráti sétán. Kóstolja meg a helyi éttermek és kávézók specialitásait. Tapasztalja meg a város kulturális életét autentikus módon. Élvezze a folyóparti sétákat és a világítással kiemelt történelmi helyszíneket. Ideális program esti kikapcsolódásra.'),
(80, 3, 7, 'Budapesti Kortárs Művészeti Túra', 'budapesti_kortars_muveszeti_tura', 50, 'Fedezze fel Budapest kortárs művészeti helyszíneit interaktív vezetett túrán. Látogasson el galériákba, művészeti központokba és kiállításokra. Ismerje meg a helyi művészek alkotásait. Tapasztalja meg a város kulturális életét autentikus módon. Egyedülálló élmény művészetkedvelőknek.'),
(81, 23, 71, 'Prágai Kastélylátogatás', 'pragai_kastelylatogatas', 60, 'Fedezze fel Prága híres kastélyait és történelmi épületeit egy vezetett túra keretében. Ismerje meg a kastélyok múltját és legendáit érdekes történetek segítségével. Tapasztalja meg a csodálatos építészetet és a gyönyörű parkokat. Kóstolja meg a helyi ételeket a kastély közeli éttermekben. Ideális program történelem és kultúra iránt érdeklődőknek.'),
(82, 3, 9, 'Debreceni Kulturális Túra', 'debreceni_kulturalis_tura', 42, 'Fedezze fel Debrecen gazdag kulturális életét múzeumok és történelmi helyszínek látogatásával. Tapasztalja meg a város építészeti különlegességeit és hangulatos tereit. Kóstolja meg a helyi gasztronómiai különlegességeket. Vegyen részt interaktív programokon és workshopokon, ahol a helyi kultúrával ismerkedhet. Tökéletes program családoknak és egyéni utazóknak.'),
(83, 7, 21, 'Bécsi Operalátogatás', 'becsi_operalatogatas', 55, 'Élvezze Bécs híres operaházainak hangulatát egy vezetett túra során. Ismerje meg a híres zeneszerzők történetét és a klasszikus zene örökségét. Tapasztalja meg a lenyűgöző építészetet és díszleteket. Látogasson el interaktív kiállításokra, ahol közelebbről is megismerkedhet a művészettel. Egyedülálló élmény minden zenerajongónak.'),
(84, 3, 10, 'Pécsi Borút', 'pecsi_borut', 50, 'Fedezze fel Pécs borvidékeit egy vezetett túra keretében. Kóstolja meg a helyi borokat és specialitásokat autentikus pincészetekben. Ismerje meg a borok készítésének folyamatát és történelmét. Élvezze a festői tájat és a kulturális látnivalókat út közben. Ideális program ínyenceknek és borkedvelőknek.'),
(85, 23, 72, 'Prágai Híres Terek Túrája', 'pragai_hires_terek_tura', 50, 'Fedezze fel Prága híres tereit, köztük az Óváros terét és a Hídlábat. Ismerje meg a város történelmét és legendáit érdekes történetek segítségével. Tapasztalja meg a helyi életet kávézók és éttermek között sétálva. Kóstolja meg a tradicionális cseh ételeket. Egyedülálló élmény a kultúra és történelem kedvelőinek.'),
(86, 3, 11, 'Győri Művészeti Élmény', 'gyori_muveszeti_elmeny', 48, 'Fedezze fel Győr művészeti helyszíneit egy vezetett túrán. Látogasson el galériákba, múzeumokba és kiállításokra. Ismerje meg a helyi művészek munkáit és stílusát. Tapasztalja meg a város kulturális életét autentikus programokon keresztül. Ideális élmény művészetkedvelőknek.'),
(87, 7, 22, 'Bécsi Kávéház Túra', 'becsi_kavehaz_tura', 45, 'Fedezze fel Bécs híres kávéházait egy vezetett sétán. Kóstolja meg a tradicionális süteményeket és kávékülönlegességeket. Ismerje meg a város irodalmi és zenei történelmét a kávéházak hangulatában. Tapasztalja meg a bécsi életstílust autentikus helyszíneken. Egyedülálló élmény minden látogatónak.'),
(88, 3, 12, 'Soproni Történelmi Túra', 'soproni_tortenelmi_tura', 44, 'Fedezze fel Sopron történelmét és nevezetességeit egy idegenvezető segítségével. Látogasson el történelmi épületekhez, terekre és múzeumokhoz. Ismerje meg a város múltját érdekes történetek segítségével. Kóstolja meg a helyi ételeket és italokat a séta során. Tökéletes program történelem iránt érdeklődőknek.'),
(89, 23, 73, 'Prágai Fényfesztivál Élmény', 'pragai_fenyfesztival_elmeny', 55, 'Élvezze Prága esti fényfesztiválját egy különleges túra keretében. Tapasztalja meg a város ikonikus épületeinek világítását és hangulatát. Kóstolja meg a helyi ételeket és italokat a fesztivál közben. Ismerje meg a város kulturális eseményeit és tradícióit. Ideális program barátoknak és családoknak.'),
(90, 3, 13, 'Kecskeméti Művészeti Workshop', 'kecskemet_muveszeti_workshop', 50, 'Vegyen részt egy interaktív művészeti workshopon Kecskeméten. Tanulja meg a helyi mesterségeket és alkotási technikákat. Készítsen saját szuvenírt és tapasztalja meg a kreativitást. Fedezze fel a város kulturális életét a workshop mellett. Egyedülálló élmény művészetkedvelőknek és családoknak.'),
(91, 7, 23, 'Bécsi Gasztronómiai Kaland', 'becsi_gasztro_kaland', 50, 'Fedezze fel Bécs ízvilágát egy gasztronómiai túra során. Kóstolja meg a tradicionális osztrák ételeket és italokat. Tapasztalja meg a város kulináris történelmét és kultúráját autentikus helyszíneken. Élvezze a hangulatos utcák és éttermek atmoszféráját. Ideális program ínyenceknek és gasztronómia kedvelőknek.'),
(92, 3, 14, 'Eger Városi Túra', 'eger_varosi_tura', 46, 'Fedezze fel Eger történelmi központját és nevezetességeit egy vezetett séta során. Ismerje meg a város múltját érdekes történetek segítségével. Látogasson el a híres várhoz és templomokhoz. Kóstolja meg a helyi borokat és ételeket a séták során. Tökéletes program történelem és kultúra kedvelőknek.'),
(93, 23, 74, 'Prágai Kastély és Kert Túra', 'pragai_kastely_kert_tura', 60, 'Fedezze fel Prága kastélyait és parkjait egy vezetett túra során. Ismerje meg a történelmi épületek múltját és legendáit. Tapasztalja meg a gyönyörű kerteket és panorámás kilátásokat. Kóstolja meg a helyi ételeket és italokat a közeli éttermekben. Ideális program történelem és kultúra kedvelőknek.'),
(94, 3, 15, 'Veszprémi Művészeti Túra', 'veszpremi_muveszeti_tura', 48, 'Fedezze fel Veszprém kortárs és klasszikus művészetét egy vezetett túrán. Látogasson el galériákba és múzeumokba. Ismerje meg a helyi művészek munkáit és alkotásait. Tapasztalja meg a város kulturális életét interaktív programokon keresztül. Egyedülálló élmény művészetkedvelőknek.'),
(95, 7, 24, 'Bécsi Zenei Est', 'becsi_zenei_est', 50, 'Élvezze Bécs híres zenei estjeit egy koncert vagy előadás keretében. Ismerje meg a klasszikus zenét és híres zeneszerzők történetét. Tapasztalja meg a bécsi zenei kultúrát autentikus helyszíneken. Kóstolja meg a helyi ételeket és italokat a koncert előtt vagy után. Egyedülálló élmény minden zenerajongónak.'),
(96, 3, 16, 'Székesfehérvári Történelmi Túra', 'szekesfehervari_tortenelmi_tura', 44, 'Fedezze fel Székesfehérvár történelmét és nevezetességeit egy idegenvezetővel. Látogasson el múzeumokba és történelmi épületekhez. Ismerje meg a város múltját érdekes történetek és legendák által. Kóstolja meg a helyi ételeket a városi séták során. Ideális program történelem iránt érdeklődőknek.'),
(97, 23, 75, 'Prágai Felfedező Túra', 'pragai_felfedezo_tura', 52, 'Fedezze fel Prága történelmi és kulturális helyszíneit egy vezetett túrán. Látogasson el híres terekre, múzeumokba és galériákba. Ismerje meg a város legendáit és érdekes történeteit. Kóstolja meg a helyi ételeket és italokat út közben. Egyedülálló élmény minden korosztálynak.'),
(98, 3, 17, 'Nyíregyházi Állatkert Élmény', 'nyiregyhazi_allatkert_elmeny', 42, 'Látogasson el Nyíregyházi Állatkertbe egy családi nap keretében. Ismerje meg a különleges állatfajokat és a természetvédelmi programokat. Vegyen részt interaktív bemutatókon és etetéseken. Tapasztalja meg a város parkjainak és zöld területeinek hangulatát. Ideális program családoknak és állatbarátoknak.'),
(99, 7, 25, 'Bécsi Történelmi Séta', 'becsi_tortenelmi_seta', 45, 'Fedezze fel Bécs történelmi központját egy idegenvezetővel. Látogasson el híres épületekhez, terekre és múzeumokhoz. Ismerje meg a város múltját érdekes történetek és legendák által. Tapasztalja meg a bécsi kultúrát és életstílust autentikus helyszíneken. Tökéletes program történelem iránt érdeklődőknek.'),
(100, 3, 18, 'Miskolci Kulturális Élmény', 'miskolci_kulturalis_elmeny', 46, 'Fedezze fel Miskolc kulturális életét múzeumok és történelmi helyszínek látogatásával. Tapasztalja meg a város építészeti különlegességeit. Kóstolja meg a helyi gasztronómiai különlegességeket. Vegyen részt interaktív programokon és workshopokon. Ideális program családoknak és egyéni utazóknak.'),
(101, 23, 76, 'Prágai Gasztronómiai Élmény', 'pragai_gasztro_elmeny', 50, 'Fedezze fel Prága ízvilágát egy gasztronómiai túra során. Kóstolja meg a tradicionális cseh ételeket és italokat autentikus helyszíneken. Ismerje meg a város kulináris hagyományait. Tapasztalja meg a piacok és éttermek hangulatát. Ideális program ínyenceknek és gasztronómia kedvelőknek.'),
(102, 3, 19, 'Kaposvári Városi Túra', 'kaposvari_varosi_tura', 44, 'Fedezze fel Kaposvár történelmi központját és nevezetességeit egy vezetett túra keretében. Ismerje meg a város múltját érdekes történetek segítségével. Látogasson el múzeumokhoz és templomokhoz. Kóstolja meg a helyi ételeket a séták során. Tökéletes program történelem és kultúra kedvelőknek.'),
(103, 7, 26, 'Bécsi Kastélylátogatás', 'becsi_kastelylatogatas', 55, 'Fedezze fel Bécs híres kastélyait és történelmi épületeit egy vezetett túra során. Ismerje meg a kastélyok múltját és legendáit. Tapasztalja meg a csodálatos építészetet és parkokat. Kóstolja meg a helyi ételeket és italokat a közeli éttermekben. Ideális program történelem és kultúra kedvelőknek.'),
(104, 3, 20, 'Szolnoki Kulturális Túra', 'szolnoki_kulturalis_tura', 42, 'Fedezze fel Szolnok kulturális életét múzeumok és történelmi helyszínek látogatásával. Tapasztalja meg a város építészeti különlegességeit. Kóstolja meg a helyi gasztronómiai különlegességeket. Vegyen részt interaktív programokon és workshopokon. Tökéletes program családoknak és egyéni utazóknak.');

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
(23, 2, 54),
(43, 3, 60),
(27, 4, 30),
(11, 6, 10),
(24, 7, 72),
(30, 9, 98),
(48, 11, 56),
(45, 12, 88),
(13, 15, 22),
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
(37, 59, 22),
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
(151, 1, 10, 1, 1200, 'paid', '4111111111111111', '12/26', 123, '2025-01-02', '2025-01-10', '2025-01-15'),
(152, 2, 11, 2, 800, 'paid', '4222222222222222', '05/25', 234, '2025-02-05', '2025-02-10', '2025-02-12'),
(153, 3, 12, 3, 1500, 'paid', '4333333333333333', '09/27', 345, '2025-03-01', '2025-03-10', '2025-03-15'),
(154, 4, 13, 4, 600, 'paid', '4444444444444444', '11/25', 456, '2025-01-20', '2025-01-25', '2025-01-28'),
(155, 5, 14, 5, 1000, 'paid', '4555555555555555', '07/26', 567, '2025-04-01', '2025-04-05', '2025-04-10'),
(156, 6, 15, 6, 900, 'paid', '4666666666666666', '03/25', 678, '2025-05-02', '2025-05-10', '2025-05-14'),
(157, 7, 16, 7, 1100, 'paid', '4777777777777777', '10/26', 789, '2025-06-01', '2025-06-05', '2025-06-10'),
(158, 8, 17, 8, 750, 'paid', '4888888888888888', '01/27', 890, '2025-07-03', '2025-07-10', '2025-07-12'),
(159, 9, 18, 9, 1300, 'paid', '4999999999999999', '08/25', 901, '2025-08-01', '2025-08-05', '2025-08-10'),
(160, 10, 19, 10, 1400, 'paid', '4000111122223333', '06/26', 234, '2025-09-05', '2025-09-10', '2025-09-15'),
(161, 11, 20, 11, 1600, 'paid', '4111222233334444', '12/25', 345, '2025-10-01', '2025-10-05', '2025-10-12'),
(162, 12, 21, 12, 950, 'paid', '4222333344445555', '09/26', 456, '2025-11-01', '2025-11-05', '2025-11-08'),
(163, 13, 22, 13, 1200, 'paid', '4333444455556666', '04/27', 567, '2025-12-01', '2025-12-05', '2025-12-10'),
(164, 14, 23, 14, 700, 'paid', '4444555566667777', '05/26', 678, '2025-01-05', '2025-01-10', '2025-01-13'),
(165, 15, 24, 15, 1050, 'paid', '4555666677778888', '07/25', 789, '2025-02-01', '2025-02-05', '2025-02-10'),
(166, 16, 25, 16, 850, 'paid', '4666777788889999', '03/26', 890, '2025-03-03', '2025-03-10', '2025-03-12'),
(167, 17, 26, 17, 1150, 'paid', '4777888899990000', '10/25', 901, '2025-04-01', '2025-04-05', '2025-04-10'),
(168, 18, 27, 18, 780, 'paid', '4888999900001111', '01/26', 234, '2025-05-02', '2025-05-05', '2025-05-08'),
(169, 19, 28, 19, 1320, 'paid', '4999000011112222', '08/26', 345, '2025-06-01', '2025-06-05', '2025-06-10'),
(170, 20, 29, 20, 1450, 'paid', '4000111122223334', '06/25', 456, '2025-07-01', '2025-07-05', '2025-07-12'),
(171, 21, 10, 21, 1250, 'paid', '4111111111115555', '12/26', 567, '2025-08-03', '2025-08-10', '2025-08-15'),
(172, 22, 11, 22, 870, 'paid', '4222222222226666', '05/25', 678, '2025-09-01', '2025-09-05', '2025-09-08'),
(173, 23, 12, 23, 1550, 'paid', '4333333333337777', '09/27', 789, '2025-10-02', '2025-10-05', '2025-10-12'),
(174, 24, 13, 24, 620, 'paid', '4444444444448888', '11/25', 890, '2025-11-05', '2025-11-10', '2025-11-12'),
(175, 25, 14, 25, 1020, 'paid', '4555555555559999', '07/26', 901, '2025-12-01', '2025-12-05', '2025-12-10'),
(176, 26, 15, 26, 910, 'paid', '4666666666661111', '03/25', 234, '2025-01-10', '2025-01-15', '2025-01-18'),
(177, 27, 16, 27, 1110, 'paid', '4777777777772222', '10/26', 345, '2025-02-02', '2025-02-05', '2025-02-10'),
(178, 28, 17, 28, 760, 'paid', '4888888888883333', '01/27', 456, '2025-03-01', '2025-03-03', '2025-03-06'),
(179, 29, 18, 29, 1340, 'paid', '4999999999994444', '08/25', 567, '2025-04-05', '2025-04-10', '2025-04-15'),
(180, 30, 19, 30, 1420, 'paid', '4000111122225555', '06/26', 678, '2025-05-01', '2025-05-05', '2025-05-10'),
(181, 31, 20, 31, 1610, 'paid', '4111222233336666', '12/25', 789, '2025-06-01', '2025-06-05', '2025-06-12'),
(182, 32, 21, 32, 970, 'paid', '4222333344447777', '09/26', 890, '2025-07-01', '2025-07-05', '2025-07-08'),
(183, 33, 22, 33, 1210, 'paid', '4333444455558888', '04/27', 901, '2025-08-01', '2025-08-05', '2025-08-10'),
(184, 34, 23, 34, 710, 'paid', '4444555566669999', '05/26', 234, '2025-09-02', '2025-09-05', '2025-09-08'),
(185, 35, 24, 35, 1070, 'paid', '4555666677770000', '07/25', 345, '2025-10-01', '2025-10-05', '2025-10-10'),
(186, 36, 25, 36, 860, 'paid', '4666777788881111', '03/26', 456, '2025-11-03', '2025-11-05', '2025-11-08'),
(187, 37, 26, 37, 1160, 'paid', '4777888899992222', '10/25', 567, '2025-12-01', '2025-12-05', '2025-12-10'),
(188, 38, 27, 38, 790, 'paid', '4888999900003333', '01/26', 678, '2025-01-02', '2025-01-05', '2025-01-08'),
(189, 39, 28, 39, 1330, 'paid', '4999000011114444', '08/26', 789, '2025-02-01', '2025-02-05', '2025-02-10'),
(190, 40, 29, 40, 1460, 'paid', '4000111122226666', '06/25', 890, '2025-03-01', '2025-03-05', '2025-03-12'),
(191, 41, 10, 41, 1260, 'paid', '4111111111117777', '12/26', 901, '2025-04-01', '2025-04-05', '2025-04-10'),
(192, 42, 11, 42, 880, 'paid', '4222222222228888', '05/25', 234, '2025-05-01', '2025-05-05', '2025-05-08'),
(193, 43, 12, 43, 1560, 'paid', '4333333333339999', '09/27', 345, '2025-06-01', '2025-06-05', '2025-06-12'),
(194, 44, 13, 44, 630, 'paid', '4444444444441111', '11/25', 456, '2025-07-01', '2025-07-05', '2025-07-08'),
(195, 45, 14, 45, 1030, 'paid', '4555555555552222', '07/26', 567, '2025-08-01', '2025-08-05', '2025-08-10'),
(196, 46, 15, 46, 920, 'paid', '4666666666663333', '03/25', 678, '2025-09-01', '2025-09-05', '2025-09-08'),
(197, 47, 16, 47, 1120, 'paid', '4777777777774444', '10/26', 789, '2025-10-01', '2025-10-05', '2025-10-10'),
(198, 48, 17, 48, 770, 'paid', '4888888888885555', '01/27', 890, '2025-11-01', '2025-11-03', '2025-11-06'),
(199, 49, 18, 49, 1350, 'paid', '4999999999996666', '08/25', 901, '2025-12-01', '2025-12-05', '2025-12-10'),
(200, 50, 19, 50, 1430, 'paid', '4000111122227777', '06/26', 234, '2025-01-01', '2025-01-05', '2025-01-10');

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
(100, 'Ella', 'Russell', NULL, 'ella.r98@gmail.com', 'ERus98', '+15120000098', 'F', 'U', NULL, NULL, NULL),
(101, 'Dylan', 'Howard', NULL, 'dylan.h99@gmail.com', 'DHow99', '+15120000099', 'M', 'U', '453210000000050', '09/30', 150),
(102, 'Luna', 'Bailey', NULL, 'luna.b100@gmail.com', 'LBai100', '+15120000100', 'F', 'U', NULL, NULL, NULL);

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
-- AUTO_INCREMENT a táblához `experiences`
--
ALTER TABLE `experiences`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT a táblához `favourite`
--
ALTER TABLE `favourite`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT a táblához `history`
--
ALTER TABLE `history`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=201;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

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
