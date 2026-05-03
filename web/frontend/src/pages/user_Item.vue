<script setup>
import { user } from '@/store/user'
import router from '@/router'
import { reactive, ref, watch } from 'vue'
import axios from 'axios'
import { useI18n } from 'vue-i18n'
import { selectedCurrency } from '@/store/currency'
import { convertStrings } from '@/common'

const props = defineProps(['table_name','id','name'])
const {t} = useI18n();
const {locale} = useI18n();

let model = reactive({
  bathroom:"",
  bed:"",
  bedroom:"",
  city_id:"",
  city_name:"",
  city_trans_name:"",
  country_id:"",
  country_name:"",
  country_trans_name:"",
  description:"",
  folder_name:"",
  guest_number:"",
  id:"",
  name:"",
  owner_id:"",
  price:"",
  size:""
})

let item = ref([]);
let itemClone = "";
let changedModel = ref(false);

// adatbázisból lehúzzuk a szállás/élmény többi adatát.
axios.get(`http://localhost:3000/${props.table_name}/${props.id}`)
.then(datas=>{

	datas.data[0].country_trans_name =t(`search.countries.${datas.data[0].country_id}`);
	datas.data[0].city_trans_name = t(`search.cities.${datas.data[0].city_id}`);

	// tömb feltöltése
	item.value = datas.data[0];
  console.log(item.value);
  itemClone = {... item};

  item.value.price =  item.value.price*(selectedCurrency.currencyMultiplier).toLocaleString('fi-FI');

  Object.assign(model,item.value);
  
})
.catch(err=>{
  console.log(err);
})


