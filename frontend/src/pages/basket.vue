<script setup>
import router from '@/router';
import { selectedCurrency } from '@/store/currency';
import { rent } from '@/store/current_rent';
import { user } from '@/store/user';
import { reactive } from 'vue';

let accommodation_data = reactive(JSON.parse(rent.accommodation));

console.log(user.cardNumber)

if (!accommodation_data.id)
  router.back()

let model = reactive({
  firstName: user.firstname,
  lastName: user.lasttname,
  middleName: user.middlename,
  email: user.email,
  phoneNum: user.phone_number
})

let card = reactive({
  cardnumber: user.cardNumber === null ? ""  : user.cardNumber,
  expiration: user.expiration,
}) 
let convertStrings = (str) => {
      
    	
  return str.normalize("NFD")
            .replace(/[\u0300-\u036f]/g, "")
            .replaceAll(" ", "_")
            .toLowerCase();}
</script>
<template>
  <div class="container mt-2">
    <h1 class="display-1 text-center text-white ">Kosár</h1>
    <div class="row flex-row-reverse">

      <!-- Accomodation data-->
      <div class="col-12 col-md-6">
        <div class="row">
          <div class="d-flex justify-content-center justify-content-lg-end">
            <div class="card bg-black bg-opacity-25 border-1 
                        border-white bg-opacity-25 text-white" 
                 style="width: 18rem;">
              <img height="300" 
                   :src="`/countries/${convertStrings(accommodation_data.country_name)}` +
                         `/cities/${convertStrings(accommodation_data.city_name)}` +
                         `/accommodations/${convertStrings(accommodation_data.folder_name)}/001.png`"
                   class="card-img-top" 
                   alt="...">
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
          <h4 class="text-white mx-auto w-auto mb-5 mt-3" 
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
          <h4 class="text-white mx-auto w-auto mb-5 mt-3" 
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
                            align-items-center">
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

                  <!-- Szépcard -->
                  <div class="form-check d-flex justify-content-between 
                            align-items-center">
                    <label class="form-check-label h5" 
                          for="radioPayPal">
                      PayPal
                    </label>
                    <input class="form-check-input" 
                          type="radio" 
                          name="radioDefault" 
                          id="radioPayPay"
                          value="paypal"
                          v-model="model.method">
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>

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
                            card w-auto mx-auto text-white p-2">
                  <form v-if="model.method == 'creditcard'">

                    <!-- FirstName -->
                    <h4>Kártya tulajdonos neve</h4>
                    <div class="row">
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
                      <div class="mb-3 m-0 col-12 col-lg-4">
                        <label for="InputFirstName" 
                              class="form-label">
                          Vezetéknév
                        </label>
                        <input type="text" 
                               class="form-control" 
                               id="InputFirstName" 
                               v-model="model.lastName">
                      </div>

                      <!-- MiddleName -->
                      <div class="mb-3 m-0 col-12 col-lg-4">
                        <label for="InputFirstName" 
                              class="form-label">
                          Harmadiknév
                        </label>
                        <input type="text" 
                               class="form-control" 
                               id="InputFirstName" 
                               v-model="model.middleName">
                      </div>
                    </div>

                    <hr>

                    <!-- card data -->
                    <div class="row">
                      <!-- cardNumber -->
                      <div class="mb-3 m-0 col-12">
                        <label for="inputCardNumber" 
                              class="form-label">
                          Kártyaszám
                        </label>
                        <input type="text" 
                               class="form-control" 
                               id="inputCardNumber" 
                               v-model="card.cardnumber">
                      </div>

                      <!-- card expirationDate and cvv  -->
                      <div class="mb-3 m-0 col-12">
                        <label for="inputCardNumber" 
                              class="form-label">
                          Kártyaszám
                        </label>
                        <input type="text" 
                               class="form-control" 
                               id="inputCardNumber" 
                               v-model="card.expiration">
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

@media (min-width: 900px) {
  .w-md-50 {
    width: 50% !important;
  }
}
</style>