import { watch, reactive } from "vue";

//Hívja le a localstorage adatai
export let user = reactive({
  id: localStorage.getItem("id") ?? null,
  firstname: localStorage.getItem("first_name") ?? "",
  lasttname: localStorage.getItem("last_name") ?? "",
  middlename: localStorage.getItem("middle_name")=="null"?"":localStorage.getItem("middle_name") ?? "",
  phone_number: localStorage.getItem("phone_number") ?? "",
  email: localStorage.getItem("email") ?? "",
  gender: localStorage.getItem("gender") ?? "",
  user_type: localStorage.getItem("user_type") ?? "", 
  cardNumber: localStorage.getItem("card_number")=="null"?"":localStorage.getItem("card_number") ?? "",
  expirationYear: localStorage.getItem("expirationYear") ?? "",
  expirationMonth: localStorage.getItem("expirationMonth") ?? ""
})

// Ha a user adatai változnak akkor a localstorage-be mentse el
watch(user,(newUser) => { 
  localStorage.setItem("id",newUser.id); 
  localStorage.setItem("first_name", newUser.firstname); 
  localStorage.setItem("last_name", newUser.lasttname); 
  localStorage.setItem("middle_name", newUser.middlename); 
  localStorage.setItem("phone_number", newUser.phone_number);
  localStorage.setItem("email", newUser.email)
  localStorage.setItem("gender", newUser.gender); 
  localStorage.setItem("user_type", newUser.user_type); 
  localStorage.setItem("card_number", newUser.cardNumber); 
  localStorage.setItem("expirationMonth", newUser.expirationMonth); 
  localStorage.setItem("expirationYear", newUser.expirationYear);

  console.log(newUser);
  
},{deep:true});
