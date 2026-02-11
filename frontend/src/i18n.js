import { createI18n } from "vue-i18n"
import {selectedLanguage} from "@/store/current_language.js"
import allLanguages from "@/json/languages.json"
import hu from "./locales/hu.json"
import en from "./locales/en.json"
import it from "./locales/it.json"
import de from "./locales/de.json"
import ja from "./locales/ja.json"
import rs from "./locales/rs.json"


let defaultLocale = "en";
let browserLanguage = navigator.language;

if(browserLanguage === "sr")
{
  browserLanguage = "rs";
}


if(selectedLanguage.locale_name!=null)
{
  defaultLocale = selectedLanguage.locale_name
}
else
{
  for(let x in allLanguages)
  {
    if(x == browserLanguage.split("-")[0])
    {
      defaultLocale = browserLanguage;
      selectedLanguage.locale_name = browserLanguage.split("-")[0];
      break;
    }
  }
}


export let i18n = createI18n(
{
  legacy:false,
  locale:defaultLocale,
  fallbackLocale:"en",
  messages:
  {
    hu,
    en,
    it,
    de,
    ja,
    rs
  }
})