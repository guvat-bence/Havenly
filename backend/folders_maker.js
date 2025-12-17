const mysql = require("mysql");
const fs = require("node:fs").promises;
const path  = require("path");

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "havenly"
})

db.connect(err => {
  if (err) {
    return console.error("Hiba a Mysql szerver csatlakozáskor:", err);
  }
  console.log("Sikeres csatlakozás az adatbázishoz!");
})

function convertStrings(str) 
{  
  return str.normalize("NFD")
            .replace(/[\u0300-\u036f]/g, "")
            .replaceAll(" ","_")
            .toLowerCase();
}

const itemsDir ="c:/Users/guvat.bence/Downloads/download_images";

async function putFilesToFolders(itemsDir,placeType,folderDir)
{
  //Megpróbálja végrehatjani az utasítást.
  try
  {
    //Beolvassa a létrehozott mappát, és egy változóban tárolja el az értékeket.
    let response = await fs.readdir(folderDir);

    //Ha a jelenlegi mappában már vannak fájlok akkor hibaüzenettel tér vissza.
    if(response.length>0)
    {
      return console.log(`A jelenlegi mappában már vannak fájlok. ${response.length}`);
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
    let folders = await fs.readdir(itemsDir);

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
    let files = await fs.readdir(fullDirFolder);

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
        fileType  = files[i].includes(".").pop();
        oroginalFile = path.join(fullDirFolder,files[i]);
        copiedFile = path.join(folderDir,i>9?`0${i+1}`:`00${i+1}`);
        
        //Megpróbálja végrehajtani a megadott parancsokat.
        try
        {
          await fs.copyFile(oroginalFile,copiedFile);

          await fs.unlink(oroginalFile);
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

putFilesToFolders(itemsDir,"accommodations",`../frontend/src/images/countries/india/cities/mumbai/accommodations/mumbai_sea_view_apartment`);

// db.query(
//   "SELECT `countries`.`name` AS `country_name`, "+
//   "`cities`.`name` AS `city_name`, "+
//   "`accommodations`.`name` AS `accommodation_name`, "+
//   "`experiences`.`name` AS `experience_name` FROM `countries` "+
//   "INNER JOIN `cities` "+
//   "ON `cities`.`country_id` = `countries`.`id` "+
//   "INNER JOIN `accommodations` "+
//   "ON `cities`.`id` = `accommodations`.`city_id` "+
//   "LEFT JOIN `experiences` "+
//   "ON `cities`.`id` = `experiences`.`city_id`", 
//   (err, datas) => {
//     if (err) {
//       return console.error("Hiba a datas beolvasásakor", err);
//     }
//     console.log(datas);

//     for(let i=0;i<datas.length;i++)
//     { 
      
//       let folderDir = `../frontend/src/images/countries/${convertStrings(datas[i].country_name)}`+
//                   `/cities/${convertStrings(datas[i].city_name)}`+
//                   `/accommodations/${convertStrings(datas[i].accommodation_name)}`;

//       console.log(": "+folderDir);

//       fs.mkdir(folderDir,{recursive:true},(err)=>
//       {
//         if(err)
//         {
//           console.log(err);
//         }
//         else
//         {
//           // console.log("elso: "+folderDir);
//           // putFilesToFolders(itemsDir,"accommodations",folderDir);
//         }
//       })
      
//       if(datas[i].experience_name != null)
//       {
//         let folderDir = `../frontend/src/images/countries/${convertStrings(datas[i].country_name)}`+
//                     `/cities/${convertStrings(datas[i].city_name)}`+
//                     `/experiences/${convertStrings(datas[i].experience_name)}`;

//         fs.mkdir(folderDir,{recursive:true},(err)=>
//         {
//           if(err)
//           {
//             console.log(err);
//           }
//           else
//           {
//             // console.log("elso: "+folderDir);
//             // putFilesToFolders(itemsDir,"experiences",folderDir);
           
//           }
//         })
//       }
//     }
//     // process.exit(0);
//   }
// )

