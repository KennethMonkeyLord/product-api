const model = require('../model/model');

const getAll = (req, res) => {
  const { page, count } = req.query;
  model
    .getAll(page, count, (err, data) => {
      if (err) {
        res.status(500);
        res.send(err);
      } else {
        res.status(200);
        res.send(data);
      }
    });
};

const getProudct = (req, res) => {
  const { product_id } = req.params;
  model.getProudct(product_id, (err, data) => {
    if (err) {
      res.status(500);
      res.send(err);
    } else {
      res.status(200);
      res.send(data);
    }
  });
};

const getStyles = (req, res) => {
  // const id = req.originalUrl.slice(req.originalUrl.length - 6, req.originalUrl.length - 1);
  // console.log(id);
  const id = req.params.product_id;
  model.getStyles(id, (err, data) => {
    // console.log(data,'datawqe')
    if (err) {
      res.status(500);
      res.send(err);
    } else {
      res.status(200);
      res.send(data);
    }
  });
};

const getRelated = (req, res) => {
  // console.log(req, 'ds');
  // const id = req.originalUrl.slice(req.originalUrl.length - 6, req.originalUrl.length - 1);
  const id = req.params.product_id;
  model.getRelated(id, (err, data) => {
    if (err) {
      res.status(500);
      res.send(err);
    } else {
      res.status(200);
      res.send(data);
    }
  });
};

module.exports = {
  getAll,
  getProudct,
  getStyles,
  getRelated,
};
