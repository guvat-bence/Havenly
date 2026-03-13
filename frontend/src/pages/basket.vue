<script setup>
import { useRouter } from 'vue-router';
import { selectedCurrency } from '@/store/currency';
import { rent } from '@/store/current_rent';
import { user } from '@/store/user';
import { reactive, ref, Transition, watch } from 'vue';
import axios, { Axios } from 'axios';

let router = useRouter()
let accommodation_data = JSON.parse(rent.accommodation);
let cardData = ref([])
let currentCard = ref("")

if(!user.id)
  router.back()

// véletlenszerü 5 ország beolvasása
axios.get('http://localhost:3000/getCardNetwork')
  .then(response => {
    cardData.value = response.data
  })
  .catch(e => console.error(e))

if (!accommodation_data.id || !user.id)
  router.back()

let transitionName 
let step = ref(0)

let accommodationData = JSON.parse(rent.accommodation);

let model = reactive({
  owner_id: accommodationData.owner_id,
  accommodation_id: accommodationData.id,
  rent_beginning: rent.rent_beginning,
  rent_end: rent.rent_end,
  price: (rent.accommodation_full_price) + ((rent.accommodation_full_price) * 0.1),
  id: parseInt(user.id),
  firstName: user.firstname,
  lastName: user.lasttname,
  middleName: user.middlename,
  email: user.email,
  phoneNum: user.phone_number,
  cardnumber: user.cardNumber,
  expiration_month: user.expirationMonth,
  expirationYear: user.expirationYear,
  cvv: null,
  city: null,
  postalCode: null,
  address: null,
  door: null
})

console.log(model)
console.log(accommodationData)

let currentExpYear = ref(new Date().getFullYear().toString().substring(2,4))

// Format text to readable
let convertStrings = (str) => {
  return str.normalize("NFD")
            .replace(/[\u0300-\u036f]/g, "")
            .replaceAll(" ", "_")
            .toLowerCase();
};

let payForAccomadtion = () => {
  axios.post('http://localhost:3000/rentAccomodation', model)
  .then(response => {
    console.log(response.data)
  })
  .catch(e => console.error(e))
}

setTimeout(() => {
  if(model.cardnumber){
    for (let i = 0; i < cardData.value.length; i++) {
      if(model.cardnumber.startsWith(cardData.value[i].prefix)){
        currentCard.value = convertStrings(cardData.value[i].network_name)
      }
    }
  }
}, 50);


