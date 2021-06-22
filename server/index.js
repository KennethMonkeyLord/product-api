const express = require('express');

const app = express();
const PORT = 3003 || process.env.PORT;

app.use(express.json());

app.listen(PORT, () => {
  console.log(`Server listening on port: ${PORT}`);
});
