const mysql = require("mysql");
const fsp = require("node:fs").promises;
const fs = require("node:fs");
const path  = require("path");

//Adatbázis beállítása.
const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "havenly"
})

//Adatbázis kapcsolat létrehozása.
db.connect(err => {
  if (err) {
    return console.error("Hiba a Mysql szerver csatlakozáskor:", err);
  }
  console.log("Sikeres csatlakozás az adatbázishoz!");
})

//Sztring általakító function.
function convertStrings(str) 
{  
  return str.normalize("NFD")
            .replace(/[\u0300-\u036f]/g, "")
            .replaceAll(" ","_")
            .toLowerCase();
}

//Annak a könyvtárnak a helye ahol a másolandó képek vannak.
const itemsDir ="e:/Downloads/project_images";

//putFilesToFolders async function.
async function putFilesToFolders(itemsDir,placeType,folderDir)
{
  //Megpróbálja végrehatjani az utasítást.
  try
  {
    //Beolvassa a létrehozott mappát, és egy változóban tárolja el az értékeket.
    let response = await fsp.readdir(folderDir);

    //Ha a jelenlegi mappában már vannak fájlok akkor hibaüzenettel tér vissza.
    if(response.length>0)
    {
      return console.log(`A jelenlegi mappában már vannak fájlok. ${response.length}, ${folderDir}`);
    }
  }
  //Ha nem tudja végrehajtani az utasítésokat akkor ezzel tér visssza:
  catch(err)
  {
    return console.log(`Hiba történ létrehozott mappa beolvasása során: ${err}`);
  }

  //Megpróbálja végrehatjani az utasítást.
  try
  {
    //Beolvassuk a célmappát amely mapparendszerében vannak a másolandó fájlok.
    //A megkapott értékeket el tároljuk.
    let folders = await fsp.readdir(itemsDir);

    //Ellenörzi hogy a fájlok közzöt megtalálhatóak-e azok a mappák ahol a másolandó fájlok vannak.
    //Ha nem találja hibaüzenettel tér vissza:
    if(!folders.includes("accommodations")|| !folders.includes("experiences"))
    {
      return console.log(`Nem található a(z) accommodations/experiences mappa.`)
    }
  }
  //Ha nem tudja végrehajtani az utasítésokat akkor ezzel tér visssza:
  catch(err)
  {
    return console.log(`Hiba történ a célmappa beolvasása során: ${err}`);
  }

  //Létrehozzuk a fullDirFolder változót.
  //A path.join segítségével meghatérozzuk a célmappán belüli mappa pontos útvonalát(accommodations/experiences).
  let fullDirFolder = path.join(itemsDir,placeType);

  //Megpróbálja végrehajtani a megadott parancsokat.
  try
  {
    //A files változóba eltárolja a(z) accommodations/experiences mappában lévő fáljokat.
    let files = await fsp.readdir(fullDirFolder);

    //Megnézzük mennyi fálj található az adott mappában.
    //Ha nincs elég a teljes másolás végrehajtásához akkor hibaüzenettel tér vissza: 
    if(files.length<10)
    {
      return console.log(`Nincsen elég fálj a másoláshoz! ${files.length}`);
    }

    // Létrehozzuk a fileType,oroginalFile és a copiedFile változókat. 
    let fileType  = "";
    let oroginalFile = "";
    let copiedFile = ""; 

    //A for ciklus segíségével szabályozzuk hogy hány fájl legyen egy mappában.
    for(let i=0;i<10;i++)
    {
      //Megpróbálja végrehajtani a megadott parancsokat.
      try
      {
        oroginalFile = path.join(fullDirFolder,files[i]);
        copiedFile = path.join(folderDir,i>8?`0${i+1}.png`:`00${i+1}.png`);
        
        //Megpróbálja végrehajtani a megadott parancsokat.
        try
        {
          //lemásoljuk a lamásolandó fájlokat és a megadott helyre tesszük. 
          await fsp.copyFile(oroginalFile,copiedFile);

          // kitöröltük az eredeti fájlokat hogy a későbbiekben ne legyen ismétlődés. 
          await fsp.unlink(oroginalFile);
        }
        //Ha nem tudja végrehajtani az utasításokat akkor ezzel tér visssza:
        catch(err)
        {
          return console.log(`Hiba történ az accommodations/experiences mappa beolvasása során. ${err}`);
        }

      }
      //Ha nem tudja végrehajtani az utasítésokat akkor ezzel tér visssza:
      catch(err)
      {
        return console.log(`Hiba történ az accommodations/experiences mappa beolvasása során. ${err}`);
      }
    }
  }
  //Ha nem tudja végrehajtani az utasítésokat akkor ezzel tér visssza:
  catch(err)
  {
    return console.log(`Hiba történ az accommodations/experiences mappa beolvasása során. ${err}`);
  }
}

// tesztsor:
// putFilesToFolders(itemsDir,"accommodations",`../frontend/src/images/countries/india/cities/mumbai/accommodations/mumbai_sea_view_apartment`);

//Lekérjük a nekünk kellő adatokat az adatbázisból.
//Majd egy callback functionban dolgozunk tovább az adatokal.
db.query(
  "SELECT `countries`.`name` AS `country_name`, "+
  "`cities`.`name` AS `city_name`, "+
  "`accommodations`.`folder_name` AS `accommodation_name`, "+
  "`experiences`.`folder_name` AS `experience_name` FROM `countries` "+
  "INNER JOIN `cities` "+
  "ON `cities`.`country_id` = `countries`.`id` "+
  "INNER JOIN `accommodations` "+
  "ON `cities`.`id` = `accommodations`.`city_id` "+
  "LEFT JOIN `experiences` "+
  "ON `cities`.`id` = `experiences`.`city_id`"+
  "ORDER BY `accommodations`.`id` ASC", 
  async (err, datas) => {
    //Ha hibába ütközik a program akkor ezzel a hiaüzenettel tér vissza:
    if (err) {
      return console.error("Hiba a datas beolvasásakor", err);
    }

    //Létrehozzuk a folderDir változót. 
    let folderDir = "";

    //Végigmegyünk az összes adaton és mappákat készítünk hozzá.
    for(let i=0;i<datas.length;i++)
    { 
      
      //Elérési útvonal az accomodations mappához.
      folderDir = `../frontend/public/countries/${convertStrings(datas[i].country_name)}`+
                  `/cities/${convertStrings(datas[i].city_name)}`+
                  `/accommodations/${convertStrings(datas[i].accommodation_name)}`;

      //Létrehozzuk a mappákat.
      fs.mkdirSync(folderDir,{recursive:true});

      //Meghívjuk a fájl másolós funxctiont.
      await putFilesToFolders(itemsDir,"accommodations",folderDir);

      //Ha vannak experiencek akkor azoknak is megcsinálja a mappát. 
      if(datas[i].experience_name != null)
      {
        ///Elérési útvonal az experiences mappához.
        folderDir = `../frontend/public/countries/${convertStrings(datas[i].country_name)}`+
                    `/cities/${convertStrings(datas[i].city_name)}`+
                    `/experiences/${convertStrings(datas[i].experience_name)}`;

        //Létrehozzuk a mappákat.
        fs.mkdirSync(folderDir,{recursive:true});

        //Meghívjuk a fájl másolós functiont.
        await putFilesToFolders(itemsDir,"experiences",folderDir);
      }
    }
    //Kilép a program futásából a for ciklus végeztével.
    process.exit(0);
  }
)