watch(() => model.cardnumber, (x) => {
  currentCard.value = "";
  for (let i = 0; i < cardData.value.length; i++) {
    if(x.startsWith(cardData.value[i].prefix)){
      currentCard.value = convertStrings(cardData.value[i].network_name)
    }
  }
})       
</script>
<template>
  <div class="container mt-2">
    <h1 class="display-1 text-center text-white " v-on:click="step++">Kosár</h1>
    <div class="row flex-row-reverse">

      <!-- Accomodation data-->
      <div class="col-12 col-md-6 mb-4 text-center">
        <div class="row">
          <div class="d-flex justify-content-center justify-content-lg-end">

            <!-- Card -->
            <div class="card bg-dark bg-opacity-50 border-1 
                        border-white text-white w-50">
              
              <!-- Image -->
              <img height="300" 
                   :src="`/countries/${convertStrings(accommodation_data.country_name)}` +
                         `/cities/${convertStrings(accommodation_data.city_name)}` +
                         `/accommodations/${convertStrings(accommodation_data.folder_name)}/001.png`"
                   class="card-img-top" 
                   alt="accomodation_image">

              <!-- Accomodation informations -->
              <div class="card-body">
                <h5 class="card-title">{{ accommodation_data.name }}</h5>
                <hr>

                <!-- Details -->
                <div>
                  <div class="row">
                    <p>Személyszám: {{ rent.guests}}</p>
                    <p>Ettől: {{ rent.rent_beginning }}</p>
                    <p>Eddig: {{ rent.rent_end }}</p>
                  </div>
                  <hr>

                  <!-- Prices -->
                  <div>
                    <p>Alapár: {{ (rent.accommodation_full_price * 
                                   selectedCurrency.currencyMultiplier).toLocaleString('fi-FI') }} 
                               {{ selectedCurrency.currencyShortedName }}</p>
                    <p>Kezelési díj 
                      <span class="text-danger">(8%)</span>:
                      {{ ((rent.accommodation_full_price * 
                           selectedCurrency.currencyMultiplier) * 0.08).toLocaleString('fi-FI') }} 
                      {{ selectedCurrency.currencyShortedName }}
                    </p>
                  </div>
                  <hr>

                  <!-- Overall price -->
                  <div>
                    <p class="fw-bold mb-0">Összesen: 
                      {{((rent.accommodation_full_price * 
                          selectedCurrency.currencyMultiplier) + 
                        ((rent.accommodation_full_price * 
                          selectedCurrency.currencyMultiplier) * 0.1)).toLocaleString('fi-FI')}}
                      {{ 
                        selectedCurrency.currencyShortedName
                      }}
                  </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      
      <!-- user datas -->
      <div class="col-12 col-md-6 bg-dark 
                  bg-opacity-50 border border-1
                   border-white p-4 rounded-3 h-50 
                   text-white my-auto">

        <h4 class="display-5 mb-4 text-center">Számlázási adatok</h4>
        
        <Transition :name="transitionName"
                    type="transition" 
                    mode="out-in">
          <div :key="step">
            <!-- Personal data -->
            <div v-if="step === 0">
              <!-- Names -->
              <div class="row justify-content-center mb-3">
                <div>
                  <h5 class="text-center">Nevek</h5>
                </div>

                <!-- FirstName -->
                <div :class="model.middleName!=''?
                        'col-lg-4':
                        'col-lg-6'"
                      class="mb-3 m-0 col-12">
                  <label for="InputFirstName" 
                        class="form-label">
                    Keresztnév
                  </label>
                  <input type="text" 
                        class="form-control" 
                        id="InputFirstName"
                        placeholder="Keresztnév" 
                        v-model="model.firstName">
                </div>

                <!-- MiddleName -->
                <div v-if="model.middleName!=''"
                    class="mb-3 col-12 col-lg-4">
                  <label for="InputMiddleName" 
                          class="form-label">
                    Harmadiknév
                  </label>
                  <input type="text" 
                          class="form-control" 
                          id="InputMiddleName"
                          placeholder="Harmadiknév" 
                          v-model="model.middleName">
                </div>

                <!-- LastName -->
                <div :class="model.middleName!=''?
                        'col-lg-4':
                        'col-lg-6'"
                      class="mb-3 m-0 col-12">
                  <label for="InputLastName" 
                        class="form-label">
                    Vezetéknév
                  </label>
                  <input type="text" 
                        class="form-control" 
                        id="InputLastName"
                        placeholder="Vezetéknév"
                        v-model="model.lastName">
                </div>
              </div>

              <!-- Contact information -->
              <div class="row">
                <div>
                  <h5 class="text-center">Elérési módok</h5>
                </div>

                <!-- Email -->
                <div class="mb-3 col-12 col-lg-6">
                  <label for="InputEmail" 
                        class="form-label">
                    Email
                  </label>
                  <input type="email" 
                        class="form-control" 
                        id="InputEmail"
                        placeholder="Email cím" 
                        v-model="model.email">
                </div>

                <!-- PhoneNumber -->
                <div class="mb-3 col-12 col-lg-6">
                  <label for="InputPhoneNum" 
                        class="form-label">
                    Telefonszám
                  </label>
                  <input type="text" 
                        class="form-control" 
                        id="InputPhoneNum" 
                        placeholder="Telefonszám"
                        v-model="model.phoneNum">
                </div>
              </div>
            </div>

            <!-- Billing address -->
            <div v-if="step === 1">
              <!-- LastName -->
              <div class="row">

                <div class="col-lg-6 mb-3 m-0 col-12">
                  <label for="InputLastName" 
                        class="form-label">
                    Város
                  </label>
                  <input type="text" 
                        class="form-control" 
                        id="InputLastName"
                        v-model="model.city"
                        placeholder="Város">
                </div>

                <!-- LastName -->
                <div class="col-lg-6 mb-3 m-0 col-12">
                  <label for="InputLastName" 
                        class="form-label">
                    Irányítószám
                  </label>
                  <input type="text" 
                        class="form-control" 
                        id="InputLastName"
                        placeholder="Irányítószám"
                        v-model="model.postalCode">
                </div>

                <!-- Address -->
                <div class="col-lg-12 mb-3 m-0 col-12">
                  <label for="InputLastName" 
                        class="form-label">
                    Számlázási cím
                  </label>
                  <input type="text" 
                        class="form-control" 
                        id="InputLastName"
                        placeholder="Számlázási cím 1. sor"
                        v-model="model.address1">
                </div>

                <!-- Address -->
                <div class="col-lg-12 mb-3 m-0 col-12">
                  <label for="InputLastName" 
                        class="form-label">
                    Számlázási cím
                  </label>
                  <input type="text" 
                        class="form-control" 
                        id="InputLastName"
                        placeholder="Számlázási cím 2. sor"
                        v-model="model.address2">
                </div>
              </div>
            </div>

            <!-- Card information -->
            <div v-if="step === 2">
                <!-- Card data -->
                <div class="row">

                  <!-- cardNumber -->
                  <div class="mb-3 col-9 col-md-8 col-lg-10">
                    <label for="inputCardNumber" 
                            class="form-label">
                      Kártyaszám
                    </label>
                    <input type="text"
                          class="form-control"
                          id="inputCardNumber"
                          placeholder="Kártyaszám"
                          v-model="model.cardnumber">
                  </div>

                  <!-- CardBrand -->
                  <div class="mb-3 col-3 col-md-4 col-lg-2 m-0 d-flex align-items-end">
                    <img :src="`/cards/${currentCard}.png`"
                          class="img-fluid w-auto ratio-4x3"
                          style="height: 30px;" 
                          alt="">
                  </div>

                  <!-- Month -->
                  <div class="mb-3 col-6 col-lg-4">
                    <label class="form-label"
                            for="inputMonth">
                      Hónap
                    </label>
                    <select class="form-select"
                            id="inputMonth">
                      <option value="" selected>{{ model.expiration_month }}</option>
                      <option v-for="x in 12">{{ x.toString().padStart(2,'0') }}</option>
                    </select>
                  </div>

                  <!-- Year -->
                  <div class="mb-3 col-6 col-sm-3 col-lg-4">
                    <label class="form-label"
                            for="inputYear">
                      Év
                    </label>

                    <select class="form-select"
                            id="inputYear">
                      <option value=""
                              selected>
                        {{  model.expirationYear }}
                      </option>
                      <option v-for="x in 5" >
                        {{ parseInt(currentExpYear) + x }}
                      </option>
                    </select>
                  </div>

                  <!-- CVV -->
                  <div class="mb-3 col-6 col-sm-3 col-lg-4">
                    <label for="inputCVV" 
                            class="form-label">
                      CVV
                    </label>
                    <input type="text"
                            class="form-control"
                            id="inputCVV"
                            placeholder="CVV"
                            v-model="model.cvv">
                  </div>
                </div>
            </div>
          </div>
        </Transition>

        <!-- buttons -->
        <div class="row">
           <!-- Vissza gomb -->
          <button type="button"  
                  class="btn btn-outline-light text-center 
                         w-auto w-50 mx-auto" 
                  @click="transitionName = 'slide-in'; step--;"
                  v-bind:disabled="step===0">
            {{ $t("register.previous") }}
          </button>

          <!-- Következő gomb -->
          <button type="button" 
                  class="btn btn-outline-light text-center 
                         d-block w-auto w-50 mx-auto py-0" 
                  @click="step === 2 ? payForAccomadtion() 
                                     : (transitionName = 'slide-out',step++) " >
            {{ step === 2 ? "Fizetés" : "Következő"  }}
          </button>
        </div>
      </div>
    </div>
  </div>

</template>
<style>
input {
  outline: none;
}

.custom-width {
  width: 100%;
}

</style>