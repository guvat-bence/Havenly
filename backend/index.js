const express = require("express");
const app = express();
const mysql = require("mysql");
const cors = require("cors");
const port = 3000;

app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "havenly",
});

db.connect((err) => {
  if (err) {
    console.error("Hiba a MySQL kapcsolódáskor:", err);
    return;
  }
  console.log("Sikeres MySQL kapcsolat!");
});

app.listen(port, () => {
  console.log(`index.js is running on port ${port}`);
});

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

app.get("/experiences", (req, res) => {
  db.query(
    "SELECT `experiences`.`id`,`experiences`.`name`,`experiences`.`folder_name`," +
      "`experiences`.`country_id`, `experiences`.`city_id`," +
      "`experiences`.`price`, `experiences`.`description`," +
      "`cities`.`name` AS `city_name`" +
      "FROM `experiences`" +
      "INNER JOIN `cities`" +
      "ON `experiences`.`city_id` = `cities`.`id`",
    (err, result) => {
      if (err) {
        console.error("Hiba a experiences beolvasásakor", err);
        res.status(500).send("Adatbázis hiba");
        return;
      }
      res.json(result);
    }
  );
});

app.get("/accommodations/randCountryID", (req, res) => {
  db.query(
    `SELECT DISTINCT accommodations.country_id,
                            countries.name AS 'country_name' 
            FROM accommodations 
            INNER JOIN countries 
            ON accommodations.country_id = countries.id
            ORDER BY RAND() LIMIT 5`,
    (err, result) => {
      if (err) {
        console.error("Hiba az accommodations beolvasásakor", err);
        res.status(500).send("Adatbázis hiba");
        return;
      }
      res.json(result);
    }
  );
});

app.get("/experiences/randCountryID", (req, res) => {
  db.query(
    `SELECT DISTINCT experiences.country_id,
                            countries.name AS 'country_name' 
            FROM experiences 
            INNER JOIN countries 
            ON experiences.country_id = countries.id
            ORDER BY RAND() LIMIT 5`,
    (err, result) => {
      if (err) {
        console.error("Hiba a experiences beolvasásakor", err);
        res.status(500).send("Adatbázis hiba");
        return;
      }
      res.json(result);
    }
  );
});

app.post('/register', (req, res) => {
  const data = req.body.model;

  // 1) Email ellenőrzés
  db.query(
    'SELECT id FROM users WHERE email = ? LIMIT 1',
    [data.email],
    (err, emailRows) => {
      if (err) return res.status(500).send("Adatbázis hiba");

      if (emailRows.length > 0) {
        return res.json({
          success: false,
          message: "Ez az email már foglalt"
        });
      }

      // 2) Telefonszám ellenőrzés
      db.query(
        'SELECT id FROM users WHERE phone_number = ? LIMIT 1',
        [data.phone_number],
        (err, phoneRows) => {
          if (err) return res.status(500).send("Adatbázis hiba");

          if (phoneRows.length > 0) {
            return res.json({
              success: false,
              message: "Ez a telefonszám már foglalt"
            });
          }
          // Insert parancs végrehajtása ha miden rendben van
          db.query(
            'INSERT INTO users (first_name, last_name, middle_name, email, password, phone_number) VALUES (?, ?, ?, ?, ?, ?)',
            [
              data.firstname,
              data.lastname,
              data.middlename,
              data.email,
              data.password,
              data.phone_number
            ],
            (err, result) => {
              if (err) {
                console.log("MySQL hiba:", err);
                return res.status(500).json({
                  success: false,
                  message: "Adatbázis hiba"
                });
              }

              return res.json({
                success: true,
                message: "Sikeres regisztráció!",
                insertedId: result.insertId
              });
            }
          );
        }
      );
    }
  );
});
