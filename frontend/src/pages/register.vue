<script setup>
import axios from 'axios';
import { onMounted, reactive, ref, watch} from 'vue';

 

let step = ref(0),
    transitionName = ref("slide-in"),
    progesswidth = ref(0),
    message = "",
    model = reactive({
      lastname: "",
      firstname: "",
      middlename: "",
      email: "",
      phone_number: "",
      password: "",
      confirmpass: ""
    }),
    validateForm = () => {
      if (!/^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test(model.email))
        return false;

      if(model.firstname.length === 0 || 
         model.lastname === 1) 
         return false

      if (!/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,20}$/.test(model.password))
        return false;

      if(model.password !== model.confirmpass)
        return false

      if(!/^\+?[0-9\s\-\(\)]{7,20}$/.test(model.phone_number))
        return false;

  return true;
    },
    doRegister = () =>{
      axios.post('http://localhost:3000/register',{
        model
      })
      .then(response => {
        message = response.data.message
        console.log(message) 
      })
      .catch(e=> console.log(e))
    }

   watch(step,() => {
    progesswidth.value = step.value * 33
    if(progesswidth.value === 99){
      progesswidth.value = 100
      doRegister();
      console.log(model)
    }
   })

   watch(model, () =>{
    validateForm();
  }
)
    
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
             :style="{width: progesswidth + '%'}"></div>
      </div>
    </div>

    <div class="d-flex justify-content-center align-items-center">
      <form class="border p-3 border-1 
                    border-white text-white rounded-3 
                    bg-dark bg-opacity-50 mb-3">

        <div>
          <h1 class="text-center"
              v-if="step !== 3">
              {{ step+1 }}. lépés
          </h1>
        </div>

        <Transition :name="transitionName"
                    type="transition"
                    mode="out-in">
          <div :key="step">

            <!-- A név form rész -->
            <div class="mb-3" 
                 v-if="step === 0">
              <div class="form-label text-white d-flex gap-1">
                <span>Teljesnév:</span>
              </div>

              <!-- Vezetéknév -->
              <div class="row">
                <div class="col-xxl-4 col-lg-4 col-md-4 
                          col-sm-4 col-12 p-1">
                  <input type="text" 
                         class="form-control bg-transparent text-white" 
                         id="lastName"
                         v-model="model.lastname">

                  <div class="form-text text-white text-center 
                              d-flex justify-content-center align-items-center 
                              gap-1">
                    <label for="lastName">
                      <span>vezetéknév</span>
                      <span class="text-danger">*</span>
                    </label>
                  </div>
                </div>

                <!-- Keresztnév -->
                <div class="col-xxl-4 col-lg-4 col-md-4 
                          col-sm-4 col-12 p-1">
                  <input type="text" 
                         class="form-control bg-transparent text-white" 
                         id="firstName"
                         v-model="model.firstname">

                  <div class="form-text text-white text-center 
                          d-flex justify-content-center align-items-center 
                          gap-1">
                    <label for="firstName">
                      <span>keresztnév</span>
                      <span class="text-danger">*</span>
                    </label>
                  </div>
                </div>
                <!-- Harmadiknév -->
                <div class="col-xxl-4 col-lg-4 col-md-4 
                          col-sm-4 col-12 p-1">
                  <input type="text" 
                         class="form-control bg-transparent text-white" 
                         id="middleName"
                          v-model="model.middlename">
                  <div class="form-text text-white text-center 
                            d-flex justify-content-center align-items-center 
                            gap-1">
                    <label for="middleName">
                      <span>harmadiknév</span>
                    </label>
                  </div>
                </div>
              </div>
            </div>

            <!-- Contact információk form rész -->
            <div class="mb-3" 
                 v-else-if="step === 1">
              <!-- Email cím -->
              <div>
                <label for="InputEmail1" class="form-label">
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
              </div>
            </div>

            <div class="mb-3" 
                 v-else-if="step === 2">
              <!-- Jelszó mégegyszer -->
              <div>
                <label for="InputPassword" 
                       class="form-label">
                  <span>Jelszó</span>
                  <span class="text-danger">*</span>
                </label>
                <input type="password" 
                       class="form-control bg-transparent text-white" 
                       id="InputPassword"
                       v-model="model.password">
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
                       v-model="model.confirmpass">
              </div>
          </div>              
          <div class="mb-3"
               v-else-if="step === 3">
                 {{ message }}
          </div>    
        </div>  
      </Transition>

        <div class="d-flex">
          
          <button type="button"
                  v-if="step" 
                  class="btn btn-outline-light text-center 
                         w-auto w-50 mx-auto" 
                  @click="transitionName = 'slide-in';step--;">
          Vissza
        </button>

        <button type="button" 
                class="btn btn-outline-light text-center 
                       d-block w-auto w-50 mx-auto" 
                @click="transitionName = 'slide-out';step++;"
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
  transition: all 0.3s ease;
  width: 100%;
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
  transition: all 0.3s ease;
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