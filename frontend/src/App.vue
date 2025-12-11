<script setup>
import Navbar from './components/navbar.vue';
import Myfooter  from './components/footer.vue';
</script>

<template>
<div class="page-container d-flex 
            flex-column min-vh-100 
            w-100 overflow-x-hidden">
    <navbar class="sticky-top"/>
    <router-view class="flex-fill my-5"/>
    <myfooter class="sticky-buttom"/>

</div>
</template>

<style>
body{
  background-color: hsl(0, 0%, 20%) !important;
  user-select: none;
}
*:not(input):not(textarea)
{
  -webkit-touch-callout: none !important;
  -webkit-user-select: none !important;
  user-select: none !important;
  outline-style: none !important;
}
</style>
