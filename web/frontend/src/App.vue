<script setup>
import Navbar from './components/navbar.vue';
import Myfooter from './components/footer.vue';
import { user } from './store/user';
import axios from 'axios';

if(user.id!="")
{
  axios.post(`http://localhost:3000/chekUser`,user)
  .then(response=>{
   
    if(response.data.length==0)
    {
      user.id="";
      checkforUser();
    }
  })
  .catch(err=>{
    console.log(err);
  })

}

let checkforUser = () => {
  if (user.id=="") {
    localStorage.removeItem("id");
    localStorage.removeItem("first_name");
    localStorage.removeItem("last_name");
    localStorage.removeItem("middle_name");
    localStorage.removeItem("email");
    localStorage.removeItem("phone_number");
    localStorage.removeItem("gender");
    localStorage.removeItem("user_type");
    localStorage.removeItem("card_number");
    localStorage.removeItem("expiration");
    localStorage.removeItem("accommodation_full_price");
    localStorage.removeItem("rent_beginning");
    localStorage.removeItem("rent_end");
    localStorage.removeItem("accommodation_path");
    localStorage.removeItem("guests_number");
    localStorage.removeItem("accommodation");
    localStorage.removeItem("currencyID");
    localStorage.removeItem("currencyName");
    localStorage.removeItem("currencyMultiplier");
    localStorage.removeItem("currencyShortedName");
    localStorage.removeItem("locale_name");
    localStorage.removeItem("accommodation_full_price");
    localStorage.removeItem("rent_beginning");
    localStorage.removeItem("rent_end");
    localStorage.removeItem("accommodation_path");
    localStorage.removeItem("guests_number");
    localStorage.removeItem("accommodation");
    localStorage.removeItem("expirationYear");
    localStorage.removeItem("expirationMonth");
  }
}
if (user)
  checkforUser();
</script>

<template>
  <div class="page-container d-flex 
              flex-column min-vh-100 
              w-100 overflow-x-hidden">
    <navbar class="sticky-top" />
    <router-view class="flex-fill my-5" />
    <myfooter />
  </div>
</template>

<style>
body {
  background-color: hsl(0, 0%, 20%) !important;
}

.account {
  position: relative;
  z-index: 1020;
}

.nav-tabs {
    --bs-nav-tabs-link-active-color: black;
}

.nav-link {
    --bs-nav-link-color:rgb(149, 158, 152);
    --bs-nav-link-hover-color: white;
}

.experience,.accommodation,.home,.about_us{
  opacity: 0;
  transform: translateY(90px);
  animation: fadeInUp 4s ease forwards;
}

@keyframes fadeInUp {
    0% 	{opacity:0;transform: translateY(60px); }
  25% 	{opacity:0;transform: translateY(20px); }
  100% 	{opacity:1;transform: translateY(0); }
}


*:not(input):not(textarea) {
  -webkit-touch-callout: none !important;
  -webkit-user-select: none !important;
  user-select: none !important;
  outline-style: none !important;
}

.searchresult:hover{
  background-color: rgb(115, 115, 115) !important;
  color: black !important;
  transition: 300ms;
}

.login,.register,.settings,.logout,.cardhover,.account,.userItem{
  animation: scaleIn 3s ease both;
}
@keyframes scaleIn {
    0% 	{opacity:0;transform: scale(0); }
  25% 	{opacity:0;transform: scale(0); }
  100% 	{opacity:1;transform: scale(1); }
}

.home,.login,.register,.account{
  /* profile inputok effektusai */
  input:not([type="checkbox"],[type="radio"]):focus,
  input:not([type="checkbox"],[type="radio"]):hover,
  input:not([type="checkbox"],[type="radio"])::after {
    background-color: white !important;
    box-shadow: 0px 0px 10px white !important;
    transition: 200ms;
    color: black !important;
  }
}

/* Becsúszás animáció */
.slide-in-enter-active,
.slide-in-leave-active {
  transition: all 0.278s ease;
  width: 100%;
  opacity: 1;
}

.slide-in-enter-from {
  transform: translateX(100%);
  opacity: 0;
}

.slide-in-leave-to {
  transform: translateX(-100%);
  opacity: 0;
}

/* Ki csúszás animáció */
.slide-out-enter-active,
.slide-out-leave-active {
  transition: all 0.278s ease;
  width: 100%;
  opacity: 0.4;
}

.slide-out-enter-from {
  transform: translateX(-100%);
}

.slide-out-leave-to {
  transform: translateX(100%);
}
</style>
