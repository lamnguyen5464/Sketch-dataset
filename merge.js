const fs = require("fs");

try {
  const data = fs.readFileSync("list_file.txt", "utf8");
  const lines = data.split("\n");

  const result = {};
  lines.forEach((fileName) => {
    if (fileName) {
      const fileData = fs.readFileSync(`data/${fileName}`, "utf8");
      const linesOfFile = fileData.split("\n");
      result[fileName.replace(".ndjson", "")] = linesOfFile;
    }
  });

  fs.writeFileSync("merged_data.json", JSON.stringify(result, null, 2));
} catch (err) {
  console.error(err);
}
