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

-- CREATE INDEX test2_mm_idx ON test2 (id, style_id);
-- CREATE INDEX test1_id_index ON test1 (id) USING B-tree.

\COPY products(product_id, name, slogan, description, category, default_price) FROM '/Users/kenneth/Desktop/hackreacter/product-api/data/product.csv' WITH (DELIMITER ',', FORMAT csv, HEADER true);
\COPY styles(style_id, product_id, name, sale_price, original_price, default_) FROM '/Users/kenneth/Desktop/hackreacter/product-api/data/styles.csv' WITH (DELIMITER ',', FORMAT csv, HEADER true);
\COPY features(feature_id, product_id, feature, feature_value) FROM '/Users/kenneth/Desktop/hackreacter/product-api/data/features.csv' WITH (DELIMITER ',', FORMAT csv, HEADER true);
\COPY photos(photo_id, style_id, url, thumbnail_url) FROM '/Users/kenneth/Desktop/hackreacter/product-api/data/photos.csv' WITH (DELIMITER ',', FORMAT csv, HEADER true);
\COPY related(id, product_id, related_id) FROM '/Users/kenneth/Desktop/hackreacter/product-api/data/related.csv' WITH (DELIMITER ',', FORMAT csv, HEADER true);
\COPY skus(id, style_id, size, qty) FROM '/Users/kenneth/Desktop/hackreacter/product-api/data/skus.csv' WITH (DELIMITER ',', FORMAT csv, HEADER true);