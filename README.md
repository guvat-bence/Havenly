# <center> Havenly projekt

## <center> A projekt rövid lírása

    Vizsgaremekünk témája egy szállásfoglaló weboldal fejlesztése. Az oldalon a felhasználók szállásokat foglalhatnak, valamint saját házukat vagy apartmanjukat is feltölthetik és kiadhatják.

    A foglaláshoz és a szállások feltöltéséhez regisztráció szükséges, amely során a felhasználók megadják adataikat. Bejelentkezés után szállásokat foglalhatnak, szállásokat kezelhetnek, valamint különböző élményeket és helyi látványosságokat adhatnak hozzá és értékelhetnek városokhoz, ezzel segítve mások tájékozódását és vonzóbbá téve az adott településeket.

    A felhasználók szerkeszthetik fiókadataikat, beállíthatják és elmenthetik fizetési és banki adataikat, így a későbbi foglalások gyorsabbá és kényelmesebbé válnak. A feltöltött szállások módosíthatók, kiegészíthetők vagy törölhetők, valamint részletes leírással, képekkel és videókkal is bemutathatók.

    A rendszer automatikusan kezeli a foglalásokat, elkerülve a dupla foglalásokat. A kiadó minden foglalásról értesítést kap, és mind a kiadó, mind a foglaló lemondhatja a foglalást, azonban bizonyos idő elteltével csak részleges visszatérítés jár.

    A weboldal saját üzenetküldő funkciót biztosít a kiadók és foglalók közötti kapcsolattartáshoz, emellett e-mailen és telefonon is elérhetik egymást. Az oldal több nyelven lesz elérhető, így szélesebb felhasználói kör számára nyújt lehetőséget.

    A weboladhoz elérhető egy asztali alkalmazás is. Ezzel a z alkalmazással tudnak az adminisztráció jogosultságú felhasználók, különféle adatokat szerkeszteni, törölni vagy hozzáadni az adatbázishoz.

## <center> Csapat tagok
- Projekt vezető.: Guvat Bence József
- Projekt tag.: Herczeg Máté János 

## <center> Github
    https://github.com/guvat-bence/Havenly

## <center> Trello
    https://trello.com/b/9NnuwGVv/havenly


## <center> Mivel dolgozunk?
- Bootstrap
- ExpressJS
- Vue
- C#

## <center> Telepítés és indítás

# A weboldalhoz:

## Ezt az első indításnál kell megcsinálni:

### 1. Adatbázis telepítés és indítása

    Nyissa meg a "xampp" alkamazást, majd az "Apache" menüpontnál kattintson a start gombra.

    A "MySQL" menüpontnál kattintson a start gombra.
    Ezután a  "MySQL" menüpontnál kattintson az admin menüpontra hogy hozzá tudja adni az adatbázist.

    A "phpMyAdmin" oldalán kattintson bal oldalt  az "Új" menüpontra.

    Adatbázis névnek állítsa be a "havenly" nevet, majd a mellete lévő legürdülő menüben keresse meg a "utf8mb4_general_ci" opciót.
    Végül kattintson a "Létrehozás" gombra.

    Ezután menjen a "beszúrás" menüpontra.Itt a tallózás gombra, és válassza ki a "havenly" mappából, azon belül pedig a "db" mappából a "havenly.sql" fájlt.
    Ezután kattintsont az oldal alján lévő importálás gombra. 

### 2. Backend telepítése és indítása
    cd web
    cd backend
    npm install
    npm run dev

### 3. Frontend telepítése és indítása
    cd web
    cd frontend
    npm install
    npm run dev

    Ez után másolja ki a konzolon megjelenő localhostos elérési útvonalat, és másolja bele egy böngészőbe.



## Az első indítás utáni indításkor:

### 1. Adatbázis indítása

    Nyissa meg a "xampp" alkamazást, majd az "Apache" menüpontnál kattintson a start gombra.

    Majd a "MySQL" menüpontnál kattintson a start gombra.

### 2. Backend indítása
    cd web
    cd backend
    npm run dev

### 3. Frontend indítása
    cd web
    cd frontend
    npm run dev
    Ez után másolja ki a konzolon megjelenő localhostos elérési útvonalat, és másolja bele egy böngészőbe.


# Az asztali alkalmazáshoz:

## Ezt az első indításnál kell megcsinálni:

### 1. Adatbázis telepítés és indítása

    Nyissa meg a "xampp" alkamazást, majd az "Apache" menüpontnál kattintson a start gombra.

    A "MySQL" menüpontnál kattintson a start gombra.
    Ezután a  "MySQL" menüpontnál kattintson az admin menüpontra hogy hozzá tudja adni az adatbázist.

    A "phpMyAdmin" oldalán kattintson bal oldalt  az "Új" menüpontra.

    Adatbázis névnek állítsa be a "havenly" nevet, majd a mellete lévő legürdülő menüben keresse meg a "utf8mb4_general_ci" opciót.
    Végül kattintson a "Létrehozás" gombra.

    Ezután menjen a "beszúrás" menüpontra.Itt a tallózás gombra, és válassza ki a "havenly" mappából, azon belül pedig a "db" mappából a "havenly.sql" fájlt.
    Ezután kattintsont az oldal alján lévő importálás gombra. 

### 2. Alkalmazás telepítése és indítása
    
    A wpf mappában fog találni egy "havenlyInstaller.msi" nevű fáljt, annak az elidításával lehet elkezdeni az alkalmazás letöltését.

    Miután megnyitotta a telepítőt, menjen végig az összes folyamaton amit a telepítő kér, és válassza ki közben, hogy hova szeretné telepíteni az alkalmazást.

    Miután sikeresen telepítette. az asztalán (vagy ha a kersőben rá keres) meg fog jelenni a "HavenlyDemo" nevű parancsikon, azt kell elindítani az alkalmazás indításához.


## Az első indítás utáni indításkor:

### 1. Adatbázis indítása
    Nyissa meg a "xampp" alkamazást, majd az "Apache" menüpontnál kattintson a start gombra.

    Majd a "MySQL" menüpontnál kattintson a start gombra.


### 2. Alkalmazás indítása
    
    Az asztalán (vagy a keresőben) lévő "HavenlyDemo" nevű parancsikonnal tudja elidítani az alkalmazást.
