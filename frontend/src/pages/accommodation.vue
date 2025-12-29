<script setup>
import Cards from '@/components/cards.vue';
import axios from 'axios';
import { onMounted, ref } from 'vue';

let country = ref([]);

onMounted(() => {
  axios.get('http://localhost:3000/accommodations/randCountryID')
    .then(response => {
      country.value = response.data;
      console.log(country.value)
    })
    .catch(e => console.error(e))
})

</script>

<template>
  <div class="accommodation">
     <div v-for="x in country">
    <h1 class="display-5 text-center text-white">
      Szállások amiket {{ x.country_name }} kínál
    </h1>
    <Cards tableName="accommodations" 
          :country_id="x.country_id"
          :country_name="x.country_name"/>
    </div>
  </div>
</template>