const express = require("express");
const app = express();
const mysql = require("mysql");
const fs = require("node:fs");
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

let datas = [];

db.query(
  "SELECT `countries`.`name` AS `country_name`," +
  "`cities`.`name` AS `city_name`," +
  "`accommodations`.`name` AS `accommodation_name`," +
  "`experiences`.`name` AS `experience_name` FROM `countries`" +
  "INNER JOIN `cities`" +
  "ON `cities`.`country_id` = `countries`.`id`" +
  "INNER JOIN `accommodations`" +
  "ON `cities`.`id` = `accommodations`.`city_id`" +
  "LEFT JOIN `experiences`" +
  "ON `cities`.`id` = `experiences`.`city_id`", 
  (err, result) => {
    if (err) {
      console.error("Hiba a apartmans beolvasásakor", err);
      return;
    }
    
    datas = result;
    console.log(datas);

    
  }
)

