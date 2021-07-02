DROP DATABASE IF EXISTS productdb;

CREATE DATABASE productdb;

\c productdb;

DROP TABLE IF EXISTS products, styles, photos, features, related, skus;

CREATE TABLE IF NOT EXISTS products (
  product_id INT PRIMARY KEY,
  name VARCHAR(100),
  slogan VARCHAR(1000),
  description VARCHAR(1000),
  category VARCHAR(100),
  default_price VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS styles (
  style_id INT PRIMARY KEY,
  product_id INT,
  name VARCHAR(100),
  sale_price VARCHAR(100),
  original_price VARCHAR(100),
  default_ BOOLEAN,
  FOREIGN KEY(product_id) REFERENCES products(product_id)
);

CREATE TABLE IF NOT EXISTS features (
  feature_id INT PRIMARY KEY,
  product_id INT,
  feature VARCHAR(100),
  feature_value VARCHAR(100),
  FOREIGN KEY(product_id) REFERENCES products(product_id)
);

CREATE TABLE IF NOT EXISTS photos (
  photo_id INT PRIMARY KEY,
  style_id INT,
  url TEXT,
  thumbnail_url TEXT,
  FOREIGN KEY(style_id) REFERENCES styles(style_id)
);

CREATE TABLE IF NOT EXISTS related (
  id INT PRIMARY KEY,
  product_id INT,
  related_id INT,
  FOREIGN KEY(product_id) REFERENCES styles(style_id)
);

CREATE TABLE IF NOT EXISTS skus (
  id INT PRIMARY KEY,
  style_id INT,
  size VARCHAR(10),
  qty INT,
  FOREIGN KEY(style_id) REFERENCES styles(style_id)
);


-- http://localhost:3001/products/?page=1&count=5 11ms;
-- http://localhost:3001/products/?page=2&count=5 36ms;
-- http://localhost:3001/products/?page=1&count=10 16ms;
-- http://localhost:3001/products/?page=10&count=10 18ms;
-- http://localhost:3001/products/?page=10&count=20 45ms;
CREATE INDEX product_id_index ON products (product_id);
-- http://localhost:3001/products/?page=1&count=5 27ms;
-- http://localhost:3001/products/?page=2&count=5 7ms;
-- http://localhost:3001/products/?page=1&count=10 30ms;
-- http://localhost:3001/products/?page=10&count=10 35ms;
-- http://localhost:3001/products/?page=10&count=20 18ms;

--http://localhost:3001/products/25711/related 189ms;
--http://localhost:3001/products/255467/related 297ms;
--http://localhost:3001/products/65067/related 243ms;
--http://localhost:3001/products/111237/related 254ms;
--http://localhost:3001/products/511237/related 249ms;
CREATE INDEX relate_id_index ON related (product_id);
--http://localhost:3001/products/25711/related 22ms;
--http://localhost:3001/products/255467/related 59ms;
--http://localhost:3001/products/65067/related 33ms;
--http://localhost:3001/products/111237/related 22ms;
--http://localhost:3001/products/511237/related 36ms;


-- http://localhost:3001/products/511237/ 1717ms;
-- http://localhost:3001/products/57/ 161ms;
-- http://localhost:3001/products/5547/ 206ms;
-- http://localhost:3001/products/55747/ 148ms;
-- http://localhost:3001/products/154747/ 160ms
CREATE INDEX feature_id_index ON features (product_id);
-- http://localhost:3001/products/511237/ 54ms;
-- http://localhost:3001/products/57/ 16ms;
-- http://localhost:3001/products/5547/ 31ms;
-- http://localhost:3001/products/55747/ 27ms;
-- http://localhost:3001/products/154747/ 52ms;


-- http://localhost:3001/products/26548/styles 14.1s
-- http://localhost:3001/products/4568/styles 4.67s
-- http://localhost:3001/products/145/styles 4.88s
-- http://localhost:3001/products/68/styles 4.67s
-- http://localhost:3001/products/8/styles 20.53s
CREATE INDEX style_id_index ON styles (style_id);
-- http://localhost:3001/products/26548/styles 9.21s
-- http://localhost:3001/products/4568/styles 5.53s
-- http://localhost:3001/products/145/styles 4.7s
-- http://localhost:3001/products/68/styles 4.8s
-- http://localhost:3001/products/8/styles 21.1s
CREATE INDEX photo_id_index ON photos (style_id);
-- http://localhost:3001/products/26548/styles 4.41s
-- http://localhost:3001/products/4568/styles 2.43s
-- http://localhost:3001/products/145/styles 3.17s
-- http://localhost:3001/products/68/styles 2.58s
-- http://localhost:3001/products/8/styles 9.69s
CREATE INDEX skus_id_index ON skus (style_id);
-- http://localhost:3001/products/26548/styles 319ms
-- http://localhost:3001/products/4568/styles 340ms
-- http://localhost:3001/products/145/styles 263ms
-- http://localhost:3001/products/68/styles 320ms
-- http://localhost:3001/products/8/styles 281ms
CREATE INDEX style_product_id_index ON styles (product_id);
-- http://localhost:3001/products/26548/styles 26ms
-- http://localhost:3001/products/4568/styles 15ms
-- http://localhost:3001/products/145/styles 28ms
-- http://localhost:3001/products/68/styles 37ms
-- http://localhost:3001/products/8/styles 16ms
CREATE INDEX style_product_com_id_index ON styles (product_id, style_id);


-- CREATE INDEX test1_id_index ON test1 (id) USING B-tree.

\COPY products(product_id, name, slogan, description, category, default_price) FROM '/Users/kenneth/Desktop/hackreacter/product-api2/data/product.csv' WITH (DELIMITER ',', FORMAT csv, HEADER true);
\COPY styles(style_id, product_id, name, sale_price, original_price, default_) FROM '/Users/kenneth/Desktop/hackreacter/product-api2/data/styles.csv' WITH (DELIMITER ',', FORMAT csv, HEADER true);
\COPY features(feature_id, product_id, feature, feature_value) FROM '/Users/kenneth/Desktop/hackreacter/product-api2/data/features.csv' WITH (DELIMITER ',', FORMAT csv, HEADER true);
\COPY photos(photo_id, style_id, url, thumbnail_url) FROM '/Users/kenneth/Desktop/hackreacter/product-api2/data/photos.csv' WITH (DELIMITER ',', FORMAT csv, HEADER true);
\COPY related(id, product_id, related_id) FROM '/Users/kenneth/Desktop/hackreacter/product-api2/data/related.csv' WITH (DELIMITER ',', FORMAT csv, HEADER true);
\COPY skus(id, style_id, size, qty) FROM '/Users/kenneth/Desktop/hackreacter/product-api2/data/skus.csv' WITH (DELIMITER ',', FORMAT csv, HEADER true);

-- \i '/Users/kenneth/Desktop/hackreacter/product-api/productSchemaPG.sql'