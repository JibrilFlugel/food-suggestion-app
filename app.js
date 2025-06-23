const express = require("express");
const bodyParser = require("body-parser");
const { exec } = require("child_process");

const app = express();
app.use(bodyParser.json());
app.use(express.static("public"));

app.post("/suggest", (req, res) => {
  const ingredients = req.body.ingredients.map((i) => `'${i}'`).join(",");
  const command = `swipl -s recipes.pl -g "findall(R, suggest_recipe([${ingredients}], R), List), writeln(List)." -t halt`;

  exec(command, (error, stdout) => {
    if (error) return res.status(500).send("Error: " + error.message);
    const cleaned = stdout
      .trim()
      .replace(/\[|\]|\n/g, "")
      .split(",")
      .map((i) => i.trim());
    res.send({ suggestions: cleaned });
  });
});

app.listen(3000, () => console.log("Server running at http://localhost:3000"));
