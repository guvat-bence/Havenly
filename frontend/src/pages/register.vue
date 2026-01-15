<script setup>
import router from '@/router';
import { user } from '@/store/user';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import axios from 'axios';
import { reactive, ref, watch } from 'vue';


// Változók és funkciók deklarálása
let step = ref(0),
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
    password: "",
    confirmpass: ""
  }),

  // Adatokat ellenőrzése
  validateForm = () => {
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test(model.email))
      return false;

    if (model.firstname.length === 0 ||
        model.lastname === 1)
      return false

    if (!/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,20}$/.test(model.password))
      return false;

    if (model.password !== model.confirmpass)
      return false

    if(model.password.length >= 40 || model.password.length <= 6)
      return false;

    if (!/^\+?[0-9\s\-\(\)]{7,20}$/.test(model.phone_number))
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
            user.middlename = "";
            user.phone_number = model.phone_number;
            user.user_type = "U";
            router.push('/');
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
      <form class="border p-3 border-1 
                    border-white text-white rounded-3 
                    bg-dark bg-opacity-50 mb-3">

        <div>
          <h1 class="text-center" v-if="step !== 3">
            {{ step + 1 }}. lépés
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
                    <span>vezetéknév</span>
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
                      <span>keresztnév</span>
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
                      <span>harmadiknév</span>
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
              <div>
                <label for="InputEmail1" 
                       class="form-label">
                  <span>Email</span>
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
                  <span>Telefonszám</span>
                  <span class="text-danger">*</span>
                </label>
                <input type="text" 
                       class="form-control bg-transparent text-white" 
                       id="phoneNumber"
                       v-model="model.phone_number">
                  <div class="form-text text-white fw-bold">Példa: +36301234567</div>
              </div>
            </div>

            <!-- Jelszó megadása form rész -->
            <div class="mb-3" v-else-if="step === 2">

              <!-- Jelszó-->
              <div>
                <label for="InputPassword" 
                       class="form-label">
                  <span>Jelszó</span>
                  <span class="text-danger">*</span>
                </label>
                <input type="password" 
                       class="form-control bg-transparent text-white" 
                       id="InputPassword"
                       autocomplete="off"
                       minlength="6"
                       maxlength="40" 
                       v-model="model.password">
                  <div class="form-text text-white fw-bold">
                    A jelszónak tartalmaznia kell legalább egy nagybetűt és egy számot
                  </div>
                  <div class="form-text text-white fw-bold">
                    Minimum 6 karaktert kell tartalmaznia
                  </div>
              </div>

              <!-- Jelszó mégegyszer -->
              <div>
                <label for="inputconfirmpass" 
                       class="form-label">
                  <span>Megerősítő jelszó</span>
                  <span class="text-danger">*</span>
                </label>
                <input type="password" 
                       class="form-control bg-transparent text-white" 
                       id="inputconfirmpass"
                       minlength="6"
                       maxlength="40"
                       autocomplete="off" 
                       v-model="model.confirmpass">
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
                <h6 class="display-6">{{ message }}</h6>
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
            Vissza
          </button>

          <!-- Következő gomb -->
          <button type="button" 
                  class="btn btn-outline-light text-center 
                         d-block w-auto w-50 mx-auto" 
                  @click="transitionName = 'slide-out'; step++;" 
                  v-if="step < 3"
                  v-bind:disabled="step === 2 && !validateForm()">
            Következő
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<style scoped>
/* Regisztrációs inputok effektusai */
input:focus,
input:hover,
input::after {
  background-color: white !important;
  box-shadow: 0px 0px 10px white !important;
  transition: 200ms;
  color: black !important;
}

/* Becsúszás animáció */
.slide-in-enter-active,
.slide-in-leave-active {
  transition: all 0.278s ease;
  width: 100%;
  opacity: 1;
}

.slide-in-enter-from {
  transform: translateX(100%);
  opacity: 0;
}

.slide-in-leave-to {
  transform: translateX(-100%);
  opacity: 0;
}

/* Ki csúszás animáció */
.slide-out-enter-active,
.slide-out-leave-active {
  transition: all 0.278s ease;
  width: 100%;
  opacity: 0.4;
}

.slide-out-enter-from {
  transform: translateX(-100%);
}

.slide-out-leave-to {
  transform: translateX(100%);
}
</style>