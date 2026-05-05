<script setup>
import Cards from '@/components/cards.vue';
import Searchbar from '@/components/searchbar.vue';
import { activeLocations, searchInput } from '@/js/getLocation';
import axios from 'axios';
import { ref, watch } from 'vue';
import { useI18n } from 'vue-i18n';

const {t} = useI18n();
const {locale} = useI18n();
let country = ref([]);
let data = ref([]);
let result = ref([]);

// véletlenszerü 5 ország beolvasása
axios.get('http://localhost:3000/experiences/randCountryID')
  .then(async response => {

    for(let x in response.data)
    {
      await axios.post('http://localhost:3000/getAllLocations',{country_id:response.data[x].country_id,
                                                      city_id:1,
                                                      language_short_name:locale.value})
      .then(translations=>{

        response.data[x].country_name = translations.data.countries[0].name;
      })
      .catch(err=>{
        console.log(err);
      })
    }

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
});
</script>

<template>
  
  <div class="experience">
    <div class="container text-white">

      <Searchbar class="justify-content-center"
                tablename="Expreience"/>

      <div class="row justify-content-center">
        <!-- Élénye árai, tájékoztató jellegű szöveg -->
        <div class="row justify-content-center my-3 mx-3 py-3 bg-dark bg-opacity-50
                    text-center align-items-center border border-2 rounded-3 
                    col-12 col-sm-12 col-md-8 col-lg-5">
          <h3>
           	{{ $t("about.information_text") }}
          </h3>
        </div>
      </div>

      <!-- 5-ször ismételjük mert 5 országoz hívunk le -->
      <div v-for="x in data">
        <!-- kiegészítjük az országok neveivel a címet -->
        <h1 class="display-5 text-center" v-if="!searchInput">
        {{ $t("experiences.title_first_part") }} {{ x.country_name }} {{  $t("experiences.title_second_part") }}
        </h1>

        <!-- meghívjuk hozzá a kártya.vue-t -->
        <Cards tableName="experiences" 
              :country_name="x.country_name"/>
      </div>
    </div>
  </div>
</template>