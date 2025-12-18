<script setup>
import Cards from '@/components/cards.vue';
import axios from 'axios';
import { onMounted, ref } from 'vue';

let country = ref([]);

onMounted(() => {
  axios.get('http://localhost:3000/randCountryID')
    .then(response => {
      country.value = response.data;
      console.log(country.value)
    })
    .catch(e => console.error(e))
})

</script>

<template>
  <div v-for="x in country">
    <h1 class="display-5 text-center text-white">
      Szállások amiket {{ x.name }} kínál
    </h1>
    <Cards tableName="accommodations" 
          :country="x.country_id"
          :country_name="x.name"/>
  </div>
</template>