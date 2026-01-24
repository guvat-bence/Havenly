<script setup>
import Cards from '@/components/cards.vue';
import { searchInput } from '@/js/getLocation';
import axios from 'axios';
import { ref, watch } from 'vue';

let country = ref([]);
let data = ref([]);

// véletlenszerü 5 ország beolvasása
axios.get('http://localhost:3000/experiences/randCountryID')
  .then(response => {
    country.value = response.data;
    data.value = country.value
  })
  .catch(e => console.error(e))

watch(searchInput,(value) => {
  // Ha nincs keresési mezőben érték akkor térjen vissza az alap értékekhez
  if (!value) {
    data.value = country.value
    return;
  }

  // Különben csökkenjen le az értéke 1-re
  data.value = data.value.slice(0,1)
})

</script>

<template>
  <div class="experience">

    <!-- 5-ször ismételjük mert 5 országoz hívunk le -->
    <div v-for="x in data">
      <!-- kiegészítjük az országok neveivel a címet -->
      <h1 class="display-5 text-center text-white" v-if="!searchInput">
        Élmények amiket {{ x.country_name }} kínál
      </h1>

      <!-- meghívjuk hozzá a kártya.vue-t -->
      <Cards tableName="experiences" 
            :country_name="x.country_name"/>
    </div>
  </div>
</template>