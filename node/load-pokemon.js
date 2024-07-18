const { JSDOM } = require("jsdom");
const fs = require("fs");
const path = require("path");

// pokemon-list.htmlを読み込む
const filePath = path.join(__dirname, "pokemon-list.html");

// ファイルを非同期で読み込む関数を定義
function readFileAsync(filePath) {
  return new Promise((resolve, reject) => {
    fs.readFile(filePath, "utf8", (err, data) => {
      if (err) {
        reject(err);
      } else {
        resolve(data);
      }
    });
  });
}

// 非同期関数でファイルを読み込み、結果を返す関数を定義
async function readPokemonList() {
  try {
    const data = await readFileAsync(filePath);
    const dom = new JSDOM(data);
    const doc = dom.window.document;

    const items = doc.querySelectorAll(".loadItem");
    const result = Array.from(items).map((item, index) => {
      const id = index;
      const name = item.querySelector(".name__loadItem").textContent;
      const img = item.querySelector("img").src;
      return { id, name, img };
    });

    const jsonContent = JSON.stringify(result, null, 2);
    return jsonContent; // 結果を返す
  } catch (error) {
    console.error("Error reading file:", error);
    throw error; // エラーを再スローする
  }
}

// メインの処理を非同期関数で実行
async function main() {
  try {
    // readPokemonList を呼び出して結果を取得
    const jsonContent = await readPokemonList();

    // 取得した結果をファイルに書き込む
    fs.writeFile("pokemon-data.json", jsonContent, "utf8", (err) => {
      if (err) {
        throw err; // エラーを再スローする
      }
      console.log("ファイルが正常に書き込まれました。");
    });
  } catch (error) {
    console.error("Error:", error);
  }
}

// main 関数を呼び出して実行
main();
