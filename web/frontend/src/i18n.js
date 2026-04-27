import { createI18n } from "vue-i18n"
import {selectedLanguage} from "@/store/current_language.js"
import allLanguages from "@/json/languages.json"
import hu from "./locales/hu.json"
import en from "./locales/en.json"
import it from "./locales/it.json"
import de from "./locales/de.json"
import ja from "./locales/ja.json"
import sr from "./locales/sr.json"

// definiáljuk defaultLocale-t és a browserLanguage-t
// defaultLocale az alapvető nyelv
// browserLanguage pedig a böngésző nyelve
let defaultLocale = "en";
let browserLanguage = navigator.language;

// ha van eltárolva nyelv akkor az lesz az alapértelmezett
if(selectedLanguage.locale_name!=null)
{
  defaultLocale = selectedLanguage.locale_name
}
// ha nincs akkor meg próbálja bellítani a böngészőő nyelvét alapértelmezettre
// ha a böngésző nyelve nincsen a mi nyelvein kközött akkor szimplán az alapvető érték lesz a kiválasztott nyelvv
else
{
  for(let x in allLanguages)
  {
    if(x == browserLanguage.split("-")[0])
    {
      defaultLocale = browserLanguage.split("-")[0];
      selectedLanguage.locale_name = browserLanguage.split("-")[0];
      break;
    }
  }
  if(defaultLocale == "en")
  {
    selectedLanguage.locale_name = defaultLocale;
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
    sr
  }
})