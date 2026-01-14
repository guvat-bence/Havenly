const express = require("express");
const app = express();
const mysql = require("mysql");
const cors = require("cors");
const port = 3000;

app.use(cors());
app.use(express.json());

// Adatbázis csatlakozás
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

// Szállások le kérdezése
app.get('/accommodations', (req, res) => {
  db.query('SELECT `accommodations`.`id`, `accommodations`.`owner_id`,'+
                   '`accommodations`.`name`,`accommodations`.`folder_name`,'+ 
                   '`accommodations`.`size`,'+
                   '`accommodations`.`country_id`, `accommodations`.`city_id`,'+
                   '`accommodations`.`price`, `accommodations`.`description`,'+
                   '`cities`.`name` AS `city_name`,'+
                   '`countries`.`name` AS `country_name` '+
          'FROM `accommodations` '+
          'INNER JOIN `cities` '+
          'ON `accommodations`.`city_id` = `cities`.`id` '+
          'INNER JOIN `countries` '+
          'ON `accommodations`.`country_id` = `countries`.`id`', (err,result) => {
    if(err){
      console.error("Hiba a accommodations beolvasásakor", err);
      res.status(500).send("Adatbázis hiba");
      return;
    }
    res.json(result);
  })
});

//random generáljon country id-t és írja ki a hozzá rendelt szállásokat
app.get("/accommodations/randCountryID", (req, res) => {
  db.query(`SELECT DISTINCT accommodations.country_id,
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

//top 5 szállás le kérdezése
app.get("/accommodations/top5", (req, res) => {
  db.query('SELECT COUNT(`history`.`accommodation_id`) AS `rented_times`,'+
                  '`accommodations`.`id`,'+
                  '`accommodations`.`country_id`,'+
                  '`countries`.`name` '+
           'FROM `history` '+
           'INNER JOIN `accommodations` '+
           'ON `history`.`accommodation_id` = `accommodations`.`id` '+
           'INNER JOIN `countries` '+
           'ON `countries`.`id` = `accommodations`.`country_id` '+
           'GROUP BY `history`.`accommodation_id` '+
           'HAVING COUNT(`accommodations`.`id`) > 1 '+
           'ORDER BY COUNT(`accommodations`.`id`) DESC '+
           'LIMIT 5',
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

// Egy szállás le kérdezése country id alapján
app.get('/accommodations/country/:id', (req, res) => {
  let country_id = req.params.id;  
  db.query(`SELECT accommodations.id, accommodations.owner_id,
                   accommodations.name,accommodations.folder_name, 
                   accommodations.size,
                   accommodations.country_id, accommodations.city_id,
                   accommodations.price,accommodations.description,
                   cities.name AS city_name,
                   countries.name AS country_name
          FROM accommodations
          INNER JOIN cities
          ON accommodations.city_id = cities.id
          INNER JOIN countries
          ON accommodations.country_id = countries.id
          WHERE  accommodations.country_id = ?`,
          [country_id],
          (err,result) => {
            if(err){
              console.error("Hiba a accommodations beolvasásakor", err);
              res.status(500).send("Adatbázis hiba");
              return;
            }
            res.json(result);
          }
  );
});

// Egy szállás le kérdezése id alapján
app.get('/accommodations/:id', (req, res) => {
  let accommodation_id = req.params.id;  
  db.query(`SELECT accommodations.id, accommodations.owner_id,
                   accommodations.name,accommodations.folder_name, 
                   accommodations.size,
                   accommodations.country_id, accommodations.city_id,
                   accommodations.price,accommodations.description,
                   cities.name AS city_name,
                   countries.name AS country_name
          FROM accommodations
          INNER JOIN cities
          ON accommodations.city_id = cities.id
          INNER JOIN countries
          ON accommodations.country_id = countries.id
          WHERE accommodations.id = ?`,
          [accommodation_id],
          (err,result) => {
            if(err){
              console.error("Hiba a accommodations beolvasásakor", err);
              res.status(500).send("Adatbázis hiba");
              return;
            }
            res.json(result);
          }
  );
});


//Szállások részletei le kérdezése
app.get("/accommodations/accommodations_details/:id",(req, res) =>{
  let accommodation_id = req.params.id;  
  db.query(`SELECT
              apartman_id,
              coffee_maker,
              kettle,
              microwave,
              basic_spices,
              dishes,
              extra_bed_linen,
              darkening,
              night_lamp,
              towels,
              hair_dryer,
              smart_tv,
              bluetooth_speaker,
              usb_charger,
              work_table,
              suitcase_rack,
              iron,
              safe,
              balcony,
              board_games,
              free_wifi,
              parking_lot
            FROM
                accommodations_details
            WHERE apartman_id = ?`,
            [accommodation_id],
          (err,result)=>{
            if(err)
            {
              console.error("Hiba a accommodations_details beolvasásakor",err);
              res.status(500).send("Adatbázis hiba");
              return;
            }
            res.json(result);
          }
  );
})


// Élmények le kérdezése
app.get("/experiences", (req, res) => {
  db.query(
    "SELECT `experiences`.`id`,`experiences`.`name`,`experiences`.`folder_name`," +
      "`experiences`.`country_id`, `experiences`.`city_id`," +
      "`experiences`.`price`, `experiences`.`description`," +
      "`cities`.`name` AS `city_name`," +
      "`countries`.`name` AS `country_name` "+
      "FROM `experiences`" +
      "INNER JOIN `cities`" +
      "ON `experiences`.`city_id` = `cities`.`id` "+
      "INNER JOIN `countries` "+
      "ON `experiences`.`country_id` = `countries`.`id`",
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

//random generáljon country id-t és írja ki a hozzá rendelt élményeket
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

// Élmények le kérdezése country id alapján
app.get("/experiences/country/:id", (req, res) => {
  let country_id = req.params.id
  db.query(
    `SELECT experiences.id,experiences.name,experiences.folder_name,
      experiences.country_id,experiences.city_id,
      experiences.price, experiences.description,
      cities.name AS city_name,
      countries.name AS country_name
      FROM experiences
      INNER JOIN cities
      ON experiences.city_id = cities.id
      INNER JOIN countries
      ON experiences.country_id = countries.id
      WHERE experiences.country_id = ?`,
      [country_id],
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


// Élmények le kérdezése
app.get("/experiences/:id", (req, res) => {
  let experience_id = req.params.id
  db.query(
    `SELECT experiences.id,experiences.name,experiences.folder_name,
      experiences.country_id,experiences.city_id,
      experiences.price, experiences.description,
      cities.name AS city_name,
      countries.name AS country_name
      FROM experiences
      INNER JOIN cities
      ON experiences.city_id = cities.id
      INNER JOIN countries
      ON experiences.country_id = countries.id
      WHERE experiences.id = ?`,
      [experience_id],
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

// Regisztréciós route
app.post('/register', (req, res) => {
  let data = req.body;
  if(data.password.length > 40){
    return res.status(400).json({
      success: false,
      message: 'Túl hosszú jelszót adtál meg'
    })
  }
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

          let insertQuery = `INSERT INTO users (first_name, 
                                               last_name, 
                                               middle_name, 
                                               email, 
                                               password, 
                                               phone_number) 
                                   VALUES (?, ?, ?, ?, ?, ?)`
          // Insert parancs végrehajtása ha miden rendben van
          db.query(
            insertQuery,
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

// Bejelentkezés route
app.post('/login', (req, res) => {
  let data = req.body;

  const query = `
    SELECT
      id,
      first_name,
      last_name,
      middle_name,
      email,
      password,
      phone_number,
      gender,
      user_type,
      card_number,
      expiration,
      cvv
    FROM users
    WHERE email = ? AND password = ?
    LIMIT 1
  `;

  db.query(query, [data.email, data.password], (err, account) => {
    if (err) {
      return res.status(500).send('Adatbázis hiba');
    }

    if (account.length === 0) {
      return res.json({
        success: false,
        message: 'Az email-cím vagy a jelszó hibás'
      });
    }

    return res.json({
      success: true,
      user: account[0]
    });
  });
});

app.get('/getCurrency', (req, res) => {
  let command = 'SELECT `id`, `name`, `multiplier`, `shorted_name` FROM `currency`';
  db.query(command, (err,result) => {
    if(err){
      console.error("Hiba a lekérdezéskor.:",err);
      res.status(500).send("Adatbázis hiba");
      return;
    }
    res.json(result);
  })
})