</script>
<template>
  <div class="userItem">
    <div class="container">
      <div class="row justify-content-center">

        <!-- Tárgy adatai -->
        <form id="collpasePrivacyDatas"
              class="col-12 col-sm-10 col-md-8 
                    col-lg-8 col-xl-8 col-xxl-6
                    my-4 text-white">

          <!-- Cím -->
          <h4 class="text-center">
            <i class="fa-solid fa-square-poll-horizontal"></i>
             Adatok
          </h4>

          <!-- Adatok és gombok -->
          <div class="px-3 py-3 border rounded-3">

            <!-- Helyszín -->
            <div class="row justify-content-center mb-3">

              <!-- Helyzet -->
              <h5 class="text-center">
                <i class="fa-regular fa-compass fa-lg"></i>
                Helyzet
              </h5>

              <!-- Ország -->
              <div class="mb-3 m-0 col-12 col-lg-6">

                <!-- Label -->
                <label for="country" 
                        class="form-label">
                  <i class="fa-solid fa-earth-europe"></i>
                  Ország
                </label>

                <!-- Input -->
                <input type="text" 
                        class="form-control" 
                        id="country" 
                        v-model="model.city_name"
                        autocomplete="off">
              </div>

              <!-- Város -->
              <div class="mb-3 col-12 col-lg-6">

                <!-- Label -->
                <label for="city" 
                        class="form-label">
                 <i class="fa-solid fa-city"></i>
                  Város
                </label>

                <!-- Input -->
                <input type="text" 
                        class="form-control" 
                        id="city" 
                        v-model="model.country_name"
                        autocomplete="off">
              </div>
            </div>

            <!-- Név és leírás -->
            <div class="row">

              <!-- Cím -->
              <h5 class="text-center">
               <i class="fa-solid fa-book-open"></i>
                Név és leírás
              </h5>

              <!-- Név -->
              <div class="mb-3 col-12 col-lg-6">

                <!-- Label -->
                <label for="name" 
                        class="form-label">
                  <i class="fa-solid fa-file-signature"></i>
                  Név
                </label>

                <!-- Input -->
                <input type="text" 
                        class="form-control" 
                        id="name" 
                        v-model="model.name"
                        autocomplete="off">
              </div>

              <!-- Leírás -->
              <div class="mb-3 col-12 col-lg-6">

                <!-- Label -->
                <label for="description" 
                        class="form-label">
                  <i class="fa-solid fa-file-signature"></i>
                  Leírás
                </label>

                <!-- Input -->
               <textarea class="form-control col-10" 
										 id="description" 
										 type="text"
										 value=""
										 rows="5"
										 maxlength="500"
										 v-model="model.description">
							</textarea>
              </div>
            </div>

            <!-- Részletek -->
            <div class="row mb-4 justify-content-center">   

              <!-- Cím -->
              <h5 class="text-center">
                <i class="fa-solid fa-circle-info"></i>
                Részletek
              </h5>

              <!-- Ár -->
              <div class="mb-3 m-0 col-12 col-lg-4">

                <!-- Label -->
                <label for="price" 
                        class="form-label">
                  <i class="fa-solid fa-money-bill"></i>
                  Ár ({{ selectedCurrency.currencyShortedName }}) 
                    / {{ props.table_name=="accommodations"?'éjszaka':'fő' }}
                </label>

                <!-- Input -->
                <input type="text" 
                        class="form-control" 
                        id="price" 
                        v-model="model.price"
                        autocomplete="off">
              </div>

              <!-- Méret -->
              <div v-if="props.table_name=='accommodations'"
                   class="mb-3 col-12 col-lg-4">

                <!-- Label -->
                <label for="size" 
                        class="form-label">
                  <i class="fa-solid fa-ruler-combined"></i>
                  Méret (m²)
                </label>

                <!-- Input -->
                <input type="text" 
                        class="form-control" 
                        id="size" 
                        v-model="model.size"
                        autocomplete="off">
              </div>
              
              <!-- Vendégek száma -->
              <div v-if="props.table_name=='accommodations'"
                   class="mb-3 col-12 col-lg-4">

                <!-- Label -->
                <label for="guests_number" 
                        class="form-label">
                  <i class="fa-solid fa-people-group"></i>
                  Vendégek száma
                </label>

                <!-- Input -->
                <input type="text" 
                        class="form-control" 
                        id="guests_number" 
                        v-model="model.guest_number"
                        autocomplete="off">
              </div>

              <!-- Hálószobák száma -->
              <div v-if="props.table_name=='accommodations'"
                   class="mb-3 m-0 col-12 col-lg-4">

                <!-- Label -->
                <label for="bedrooms_number" 
                        class="form-label">
                    <i class="fa-solid fa-house-chimney"></i>
                    Hálószobák száma
                </label>

                <!-- Input -->
                <input type="text" 
                        class="form-control" 
                        id="bedrooms_number" 
                        v-model="model.bedroom"
                        autocomplete="off">
              </div>

              <!-- Ágyak száma -->
              <div v-if="props.table_name=='accommodations'"
                   class="mb-3 col-12 col-lg-4">

                <!-- Label -->
                <label for="beds_number" 
                        class="form-label">
                  <i class="fa-solid fa-bed"></i>
                  Ágyak száma
                </label>

                <!-- Input -->
                <input type="text" 
                        class="form-control" 
                        id="beds_number" 
                        v-model="model.bed"
                        autocomplete="off">
              </div>
              
              <!-- Fürdőszobák száma -->
              <div v-if="props.table_name=='accommodations'"
                   class="mb-3 col-12 col-lg-4">

                <!-- Label -->
                <label for="bathoroom_number" 
                        class="form-label">
                  <i class="fa-solid fa-bath"></i>
                  Fürdőszobák száma
                </label>

                <!-- Input -->
                <input type="text" 
                        class="form-control" 
                        id="bathoroom_number" 
                        v-model="model.bathroom"
                        autocomplete="off">
              </div>
            </div>

            <!-- Képek -->
            <div class="row mb-4 justify-content-center">   

            <!-- Cím -->
              <h5 class="text-center">
                <i class="fa-regular fa-images"></i>
                Képek
              </h5>

              <!-- Képek -->
              <div v-for="x in props.table_name=='accommodations'?10:3"
                   class="mb-3 m-0 col-12 col-lg-3">

                <label class="form-label d-flex 
                              justify-content-center 
                              align-items-center border" 
                      :for="x"
                      style="height: 150px;
                             cursor:pointer;
                             background-repeat: no-repeat;
                             background-position: center;
                             background-size: contain;"
                      :style=" item!=''?{
                        backgroundImage: `url(/countries/${convertStrings(model.country_name)}/cities/${convertStrings(model.city_name)}/${props.table_name}/${model.folder_name}/0${x<10?`0${x}`:x}.png)`
                      }:{}">
                  <span v-if="item==''">
                    <i class="fa-solid fa-image"></i>          
                    Kép
                  </span>
                </label>
                <input type="file" 
                       class="form-control d-none"
                       :id="x"
                       accept="image/*">
              </div>

            </div>

            <!-- Gombok -->
            <div class="row mx-1 justify-content-center">

              <!-- Mentés gomb -->
              <button v-if="changedModel==true && changedCard!=true"
                      @click="messageBox('open');
                              messageBoxmessage = messages.editing"
                      type="button"
                      class="col-12 col-sm-12 col-md-4 col-lg-3
                              mx-2 my-2 btn btn-light">
                {{ $t("profile.save") }}
              </button>

              <!-- Mégse gomb -->
              <button :disabled="changedModel!=true"
                      @click="restoreDatas(model)"
                      type="button" 
                      class="col-12 col-sm-12 col-md-4 col-lg-3
                            mx-2 my-2 btn btn-secondary">
                {{ $t("profile.unsave") }}
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>
<style scoped>
</style>