const db = require('../../database/mysql');

const getAll = (page = 1, count = 5, callback) => {
  const str = `select * from product limit ${count} offset ${page * count - count}`;
  db.query(str, (err, data) => {
    if (err) {
      console.log(`something wrong on get:${err}`);
    } else {
      callback(null, data);
    }
  });
};

const getProudct = (id, callback) => {
  // const str = `select * from product where id=${id}`;
  // const str1 = `select feature, value from features where product_id =${id}`;

  const str = `
    select
    p.id,
    p.name,
    p.slogan,
    p.description,
    p.category,
    p.default_price,
    json_arrayagg(json_object('feature', f.feature,'value',f.value)) as features
    from product p
    inner join features f
    on f.product_id=p.id
    where p.id=${id}
  `;

  db.query(str, (err, data) => {
    if (err) {
      console.log(`something wrong on get:${err}`);
    } else {
      const array = data[0].features;
      data[0].features = JSON.parse(array);
      callback(null, data[0]);
      // db.query(str1, (err1, data1) => {
      //   if (err1) {
      //     console.log(err1);
      //   } else {
      //     const data2 = { ...data['0'] };
      //     data2.features = data1;
      //     callback(null, data2);
      //   }
      // });
    }
  });
};

const getStyles = (id, callback) => {
  // const str = `
  // select s.id as style_id, s.name, s.sale_price, s.original_price, s.default_ as 'default?',
  // JSON_ARRAYAGG(p.url) as photos
  // from styles as s left join photos as p on style_id=s.id
  // where product_id=${id}
  // GROUP BY s.id`;
  // const str1 = `select thumbnail_url, url from photos where style_id=${50740}`;

//   "photos", (select json_arrayagg(json_object(
//     "url", p.url,
//     "thumbnail_url", p.url
// ))from photos p where p.style_id = s.id),

// "skus", (select json_objectagg(
//   skus.id, (select json_object(
//     "size", skus.size,
//     "quantity", skus.qty
//   ) from skus where skus.stlye_id = s.id)
// )from skus where skus.stlye_id = s.id)

  const str = `
  select
  s.product_id,
  json_arrayagg(json_object(
    "style_id", s.id,
    "name", s.name,
    "original_price", s.original_price,
    "sale_price", s.sale_price,
    "default?", s.default_
        ))  as results

  from styles s
  inner join photos p on p.style_id=s.id
  inner join skus on skus.stlye_id=s.id
  where s.product_id=${id}
  group by s.id
`;
  // const str = `select name from styles where product_id =${id}`

  db.query(str, (err, data) => {
    if (err) {
      console.log(`something wrong on get:${err}`);
    } else {
      const { results } = data[0];
      data[0].results = JSON.parse(results);
      // const { skus } = data[0].results;
      // // data[0].results.skus = JSON.parse(skus);
      // console.log(data[0].results['skus'], 'data');
      console.log(data[0]);
      callback(null, data[0]);
    }
  });
  // console.log(style1,'style1');
};

const getRelated = (id, callback) => {
  const str = `select json_arrayagg(related_product_id) from relate_Product where product_id=${id}`;
  db.query(str, (err, data) => {
    if (err) {
      console.log(`something wrong on get:${err}`);
    } else {
      callback(null, data[0]['json_arrayagg(related_product_id)']);
    }
  });
};

module.exports = {
  getAll,
  getProudct,
  getStyles,
  getRelated,
};
