<script setup>
import { rent } from '@/store/current_rent';
import { user } from '@/store/user';
import { reactive } from 'vue';

console.log(rent);
console.log(user)

let model = reactive({
  firstName: user.firstname,
  lastName: user.lasttname,
  middleName: user.middlename,
  email: user.email,
  phoneNum: user.phone_number
})
</script>
<template>
  <div class="container">
    <h1 class="display-1 text-center text-center text-white">Kosár</h1>
    <!-- Billing adresses -->
    <div class="row">
      <button class="btn btn-outline-light mx-auto w-auto mb-5 mt-3" 
              type="button" 
              data-bs-toggle="collapse"
              data-bs-target="#billingCollapse" 
              aria-expanded="false" 
              aria-controls="billingCollapse">
        Számlázási adatok
      </button>

      <div class="collapse show" id="billingCollapse">
        <div class="card bg-black bg-opacity-25 w-75 mx-auto text-white border-white text-black card-body">
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
      <button class="btn btn-outline-light mx-auto w-auto mb-5 mt-3" 
              type="button" 
              data-bs-toggle="collapse"
              data-bs-target="#methodCollapse" 
              aria-expanded="false" 
              aria-controls="methodCollapse">
        Fizetési mód
      </button>

      <div class="collapse show" id="methodCollapse">
        <div class="card bg-black bg-opacity-25 w-50 mx-auto text-white border-white text-black card-body">
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
                       id="radioCash">
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
                       id="radioCard">
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
                       id="radioPayPay">
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>
<style>
input {
  outline: none;
}

.custom-width{
  width: 100%;
}

@media (min-width: 900px) {
  .w-md-50{
    width: 50% !important;
  }
}
</style>