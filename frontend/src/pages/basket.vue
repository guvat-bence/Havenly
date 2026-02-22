<script setup>
import { useRouter } from 'vue-router';
import { selectedCurrency } from '@/store/currency';
import { rent } from '@/store/current_rent';
import { user } from '@/store/user';
import { reactive, ref, watch } from 'vue';
import axios from 'axios';


let router = useRouter()

let accommodation_data = JSON.parse(rent.accommodation);

let cardData = ref([])
let currentCard = ref("")

// véletlenszerü 5 ország beolvasása
axios.get('http://localhost:3000/getCardNetwork')
  .then(response => {
    cardData.value = response.data
    console.log(cardData.value)
  })
  .catch(e => console.error(e))

if (!accommodation_data.id || !user.id)
  router.back()

let model = reactive({
  firstName: user.firstname,
  lastName: user.lasttname,
  middleName: !user.middlename ? "" : user.middlename,
  email: user.email,
  phoneNum: user.phone_number,
})

let card = reactive({
  cardnumber: user.cardNumber,
  expiration_month: user.expirationMonth,
  expirationYear: user.expirationYear,
  cvv: user.cvv
}) 

console.log(user.middlename)

let currentExpYear = ref(new Date().getFullYear().toString().substring(2,4))

model.method = "creditcard"



// Format text to readable
let convertStrings = (str) => {
  return str.normalize("NFD")
            .replace(/[\u0300-\u036f]/g, "")
            .replaceAll(" ", "_")
            .toLowerCase();
};

