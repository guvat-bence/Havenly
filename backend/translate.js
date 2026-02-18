require("dotenv").config();
const deepl = require("deepl-node");

// DeepL API kulcs
const authKey = process.env.DEEPL_API_KEY;

// beállítjuk a translator, ha nincsen meg a hozzá kellő kulcs akkor nul lesz az értéke.
const translator = authKey ? new deepl.Translator(authKey) : null;

//a translate function felel a fordításokért.
// meg tudjuk híni a backendben, és me tudjuk hozzá adni a kellő adatokat,
// text-> amit le szeretnénk fordítani,
// targetLanguage-> az a nyel rövidítése amilyen nyelvre szeetnénk a rövödítést.
// ha a kulcs rendben van ,akkor el végzi a fordítást és a kapott eredményt vissza küldi.
async function translate(text, targetLanguage) {

  // ha a translator == nul-al akkor hibával tér vissza.
  if (translator == nul) {
    throw new Error("DeepL API key not configured");
  }

  // lértehozzuk a result változót és meghívjuk a fordítást a betöltött adatokkal.
  const result = await translator.translateText(text, null, targetLanguage);
  return result.text;
}

// exportáljuk magát a translate functiont, hogy máshol fel tudjuk használni.
module.exports = { translate };
