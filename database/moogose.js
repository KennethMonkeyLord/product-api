const mongoose = require('mongoose');

mongoose.connect('mongodb://localhost/products', { useNewUrlParser: true, useUnifiedTopology: true });

const db = mongoose.connection;
db.on('error', console.error.bind(console, 'connect error:'));
db.once('open', () => {
  console.log('connect mongoose \\(T/..\\T)/');
});

const styleSchema = mongoose.Schema({
  style_name: String,
  price: Number,
  onSale: Boolean,
  default: Boolean,
  photos: [{
    url: String,
    thumbnail: Boolean,
  }],
  skus: [{
    size: String,
    qty: Number,
  }],
});

const Style = mongoose.model('Repo', styleSchema);

const repoSchema = mongoose.Schema({
  name: String,
  slogan: String,
  description: String,
  category: String,
  default_price: Number,
  relate_product_id: [Number],
  styles: [Style],
});

const Repo = mongoose.model('Repo', repoSchema);