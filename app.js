const express = require("express");

const app = express();
const port = process.env.PORT || 3000;

app.get("/", (req, res) => {
  res.json({
    message: "Container security demo",
    status: "running"
  });
});

app.listen(port, () => {
  console.log(`Application listening on port ${port}`);
});