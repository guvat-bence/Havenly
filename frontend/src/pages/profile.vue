<script setup>
import { user } from '@/store/user';
import router from '@/router';
import { reactive, ref } from 'vue';

//securityCheck
if(!user.id)
  router.back()

let model = reactive({
  firstName: user.firstname,
  lastName: user.lasttname,
  middleName: user.middlename == null ? "" : user.middlename,
  email: user.email,
  phoneNum: user.phone_number,
  gender: user.gender,
})

let card = reactive({
  cardnumber: user.cardNumber,
  expiration_month: user.expirationMonth,
  expirationYear: user.expirationYear,
  cvv: user.cvv
}) 

console.log(card);

let currentExpYear = ref(new Date().getFullYear().toString().substring(2,4))

</script>
<template>
  <div class="account">
    <div class="container">
      
      <nav>
        <div class="nav nav-tabs justify-content-center" 
             id="nav-tab" 
             role="tablist">
          <button class="nav-link active"
                  id="nav-datas-tab"
                  data-bs-toggle="tab"
                  data-bs-target="#nav-datas"
                  type="button" role="tab"
                  aria-controls="nav-datas"
                  aria-selected="true">
            Adataim
          </button>
          <button class="nav-link" 
                  id="nav-posts-tab" 
                  data-bs-toggle="tab" 
                  data-bs-target="#nav-posts" 
                  type="button" role="tab" 
                  aria-controls="nav-posts" 
                  aria-selected="false">
            Közzétételeim
          </button>
          <button class="nav-link" 
                  id="nav-chats-tab" 
                  data-bs-toggle="tab" 
                  data-bs-target="#nav-chats" 
                  type="button" 
                  role="tab" 
                  aria-controls="nav-chats" 
                  aria-selected="false">
            Beszégetéseim
          </button>
        </div>
      </nav>

      <div class="tab-content text-white
                  text-center bg-dark rounded-5 rounded-top-0 py-4" 
            id="nav-tabContent">
        <div class="tab-pane fade show active"
             id="nav-datas" 
             role="tabpanel" 
             aria-labelledby="nav-datas-tab" 
             tabindex="0">
          
          <div class="row justify-content-center">

       
            <form class="w-50">
              <h4 class="text-center">Személyes adatok</h4>
              <div class="px-3 py-3 border rounded-3">
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

                  <!-- Gender -->
                  <div class="mb-4">
                    <h5 class="text-center">
                      {{ $t("register.gender") }}
                    </h5>
                    <div class="row justify-content-center text-center">
                      <label for="genderMale" 
                            class="form-label col-6">
                        <span>{{ $t("register.male") }}</span> 
                      </label>
                      <label for="genderFemale" 
                            class="form-label col-6">
                        <span>{{ $t("register.female") }}</span>
                      </label>
                    </div>
                    <div class="row justify-content-center">
                      <div class="d-flex col-6 justify-content-center">
                        <input type="radio"
                          name="genderMale"
                          class="form-check-input" 
                          id="genderMale"
                          value="M"
                          v-model="model.gender">
                      </div>
                      <div class="d-flex col-6 justify-content-center">
                        <input type="radio"
                              name="genderFemale" 
                              class="form-check-input" 
                              id="genderFemale"
                              value="F"
                              v-model="model.gender">
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <h4 v-if="card.cardnumber!='null'"
                  class="text-center mt-5">Kártya adatok</h4>

              <div v-if="card.cardnumber!='null'"
                   class="px-3 py-3 border rounded-3">

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
                    <label for="InputOwnerFirstName" 
                          class="form-label">
                      Vezetéknév
                    </label>
                    <input type="text" 
                            class="form-control" 
                            id="InputOwnerFirstName" 
                            v-model="model.lastName">
                  </div>

                  <!-- MiddleName -->
                  <div class="mb-2 m-0 col-12 col-lg-4">
                    <label for="InputOwnerFirstName" 
                          class="form-label">
                      Harmadiknév
                    </label>
                    <input type="text" 
                            class="form-control" 
                            id="InputOwnerFirstName" 
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
                    <img src="/cards/mastercard.png"
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
              </div>

            </form>
          </div>
        </div>
        <div class="tab-pane fade" 
             id="nav-posts" 
             role="tabpanel" 
             aria-labelledby="nav-posts-tab" 
             tabindex="0">
          Lorem ipsum dolor sit amet consectetur adipisicing elit. Dolores cumque excepturi nemo odio qui. Quam magni odio debitis eius temporibus ex natus, alias doloribus veritatis, quasi eligendi, ratione nulla voluptates.
        </div>
        <div class="tab-pane fade"
             id="nav-chats" 
             role="tabpanel" 
             aria-labelledby="nav-chats-tab" 
             tabindex="0">
          Lorem ipsum dolor sit amet consectetur adipisicing elit. Rerum laudantium, est qui voluptate sint tempore quasi ipsa repellendus esse mollitia quos velit fugit voluptas, perferendis, quas blanditiis neque. Optio, sit?
        </div>
      </div>
    </div>
  </div>
</template>
<style scoped>

/* Regisztrációs inputok effektusai */
input:not([type="checkbox"],[type="radio"]):focus,
input:not([type="checkbox"],[type="radio"]):hover,
input:not([type="checkbox"],[type="radio"])::after {
  background-color: white !important;
  box-shadow: 0px 0px 10px white !important;
  transition: 200ms;
  color: black !important;
}

.nav-tabs {
    --bs-nav-tabs-link-active-color: black;
}

.nav-link {
    --bs-nav-link-color:rgb(149, 158, 152);
    --bs-nav-link-hover-color: white;
}
</style>