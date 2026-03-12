<script setup>
import router from '@/router';
import { user } from '@/store/user';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import axios from 'axios';
import { reactive, ref, watch } from 'vue';


//securityCheck
  if(user.id)
    router.push("/havenly")

// Változók és funkciók deklarálása
let step = ref(0),
  showpasscheck = ref(false),
  transitionName = ref("slide-in"),
  progesswidth = ref(0),
  message = "",
  isSuccess = null,
  model = reactive({
    lastname: "",
    firstname: "",
    middlename: "",
    email: "",
    phone_number: "",
    gender:"",
    password: "",
    confirmpass: ""
  }),
  messages= 
  {
    email:"Ez az email már foglalt!",
    phone_number:"Ez a telefonszám már foglalt!",
    success:"Sikeres regisztráció!"
  },

  // Adatokat ellenőrzése
  validateForm = () => {
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test(model.email))
      return false;

    if (model.firstname.length === 0 ||
        model.lastname === 1)
      return false

    if (!/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,40}$/.test(model.password))
      return false;

    if (model.password !== model.confirmpass)
      return false

    if(model.password.length >= 40 || model.password.length <= 6)
      return false;

    if (!/^\+?[0-9\s\-\(\)]{7,40}$/.test(model.phone_number))
      return false;

    if(model.gender == "")
      return false;

    return true;
  },

  // Regiszrációs függvény
  doRegister = () => {
    axios.post('http://localhost:3000/register', model)
      .then(response => {
        message = response.data.message;
        isSuccess = response.data.success;

        if(isSuccess){
          setTimeout(() => {
            user.id = response.data.insertedId
            user.firstname = model.firstname;
            user.lasttname = model.lastname;
            user.middlename = model.middlename;
            user.email = model.email;
            user.phone_number = model.phone_number;
            user.user_type = "U";
            user.gender = model.gender;
            router.push("/havenly");
            location.reload();
          }, 1500);
        }
      })
      .catch(e => console.error(e))
  }

//A step változó változása esetén fusson ez a függvény
watch(step, () => {
  // A progess width-et értéke legyen step szorozva 33
  progesswidth.value = step.value * 33
  //Ha eléri a 99-es értéket akkor legyen 100
  //Ha eléri a 99-et akkor hajtsa végre a do register függvényt
  //A 99 csak abban az esetben elérhető ha már elvégezte az utolsó pontot
  if (progesswidth.value === 99) {
    progesswidth.value = 100
    doRegister();
  }
})

//Model elemek változására hajtsa validateForm függvényt
watch(model, () => {
  validateForm();
})
</script>

