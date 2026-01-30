<script setup>
import Cards from '@/components/cards.vue';
import Searchbar from '@/components/searchbar.vue';
import { activeLocations, searchInput } from '@/js/getLocation';
import axios from 'axios';
import { ref, watch } from 'vue';

let country = ref([]);
let data = ref([]);
let result = ref([]);

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

let convertStrings = (str) => {
  
  	return str.normalize("NFD")
  		.replace(/[\u0300-\u036f]/g, "")
  		.replaceAll(" ", "_")
  		.toLowerCase();
  
  },
  search = (value) => {
  	result.value = [];
  	for (let index = 0; index < activeLocations.value.length; index++) {
    
  		if ((convertStrings(activeLocations.value[index].city_name)).split(" ")
  			  .filter(x => x.includes(convertStrings(value))).length > 0) {
          
  			result.value.push(activeLocations.value[index])
  		}
  	}
  };

</script>

<template>
  
  <div class="experience">

    <Searchbar class="justify-content-center"/>

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