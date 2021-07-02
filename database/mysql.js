const mysql = require('mysql');
const { mysqlKey } =require ('./key');

const con = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: mysqlKey,
  database: 'products',
});

con.connect((err) => {
  if (err) {
    console.error(err);
  } else {
    console.log('connected to mysql!!');
  }
});

module.exports = con;
