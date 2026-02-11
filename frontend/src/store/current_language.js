import { reactive, watch } from "vue";


export let selectedLanguage = reactive(
{
  locale_name: localStorage.getItem('locale_name') || null
})

watch(selectedLanguage,(datas)=>
{
  localStorage.setItem('locale_name',datas.locale_name);
})