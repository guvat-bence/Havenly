<script setup>
import { user } from '@/store/user';
import { useRouter } from 'vue-router';
import axios from 'axios';
import { reactive, ref, watch } from 'vue';

const router = useRouter()

let websitekey = window.location.pathname.split("/")[1];

console.log(websitekey);

if(user.id)
  router.push("/havenly")
// Model dekralálása
let model = reactive({
  email: "",
  password: ""
}),
  //Üzenet fele
  message = ref(""),
  isSuccess,
  showpasscheck = ref(false),
  expiration_sliced = ref([]),

  // login függvény
  login = () => {
    axios.post('http://localhost:3000/login',model)
      .then(response => {
        // Ha sikertelen akkor a változók 
        // legyen egyelők a visszatérő értékekkel
        if(!response.data.success){
          message.value = response.data.message;
          isSuccess = response.data.success
        }

        // Ha sikeres akkor 
        // a felasználó adait töltse fel a visszakapott adatokkal
        else{
          user.id = `${response.data.user.id} ${websitekey}`;
          user.firstname = response.data.user.first_name;
          user.lasttname = response.data.user.last_name;
          user.middlename = response.data.user.middle_name;
          user.phone_number = response.data.user.phone_number;
          user.email = response.data.user.email;
          user.gender = response.data.user.gender;
          user.user_type = response.data.user.user_type;
          user.cardNumber = response.data.user.card_number;

          try{
            user.expirationMonth = response.data.user.expiration.split("/")[0];
            user.expirationYear = response.data.user.expiration.split("/")[1];
          }
          catch
          {
            user.expirationMonth = "";
            user.expirationYear = "";
          }

          // Töltse újra az oldalt annak érdekében 
          // hogy a felhasználót minden komponens érzékelni tudja
          window.location.reload()
        }  
      })
      // Hiba kezelés
      .catch(e => console.error(e))
  },

  // Ellenőrzi a bevitt értéket
  validateForm = () => {

    if (!/^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test(model.email))
      return false;

    if (!/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d!@#$%^&*()_\-+= \[\] {};:'",.<>/?]{6,40}$/.test(model.password)) 
      return false

    return true;
  }

  // Figyeli a bevitt értéket
  watch(model, () => {
    validateForm();
  })
</script>

<template>
  <div class="login">
    <div class="d-flex justify-content-center align-items-center">

      <!-- bejelentkezés form -->
      <form class="border p-4 border-1 border-white 
                   text-white rounded-3 bg-dark 
                   bg-opacity-50"
            name="login">

        <!-- Cím és üzenet részleg -->
        <div>
          <!-- cím -->
          <h1 class="text-center text-white h2 m-3">
            {{ $t("login.title") }}
          </h1>

          <!-- ha van valamilyen probléma akkor azt ide írja ki -->
          <p class="text-danger text-center">
            {{ message }}
          </p>
        </div>

        <!-- Email részleg -->
        <div class="mb-3">
          <label for="InputEmail1" 
                 class="form-label">
            <span>{{ $t("login.email") }}</span>
            <span class="text-danger">*</span>
          </label>
          <input type="email" 
                 class="form-control bg-transparent text-white" 
                 id="InputEmail1"
                 autocomplete="off"
                 v-model="model.email">
        </div>

        <!-- Jelszó részleg -->
        <div class="mb-2 my-3">
          <label for="InputPassword" 
                 class="form-label">
            <span>{{ $t("login.password") }}</span>
            <span class="text-danger">*</span>
          </label>
          <input :type="showpasscheck ? 'text' : 'password'" 
                 class="form-control bg-transparent text-white" 
                 id="InputPassword"
                 autocomplete="off"
                 ref="passwordInput"
                 minlength="6"
                 maxlength="40"
                 v-model="model.password">
        </div>
        <!-- Jelszó megjelenítése -->
        <div class=" mb-3">
          <label class="form-check-label mx-1 text-start" 
                 for="flexCheckDefault">
           {{ $t("login.show_password") }}
          </label>
          <input class="form-check-input float-end" 
                 type="checkbox" 
                 id="flexCheckDefault"
                 v-model="showpasscheck">
        </div>

        <!-- Bejelentkezés gomb -->
        <button type="button" 
                class="btn btn-outline-light 
                       text-center rounded-3 w-100
                       w-auto d-block mx-auto" 
                v-on:click="login()"
                v-bind:disabled="!validateForm()">
          {{ $t("login.log_in") }}
        </button>

      </form>
    </div>
  </div>
</template>

<style scoped>
input:not([type="checkbox"]):focus,
input:not([type="checkbox"]):hover,
input:not([type="checkbox"])::after{
  background-color: white !important;
  box-shadow: 0px 0px 10px white !important;
  transition: 200ms;
  color: black !important;
}
</style>