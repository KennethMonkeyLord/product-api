const mysql = require('mysql');

const con = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '123456',
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
