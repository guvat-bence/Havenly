const express = require('express')
const app = express()
const mysql = require('mysql')
const cors = require('cors')
const port = 3000

app.use(cors())

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'havenly'
})

db.connect(err => {
  if (err) {
    console.error('Hiba a MySQL kapcsolódáskor:', err);
    return;
  }
  console.log('Sikeres MySQL kapcsolat!');
})

app.listen(port, () => {
  console.log(`index.js is running on port ${port}`);
})


app.get('/accommodations', (req, res) => {
  db.query('SELECT `accommodations`.`id`, `accommodations`.`owner_id`,'+
                   '`accommodations`.`name`,`accommodations`.`folder_name`,'+ 
                   '`accommodations`.`size`,'+
                   '`accommodations`.`country_id`, `accommodations`.`city_id`,'+
                   '`accommodations`.`price`, `accommodations`.`description`,'+
                   '`cities`.`name` AS `city_name`'+
          'FROM `accommodations`'+
          'INNER JOIN `cities`'+
          'ON `accommodations`.`city_id` = `cities`.`id`', (err,result) => {
    if(err){
      console.error("Hiba a accommodations beolvasásakor", err);
      res.status(500).send("Adatbázis hiba");
      return;
    }
    res.json(result);
  })
})

app.get('/experiences', (req, res) => {
  db.query('SELECT `experiences`.`id`,`experiences`.`name`,'+
                   '`experiences`.`country_id`, `experiences`.`city_id`,'+
                   '`experiences`.`price`, `experiences`.`description`,'+
                   '`cities`.`name` AS `city_name`'+
          'FROM `experiences`'+
          'INNER JOIN `cities`'+
          'ON `experiences`.`city_id` = `cities`.`id`', (err,result) => {
    if(err){
      console.error("Hiba a experiences beolvasásakor", err);
      res.status(500).send("Adatbázis hiba");
      return;
    }
    res.json(result);
  })
})

app.get('/accommodations/randCountryID', (req, res) => {
  db.query(`SELECT DISTINCT accommodations.country_id,
                            countries.name AS 'country_name' 
            FROM accommodations 
            INNER JOIN countries 
            ON accommodations.country_id = countries.id
            ORDER BY RAND() LIMIT 5`,(err,result) => {
    if(err){
      console.error("Hiba az accommodations beolvasásakor", err);
      res.status(500).send("Adatbázis hiba");
      return;
    }
    res.json(result);
  })
})

app.get('/experiences/randCountryID', (req, res) => {
  db.query(`SELECT DISTINCT experiences.country_id,
                            countries.name AS 'country_name' 
            FROM experiences 
            INNER JOIN countries 
            ON experiences.country_id = countries.id
            ORDER BY RAND() LIMIT 5`,(err,result) => {
    if(err){
      console.error("Hiba a experiences beolvasásakor", err);
      res.status(500).send("Adatbázis hiba");
      return;
    }
    res.json(result);
  })
})

