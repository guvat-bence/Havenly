const express = require("express");
const router = express.Router();
const deepl = require('deepl-node');

const authKey = process.env.DEEPL_API_KEY;
const translator = authKey ? new deepl.Translator(authKey) : null;

router.post("/", async (req,res) => {
  try{

    let {text, targetLanguage} = req.body;

    if (translator == null){

      return res.status(500).json({ error: "DeepL API key not configured" });
    }
    let result = await translator.translateText(
      text,
      null,
      targetLanguage
    );

    res.json({translation: result.text});
  }
  catch(err)
  {
    console.log(err);
    res.status(500).json({error: "Translation failed"});
  }

});

module.exports = router;