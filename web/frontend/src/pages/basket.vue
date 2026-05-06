<script setup>
import { useRouter } from 'vue-router';
import { selectedCurrency } from '@/store/currency';
import { rent } from '@/store/current_rent';
import { user } from '@/store/user';
import { reactive, ref, Transition, watch } from 'vue';
import axios from 'axios';
import { convertStrings } from '@/common';
import { useI18n } from 'vue-i18n';

const {t} = useI18n();
let router = useRouter()
let cardData = ref([])
let currentCard = ref("")
let accommodation_data = "";
let showDatas = ref(false);

try
{
accommodation_data = JSON.parse(rent.accommodation);

if (!accommodation_data.id || !user.id)
  router.back()
}
catch{
  router.back();
}

if(!user.id)
  router.back()

// Kártyatipusok beolvasása
axios.get('http://localhost:3000/getCardNetwork')
  .then(response => {
    cardData.value = response.data
  })
  .catch(e => console.error(e))

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
  firstName: null,
  lastName: null,
  middleName: null,
  email: null,
  phoneNum: null,
  cardnumber: null,
  expiration_month: null,
  expirationYear: null,
  address1: null,
  address2: null,
  cvv: null,
  city: null,
  postalCode: null,
  address: null,
  door: null,
  message:"",
})

// Ezzel a functionnal állítjuk be vagy éppen töröljük ki a profilban megadott kártyadatokat.
function showCardDatas()
{
  showDatas.value = showDatas.value == true?false:true;

  if(showDatas.value == true)
  {
    model.cardnumber = user.cardNumber;
    model.expiration_month = user.expirationMonth;
    model.expirationYear = user.expirationYear;
  }
  else{
    model.cardnumber = "";
    model.expiration_month = null;
    model.expirationYear = null;
  }
}

let currentExpYear = ref(new Date().getFullYear().toString().substring(2,4))

