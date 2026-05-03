const express = require("express");
const app = express();
const mysql = require("mysql");
const cors = require("cors");
const fs = require('node:fs/promises');
const {translate} = require("./translate.js");
const { rmdir } = require("node:fs");
const port = 3000;
require("dotenv").config();

app.use(cors());
app.use(express.json());

// Adatbázis csatlakozás
const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "havenly",

  typeCast: function (field, next) {
    if (field.type === "DATE" || field.type === "DATETIME") {
      return field.string();
    }
    return next();
  }
});

db.connect((err) => {
  if (err) {
    console.error("Hiba a MySQL kapcsolódáskor:", err);
    process.exit(1);
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
                   accommodations.guest_number, accommodations.bedroom,
                   accommodations.bed, accommodations.bathroom,
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
          message: "Ez az email már foglalt!"
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
              message: "Ez a telefonszám már foglalt!"
            });
          }

          let insertQuery = `INSERT INTO users (first_name, 
                                               last_name, 
                                               middle_name, 
                                               email, 
                                               password, 
                                               phone_number,
                                               gender) 
                                   VALUES (?, ?, ?, ?, ?, ?, ?)`
          // Insert parancs végrehajtása ha miden rendben van
          db.query(
            insertQuery,
            [
              data.firstname,
              data.lastname,
              data.middlename,
              data.email,
              data.password,
              data.phone_number,
              data.gender
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
      expiration
    FROM users
    WHERE email = ? AND password = ?
    LIMIT 1`;

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

// Currency lekérdezése
app.get('/getCurrency', (req, res) => {
  let command = 'SELECT `id`, `full_name`, `multiplier`, `shorted_name` FROM `currency`';
  db.query(command, (err,result) => {
    if(err){
      console.error("Hiba a lekérdezéskor.:",err);
      res.status(500).send("Adatbázis hiba");
      return;
    }
    res.json(result);
  })
})

//Lekérdezi az aktív szállások helyét egyszer
app.get('/createAccomodationLocationList',(req, res) => {
  const query = ` SELECT DISTINCT countries.name AS country_name, 
                  countries.id AS country_id,
                  cities.name AS city_name,
                  cities.id AS city_ID
                  FROM countries 
                  INNER JOIN cities ON cities.country_id = countries.id 
                  INNER JOIN accommodations ON cities.id = accommodations.city_id 
                  LEFT JOIN experiences ON cities.id = experiences.city_id `;
  db.query(query, (err,result) => {
    if(err){
      res.status(401).send("Sikertelen beolvasás")
      return;
    }

    res.send(result);
    
  })
});

//Lekérdezi az aktív élmények helyét egyszer
app.get('/createExpreienceLocationList',(req, res) => {
  const query = ` SELECT DISTINCT countries.name AS country_name, 
                  countries.id AS country_id,
                  cities.name AS city_name,
                  cities.id AS city_ID
                  FROM countries 
                  INNER JOIN cities ON cities.country_id = countries.id 
                  INNER JOIN experiences ON cities.id = experiences.city_id`;
  db.query(query, (err,result) => {
    if(err){
      res.status(401).send("Sikertelen beolvasás")
      return;
    }

    res.send(result);
    
  })
});

app.get("/getReports", (req, res) => {
  db.query(`SELECT  r.id,
                    r.user_id,
                    CONCAT(
                        u.first_name,
                        ' ',
                        u.middle_name,
                        ' ',
                        u.last_name
                    ) AS full_name,
                    r.message,
                    r.message_type,
                    r.item_type,
                    r.item_id,
                    r.status,
                    IF(
                        r.item_type = 'accommodations' OR o.item_type = 'accommodations',
                        a.name,
                        e.name
                    ) AS place_name,
                    IF(o.item_type IS NULL, r.item_type, o.item_type) AS place_type
                FROM
                    report r
                INNER JOIN users u ON
                    r.user_id = u.id
                LEFT JOIN opinions o ON
                    r.item_type = 'opinions' AND r.item_id = o.id
                LEFT JOIN accommodations a ON
                    (
                        (
                            r.item_type = 'opinions' AND o.item_type = 'accommodations' AND o.item_id = a.id
                        ) OR(
                            r.item_type = 'accommodations' AND r.item_id = a.id
                        )
                    )
                LEFT JOIN experiences e ON
                    (
                        (
                            r.item_type = 'opinions' AND o.item_type = 'experiences' AND o.item_id = e.id
                        ) OR(
                            r.item_type = 'experiences' AND r.item_id = e.id
                        )
                    )
                WHERE 1`,(err, reports) => {
    if (err) {
      return res.status(500).send('Sikertelen lekérdezés');
    }
    res.send(reports)
  });
});

//az adott szálláshoz való history elemek lehívása.
app.get("/history/:id", (req, res) => {
  let id = req.params.id;
  db.query(`SELECT 
              rent_beginning,
              rent_end
            FROM history
            WHERE accommodation_id = ?`,
    id,
    (err, result) => {
      if (err) {
        console.error("Hiba a history beolvasásakor", err);
        res.status(500).send("Adatbázis hiba");
        return;
      }
      res.json(result);
    }
  );
});

// Ennek segítségével fordítjuk le a hozzáaszólásokat az adott szállás/élménynél.
function getOpinions(item_id,item_type,language_short_name,callback)
{
  // Lehívjuk az összes véleményt a a megadott elemhez .
  db.query(`SELECT
                id,
                opinion
            FROM opinions
            WHERE item_id = ? AND item_type = ?`,
    [item_id,item_type],
    (err,result)=>
    {
      // Hiba estén vissza küldjük a hibát.
      if(err)
      {
        callback(err);
        return;
      }
      // Végigmegyünk az összes véleményen.
      for(let x of result)
      {
        // megnézzük, hogy az adott véleményke van e már fórdítása.
        db.query(`SELECT
                      language_short_name,
                      item_id,
                      item_name
                  FROM translations
                  WHERE item_id = ? AND item_name = ? AND language_short_name = ?`,
          [x.id,'opinions',language_short_name],
          async (err,response)=>
          {
            // Hiba estén vissza küldjük a hibát.
            if(err){
              callback(err);
              return;
            }

            // Ha van fordítása akkor csak vissza térünk
            if(response.length>0)
            {
              return;
            }
            else
            {
              // átállítja a nyelv potos nevét a fordítás miatt.
              let current_language_short_name =  language_short_name;
              if(current_language_short_name == "en")
              {
                current_language_short_name = "en-GB";
              }
            
              // megpróbálja a fordítást elkészíteni
              try
              {
                
                // az elem véleményét lefordítatjuk.
                let translated_opinion = await translate(
                  x.opinion,
                  current_language_short_name
                );

                // ezek után pedig feltöltjük az új adatoakat a translatins táblába.
                db.query(`INSERT INTO translations(
                            language_short_name,
                            item_id,
                            item_name,
                            item)
                          VALUES(?,?,?,?)`,
                [language_short_name,x.id,'opinions',translated_opinion],
                (err,result)=>
                  {
                    // ha hiba vna, ide jön be.
                    if(err)
                    {
                      callback(`Hiba a(z) translations-ba való feltöltéskor: ${err}`);
                      return;
                    }

                    return;
                });
              }
              // ha bármi hiba adódna az api-al akkor ide lép be
              catch(err)
              {
                callback(`Sikertelen vélemény fordítás. ${err}`);
                return;
              }
            }
        })
      }
  })
}

// Mgnézi hogy van e az adott elemnek fordítása, ha van akkor betölti. 
// Ha nincs akkor meg nézi, hogy az erdeti adatai ugyan azon a nyelven annak e feltöltve,
// mint amilyen nyelven van az oldal, és ha megtalálta akkor betölti.
// Ha nem talál semmit, akkor a tárgy id-ja alapján lekéri az alap információit,
// majd meghívja a translate.js-t és lefordíttatja az adott adatokat.
// ha nem ütközik hibába a fordítás során akkor,
// eltárolja az adatoakt az adatbázosban.
app.post("/translate",(req,res)=>
{
  // 1. szakasz, az adot tárgy fordításának megkeresése a translations táblában.
  let datas = req.body;
  db.query(`SELECT
              item_id,
              item
            FROM translations
            WHERE item_id = ? AND item_name = ? AND language_short_name = ?`,
    [datas.item_id,datas.item_name,datas.language_short_name],
    (err,result)=>
    {
      // Hiba esetén ide jön be.
      if(err)
      {
        console.error("Hiba a translations beolvasásakor",err);
        res.status(500).send("Adatbázis hiba");
        return;
      }
      // ha megtalálja visszaküldi és vele együtt a translationed üzenetet is.
      if(result.length>0)
      {

        // Meghívjuk az adott szállás/élmény fordítását
        getOpinions(datas.item_id,datas.item_name,datas.language_short_name,(err,result)=>
        {
          // Ha hiba van kiíratjuk.
          if(err)
          {
            console.log(err);
          }
        })

        res.json({
          message:"translationed",
          data: result
        });
        return;
      }
      // ha nem találja a fordítását akkor ide jön be.
      else
      {
        // 2. szakasz, ha nem talált a foordítását,
        //  akkor meg nézi hátha az eredeti adata ugyan azon a nyelven van-e írva,
        //  mint az oldal nyelve.
        db.query(`SELECT
                    id,
                    language_short_name,
                    name,
                    description
                  FROM ${datas.item_name}
                  WHERE id = ? AND language_short_name = ?`,
          [datas.item_id,datas.language_short_name],
          (err,result)=>
          {
            // Hib esetén ide megy be.
            if(err)
            {
              console.error("Hiba a(z) accommodations/experiences beolvasásakor",err);
              res.status(500).send("Adatbázis hiba");
              return;
            }

            // ha megtalálja akkor vissza köldi az adatokat és az original üzenetet.
            if(result.length>0)
            {
              res.json({
                message:"original",
                data: result
              });
              return;
            }
           // ha nem találja így sem, akkor ide jön be.
            else{
              // 3. szakasz, itt az elem azonosítójával megkeresi az elemet,
              // ezek után pedig lefordítja az adott nyelvre,
              // és feltölti a translations táblába.
              db.query(`SELECT
                          id,
                          name,
                          description
                  FROM ${datas.item_name}
                  WHERE id = ?`,
                [datas.item_id],
               async (err,result)=>
                {
                  // ha hibába ütlözik de megy bele.
                  if(err)
                  {
                    console.error("Hiba a(z) accommodations/experiences beolvasásakor",err);
                    res.status(500).send("Adatbázis hiba");
                    return;
                  }

                  // átállítja a nyelv potos nevét a fordítás miatt.
                  let current_language_short_name =  datas.language_short_name;
                  if(current_language_short_name == "en")
                  {
                    current_language_short_name = "en-GB";
                  }
                
                  // megpróbálja a fordítást elkészíteni
                  try
                  {
                    // az elem nevét lefordítatjuk.
                    let translated_name = await translate(
                      result[0]["name"],
                      current_language_short_name
                    );

                    // az elem szövegét is lefordítatjuk.
                    let translated_description = await translate(
                      result[0]["description"],
                      current_language_short_name
                    );

                    // egy json file-t csinálunk a lefodított adatokból
                    let item = JSON.stringify(
                    {
                      title:translated_name,
                      description:translated_description
                    });
                    
                    // ezek után pedig feltöltjük az új adatoakat a translatins táblába.
                    db.query(`INSERT INTO translations(
                                language_short_name,
                                item_id,
                                item_name,
                                item)
                              VALUES(?,?,?,?)`,
                    [datas.language_short_name,datas.item_id,datas.item_name,item],
                    (err,result)=>
                      {
                        // ha hiba vna, ide jön be.
                        if(err)
                        {
                          console.error("Hiba a(z) translations-ba való feltöltéskor",err);
                          res.status(500).send("Adatbázis hiba");
                          return;
                        }
                        // visszaköldi az értéket a feltöltésről
                        res.json(result);
                        return;
                      });
                  }
                  // ha bármi hiba adódna az api-al akkor ide lép be
                  catch
                  {
                    res.json({
                      message:"failed"
                    });
                    return;
                  }
              });
            }
          });
      }
  });
});

app.get("/getCardNetwork",(req,res) => {
  db.query(`SELECT id, 
                   network_name, 
                   prefix 
            FROM card_networks`, (err,result) => {
    
    if(err){
      console.error("Hiba a history beolvasásakor", err);
      res.status(500).send("Adatbázis hiba");
      return;
    }

    res.json(result);
    return;
  })
});

app.post("/updateUser/Privacy",(req,res)=>{
  let datas = req.body;
  datas.middleName=datas.middleName!=""?datas.middleName:null;
  db.query(`UPDATE users
            SET first_name = ?,
                last_name = ?,
                middle_name = ?,
                email = ?,
                phone_number = ?,
                gender = ?
            WHERE id = ?`,
           [datas.firstName,datas.lastName,datas.middleName,
            datas.email,datas.phoneNum,datas.gender,datas.userID],
           (err,response)=>{
    if(err)
    {
      if(err.code='ER_DUP_ENTRY')
      {
        res.json({message: "reservedEmail"});
        return;
      }
      else{
        console.error("Hiba a user módosításakor", err);
        res.status(500).send("Adatbázis hiba");
        return;
      }
    }

    if(response.affectedRows)
    {
      db.query(`SELECT
                  first_name,
                  last_name,
                  middle_name,
                  email,
                  phone_number,
                  gender,
                  card_number,
                  expiration
                FROM users
                WHERE id =?`,[datas.userID],(err,datas)=>{
        
        if(err)
        {
          console.error("Hiba a user beolvasásakor", err);
          res.status(500).send("Adatbázis hiba");
          return;
        }

        res.json([response,datas]);
        return;
      })
    }
  })
});

app.post("/updateUser/Card",(req,res)=>{
  let datas = req.body;
  db.query(`UPDATE users
            SET card_number =?,
                expiration = ?
            WHERE id = ?`,
           [datas.cardNumber,`${datas.expirationMonth}/${datas.expirationYear}`,
            datas.userID],
           (err,response)=>{
    if(err)
    {
      console.error("Hiba a user módosításakor", err);
      res.status(500).send("Adatbázis hiba");
      return;
    }

    if(response.affectedRows)
    {
      db.query(`SELECT
                  first_name,
                  last_name,
                  middle_name,
                  email,
                  phone_number,
                  gender,
                  card_number,
                  expiration
                FROM users
                WHERE id =?`,[datas.userID],(err,datas)=>{
        
        if(err)
        {
          console.error("Hiba a user beolvasásakor", err);
          res.status(500).send("Adatbázis hiba");
          return;
        }

        res.json([response,datas]);
        return;
      })
    }
  });  
});

app.post("/updateUser/allDatas",(req,res)=>{
  let datas = req.body;
  db.query(`UPDATE users
            SET first_name = ?,
                last_name = ?,
                middle_name = ?,
                email = ?,
                phone_number = ?,
                gender = ?,
                card_number = ?,
                expiration = ?
            WHERE id = ?`,
           [datas.model.firstName,datas.model.lastName,datas.model.middleName,
            datas.model.email,datas.model.phoneNum,datas.model.gender,
            datas.card.cardNumber,`${datas.card.expirationMonth}/${datas.card.expirationYear}`,
            datas.model.userID],
           (err,response)=>{
    if(err)
    {
      if(err.code='ER_DUP_ENTRY')
      {
        res.json({message: "reservedEmail"});
        return;
      }
      else{
        console.error("Hiba a user módosításakor", err);
        res.status(500).send("Adatbázis hiba");
        return;
      }
    }

    if(response.affectedRows)
    {
      db.query(`SELECT
                  first_name,
                  last_name,
                  middle_name,
                  email,
                  phone_number,
                  gender,
                  card_number,
                  expiration
                FROM users
                WHERE id =?`,[datas.model.userID],(err,datas)=>{
        
        if(err)
        {
          console.error("Hiba a user beolvasásakor", err);
          res.status(500).send("Adatbázis hiba");
          return;
        }

        res.json([response,datas]);
        return;
      })
    }
  });  
});

app.post("/updateUser/Password",(req,res)=>{
  let datas = req.body;
  db.query(`SELECT id
            FROM users
            WHERE password = ? AND id = ?`,
            [datas.currentPassword,datas.userID],(err,result)=>{

    if(err)
    {
      console.error("Hiba a jelszó beolvasásakor", err);
      res.status(500).send("Adatbázis hiba");
      return;
    }

    if(result.length>0)
    {
      db.query(`UPDATE users
                SET password = ?
                WHERE id = ?`,
                [datas.newPassword,datas.userID],(err,response)=>{

        if(err)
        {
          console.error("Hiba a jelszó beolvasásakor", err);
          res.status(500).send("Adatbázis hiba");
          return;
        }

        res.json(response);
        return;

      });
      
    }
    else{
      res.json({message: "incorrectPassword"});
      return;
    }
    })
});

app.post("/deleteUser",(req,res)=>{
 let datas = req.body.userID;
  db.query(`DELETE FROM users
            WHERE id = ?`,
          [datas],(err,result)=>{
    if(err)
    {
     console.error("Hiba a user törlésekor", err);
     res.status(500).send("Adatbázis hiba");
     return;
    }

    res.json({message: "deletedProfile"});
    return;

  });  
});

app.post("/deleteCardDatas",(req,res)=>{
  let datas = req.body;
  
  db.query(`UPDATE users
            SET card_number =NULL,
                expiration = NULL
            WHERE id = ?`,
           [datas.userID],
           (err,response)=>{
    if(err)
    {
      console.error("Hiba a user módosításakor", err);
      res.status(500).send("Adatbázis hiba");
      return;
    }

    if(response.affectedRows)
    {
      db.query(`SELECT
                  first_name,
                  last_name,
                  middle_name,
                  email,
                  phone_number,
                  gender,
                  card_number,
                  expiration
                FROM users
                WHERE id =?`,[datas.userID],(err,datas)=>{
        
        if(err)
        {
          console.error("Hiba a user beolvasásakor", err);
          res.status(500).send("Adatbázis hiba");
          return;
        }

          res.json({message: "deletedCardDatas"});
          return;
      })
    }
  })
});

app.post("/rentAccomodation", (req, res) => {
  let data = req.body;

  db.query(`SELECT id FROM history
                      WHERE accommodation_id = ? AND(
                            rent_beginning = ? OR rent_end = ? 
                                               OR( rent_beginning < ? AND rent_end > ?))`,
    [data.accommodation_id,
     data.rent_beginning,
     data.rent_end,
     data.rent_beginning,
     data.rent_end], (err, result) => {
      if (err) {
        res.status(500).send('Adatbázis hiba')
        return;
      }
      if (result.length > 0) {
        res.status(500).send('Már van lefoglalva erre az időpontra');
      }
      else {
        db.query(`INSERT INTO history (renter_id, 
                                 owner_id, 
                                 accommodation_id, 
                                 price,
                                 rent_beginning, 
                                 rent_end) VALUES (?,?,?,?,?,?)`,
                                [data.id,
                                  data.owner_id,
                                  data.accommodation_id,
                                  data.price,
                                  data.rent_beginning,
                                  data.rent_end], (err, history)=>{
            
          if (err) {
            res.status(500).send("Adatbázis hiba");
            return;
          }
          else {

            db.query(`INSERT INTO messages(
                        from_user_id,
                        to_user_id,
                        message)
                      VALUES(?,?,?)`,
                      [data.owner_id,data.id,data.message],
                      (err,result)=>{

              if(err)
              {
                res.status(500).send("Adatbázis hiba");
                return;
              }

              if(result.affectedRows>0)
              {
                db.query(`INSERT INTO billing_address(
                            user_id,
                            history_id,
                            name,
                            email,
                            phone_number,
                            city,
                            postal_code,
                            billing_address1,
                            billing_address2,
                            card_number)
                          VALUES(?,?,?,?,?,?,?,?,?,?)`,
                        [data.owner_id,history.insertId,
                          (`${data.firstName} ${data.middleName} ${data.lastName}`),
                          data.email,data.phoneNum,data.city,data.postalCode,
                          data.address1,data.address2,data.cardnumber],
                        (err,result)=>{

                  if(err)
                  {
                    res.status(500).send("Adatbázis hiba");
                    return;
                  }

                  if(result.affectedRows>0)
                  {
                    res.send('Sikeres foglalás')
                    return;
                  }
                })
              }
            })
          }
        })
      }
    }
  )
});

// Vélemények lekérdezése
app.post("/opinions",(req,res) =>{

  let datas = req.body;

  db.query(`SELECT
              opinions.id,
              opinions.user_id,
              opinions.item_id,
              translations.item AS opinion,
              opinions.rate,
              users.first_name,
              users.last_name,
              IF(users.middle_name IS NOT NULL,users.middle_name,'') AS middle_name
            FROM opinions
            INNER JOIN users 
            ON opinions.user_id = users.id
            INNER JOIN translations
            ON translations.item_id = opinions.id
            WHERE opinions.item_id = ? 
                  AND opinions.item_type = ?
                  AND translations.language_short_name = ? 
                  AND translations.item_name = ?`,
            [datas.item_id,datas.item_type,datas.language_short_name,'opinions'],(err,response)=>{

    if(err)
    {
      res.status(500).send("Adatbázis hiba");
      return;
    }

    if(response.length >0)
    {
      res.json(response);
      return;
    }
    else
    {
      db.query(`SELECT  opinions.id,
                        opinions.user_id,
                        opinions.item_id,
                        opinions.opinion,
                        opinions.rate,
                        users.first_name,
                        users.last_name, 
                        IF(users.middle_name IS NOT NULL,users.middle_name,'') AS middle_name
                FROM opinions
                INNER JOIN users
                ON opinions.user_id = users.id
                WHERE opinions.item_id = ? 
                      AND opinions.item_type = ?
                      AND language_short_name = ?`,
                  [datas.item_id,datas.item_type,datas.language_short_name],(err,result)=>{

          if (err) {
            res.status(500).send("Adatbázis hiba");
            return;
          }

          res.json(result);
      });
    }
  })
})

// Foglalási előzmények lekérése egy adott felhasználóhoz
app.post("/getHistory", (req,res) => {

  const id = req.body.id;

  db.query(`SELECT  h.id,
                    h.renter_id,
                    h.owner_id,
                    a.name AS accommodation_name,
                    a.folder_name AS accommodation_folder_name,
                    c.name AS city_name,
                    co.name AS country_name,
                    h.accommodation_id,
                    h.price,
                    h.rent_date,
                    h.rent_beginning,
                    h.rent_end
                FROM
                    history h
                INNER JOIN accommodations a
                ON h.accommodation_id = a.id 
                INNER JOIN cities c 
                ON a.city_id = c.id
                INNER JOIN countries co 
                ON a.country_id = co.id
                WHERE
                    renter_id = ?`,[id],(err,result) => {
    if(err){
      res.status(500).send(err)
      return
    }

    res.send(result)
  })
})

// Probléma küldése
app.post("/sendProblem",(req,res) =>{
  let datas = req.body;

  db.query(
    `INSERT INTO report(
          user_id,
          message,
          message_type,
          item_type,
          item_id)
      VALUES(?,?,?,?,?)`,
      [datas.user_id,datas.description,
       datas.name,datas.type,datas.item_id],
       (err,result)=>{
    if(err){
      res.status(500).send(err);
      return;
    }
    if(result.affectedRows){
      res.json(result);
      return;
    }
  })
})

// Vélemény küldése
app.post("/sendOpinion",(req,res) =>{
  let datas = req.body;

  db.query(
    `INSERT INTO opinions(
          user_id,
          item_id,
          item_type,
          opinion,
          rate,
          language_short_name)
      VALUES(?,?,?,?,?,?)`,
      [datas.user_id,datas.item_id,
       datas.item_type,datas.message,
       datas.rate,datas.language_short_name],
       (err,result)=>{
    if(err){
      res.status(500).send(err);
      return;
    }
    if(result.affectedRows){
      res.json(result);
      return;
    }
  })
})

// Vélemény módosítása
app.post("/editOpinion",(req,res) =>{
  let datas = req.body;

  db.query(
    ` UPDATE opinions
      SET
          user_id = ?,
          item_id = ?,
          item_type =?,
          opinion = ?,
          rate = ?,
          language_short_name = ?
      WHERE id = ?`,
      [datas.user_id,datas.item_id,
       datas.item_type,datas.message,
       datas.rate,datas.language_short_name,
       datas.opinion_id],
       (err,result)=>{
    if(err){
      res.status(500).send(err);
      return;
    }
    if(result.affectedRows){
      res.json(result);
      return;
    }
  })
})

// Vélemény törlése
app.post("/deleteOpinion",(req,res) =>{
  let datas = req.body;
  
  db.query(
    ` DELETE FROM opinions
      WHERE id = ?`,
      [datas.opinion_id],
       (err,result)=>{
    if(err){
      res.status(500).send(err);
      return;
    }
    if(result.affectedRows){
      res.json(result);
      return;
    }
  })
})

// Kontaktok lekérezése
app.get("/getContacts/:id",(req,res)=>{
  let id = req.params.id;

  db.query(`SELECT DISTINCT
              messages.from_user_id,
              users.first_name,
              users.last_name, 
              IF(users.middle_name IS NOT NULL,users.middle_name,'') AS middle_name,
              messages.to_user_id
            FROM messages
            INNER JOIN users
            ON users.id = messages.from_user_id
            WHERE messages.to_user_id = ?
            ORDER BY users.first_name`,
            [id],(err,contacts)=>{
    if(err)
    {
      res.status(500).send("Adatbázis hiba");
      return;
    }

    res.json(contacts);
    return;
  })
})   

// Üzenetek lekérezése
app.post("/getMessages",(req,res)=>{
  let datas = req.body;

  db.query(`SELECT 
              messages.from_user_id,
              messages.to_user_id,
              messages.sended_time,
              messages.message
            FROM messages
            INNER JOIN users
            ON users.id = messages.from_user_id
            WHERE (messages.to_user_id = ? AND messages.from_user_id = ?) OR (messages.to_user_id = ? AND messages.from_user_id = ?)
            ORDER BY messages.sended_time`,
          [datas.from_id,datas.to_id,datas.to_id,datas.from_id,],(err,messages)=>{
    if(err)
    {
      res.status(500).send("Adatbázis hiba");
      return;
    }

    res.json(messages);
    return;
  })
})

// Üzenet küldése
app.post("/sendMessages",(req,res)=>{
  let datas = req.body;
  
  db.query(`INSERT INTO messages(
              from_user_id,
              to_user_id,
              message)
            VALUES(?,?,?)`,
            [datas.from_id,datas.to_id,datas.message],
            (err,result)=>{
    
    if(err)
    {
      res.status(500).send("Adatbázis hiba");
      return;
    }
    res.json(result);
    return;
  })
})

app.get("/getUserItems/:id",(req,res)=>{
  let id = req.params.id;

  db.query(`SELECT
              accommodations.id,
              accommodations.language_short_name,
              accommodations.owner_id,
              accommodations.country_id,
              accommodations.city_id,
              accommodations.name,
              accommodations.folder_name,
              accommodations.size,
              accommodations.price,
              accommodations.guest_number,
              accommodations.bedroom,
              accommodations.bed,
              accommodations.bathroom,
              accommodations.description,
              countries.name AS 'country_name',
              cities.name AS 'city_name',
              'accommodations' AS 'table_type'
            FROM accommodations
            INNER JOIN countries
            ON countries.id = country_id
            INNER JOIN cities
            ON cities.id = city_id
            WHERE owner_id = ?`,[id],(err,accommodations)=>{
    if(err)
    {
      res.status(500).send("Adatbázis hiba");
      return;
    }

    db.query(`SELECT
                experiences.id,
                experiences.uploaded_id,
                experiences.language_short_name,
                experiences.country_id,
                experiences.city_id,
                experiences.name,
                experiences.folder_name,
                experiences.price,
                experiences.description,
                countries.name AS 'country_name',
                cities.name AS 'city_name',
                'experiences' AS 'table_type'
              FROM experiences
              INNER JOIN countries
              ON countries.id = country_id
              INNER JOIN cities
              ON cities.id = city_id
              WHERE uploaded_id = ?`,[id],(err,experiences)=>{

      if(err)
      {
        res.status(500).send("Adatbázis hiba");
        return;
      }

      if(experiences.length==0)
      {
        res.json(accommodations);
        return;
      }

      res.json({accommodations,experiences});
      return;

    })
  })
})

  app.post("/removeItem", (req,res) => {
    const data = req.body;
    db.query(`DELETE FROM ${data.table} WHERE id = ?`, [data.id], 
            (err,result) => {
      if(err)
        return res.status(500).send('Adatbázis hiba...')

      if(result.affectedRows === 0)
        return res.status(500).send('Sikertelen törlés')

      fs.rm(`../frontend/public/${data.path}`,
                {recursive: true}, (err) => {
        return res.status(500).send('Sikertelen mappa törlés')
      })
      return res.send('Sikeres törlés')
    })
  })