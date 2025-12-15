const express = require("express");
const app = express();
const mysql = require("mysql");
const fs = require("node:fs");
const { after } = require("node:test");
const path  = require("path");
const port = 3100;

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "havenly"
})

db.connect(err => {
  if (err) {
    console.error("Hiba a Mysql szerver csatlakozáskor:", err);
    return;
  }
  console.log("Sikeres csatlakozás!");
})

app.listen(port, () => {
  console.log(`folders_maker is running on port ${port}`);
})

function convertStrings(str) 
{  
  return str.normalize("NFD")
            .replace(/[\u0300-\u036f]/g, "")
            .replaceAll(" ","_")
            .toLowerCase();
}

const itemsDir ="e:/Downloads/project_images";

function putFilesToFolders(itemsDir,placeType,folderDir)
{

  //Megnézzük milyenelemek vannak az adott létrehozott accommodation/experiences mappában.
  fs.readdir(folderDir,(err,response)=>
  {
    // Ha nem tudja megnézni a mappa tartalmát akkor az errorral fog visszatérrni.
    if(err)
    {
      return console.log(err);
    }
    // Megnézzük a response length-jét, ha nagyoobb mint 0 akkor ebben a mappában már vannak fotók.
    if(response.length>0)
    {
      return console.log("A mappában már szerepelnek fotók! "+response.length);
    }

    //megnézzük milyen mappák vannak a másolandó elemekkel teli mappacsoprtban.
    fs.readdir(itemsDir,(err,folders)=>
    {
      // Ha nem tudja megnézni a mappa tartalmát akkor az errorral fog visszatérrni.
      if(err)
      {
        return console.log(err);
      }
      // ha nagyobb a folders length-je mint 2 vagy egyenlő 0-val akkor hibával tér vissza.
      //hiszen csak 2 mappának kellenen hogy legyen accommodations,experiences.
      if(folders.length>2 && files.folders == 0)
      {
        return console.log("probléma adódott a belső mappákkal, kérem ellnőrizze!" + console.log(folders));
      }

      // a path segítségel az adatokból össze rakjuk a kezdeti elérési útvonalat.
      let fullFolder = path.join(itemsDir,placeType);

      // for ciklust állítunk a képek számolásához.
      for(let i=0;i<10;i++)
      {
        // megnézzök az accommodation/experiences mappa tartalmát.
        fs.readdir(fullFolder,(err,files)=>
        {
          // Ha nem tudja megnézni a mappa tartalmát akkor az errorral fog visszatérrni.
          if(err)
          {
            return console.log(err);
          }
          // Megnézzük a files length-jét, ha nem nagyoobb mint 0 akkor ebben a mappában nincsenek fotók.
          if(files.length==0)
          {
            return console.log("Ellenőrizze a mappa tartalmát! "+files);
          }
          else{
            let originalFile = path.join(itemsDir,placeType,files[i]);
            let copied = path.join(folderDir,i>=9?`0${i+1}.png`:`00${i+1}.png`);

            fs.copyFile(originalFile,copied,(err)=>
            {
              // Ha nem tudja másolni a fájlt akkor az errorral fog visszatérrni.
              if(err)
              {
                return console.log(err);
              }
              
              fs.unlink(originalFile,(err)=>
              {
                console.log(i);
                console.log(originalFile);
                console.log(copied);
                // Ha nem tudja törölni a fájlt akkor az errorral fog visszatérrni.
                if(err)
                {
                  return console.log(err);
                }
                console.log("A művelet befejeződött.");
              })
            })
          }
        })
      }
    })
  })
}

// putFilesToFolders(itemsDir,"accommodations",`../frontend/src/images/countries/india/cities/mumbai/accommodations/mumbai_sea_view_apartment`);

// db.query(
//   "SELECT `countries`.`name` AS `country_name`," +
//   "`cities`.`name` AS `city_name`," +
//   "`accommodations`.`name` AS `accommodation_name`," +
//   "`experiences`.`name` AS `experience_name` FROM `countries`" +
//   "INNER JOIN `cities`" +
//   "ON `cities`.`country_id` = `countries`.`id`" +
//   "INNER JOIN `accommodations`" +
//   "ON `cities`.`id` = `accommodations`.`city_id`" +
//   "LEFT JOIN `experiences`" +
//   "ON `cities`.`id` = `experiences`.`city_id`", 
//   (err, datas) => {
//     if (err) {
//       console.error("Hiba a datas beolvasásakor", err);
//       return;
//     }

//     console.log(datas);
//     for(let i=0;i<datas.length;i++)
//     { 
//       fs.mkdirSync(`../frontend/src/images/countries/${convertStrings(datas[i].country_name)}`+
//         `/cities/${convertStrings(datas[i].city_name)}`+
//         `/accommodations/${convertStrings(datas[i].accommodation_name)}`,{recursive:true});
      
//       if(datas[i].experience_name != null)
//       {
//         fs.mkdirSync(`../frontend/src/images/countries/${convertStrings(datas[i].country_name)}`+
//           `/cities/${convertStrings(datas[i].city_name)}`+
//           `/experiences/${convertStrings(datas[i].experience_name)}`,{recursive:true});
//       }
//     }
//     process.exit(0);
//   }
// )

