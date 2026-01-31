<script setup>
import { callWithAsyncErrorHandling, reactive, ref } from 'vue';
import axios from 'axios';
import Cards from '../components/cards.vue';

let model = reactive({
  searchbar: ''
})

let accommodations = ref([])


// lekérjük a top5 szállást amit a legtöbbször foglaltak.
axios.get("http://localhost:3000/accommodations/top5")
  .then(data=>
  {
    accommodations.value = data.data;
    console.log(accommodations.value)
  })
  .catch(err=>
  {
    console.error(err);
  })
</script>

<template>
  <div class="home" >
    <div class="container" >
      <div class="row justify-content-center 
                  align-items-center rounded-5 shadow-lg"
           id="searchPart">
        <!-- kereső címe -->
        <h1 class="display-1 text-white text-center w-auto mt-5
                   bg-black bg-opacity-50 rounded-3 shadow">
          Mit keresel?
        </h1>
        <!-- kereső mező form-ja -->
        <div class="row justify-content-center">
           <form class="form col-12 col-lg-4 col-md-5 row justify-content-center 
                    bg-black bg-opacity-50 rounded-3 shadow
                    p-4 border border-1 border-white mb-5">
            <!-- Keresési mező -->
            <div class="justify-content-between d-flex">
              <RouterLink to="/accommodation" class="btn btn-outline-light w-50 mx-1">Szállások</RouterLink>
              <RouterLink to="/experience" class="btn btn-outline-light w-50 mx-1">Élmények</RouterLink>
            </div>
          </form> 
        </div>
      </div>
      <!-- LEgnépszerűbb szállások,cím -->
      <h1 class="display-5 mt-5 text-center text-white">
          Legnépszerűbb szállásaink
      </h1>

      <div class="row justify-content-center">

        <!-- 5-ször ismételjük mert 5 top szállást hívunk le  -->
        <div v-for="x in accommodations" class="mx-4 col-12 col-sm-12 col-md-4 col-xl-3 col-xxl-3">

          <!-- meghívjuk hozzá a kártya.vue-t -->
          <!-- értékeket viszünk át -->
          <Cards
            table-name="accommodations"
            :country_name="x.name"
            :accommodation_id="x.id"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
input:not([type="checkbox"]):focus,
input:not([type="checkbox"]):hover,
input:not([type="checkbox"])::after{
  background-color: white !important;
  box-shadow: 0px 0px 10px white !important;
  transition: 200ms;
  color: black !important;
}

#searchPart
{
  background-image: url("../images/gif03.gif");
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  height: 500px;

}

</style>