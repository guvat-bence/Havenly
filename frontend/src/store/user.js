const { watch } = require("vue");

export let user = reactive({
  id: localStorage.getItem("id") ?? "",
  firstname: localStorage.getItem("first_name") ?? "",
  lasttname: localStorage.getItem("last_name") ?? "",
  middlename: localStorage.getItem("middle_name") ?? "",
  phone_number: localStorage.getItem("phone_number") ?? "",
  gender: localStorage.getItem("gender") ?? "",
  user_type: localStorage.getItem("user_type") ?? "", 
  cardNumber: localStorage.getItem("card_number") ?? "",
  expiration: localStorage.getItem("expiration") ?? "",
  cvv: localStorage.getItem("cvv") ?? ""
})

watch( () => user, (newUser) => { 
  localStorage.setItem("id", newUser.id); 
  localStorage.setItem("first_name", newUser.firstname); 
  localStorage.setItem("last_name", newUser.lasttname); 
  localStorage.setItem("middle_name", newUser.middlename); 
  localStorage.setItem("phone_number", newUser.phone_number);
  localStorage.setItem("gender", newUser.gender); 
  localStorage.setItem("user_type", newUser.user_type); 
  localStorage.setItem("card_number", newUser.cardNumber); 
  localStorage.setItem("expiration", newUser.expiration); 
  localStorage.setItem("cvv", newUser.cvv); }, 
);