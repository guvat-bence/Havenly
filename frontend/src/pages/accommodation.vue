<script setup>
import Cards from '@/components/cards.vue';
import { user } from '@/store/user';
import axios from 'axios';
import { ref } from 'vue';

let country = ref([]);

// véletlenszerü 5 ország beolvasása
axios.get('http://localhost:3000/accommodations/randCountryID')
  .then(response => {
    country.value = response.data;
  })
  .catch(e => console.error(e))

</script>
<template>
  <div class="accommodation">

    <!-- 5-ször ismételjük mert 5 országoz hívunk le -->
    <div v-for="x in country">

      <!-- kiegészítjük az országok neveivel a címet -->
      <h1 class="display-5 text-center text-white">
        Szállások amiket {{ x.country_name }} kínál
      </h1>

      <!-- meghívjuk hozzá a kártya.vue-t -->
      <Cards tableName="accommodations" 
            :country_id="x.country_id"/>
    </div>
  </div>
</template>