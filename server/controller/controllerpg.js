const modelpg = require('../model/modelpg');

const getAll = (req, res) => {
  const { page, count } = req.query;
  modelpg
    .getAll(page, count)
    .then((data) => {
      // console.log(data);
      res.send(data);
    })
    .catch((err) => {
      res.send(err);
    });
};

const getProduct = (req, res) => {
  console.log(req.params.product_id, 'hi');
  const { product_id } = req.params;
  modelpg
    .getProduct(product_id)
    .then((data) => {
      res.send(data);
    })
    .catch((err) => {
      res.send(err);
    });
};

const getRelated = (req, res) => {
  // console.log(req.params.product_id, 'hi2');
  const { product_id } = req.params;
  modelpg
    .getRelated(product_id)
    .then((data) => {
      res.send(data);
    })
    .catch((err) => {
      res.send(err);
    });
};

const getStyle = (req, res) => {
  // console.log(req.params.product_id, 'hi');
  const { product_id } = req.params;
  modelpg
    .getStyle(product_id)
    .then((data) => {
      res.send(data);
    })
    .catch((err) => {
      res.send(err);
    });
};

module.exports = {
  getAll,
  getProduct,
  getRelated,
  getStyle,
};
