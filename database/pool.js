const { Pool } = require('pg');

const pool = new Pool({
  user: 'kenneth',
  host: 'localhost',
  database: 'productdb',
  port: 5432,
});

module.exports = pool;
