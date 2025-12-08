<script setup>
import Navbar from './components/navbar.vue';

</script>

<template>
<div class="page-container d-flex 
            flex-column min-vh-100 
            vw-100 overflow-x-hidden">
    <navbar class="sticky-top"/>
    <router-view class="flex-fill"/>
</div>
</template>

<style>
body{
  background-color: rgb(34, 34, 34) !important;
}
</style>
