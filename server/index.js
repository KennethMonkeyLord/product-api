const express = require('express');
// const db = require('../database/mysql');
// const product = require('./controller/controller');
const controllerpg = require('./controller/controllerpg');

const app = express();
const PORT = 3001 || process.env.PORT;

app.use(express.json());

app.listen(PORT, () => {
  console.log(`Server listening on port: ${PORT}`);
});

// app.get('/products', product.getAll);
// app.get('/products/:product_id', product.getProudct);
// app.get('/products/:product_id/styles', product.getStyles);
// app.get('/products/:product_id/related', product.getRelated);

app.get('/products', controllerpg.getAll);
app.get('/products/:product_id', controllerpg.getProduct);
app.get('/products/:product_id/styles', controllerpg.getStyle);
app.get('/products/:product_id/related', controllerpg.getRelated);
