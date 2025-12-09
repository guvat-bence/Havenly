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
    console.error('Hiba a MySQL kapcsolódáskor:', err)
    return
  }
  console.log('Sikeres MySQL kapcsolat!')
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})


app.get('/country', (req, res) => {
  db.query('SELECT * FROM country', (err,result) => {
    if(err){
      console.error("Hiba a country beolvasásakor", err)
      res.status(500).send("Adatbázis hiba")
      return
    }
    res.json(result)
  })
})