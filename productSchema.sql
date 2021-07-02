set global local_infile=true;
drop database if exists products;
create database products;

use products
-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'product'
--
-- ---

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `id` INTEGER AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(20) NOT NULL,
  `slogan` VARCHAR(200) NOT NULL,
  `description` VARCHAR(2000) NOT NULL,
  `category` VARCHAR(100) NOT NULL,
  `default_price` INT NOT NULL
);

LOAD DATA local INFILE '../data/product.csv'
INTO TABLE `product`
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- ---
-- Table 'styles'
--
-- ---

DROP TABLE IF EXISTS `styles`;

CREATE TABLE `styles` (
  `style_id` INTEGER AUTO_INCREMENT PRIMARY KEY,
  `product_id` INTEGER NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `sale_price` INTEGER DEFAULT NULL,
  `original_price` INTEGER NOT NULL,
  `default_` BOOLEAN DEFAULT false
);

LOAD DATA local INFILE '../data/styles.csv'
INTO TABLE `styles`
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- ---
-- Table 'category'
--
-- ---

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id` INTEGER AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(50) NOT NULL,
  `product_id` INTEGER NOT NULL
);


-- ---
-- Table 'relate_Product'
--
-- ---

DROP TABLE IF EXISTS `relate_Product`;

CREATE TABLE `relate_Product` (
  `id` INTEGER AUTO_INCREMENT PRIMARY KEY,
  `product_id` INTEGER NOT NULL,
  `related_product_id` INTEGER NOT NULL
);

LOAD DATA local INFILE '../data/related.csv'
INTO TABLE `relate_Product`
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- ---
-- Table 'photos'
--
-- ---

DROP TABLE IF EXISTS `photos`;

CREATE TABLE `photos` (
  `id` INTEGER AUTO_INCREMENT PRIMARY KEY,
  `style_id` INTEGER NOT NULL,
  `url` VARCHAR(3000),
  `thumbnail_url` VARCHAR(3000)
);

LOAD DATA local INFILE '../data/photos.csv'
INTO TABLE `photos`
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- ---
-- Table 'skus'
--
-- ---

DROP TABLE IF EXISTS `skus`;

CREATE TABLE `skus` (
  `id` INTEGER AUTO_INCREMENT PRIMARY KEY,
  `style_id` INTEGER NOT NULL,
  `size` VARCHAR(3) NOT NULL,
  `qty` INTEGER(2) DEFAULT 0
);

LOAD DATA local INFILE '../data/skus.csv'
INTO TABLE `skus`
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- ---
-- Table 'features'
--
-- ---

CREATE TABLE `features` (
  `id` INTEGER AUTO_INCREMENT PRIMARY KEY,
  `product_id` INTEGER NOT NULL,
  `feature` VARCHAR(30) NOT NULL,
  `value` VARCHAR(30) NOT NULL
);

LOAD DATA local INFILE '../data/features.csv'
INTO TABLE `features`
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- ---
-- Foreign Keys
-- ---

-- ALTER TABLE `product` ADD FOREIGN KEY (category) REFERENCES `category` (`id`);
ALTER TABLE `styles` ADD FOREIGN KEY (product_id) REFERENCES `product` (id);
ALTER TABLE `category` ADD FOREIGN KEY (product_id) REFERENCES `product` (id);
ALTER TABLE `relate_Product` ADD FOREIGN KEY (relate_product_id) REFERENCES `product` (id);
ALTER TABLE `relate_Product` ADD FOREIGN KEY (Product_related_id) REFERENCES `product` (id);
ALTER TABLE `photos` ADD FOREIGN KEY (style_id) REFERENCES `styles` (style_id);
ALTER TABLE `skus` ADD FOREIGN KEY (stlye_id) REFERENCES `styles` (style_id);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `product` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `styles` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `category` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `relate_Product` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `photos` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `skus` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `product` (`name`,`slogan`,`description`,`category`,`default_price`) VALUES
-- ('steven','teacher Steven helps you','Teacher Steven knows best',1,5000);
-- INSERT INTO `styles` (`style-name`,`price`,`onSale`,`product_id`,`default?`) VALUES
-- ('steven goes to your home',6000,true,1,false);
-- INSERT INTO `category` (`name`,`product_id`) VALUES
-- ('teacher',1);
-- INSERT INTO `category` (`name`,`product_id`) VALUES
-- ('dog',1);
-- INSERT INTO `relate_Product` (`relate_product_id`,`Product_related_id`) VALUES
-- (1,0);
-- INSERT INTO `photos` (`url`,`style_id`,`thumbnail_url`) VALUES
-- ('http',1,false);
-- INSERT INTO `skus` (`stlyes_id`,`size`,`qty`) VALUES
-- (1,'M',10);