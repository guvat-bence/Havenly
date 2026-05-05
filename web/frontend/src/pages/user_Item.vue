<script setup>
import { user } from '@/store/user'
import { computed, reactive, ref, watch } from 'vue'
import axios from 'axios'
import { useI18n } from 'vue-i18n'
import { selectedCurrency } from '@/store/currency'
import { convertStrings } from '@/common'
import router from '@/router'
import allIcons from '@/json/icons.json';

const props = defineProps(['table_name','id','name'])
const {t} = useI18n();
const {locale} = useI18n();

if(!user.id)
  router.back()

let images = reactive({})
let item_details = ref([]);
let iconsAndTexts = ref([]);

for(let x=0;x<(props.table_name=="accommodations"?10:3);x++)
{
  images[x] = "";
}
let imagesCopie = {... images};

let model = reactive({
  bathroom:"",
  bed:"",
  bedroom:"",
  city_id:"",
  city_name:"",
  country_id:"",
  country_name:"",
  description:"",
  folder_name:"",
  guest_number:"",
  id:"",
  name:"",
  owner_id:"",
  price:"",
  size:"",
  user_id:user.id,
  language_short_name:locale.value,
  balcony:"",
  basic_spices:"",
  bluetooth_speaker:"",
  board_games:"",
  coffee_maker:"",
  darkening:"",
  dishes:"",
  extra_bed_linen:"",
  free_wifi:"",
  hair_dryer:"",
  iron:"",
  kettle:"",
  microwave:"",
  night_lamp:"",
  parking_lot:"",
  safe:"",
  smart_tv:"",
  suitcase_rack:"",
  towels:"",
  usb_charger:"",
  work_table:""
})

let item = ref([]);
let modelCopie = {... model};
let locations = ref([]);

axios.get(`http://localhost:3000/getAllCitiesAndCountries/${locale.value}`)
.then(response=>{
  locations.value = response.data;
  console.log(locations.value);
  
})
.catch(err=>{
  console.log(err);
})

for(let y in allIcons)
{
  allIcons[y]["text"] = computed(()=>(t(`about.extras.${y}`)));
  allIcons[y]["id"] = y;
}

item_details.value = allIcons;

if(props.id!=0 && props.name!="new")
{
  // adatbázisból lehúzzuk a szállás/élmény többi adatát.
  axios.get(`http://localhost:3000/${props.table_name}/${props.id}`)
  .then(datas=>{

    // tömb feltöltése
    item.value = datas.data[0];

    item.value.price =  item.value.price*selectedCurrency.currencyMultiplier;

    item.value.country_id = "";
    item.value.city_id = "";

    Object.assign(model,item.value);
    Object.assign(modelCopie,item.value);
   

    for(let x=0;x<(props.table_name=="accommodations"?10:3);x++)
    {
      images[x] = "image";
    }
    imagesCopie = {... images}

    if(props.table_name=="accommodations")
    {
      // adatbázisból lehúzzuk a szálláshoz tartozó részleteket
      axios.get(`http://localhost:3000/accommodations/accommodations_details/${props.id}`)
      .then(details=>
      {

        // végigmegyünk a részleteken
        for(let x in details.data[0])
        {

          // ha van olyan részlet amit tartalmaz a szállás
          // akkor hozzá adjuk a item_details listához 
          // az adott részlethez tartozó elemet az iconsAndTexts-ből
          if(details.data[0][x] == 1)
          {
            iconsAndTexts.value.push({
              id:[x.id],
              ...allIcons[x]});
          }
        }

        for(let x in item_details.value)
        {
          for(let y in iconsAndTexts.value)
          {
            if(item_details.value[x].id == iconsAndTexts.value[y].id)
            {
              model[item_details.value[x].id] = true;
            }
          }
        }

        Object.assign(modelCopie,model);
        
      })
      .catch(error=>
      {
        console.error(error);
      })
    }

    

  })
  .catch(err=>{
    console.log(err);
  })
}

function check()
{
  if(model.city_name=="")
    return false;
  if(model.country_name=="")
    return false;
  if(model.description=="")
    return false;
  if(model.name=="")
    return false;
  if(model.price=="" || model.price > 9999999)
    return false;
  if(props.table_name=="accommodations" && model.bathroom=="" || model.bathroom > 99)
    return false;
  if(props.table_name=="accommodations" && model.bedroom=="" || model.bedroom > 99)
    return false;
  if(props.table_name=="accommodations" && model.bed=="" || model.bed > 99)
    return false;
  if(props.table_name=="accommodations" && model.guest_number=="" || model.guest_number > 99)
    return false;
  if(props.table_name=="accommodations" && model.size=="" || model.size > 999)
    return false;

  if(props.name=="new"){
    for(let x in images)
    {
      if(images[x] == "")
      {
        return false;
      }
    }
  }

  return true;
}

function uploadImage(item)
{
  let item_id = item.currentTarget.id;

  if(item.currentTarget.files.length!=1)
    return;

  let file = item.currentTarget.files[0];
 
  if(file.type.includes("images/"))
  {
    return;
  }

  let reader = new FileReader();

  reader.onload=()=>{

    let label = document.body.querySelector(`label[for='${item_id}']`);
    label.style.backgroundImage =`url(${reader.result})`;
    label.innerHTML = "";

    images[item_id-1] = reader.result;
  };
  reader.onerror=(e)=>{
    console.log(e);
  }

  reader.readAsDataURL(file);
  
}

