<script setup>
import Cards from '@/components/cards.vue';
import axios from 'axios';
import { ref } from 'vue';

let country = ref([]);

// véletlenszerü 5 ország beolvasása
axios.get('http://localhost:3000/experiences/randCountryID')
  .then(response => {
    country.value = response.data;
  })
  .catch(e => console.error(e))


</script>

<template>
  <div class="experience">

    <!-- 5-ször ismételjük mert 5 országoz hívunk le -->
    <div v-for="x in country">

      <!-- kiegészítjük az országok neveivel a címet -->
      <h1 class="display-5 text-center text-white">
        Élmények amiket {{ x.country_name }} kínál
      </h1>

      <!-- meghívjuk hozzá a kártya.vue-t -->
      <Cards tableName="experiences" 
          :country_id="x.country_id"/>
    </div>
  </div>
</template>