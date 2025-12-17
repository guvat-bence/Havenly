<script setup>
import Cards from '@/components/cards.vue';
import axios from 'axios';
import { onMounted, ref } from 'vue';

let country = ref([]);

onMounted(() => {
  axios.get('http://localhost:3000/randCountryID')
    .then(response => {
      country.value = response.data;
    })
    .catch(e => console.error(e))
})

</script>

<template>
  <h1 class="display-1 text-center text-white">Szállások</h1>
  <Cards tableName="accommodations" 
         :country="1"/>
</template>