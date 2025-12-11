const express = require("express");
const app = express();
const mysql = require("mysql");
const port = 3100;

const db = mysql.createConnection({
  host:"localhost",
  user:"root",
  password:"",
  database:"havenly"
})

db.connect(err=>{
  if(err)
    {
      console.error("Hiba a Mysql szerver csatlakozáskor:",err);
      return;
    }
    console.log("Sikeres csatlakozás!");
})

app.listen(port,()=>{
  console.log(`folders_maker is running on port ${port}`);
})

app.get('/datas',(req,res,next)=>
{
  db.query()
})