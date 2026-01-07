<script setup>
import Cards from '@/components/cards.vue';
import axios from 'axios';
import { onMounted, ref } from 'vue';

let country = ref([]);

onMounted(() => {
  axios.get('http://localhost:3000/experiences/randCountryID')
    .then(response => {
      country.value = response.data;
    })
    .catch(e => console.error(e))
})

</script>

<template>
  <div class="experience">
    <div v-for="x in country">
    <h1 class="display-5 text-center text-white">Élmények amiket {{ x.country_name }} kínál</h1>
    <Cards tableName="experiences" 
         :country_id="x.country_id"
         :country_name="x.country_name"/>
    </div>
  </div>
</template>