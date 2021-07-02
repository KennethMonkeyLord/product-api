const { Pool } = require('pg');
const  { poolKey } = require('./key');

const pool = new Pool({
  user: 'postgres',
  host: 'host.docker.internal',
  database: 'productdb',
  password: poolKey,
  port: 5432,
});

module.exports = pool;
