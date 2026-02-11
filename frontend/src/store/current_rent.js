import { reactive, watch } from "vue"

export let rent = reactive(
{
  accommodation_full_price: localStorage.getItem("accommodation_full_price"),
  rent_beginning: localStorage.getItem("rent_beginning"),
  rent_end: localStorage.getItem("rent_end"),
  accommodation_path: localStorage.getItem("accommodation_path"),
  guests: localStorage.getItem("guests_number"),
  accommodation: localStorage.getItem("accommodation")
})

watch(rent,(datas)=>
{
  localStorage.setItem('accommodation_full_price', datas.accommodation_full_price);
  localStorage.setItem('rent_beginning',datas.rent_beginning);
  localStorage.setItem('rent_end',datas.rent_end);
  localStorage.setItem('accommodation_path',datas.accommodation_path);
  localStorage.setItem("guests_number",datas.guests);
  localStorage.setItem('accommodation',datas.accommodation);

})

console.log(rent.guests)