watch(() => card.cardnumber, (x) => {
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
    <h1 class="display-1 text-center text-white ">Kosár</h1>
    <div class="row flex-row-reverse">

      <!-- Accomodation data-->
      <div class="col-12 col-md-6">
        <div class="row">
          <div class="d-flex justify-content-center justify-content-lg-end">

            <!-- Card -->
            <div class="card bg-black bg-opacity-25 border-1 
                        border-white bg-opacity-25 text-white" 
                 style="width: 18rem;">
              
              <!-- Image -->
              <img height="300" 
                   :src="`/countries/${convertStrings(accommodation_data.country_name)}` +
                         `/cities/${convertStrings(accommodation_data.city_name)}` +
                         `/accommodations/${convertStrings(accommodation_data.folder_name)}/001.png`"
                   class="card-img-top" 
                   alt="accomodation_image">
              <div class="card-body">
                <h5 class="card-title">{{ accommodation_data.name }}</h5>
                <hr>
                <div>
                  <h4 class="text-center mb-4">Adatok</h4>
                  <div class="row text-center">
                    <p>Személyszám: {{ rent.guests}}</p>
                    <p>Ettől: {{ rent.rent_beginning }}</p>
                    <p>Eddig: {{ rent.rent_end }}</p>
                  </div>
                  <hr>
                  <h4 class="text-center">Ár</h4>
                  <div class="row">
                    <p>Alapár: {{ (rent.accommodation_full_price * selectedCurrency.currencyMultiplier).toLocaleString('fi-FI') }} 
                               {{ selectedCurrency.currencyShortedName }}</p>
                    <p>Kezelési díj 
                      <span class="text-danger">(8%)</span>:
                      {{ ((rent.accommodation_full_price * selectedCurrency.currencyMultiplier) * 0.08).toLocaleString('fi-FI') }} 
                      {{ selectedCurrency.currencyShortedName }}
                    </p>
                  </div>
                  <hr>
                  <div class="row">
                    <p class="fw-bold mb-0">Összesen: 
                      {{((rent.accommodation_full_price * selectedCurrency.currencyMultiplier) + 
                        ((rent.accommodation_full_price * selectedCurrency.currencyMultiplier) * 0.1)).toLocaleString('fi-FI')}}
                      {{ 
                        selectedCurrency.currencyShortedName
                      }}
                  </p>
                  </div>

                  <hr>
                  <div class="row">
                    <button class="btn btn-outline-light w-auto mx-auto">
                      Megerősítés
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      
      <!-- user datas -->
      <div class="col-12 col-md-6">
        <!-- Billing adresses -->
        <div class="row">
          <h4 class="text-white mx-auto w-auto mt-4" 
              data-bs-toggle="collapse"
              data-bs-target="#billingCollapse"
              aria-controls="billingCollapse">
            Számlázási adatok
          </h4>

          <div class="collapse show" 
               id="billingCollapse">
            <div class="card bg-black bg-opacity-25 w-75 mx-auto 
                        text-white border-white text-black card-body">
              <form>

                <!-- Names -->
                <div class="row mb-3">
                  <div>
                    <h5 class="text-center">Nevek</h5>
                  </div>

                  <!-- FirstName -->
                  <div class="mb-3 m-0 col-12 col-lg-4">
                    <label for="InputFirstName" 
                           class="form-label">
                      Keresztnév
                    </label>
                    <input type="text" 
                           class="form-control" 
                           id="InputFirstName" 
                           v-model="model.firstName">
                  </div>

                  <!-- LastName -->
                  <div class="mb-3 col-12 col-lg-4">
                    <label for="InputLastName" 
                           class="form-label">
                      Vezetéknév
                    </label>
                    <input type="text" 
                           class="form-control" 
                           id="InputLastName"
                            v-model="model.lastName">
                  </div>

                  <!-- MiddleName -->
                  <div class="mb-3 col-12 col-lg-4">
                    <label for="InputMiddleName" 
                           class="form-label">
                      Harmadiknév
                    </label>
                    <input type="text" 
                           class="form-control" 
                           id="InputMiddleName" 
                           v-model="model.middleName">
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
                           v-model="model.phoneNum">
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>

        <!-- Payment method -->
        <div class="row">
          <h4 class="text-white mx-auto w-auto mt-4" 
              data-bs-toggle="collapse"
              data-bs-target="#methodCollapse" 
              aria-controls="methodCollapse">
            Fizetési mód
          </h4>

          <div class="collapse show" 
              id="methodCollapse">
            <div class="card bg-black bg-opacity-25 w-50 
                        mx-auto text-white border-white text-black 
                        card-body">
              <form>
                <div class="row">

                  <!-- Cash -->
                  <div class="form-check d-flex justify-content-between 
                              align-items-center mb-2">
                    <label class="form-check-label h5" 
                          for="radioCash">
                      Készpénz
                    </label>
                    <input class="form-check-input" 
                          type="radio" 
                          name="radioDefault" 
                          id="radioCash"
                          value="cash"
                          v-model="model.method">
                  </div>

                  <hr>

                  <!-- CreditCard -->
                  <div class="form-check d-flex justify-content-between 
                              align-items-center mb-2">
                    <label class="form-check-label h5" 
                          for="radioCard">
                      Bankkártya
                    </label>
                    <input class="form-check-input" 
                          type="radio" 
                          name="radioDefault" 
                          id="radioCard"
                          value="creditcard"
                          v-model="model.method">
                  </div>

                  <hr>

                  <!-- Paypal -->
                  <div class="form-check d-flex justify-content-between 
                            align-items-center">
                    <label class="form-check-label h5" 
                          for="radioPayPal">
                      PayPal
                    </label>
                    <input class="form-check-input" 
                          type="radio" 
                          name="radioDefault" 
                          id="radioPayPal"
                          value="paypal"
                          v-model="model.method">
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>

        <!-- Card information -->
        <div>
          <div class="row"
               v-if="model.method == 'creditcard' || 
                     model.method == 'paypal'">
              <h4 class="text-center text-white mt-4"
                  data-bs-toggle="collapse"
                  data-bs-target="#cardDataCollapse" 
                  aria-controls="cardDataCollapse">
                Kártya adatok
              </h4>

              <div id="cardDataCollapse"
                  class="collapse show">
                <div class="bg-black bg-opacity-25 text-center 
                            text-white border-1 border-white 
                            card w-auto mx-auto text-white p-3">
                  <form v-if="model.method == 'creditcard'">


                    <h4>Kártya tulajdonos neve</h4>
                    <!-- Owner data -->
                    <div class="row">

                      <!-- FirstName -->
                      <div class="mb-2 m-0 col-12 col-lg-4">
                        <label for="InputOwnerFirstName" 
                              class="form-label">
                          Keresztnév
                        </label>
                        <input type="text" 
                               class="form-control" 
                               id="InputOwnerFirstName" 
                               v-model="model.firstName">
                      </div>

                      <!-- LastName -->
                      <div class="mb-2 m-0 col-12 col-lg-4">
                        <label for="InputOwnerLastName" 
                              class="form-label">
                          Vezetéknév
                        </label>
                        <input type="text" 
                               class="form-control" 
                               id="InputOwnerLastName" 
                               v-model="model.lastName">
                      </div>

                      <!-- MiddleName -->
                      <div class="mb-2 m-0 col-12 col-lg-4">
                        <label for="InputOwnerMiddleName" 
                              class="form-label">
                          Harmadiknév
                        </label>
                        <input type="text" 
                               class="form-control" 
                               id="InputOwnerMiddleName" 
                               v-model="model.middleName">
                      </div>
                    </div>

                    <hr class="m-2">

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
                              v-model="card.cardnumber">
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
                          <option value="" selected>{{ card.expiration_month }}</option>
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
                            {{  card.expirationYear }}
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
                               v-model="card.cvv">
                      </div>
                    </div>
                  </form>
                </div>
              </div>
          </div>
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