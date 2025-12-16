<script setup>
import { reactive } from 'vue';
import cards from '../components/cards.vue';

let model = reactive({
  searchbar: ''
})
</script>

<template>
  <div class="container">
    <div class="row justify-content-center">
      <h1 class="display-1 text-white text-center w-100">
        Hová szeretnél utazni?
      </h1>
      <form class="form mt-5 col-12 col-lg-4 col-md-5 row justify-content-center 
                   bg-dark bg-opacity-50 rounded-3 shadow
                   p-4 border border-1 border-white">

        <!-- Keresési mező -->
        <input  class="form-control mt-2" 
                type="search" 
                name="searchbar" 
                id="searchbar"
                placeholder="Írja be a település nevét. Pl.: Tokyo"
                v-model="model.searchbar">
        <!-- Keresési gomb -->
        <button class="btn btn-outline-light col-11 my-2 mt-3"
                :disabled="!model.searchbar">Keresés</button>
      </form> 
    </div>
  </div>
</template>