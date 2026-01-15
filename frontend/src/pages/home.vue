<script setup>
import { callWithAsyncErrorHandling, reactive, ref } from 'vue';
import axios from 'axios';
import Cards from '../components/cards.vue';

let model = reactive({
  searchbar: ''
})

let accommodations = ref([])


// lekérjük a top5 szállást amit a legtöbbször foglaltak.
axios.get("http://localhost:3000/accommodations/top5")
  .then(data=>
  {
    accommodations.value = data.data;
  })
  .catch(err=>
  {
    console.error(err);
  })
</script>

<template>
  <div class="home">
    <div class="container">
      <div class="row justify-content-center">

        <!-- kereső címe -->
        <h1 class="display-1 text-white text-center w-100">
          Hová szeretnél utazni?
        </h1>

        <!-- kereső mező form-ja -->
        <form class="form mt-5 col-12 col-lg-4 col-md-5 row justify-content-center 
                    bg-dark bg-opacity-50 rounded-3 shadow
                    p-4 border border-1 border-white mb-5">

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

      <!-- LEgnépszerűbb szállások,cím -->
      <h1 class="display-5 text-center text-white">
          Legnépszerűbb szállásaink
      </h1>

      <div class="row justify-content-center">

        <!-- 5-ször ismételjük mert 5 top szállást hívunk le  -->
        <div v-for="x in accommodations" class="mx-2 col-12 col-sm-12 col-md-6 col-xl-3 col-xxl-3">

          <!-- meghívjuk hozzá a kártya.vue-t -->
          <!-- értékeket viszünk át -->
          <Cards 
            table-name="accommodations"
            :country_id="x.country_id"
            :country_name="x.name"
            :accommodation_id="x.id"
          />
        </div>
      </div>
    </div>
  </div>
</template>