let payForAccomadtion = () => {

  model.message = t("basket.rent_message");

  axios.post('http://localhost:3000/rentAccomodation', model)
  .then(response => {
    console.log(response.data)
    if(response.data =='Sikeres foglalás')
    {
      alert(t("basket.succesful_renting"));
    }
    else{
      alert(response.data);
    }
    rent.accommodation_full_price="";
    rent.rent_beginning="";
    rent.rent_end="";
    rent.accommodation_path="";
    rent.guests="";
    rent.accommodation="";
    router.push("/");
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

let validateData = () => {
  if(!model.firstName || !model.lastName)
    return false

  if (!/^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test(model.email))
    return false;

  if (!/^\+?[0-9\s\-\(\)]{7,40}$/.test(model.phoneNum))
    return false;

  if(!model.city || 
     !model.postalCode || 
     !model.address1)
    return false

  if(!model.cvv || !model.expirationYear || !model.expiration_month)
    return false

  if(!model.cardnumber || !/^[0-9]{13,24}$/.test(model.cardnumber) || !currentCard.value)
    return false;

  return true
}  
</script>
<template>
  <div class="container mt-2">
    <h1 class="display-1 text-center text-white">{{ $t("basket.title") }}</h1>
    <div class="row flex-row-reverse">

      <!-- Accomodation data-->
      <div class="col-12 col-md-6 mb-4 text-center">
        <div class="row">
          <div class="d-flex justify-content-center justify-content-lg-end">

            <!-- Card -->
            <div class="card bg-dark bg-opacity-50 border-1 
                        border-white text-white w-75">
              
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
                    <p>{{ $t("basket.card.person_number") }} {{ rent.guests}}</p>
                    <p>{{ $t("basket.card.from") }} {{ rent.rent_beginning }}</p>
                    <p>{{ $t("basket.card.to") }} {{ rent.rent_end }}</p>
                  </div>
                  <hr>

                  <!-- Prices -->
                  <div>
                    <p>{{ $t("basket.card.price") }} {{ (rent.accommodation_full_price * 
                                   selectedCurrency.currencyMultiplier).toLocaleString('fi-FI') }} 
                               {{ selectedCurrency.currencyShortedName }}</p>
                    <p>{{ $t("basket.card.tax") }} 
                      <span class="text-danger">(8%)</span>:
                      {{ ((rent.accommodation_full_price * 
                           selectedCurrency.currencyMultiplier) * 0.08).toLocaleString('fi-FI') }} 
                      {{ selectedCurrency.currencyShortedName }}
                    </p>
                  </div>
                  <hr>

                  <!-- Overall price -->
                  <div>
                    <p class="fw-bold mb-0">{{ $t("basket.card.final_price") }}
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

        <h4 class="display-5 mb-4 text-center">{{ $t("basket.user_datas.title") }}</h4>
        
        <Transition :name="transitionName"
                    type="transition" 
                    mode="out-in">
          <div :key="step">
            <!-- Personal data -->
            <div v-if="step === 0">
              <!-- Names -->
              <div class="row justify-content-center mb-3">
                <div>
                  <h5 class="text-center">{{ $t("basket.user_datas.names") }}</h5>
                </div>

                <!-- FirstName -->
                <div :class="model.middleName!=''?
                        'col-lg-4':
                        'col-lg-6'"
                      class="mb-3 m-0 col-12">
                  <label for="InputFirstName" 
                        class="form-label">
                    {{ $t("basket.user_datas.first_name") }}
                    <span class="text-danger">*</span>
                  </label>
                  <input type="text" 
                         class="form-control" 
                         id="InputFirstName"
                         :placeholder="t('basket.user_datas.first_name')" 
                         v-model="model.firstName">
                </div>

                <!-- MiddleName -->
                <div v-if="model.middleName!=''"
                    class="mb-3 col-12 col-lg-4">
                  <label for="InputMiddleName" 
                          class="form-label">
                    {{ $t("basket.user_datas.middle_name") }}
                  </label>
                  <input type="text" 
                          class="form-control" 
                          id="InputMiddleName"
                          :placeholder="t('basket.user_datas.middle_name')" 
                          v-model="model.middleName">
                </div>

                <!-- LastName -->
                <div :class="model.middleName!=''?
                        'col-lg-4':
                        'col-lg-6'"
                      class="mb-3 m-0 col-12">
                  <label for="InputLastName" 
                        class="form-label">
                    {{ $t('basket.user_datas.last_name') }}
                    <span class="text-danger">*</span>
                  </label>
                  <input type="text" 
                        class="form-control" 
                        id="InputLastName"
                        :placeholder="t('basket.user_datas.last_name')" 
                        v-model="model.lastName">
                </div>
              </div>

              <!-- Contact information -->
              <div class="row">
                <div>
                  <h5 class="text-center">{{ $t("basket.user_datas.contact_information") }}</h5>
                </div>

                <!-- Email -->
                <div class="mb-3 col-12 col-lg-6">
                  <label for="InputEmail" 
                        class="form-label">
                    {{ $t("basket.user_datas.email") }}
                    <span class="text-danger">*</span>
                  </label>
                  <input type="email" 
                        class="form-control" 
                        id="InputEmail"
                        :placeholder="t('basket.user_datas.email')" 
                        v-model="model.email">
                </div>

                <!-- PhoneNumber -->
                <div class="mb-3 col-12 col-lg-6">
                  <label for="InputPhoneNum" 
                        class="form-label">
                    {{ $t("basket.user_datas.phone_number") }}
                    <span class="text-danger">*</span>
                  </label>
                  <input type="text" 
                        class="form-control" 
                        id="InputPhoneNum" 
                        :placeholder="t('basket.user_datas.phone_number')"
                        v-model="model.phoneNum">
                </div>
              </div>
            </div>

            <!-- Billing address -->
            <div v-if="step === 1">

              <div class="row">
                
                <!-- city -->
                <div class="col-lg-6 mb-3 m-0 col-12">
                  <label for="InputCity" 
                        class="form-label">
                    {{ $t("basket.user_datas.city") }}
                    <span class="text-danger">*</span>
                  </label>
                  <input type="text" 
                        class="form-control" 
                        id="InputCity"
                        v-model="model.city"
                        :placeholder="t('basket.user_datas.city')">
                </div>

                <!-- postal code -->
                <div class="col-lg-6 mb-3 m-0 col-12">
                  <label for="InputPostal" 
                        class="form-label">
                    {{ $t("basket.user_datas.postal_code") }}
                    <span class="text-danger">*</span>
                  </label>
                  <input type="number" 
                        class="form-control" 
                        id="InputPostal"
                        :placeholder="t('basket.user_datas.postal_code')"
                        v-model="model.postalCode">
                </div>

                <!-- Address1 -->
                <div class="col-lg-12 mb-3 m-0 col-12">
                  <label for="InputAddress1" 
                        class="form-label">
                    {{ $t("basket.user_datas.billing_addres") }}
                    <span class="text-danger">*</span>
                  </label>
                  <input type="text" 
                        class="form-control" 
                        id="InputAddress1"
                        :placeholder="t('basket.user_datas.billing_addres')"
                        v-model="model.address1">
                </div>

                <!-- Address2 -->
                <div class="col-lg-12 mb-3 m-0 col-12">
                  <label for="InputAddress2" 
                        class="form-label">
                    {{ $t("basket.user_datas.billing_addres") }}
                  </label>
                  <input type="text" 
                        class="form-control" 
                        id="InputAddress2"
                        :placeholder="t('basket.user_datas.billing_addres')"
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
                      {{ $t("basket.user_datas.card_number") }}
                      <span class="text-danger">*</span>
                    </label>
                    <input type="text"
                          class="form-control"
                          id="inputCardNumber"
                          :placeholder="t('basket.user_datas.card_number')"
                          v-model="model.cardnumber"
                          maxlength="24">
                  </div>

                  <!-- CardBrand -->
                  <div class="mb-3 col-3 col-md-4 col-lg-2 m-0 d-flex align-items-end">
                    <img  v-if="model.cardnumber!=null && model.cardnumber?.length>3"
                          :src="`/cards/${currentCard}.png`"
                          @error="e => e.target.classList.add('d-none')"
                          @load="e => e.target.classList.remove('d-none')"
                          class="img-fluid w-auto ratio-4x3"
                          style="height: 30px;" 
                          alt="CardBrand">
                  </div>

                  <!-- Month -->
                  <div class="mb-3 col-6 col-lg-4">
                    <label class="form-label"
                            for="inputMonth">
                      {{ $t("basket.user_datas.month") }}
                      <span class="text-danger">*</span>
                    </label>
                    <select class="form-select"
                            id="inputMonth"
                            v-model="model.expiration_month">

                      <option value="null"
                              :selected="!model.expiration_month"
                              class="d-none"
                              disabled="true">
                        {{ $t("basket.user_datas.month") }}
                      </option>

                      <option v-for="x in 12">
                        {{ x.toString().padStart(2,'0') }}
                      </option>
                    </select>
                  </div>

                  <!-- Year -->
                  <div class="mb-3 col-6 col-sm-3 col-lg-4">
                    <label class="form-label"
                            for="inputYear">
                      {{ $t("basket.user_datas.year") }}
                      <span class="text-danger">*</span>
                    </label>

                    <select class="form-select"
                            id="inputYear"
                            v-model="model.expirationYear">

                      <option value="null"
                              :selected="!model.expirationYear"
                              class="d-none">
                         {{ $t("basket.user_datas.year") }}
                      </option>

                      <option v-for="x in 5">
                        {{ parseInt(currentExpYear) + x }}
                      </option>
                    </select>
                  </div>

                  <!-- CVV -->
                  <div class="mb-3 col-6 col-sm-3 col-lg-4">
                    <label for="inputCVV" 
                            class="form-label">
                       {{ $t("basket.user_datas.cvv") }}
                       <span class="text-danger">*</span>
                    </label>
                    <input type="text"
                            class="form-control"
                            id="inputCVV"
                            :placeholder="t('basket.user_datas.cvv')"
                            v-model="model.cvv"
                            maxlength="3">
                  </div>

                  <!-- Card Datas -->
                  <div v-if="user.cardNumber!=''"
                       class="mb-3 form-check 
                              d-flex justify-content-center">

                    <input type="checkbox" 
                           class="form-check-input me-1" 
                           id="cardDatas"
                           @change="showCardDatas()">

                    <label class="form-check-label" 
                           for="cardDatas">
                      {{ $t("basket.user_datas.card_datas") }}
                    </label>
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
                                     : (transitionName = 'slide-out',step++) "
                    v-bind:disabled="step === 2  && !validateData()" >
            {{ step === 2 ? $t("basket.pay") : $t("register.next") }}
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