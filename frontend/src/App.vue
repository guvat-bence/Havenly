<script setup>
import Navbar from './components/navbar.vue';
import Myfooter from './components/footer.vue';
import { user } from './store/user';

let checkforUser = () => {
  if (user.websitekey != 'havenly') {
    localStorage.removeItem("id")
    localStorage.removeItem("first_name")
    localStorage.removeItem("last_name")
    localStorage.removeItem("middle_name")
    localStorage.removeItem("phone_number")
    localStorage.removeItem("gender")
    localStorage.removeItem("user_type")
    localStorage.removeItem("card_number")
    localStorage.removeItem("expiration")
    localStorage.removeItem("cvv")
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
  animation: fadeInUp 1s ease forwards;
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

.scale-in {
  animation: scaleIn .6s ease both;
}
@keyframes scaleIn {
    0% 	{opacity:0;transform: scale(0); }
  25% 	{opacity:0;transform: scale(0); }
  100% 	{opacity:1;transform: scale(1); }
}
</style>