<template>
  <div class="register">

    <!-- progressbar -->
    <div class="d-flex justify-content-center mt-4 mb-4">
      <div class="progress w-50 bg-black border border-1 border-white" 
           role="progressbar"
           aria-label="Animated striped example" 
           aria-valuenow="0" 
           aria-valuemin="0" 
           aria-valuemax="100">
        <div class="progress-bar progress-bar-striped progress-bar-animated bg-white"
          :style="{ width: progesswidth + '%' }">
        </div>
      </div>
    </div>

    <div class="d-flex justify-content-center align-items-center">
      <form class="border p-4 border-1 
                    border-white text-white rounded-3 
                    bg-dark bg-opacity-50 mb-3">

        <div>
          <h1 class="text-center h2 mb-3" v-if="step !== 3">
            {{ step + 1 }}. {{ $t("register.title") }}
          </h1>
        </div>
        <!-- Animációs komponens -->
        <Transition :name="transitionName" 
                     type="transition" 
                     mode="out-in">
          <div :key="step">

            <!-- A név form rész -->
            <div class="mb-3" v-if="step === 0">

              <!-- Vezetéknév -->
              <div class="mb-3">
                <div class="form-text text-white text-center 
                            d-flex justify-content-center align-items-center 
                            gap-1">
                  <label for="lastName">
                    <span>{{ $t("register.last_name") }}</span>
                    <span class="text-danger">*</span>
                  </label>
                </div>
                <div>
                  <input type="text" 
                         class="form-control bg-transparent text-white"
                         id="lastName"
                         v-model="model.lastname">
                </div>

                <!-- Keresztnév -->
                <div>
                  <div class="form-text text-white text-center 
                              d-flex justify-content-center align-items-center 
                              gap-1">
                    <label for="firstName">
                      <span>{{ $t("register.first_name") }}</span>
                      <span class="text-danger">*</span>
                    </label>
                  </div>
                  <input type="text" 
                         class="form-control bg-transparent text-white" 
                         id="firstName"
                         v-model="model.firstname">

                </div>

                <!-- Harmadiknév -->
                <div>
                  <div class="form-text text-white text-center 
                              d-flex justify-content-center align-items-center 
                              gap-1">
                    <label for="middleName">
                      <span>{{ $t("register.middle_name") }}</span>
                    </label>
                  </div>
                  <input type="text" 
                         class="form-control bg-transparent text-white" 
                         id="middleName"
                         v-model="model.middlename">
                </div>
              </div>
            </div>

            <!-- Contact információk form rész -->
            <div class="mb-3" v-else-if="step === 1">

              <!-- Email cím -->
              <div class="mb-3">
                <label for="InputEmail1" 
                       class="form-label">
                  <span>{{ $t("register.email") }}</span>
                  <span class="text-danger">*</span>
                </label>
                <input type="email" 
                       class="form-control bg-transparent text-white" 
                       id="InputEmail1"
                       aria-describedby="emailHelp" 
                       v-model="model.email">
              </div>

              <!-- Telefonszám -->
              <div class="mb-3">
                <label for="phoneNumber" 
                       class="form-label">
                  <span>{{ $t("register.phone_number") }}</span>
                  <span class="text-danger">*</span>
                </label>
                <input type="text" 
                       class="form-control bg-transparent text-white" 
                       id="phoneNumber"
                       v-model="model.phone_number">
                  <div class="form-text text-white fw-bold">
                    {{ $t("register.example_phone_number") }}
                  </div>
              </div>

              <!-- Gender -->
              <div class="mb-4">
                <h5 class="text-center">
                  {{ $t("register.gender") }}
                  <span class="text-danger">*</span>
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

            <!-- Jelszó megadása form rész -->
            <div class="mb-3" v-else-if="step === 2">

              <!-- Jelszó-->
              <div>
                <label for="InputPassword" 
                       class="form-label">
                  <span>{{ $t("register.password") }}</span>
                  <span class="text-danger">*</span>
                </label>
                <input :type="showpasscheck ? 'text' : 'password'" 
                       class="form-control bg-transparent text-white" 
                       id="InputPassword"
                       autocomplete="off"
                       minlength="6"
                       maxlength="40" 
                       v-model="model.password">
                  <div class="form-text text-white fw-bold">
                    {{ $t("register.password_requirement") }}
                  </div>
                  <div class="form-text text-white fw-bold">
                    {{ $t("register.password_requirement_second") }}
                  </div>
              </div>

              <!-- Jelszó mégegyszer -->
              <div>
                <label for="inputconfirmpass" 
                       class="form-label">
                  <span>{{ $t("register.password_again") }}</span>
                  <span class="text-danger">*</span>
                </label>
                <input :type="showpasscheck ? 'text' : 'password'" 
                       class="form-control bg-transparent text-white" 
                       id="inputconfirmpass"
                       minlength="6"
                       maxlength="40"
                       autocomplete="off" 
                       v-model="model.confirmpass">
              </div>

              <!-- Jelszó megjelenítése -->
              <div class="mb-3 mt-3">
                <label class="form-check-label mx-1 text-start" 
                      for="flexCheckDefault">
                  {{ $t("register.show_password") }}
                </label>
                <input class="form-check-input float-end" 
                      type="checkbox" 
                      id="flexCheckDefault"
                      v-model="showpasscheck">
              </div>
            </div>

            <!-- A végső jelezés -->
            <div class="mb-3" v-else-if="step === 3">
              <!-- Iconok -->
              <div class="text-center">
                <FontAwesomeIcon v-if="isSuccess" 
                                 icon="fa-solid fa-check" 
                                 class="text-success mb-3" 
                                 size="5x" />

                <FontAwesomeIcon v-if="!isSuccess" 
                                 icon="fa-solid fa-x" 
                                 class="text-danger mb-3" 
                                 size="5x" />
              </div>
              <!-- Üzenet -->
              <div class="text-center">
                <h6 class="display-6">{{message==messages.success?$t("register.succes_message") :
                                          message==messages.email?$t("register.email_message"):$t("register.phone_number_message") }}</h6>
              </div>
            </div>
          </div>
        </Transition>

        <!-- Gombok -->
        <div class="d-flex">

          <!-- Vissza gomb -->
          <button type="button" 
                  v-if="!isSuccess" 
                  class="btn btn-outline-light text-center 
                         w-auto w-50 mx-auto" 
                  @click="transitionName = 'slide-in'; step--;"
                  v-bind:disabled="step===0">
            {{ $t("register.previous") }}
          </button>

          <!-- Következő gomb -->
          <button type="button" 
                  class="btn btn-outline-light text-center 
                         d-block w-auto w-50 mx-auto" 
                  @click="transitionName = 'slide-out'; step++;" 
                  v-if="step < 3"
                  v-bind:disabled="step === 2 && !validateForm()">
            {{ $t("register.next") }}
          </button>
        </div>
      </form>
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
</style>