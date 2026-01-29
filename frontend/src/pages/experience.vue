<script setup>
import Cards from '@/components/cards.vue';
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
    <!-- Search bar -->
    <form class="d-sm-flex d-md-none 
                 d-lg-none position-relative 
                 justify-content-center bg-black 
                 p-2 w-75 mx-auto bg-opacity-25 
                 border border-1 border-white rounded-3" 
          role="search" 
          name="searchbar">
      <div>
        <h1 class="display-1 text-white text-center">Keresés</h1>
        <input class="form-control my-1" 
               type="search" 
               id="searchinput" 
               placeholder="Search" 
               aria-label="Search"
               v-model="searchInput"
               v-on:input="search(searchInput)"
               v-on:focus="isFocus = true"
               v-on:blur="isFocus = false"
               autocomplete="off"	/>
        <ul class="dropdown-menu justify-content-center 
                   m-0 p-0 "
            :class="result.length > 0 && isFocus ? 'show' : ''">

          <li v-for="x in result.slice(0,4)"
              v-on:click="searchInput = x.city_name;"
              v-on:mousedown.prevent="isFocus = true"
              class="searchresult d-flex 
                     m-0 p-0 p-3 bg-dark">
            <p class="text-white fs-5 bg-transparent">{{ x.city_name }} &nbsp;</p>
            <p class="text-white-50 fs-5">{{ x.country_name }}</p>
          </li>
        </ul>
      </div>
    </form>

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