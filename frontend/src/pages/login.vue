<script setup>
import { user } from '@/store/user';
import router from '@/router';
import axios from 'axios';
import { reactive, ref, watch } from 'vue';
// Model dekralálása
let model = reactive({
  email: "",
  password: ""
}),


  //Üzenet fele
  message = ref(""),
  isSuccess,
  showpasscheck = ref(false),

  // login függvény
  login = () => {
    axios.post('http://localhost:3000/login',model)
      .then(response => {
        // Ha sikertelen akkor a változók 
        // legyen egyelők a visszatérő értékekkel
        if(!response.data.success){
          message.value = response.data.message;
          isSuccess = response.data.success
          console.log(response.data)
        }

        // Ha sikeres akkor 
        // a felasználó adait töltse fel a visszakapott adatokkal
        else{
          user.id = response.data.user.id;
          user.firstname = response.data.user.first_name;
          user.lasttname = response.data.user.last_name;
          user.middlename = response.data.user.middle_name;
          user.phone_number = response.data.user.phone_number;
          user.gender = response.data.user.gender;
          user.user_type = response.data.user.user_type;
          user.cardNumber = response.data.user.card_number;
          user.expiration = response.data.user.expiration;
          user.cvv = response.data.user.cvv;
          user.websitekey = "havenly"

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

    if (!/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,20}$/.test(model.password))
    return false;

    if(model.password.length >= 40 || model.password.length <= 6)
      return false;

    return true;
  }

  // Figyeli a bevitt értéket
  watch(model, () => {
    validateForm();
  })
  
  // Ha a felhasználó be van jelentkezve akkor dobja vissza a kezdő oldalra
  if(user.id)
    router.replace({path: '/'})

</script>

<template>
  <div class="login">
    <div class="d-flex justify-content-center align-items-center">

      <!-- bejelentkezés form -->
      <form class="border p-3 border-1 border-white 
                   text-white rounded-3 bg-dark 
                   bg-opacity-50"
            name="login">

        <!-- Cím és üzenet részleg -->
        <div>
          <!-- cím -->
          <h1 class="text-center text-white display-5">Bejelentkezés</h1>

          <!-- ha van valamilyen probléma akkor azt ide írja ki -->
          <p class="text-danger text-center">
            {{ message }}
          </p>
        </div>

        <!-- Email részleg -->
        <div class="mb-3">
          <label for="InputEmail1" 
                 class="form-label">
            <span>Email</span>
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
            <span>Jelszó</span>
            <span class="text-danger">*</span>
          </label>
          <input :type="showpasscheck ? 'text' : 'password'" 
                 class="form-control bg-transparent text-white" 
                 id="InputPassword"
                 autocomplete="off"
                 ref="passwordInput"
                 v-model="model.password">
        </div>
        <!-- Jelszó megjelenítése -->
        <div class=" mb-3">
          <label class="form-check-label mx-1 text-start" for="flexCheckDefault">
            Jelszó megjelenítése:
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
          Bejelentkezés
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