function uploadItem()
{

  for(let x of locations.value)
  {

    if((convertStrings(x.country_name) == convertStrings(model.country_name)) 
        || (convertStrings(x.country_transname) == convertStrings(model.country_name)))
    {
      model.country_id = x.country_id
    }
  }

  for(let x of locations.value)
  {
    if((convertStrings(x.city_name) == convertStrings(model.city_name))
        || (convertStrings(x.city_transname) == convertStrings(model.city_name)))
    {
      model.city_id = x.city_id
    }
  }

  for(let x in model)
  {
    if(model[x] == true && item_details?.value[x]?.id == x)
    {
      model[x] = 1;
    }
    else if(model[x] == "" && item_details?.value[x]?.id == x)
    {
      model[x] = 0;
    }
  }

  model.price = model.price/selectedCurrency.currencyMultiplier;
  model.folder_name = convertStrings(model.name);

  if(model.city_id=="" || model.country_id=="")
  {
    axios.post(`http://localhost:3000/uploadLocations`,model)
    .then(response=>{
      console.log(response.data);

      model.city_id = response.data.city.insertId;
      model.country_id = response.data.country.insertId;

      ItemRequest();
    })
    .catch(err=>{
      console.log(err);
    })
  }
  else
  {
    ItemRequest();
  }
}

function ItemRequest()
{
  let url = "";

  if(model.id != "")
  {
    url = "update";
  }
  else
  {
    url = "upload";
  }
  
  axios.post(`http://localhost:3000/${props.table_name}/${url}UserItem`,{datas:model})
  .then(response=>{
    console.log(response);
    router.back();
  })
  .catch(err=>{
    console.log(err);
  })
}

watch([model,images],()=>{
  check();
},{deep:true})
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
                        v-model="model.country_name"
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
                        v-model="model.city_name"
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
                <input type="number" 
                        class="form-control" 
                        id="price" 
                        v-model="model.price"
                        autocomplete="off"
                        max="9999999">
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
                <input type="number" 
                        class="form-control" 
                        id="size" 
                        v-model="model.size"
                        autocomplete="off"
                        max="999">
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
                <input type="number" 
                        class="form-control" 
                        id="guests_number" 
                        v-model="model.guest_number"
                        autocomplete="off"
                        max="99">
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
                <input type="number" 
                        class="form-control" 
                        id="bedrooms_number" 
                        v-model="model.bedroom"
                        autocomplete="off"
                        max="99">
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
                <input type="number" 
                        class="form-control" 
                        id="beds_number" 
                        v-model="model.bed"
                        autocomplete="off"
                        max="99">
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
                <input type="number" 
                        class="form-control" 
                        id="bathoroom_number" 
                        v-model="model.bathroom"
                        autocomplete="off"
                        max="99">
              </div>
            </div>

            <!-- Amit a szállás kínál -->
            <div v-if="props.table_name=='accommodations'"
                 class="row mb-4 ps-2 justify-content-center">   

              <!-- Cím -->
              <h5 class="text-center">
                <i class="fa-solid fa-circle-info"></i>
                Amit a szállás kínál
              </h5>

              <div v-for="x in item_details" 
                   class="mb-3 form-check col-12 col-md-6 col-lg-4 ">

                <input type="checkbox" 
                       class="form-check-input" 
                       :id="x.id"
                       v-model="model[x.id]">

                <label class="form-check-label" 
                       :for="x.id">
                  <i :class="x.icon"></i>
                  {{ x.text }}
                </label>
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

                <label :for="x" 
                       class="form-label d-flex 
                              justify-content-center 
                              align-items-center border" 
                       style="height: 150px;
                             cursor:pointer;
                             background-repeat: no-repeat;
                             background-position: center;
                             background-size: cover;"
                       :style=" item!=''?{
                        backgroundImage: `url(/countries/${convertStrings(item.country_name)}`+
                                          `/cities/${convertStrings(item.city_name)}/`+
                                          `${props.table_name}/${item.folder_name}`+
                                          `/0${x<10?`0${x}`:x}.png)`}:{}">
                  <span v-if="item==''">
                    <i class="fa-solid fa-image"></i>          
                    Kép
                  </span>
                </label>
                <input type="file" 
                       class="form-control d-none"
                       :id="x"
                       accept="image/*"
                       @change="uploadImage($event)">
              </div>

            </div>

            <!-- Gombok -->
            <div class="row mx-1 justify-content-center">

              <!-- Mentés gomb -->
              <button :disabled="(!check() || JSON.stringify(model)==JSON.stringify(modelCopie))"
                      @click="uploadItem()"
                      type="button"
                      class="col-12 col-sm-12 col-md-4 col-lg-3
                              mx-2 my-2 btn btn-light">
                {{ $t("profile.save") }}
              </button>

              <!-- Mégse gomb -->
              <button :disabled="JSON.stringify(model)==JSON.stringify(modelCopie)"
                      @click="Object.assign(model,modelCopie)"
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