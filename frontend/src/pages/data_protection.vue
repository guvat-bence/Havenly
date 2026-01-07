<template>
  <div class="data_protection">
    <div class="container py-5 text-white">
     
      <!-- Cím -->
      <h1 class="display-3 text-white text-center mb-4">
        Adatvédelmi nyilatkozat
      </h1>
    
      <!-- Szöveg -->
      <div class="mb-4">
        <p>
          A Havenly (továbbiakban: „Szolgáltató”, „Mi”) elkötelezett a felhasználók személyes adatainak védelme iránt.
          Jelen adatvédelmi nyilatkozat célja, hogy átláthatóan és érthetően bemutassa, milyen adatokat gyűjtünk,
          hogyan kezeljük azokat, és milyen jogok illetik meg a felhasználókat a személyes adataik kapcsán.
        </p>
        <p>
          A Havenly egy online szállásfoglaló és szállásmegosztó platform, ahol a felhasználók szállásokat foglalhatnak,
          saját ingatlanjaikat feltölthetik, valamint helyi látványosságokat és élményeket oszthatnak meg másokkal.
        </p>
      </div>

      <!-- Az adatkezelő adatai szöveg -->
      <div class="mb-4">
        <h2>1. Az adatkezelő adatai</h2>
        <p><strong>Adatkezelő neve:</strong> Havenly</p>
        <p><strong>Projekt típusa:</strong> Vizsgaremek - szállásfoglaló és szállásmegosztó webalkalmazás</p>
        <p><strong>Elérhetőség:</strong> (később megadható e-mail cím)</p>
      </div>

      <!-- kezelt személyes adatok köre szöveg  -->
      <div class="mb-4">
        <h2>2. A kezelt személyes adatok köre</h2>

        <h5 class="mt-3">2.1. Regisztráció során megadott adatok</h5>
        <ul>
          <li>Teljes név</li>
          <li>E-mail cím</li>
          <li>Telefonszám</li>
          <li>Jelszó (titkosítva tárolva)</li>
        </ul>

        <h5 class="mt-3">2.2. Profiladatok</h5>
        <ul>
          <li>Lakcím vagy tartózkodási hely (opcionális)</li>
          <li>Profilkép</li>
          <li>Fizetési mód beállításai</li>
          <li>Bankkártya-adatok (külső fizetési szolgáltató kezeli, nem a Havenly)</li>
        </ul>

        <h5 class="mt-3">2.3. Szállásfeltöltéshez kapcsolódó adatok</h5>
        <ul>
          <li>Ingatlan címe</li>
          <li>Leírás</li>
          <li>Fényképek, videók</li>
          <li>Árazás és foglalhatósági adatok</li>
        </ul>

        <h5 class="mt-3">2.4. Foglalási adatok</h5>
        <ul>
          <li>Foglalás időpontja</li>
          <li>Foglaló és kiadó adatai</li>
          <li>Fizetési információk (összeg, tranzakciós adatok)</li>
        </ul>

        <h5 class="mt-3">2.5. Kommunikációs adatok</h5>
        <ul>
          <li>A weboldalon belüli üzenetváltások tartalma</li>
          <li>E-mailes és telefonos kommunikáció metaadatai</li>
        </ul>

        <h5 class="mt-3">2.6. Technikai adatok</h5>
        <ul>
          <li>IP-cím</li>
          <li>Böngésző típusa</li>
          <li>Bejelentkezési időpontok</li>
        </ul>
      </div>

      <!--  Az adatkezelés célja szöveg -->
      <div class="mb-4">
        <h4>3. Az adatkezelés célja</h4>
        <ul>
          <li>Felhasználói fiók létrehozása és kezelése</li>
          <li>Szállásfoglalások lebonyolítása</li>
          <li>Szállások és látványosságok feltöltése, szerkesztése</li>
          <li>Fizetések kezelése</li>
          <li>A foglaló és a kiadó közötti kommunikáció biztosítása</li>
          <li>A weboldal működésének biztosítása és fejlesztése</li>
          <li>Visszaélések megelőzése</li>
          <li>Jogszabályi kötelezettségek teljesítése</li>
        </ul>
      </div>

      <!-- Az adatkezelés jogalapja szöveg  -->
      <div class="mb-4">
        <h4>4. Az adatkezelés jogalapja</h4>
        <ul>
          <li>Felhasználó hozzájárulása</li>
          <li>Szerződés teljesítése (foglalások, fiókkezelés)</li>
          <li>Jogi kötelezettség teljesítése</li>
          <li>Szolgáltató jogos érdeke (biztonság, visszaélések megelőzése)</li>
        </ul>
      </div>

      <!-- Adattárolás időtartama szöveg -->
      <div class="mb-4">
        <h4>5. Adattárolás időtartama</h4>
        <ul>
          <li>A felhasználói fiók adatai: a fiók törléséig</li>
          <li>Foglalási adatok: jogszabályban előírt ideig</li>
          <li>Üzenetek: a fiók törléséig</li>
          <li>Technikai adatok: a rendszer működéséhez szükséges ideig</li>
        </ul>
      </div>

      <!-- Adatok továbbítása és külső szolgáltatók szöveg  -->
      <div class="mb-4">
        <h4>6. Adatok továbbítása és külső szolgáltatók</h4>
        <p>
          A Havenly bizonyos adatokat külső partnereknek továbbíthat, például:
        </p>
        <ul>
          <li>Fizetési szolgáltatók (bankkártya-adatok kezelése)</li>
          <li>Tárhelyszolgáltató</li>
          <li>E-mail küldő szolgáltató</li>
          <li>Analitikai vagy naplózó rendszerek (amennyiben használunk ilyet)</li>
        </ul>
        <p>
          A továbbított adatok mennyisége mindig a minimálisan szükségesre korlátozódik.
        </p>
      </div>

      <!-- Felhasználói jogok szöveg -->
      <div class="mb-4">
        <h4>7. Felhasználói jogok</h4>
        <p>A felhasználókat az alábbi jogok illetik meg:</p>
        <ul>
          <li>Hozzáférés a saját adataikhoz</li>
          <li>Adatok helyesbítése</li>
          <li>Adatok törlése („elfeledtetés joga”)</li>
          <li>Adatkezelés korlátozása</li>
          <li>Adathordozhatóság</li>
          <li>Hozzájárulás visszavonása</li>
          <li>Panasztétel joga a Nemzeti Adatvédelmi és Információszabadság Hatóságnál (NAIH)</li>
        </ul>
      </div>

      <!--  Adatbiztonság szöveg  -->
      <div class="mb-4">
        <h4>8. Adatbiztonság</h4>
        <p>
          A Havenly minden ésszerű technikai és szervezési intézkedést megtesz a személyes adatok védelme érdekében:
        </p>
        <ul>
          <li>Titkosított adatátvitel (HTTPS)</li>
          <li>Jelszavak biztonságos, hash-elt tárolása</li>
          <li>Rendszeres biztonsági mentések</li>
          <li>Jogosultságkezelés</li>
          <li>Visszaélés-figyelő rendszerek alkalmazása</li>
        </ul>
      </div>

      <!-- Az adatvédelmi nyilatkozat módosítása szöveg -->
      <div class="mb-4">
        <h4>9. Az adatvédelmi nyilatkozat módosítása</h4>
        <p>
          A Havenly fenntartja a jogot, hogy jelen adatvédelmi nyilatkozatot bármikor módosítsa.
          A változásokról a felhasználókat a weboldalon keresztül értesítjük.
        </p>
      </div>
    </div>
  </div>
</template>
