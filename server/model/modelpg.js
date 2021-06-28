const pool = require('../../database/pool');

const getAll = (page = 1, count = 5) => pool
  .connect()
  .then((client) => {
    const query = 'SELECT * FROM products LIMIT $2 OFFSET $1';
    return client
      .query(query, [page * count - count, count])
      .then((res) => {
        client.release();
        return res.rows;
      })
      .catch((err) => {
        client.release();
        throw err;
      });
  });

const getProduct = (id) => pool
  .connect()
  .then((client) => {
    // const query = `SELECT
    //     p.product_id, p.name, p.slogan,p.description, p.category, p.default_price,
    //     json_build_array(json_build_object('feature',f.feature, 'value', f.feature_value)) as features
    //   from products p
    //   inner join features f on f.product_id=p.product_id
    //   where p.product_id=$1`;
    // const query = `
    // select row_to_json(t), p.product_id
    // from
    // (select f.feature, f.feature_value as value
    //     from features f
    //     where f.product_id =$1) t
    //     join products p
    //     on product_id=$1
    // `;
    const query = `
      select p.product_id as id, p.name, p.slogan,p.description, p.category, p.default_price,
      array_agg(row_to_json(t)) as features
      from products p
      inner join (select f.feature, f.feature_value as value from features f where f.product_id=$1) t on $1 = p.product_id
      group by p.product_id
    `;
    return client
      .query(query, [id])
      .then((res) => {
        client.release();
        return res.rows[0];
      })
      .catch((err) => {
        client.release();
        throw err;
      });
  });

const getRelated = (id) => pool
  .connect()
  .then((client) => {
    const query = `
    select array_agg(related_id) as key
    from related
    where product_id=$1
    `;
    return client
      .query(query, [id])
      .then((res) => {
        client.release();
        return res.rows[0].key;
      })
      .catch((err) => {
        client.release();
        throw err;
      });
  });

const getStyle = (id) => pool
  .connect()
  .then((client) => {
    // const query = `select
    //   s.style_id,
    //   array_agg(row_to_json(t)) as photos
    //   from styles s
    //   inner join (
    //     select p.thumbnail_url, p.url
    //     from photos p
    //     where p.style_id=s.style_id) t on s.product_id=$1
    //     group by s.style_id
    // `;
    // const query = `
    // select
    //   s.style_id,
    //   json_build_object(
    //     skus.id, json_build_object(
    //       'size', skus.size,
    //       'qty', skus.qty
    //     )
    //     ) skus
    //   from styles s
    //   inner join skus on skus.style_id = s.style_id
    //   where s.product_id = $1
    // `;
    const query = `
    select s.product_id,
      (select json_agg(
        json_build_object(
          'style_id', s.style_id,
          'name', s.name,
          'original_price', s.original_price,
          'sale_price', s.sale_price,
          'default?', s.default_,
          'photos', (select json_agg(
            json_build_object(
              'thumbnail_url', p.thumbnail_url,
              'url', p.url))
            from photos p
            where p.style_id = s.style_id),
          'skus', (select json_object_agg(
            skus.id, json_build_object(
              'size', skus.size,
              'quantity', skus.qty))
            from skus
            where skus.style_id=s.style_id)))
      from styles s
      where s.product_id=$1) results
    from styles s
    where s.product_id=$1
    group by s.product_id
    `;

    return client
      .query(query, [id])
      .then((res) => {
        client.release();
        return res.rows[0];
      })
      .catch((err) => {
        client.release();
        throw err;
      });
  });
module.exports = {
  getAll,
  getProduct,
  getRelated,
  getStyle,
};
