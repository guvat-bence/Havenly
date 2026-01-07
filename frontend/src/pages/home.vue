<script setup>
import { onMounted, reactive, ref } from 'vue';
import cards from '../components/cards.vue';
import axios from 'axios';
import Cards from '../components/cards.vue';

let model = reactive({
  searchbar: ''
})

let accommodations = ref([])

onMounted(()=>
{
  axios.get("http://localhost:3000/accommodations/top5")
    .then(data=>
    {
      accommodations.value = data.data;
      console.log(accommodations.value);
    })
    .catch(err=>
    {
      console.error(err);
    })
})

</script>

<template>
  <div class="home">
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
      <div v-for="x in accommodations">
        <Cards 
          table-name="accommodations"
          :country_id="x.country_id"
          :country_name="x.name"
          page="home"
        />
      </div>
    </div>
  </div>
</template>