<script setup>
import Cards from '@/components/cards.vue';
import Searchbar from '@/components/searchbar.vue';
import { activeLocations, searchInput } from '@/js/getLocation';
import axios from 'axios';
import { ref, watch } from 'vue';
let country = ref([]),
    data = ref([]),
    result = ref([]),
    	isFocus = ref(false);

// véletlenszerü 5 ország beolvasása
axios.get('http://localhost:3000/accommodations/randCountryID')
  .then(response => {
    country.value = response.data;
    data.value = country.value;
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
  <div class="accommodation">

	<Searchbar class="justify-content-center"
             tablename="Accomodation"/>

    <!-- 5-ször ismételjük mert 5 országoz hívunk le -->
    <div v-for="x in data">
      <div >
        <!-- kiegészítjük az országok neveivel a címet -->
        <h1 class="display-5 text-center text-white"
            v-if="!searchInput">
          Szállások amiket {{ x.country_name }} kínál
        </h1>

        <!-- meghívjuk hozzá a kártya.vue-t -->
        <Cards tableName="accommodations" 
              :country_name="x.country_name"/>
      </div>
    </div>
  </div>
</template>

<style>
.searchinput:hover{
	background-color: rgb(0, 0, 0) !important;
	box-shadow: 0px 0px 10px white !important;
	transition: 200ms !important;
	color: black !important;
}
</style>