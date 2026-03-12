<script setup>
import Navbar from './components/navbar.vue';
import Myfooter from './components/footer.vue';
import { user } from './store/user';
import router from './router';

let websitekey = window.location.pathname.split("/")[1];
 
let id = user.id!=null?user.id:"none";

if(websitekey != 'havenly')
  router.push("/havenly")

let checkforUser = () => {
  if (!id.includes('havenly')) {
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
.experience,.accommodation,.home,.about_us{
  opacity: 0;
  transform: translateY(20px);
  animation: fadeInUp 1.5s ease forwards;
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
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

.login,.register,.settings,.logout,.cardhover,.account{
  animation: scaleIn 1s ease both;
}
@keyframes scaleIn {
    0% 	{opacity:0;transform: scale(0); }
  25% 	{opacity:0;transform: scale(0); }
  100% 	{opacity:1;transform: scale(1); }
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
