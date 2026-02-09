import { createI18n } from "vue-i18n"
import hu from "./locales/hu.json"
import en from "./locales/en.json"
import it from "./locales/it.json"
import de from "./locales/de.json"
import ja from "./locales/ja.json"

export let i18n = createI18n(
{
  legacy:false,
  locale:'hu',
  fallbackLocale:"en",
  messages:
  {
    hu,
    en,
    it,
    de,
    ja
  }
})