<script setup>
import { user } from '@/store/user';
import router from '@/router';
import { reactive, ref, watch } from 'vue';
import axios from 'axios';
import { useI18n } from 'vue-i18n';
import { selectedCurrency } from '@/store/currency';
import { convertStrings } from '@/common';
let changedModel = ref(false);
const {t} = useI18n();
const {locale} = useI18n();
// A felhasználó alap adatai.
let model = reactive({
  userID: user.id,
  firstName: user.firstname,
  lastName: user.lasttname,
  middleName: user.middlename,
  email: user.email,
  phoneNum: user.phone_number,
  gender: user.gender,
})


//securityCheck.
if(!user.id)
  router.back()
</script>
<template>
  <div class="userItem">
    <div class="container">
      <div class="row justify-content-center">

        <!-- Tárgy adatai -->
        <form id="collpasePrivacyDatas"
              class="col-12 col-sm-10 col-md-8 
                    col-lg-8 col-xl-8 col-xxl-6
                    my-4 text-white">

          <!-- Cím -->
          <h4 class="text-center">
            <i class="fa-solid fa-square-poll-horizontal"></i>
             Adatok
          </h4>

          <!-- Adatok és gombok -->
          <div class="px-3 py-3 border rounded-3">

            <!-- Helyszín -->
            <div class="row justify-content-center mb-3">

              <!-- Helyzet -->
              <h5 class="text-center">
                <i class="fa-regular fa-compass fa-lg"></i>
                Helyzet
              </h5>

              <!-- Ország -->
              <div class="mb-3 m-0 col-12 col-lg-6">

                <!-- Label -->
                <label for="InputFirstName" 
                        class="form-label">
                  <i class="fa-solid fa-earth-europe"></i>
                  Ország
                </label>

                <!-- Input -->
                <input type="text" 
                        class="form-control" 
                        id="InputFirstName" 
                        v-model="model.firstName">
              </div>

              <!-- Város -->
              <div class="mb-3 col-12 col-lg-6">

                <!-- Label -->
                <label for="InputMiddleName" 
                        class="form-label">
                 <i class="fa-solid fa-city"></i>
                  Város
                </label>

                <!-- Input -->
                <input type="text" 
                        class="form-control" 
                        id="InputMiddleName" 
                        v-model="model.middleName">
              </div>
            </div>

            <!-- Név és leírás -->
            <div class="row">

              <!-- Cím -->
              <h5 class="text-center">
               <i class="fa-solid fa-book-open"></i>
                Név és leírás
              </h5>

              <!-- Név -->
              <div class="mb-3 col-12 col-lg-6">

                <!-- Label -->
                <label for="InputEmail" 
                        class="form-label">
                  <i class="fa-solid fa-file-signature"></i>
                  Név
                </label>

                <!-- Input -->
                <input type="email" 
                        class="form-control" 
                        id="InputEmail" 
                        v-model="model.email">
              </div>

              <!-- Leírás -->
              <div class="mb-3 col-12 col-lg-6">

                <!-- Label -->
                <label for="InputPhoneNum" 
                        class="form-label">
                  <i class="fa-solid fa-file-signature"></i>
                  Leírás
                </label>

                <!-- Input -->
               <textarea class="form-control col-10" 
										 id="asd" 
										 type="text"
										 value=""
										 rows="5"
										 maxlength="200"
										 v-model="model.email">
							</textarea>
              </div>
            </div>

            <!-- Részletek -->
            <div class="row mb-4">   

              <!-- Cím -->
              <h5 class="text-center">
                <i class="fa-solid fa-circle-info"></i>
                Részletek
              </h5>

              <!-- Ország -->
              <div class="mb-3 m-0 col-12 col-lg-4">

                <!-- Label -->
                <label for="InputFirstName" 
                        class="form-label">
                  <i class="fa-solid fa-earth-europe"></i>
                  Ország
                </label>

                <!-- Input -->
                <input type="text" 
                        class="form-control" 
                        id="InputFirstName" 
                        v-model="model.firstName">
              </div>

              <!-- Város -->
              <div class="mb-3 col-12 col-lg-4">

                <!-- Label -->
                <label for="InputMiddleName" 
                        class="form-label">
                 <i class="fa-solid fa-city"></i>
                  Város
                </label>

                <!-- Input -->
                <input type="text" 
                        class="form-control" 
                        id="InputMiddleName" 
                        v-model="model.middleName">
              </div>
              
              <!-- Város -->
              <div class="mb-3 col-12 col-lg-4">

                <!-- Label -->
                <label for="InputMiddleName" 
                        class="form-label">
                 <i class="fa-solid fa-city"></i>
                  Város
                </label>

                <!-- Input -->
                <input type="text" 
                        class="form-control" 
                        id="InputMiddleName" 
                        v-model="model.middleName">
              </div>

              <!-- Ország -->
              <div class="mb-3 m-0 col-12 col-lg-4">

                <!-- Label -->
                <label for="InputFirstName" 
                        class="form-label">
                  <i class="fa-solid fa-earth-europe"></i>
                  Ország
                </label>

                <!-- Input -->
                <input type="text" 
                        class="form-control" 
                        id="InputFirstName" 
                        v-model="model.firstName">
              </div>

              <!-- Város -->
              <div class="mb-3 col-12 col-lg-4">

                <!-- Label -->
                <label for="InputMiddleName" 
                        class="form-label">
                 <i class="fa-solid fa-city"></i>
                  Város
                </label>

                <!-- Input -->
                <input type="text" 
                        class="form-control" 
                        id="InputMiddleName" 
                        v-model="model.middleName">
              </div>
              
              <!-- Város -->
              <div class="mb-3 col-12 col-lg-4">

                <!-- Label -->
                <label for="InputMiddleName" 
                        class="form-label">
                 <i class="fa-solid fa-city"></i>
                  Város
                </label>

                <!-- Input -->
                <input type="text" 
                        class="form-control" 
                        id="InputMiddleName" 
                        v-model="model.middleName">
              </div>
            </div>

            <!-- Képek -->
            <div class="row mb-4 justify-content-center">   

            <!-- Cím -->
              <h5 class="text-center">
                <i class="fa-regular fa-images"></i>
                Képek
              </h5>

              <!-- Képek -->
              <div v-for="x in 10"
                   class="mb-3 m-0 col-12 col-lg-3">

                <label class="form-label d-flex 
                              justify-content-center 
                              align-items-center border" 
                      :for="x"
                      style="height: 150px;
                            cursor:pointer;">
                  <i class="fa-solid fa-image"></i>          
                  Kép
                </label>
                <input type="file" class="form-control d-none" :id="x">
              </div>

            </div>

            <!-- Gombok -->
            <div class="row mx-1 justify-content-center">

              <!-- Mentés gomb -->
              <button v-if="changedModel==true && changedCard!=true"
                      @click="messageBox('open');
                              messageBoxmessage = messages.editing"
                      type="button"
                      class="col-12 col-sm-12 col-md-4 col-lg-3
                              mx-2 my-2 btn btn-light">
                {{ $t("profile.save") }}
              </button>

              <!-- Összes mentése gomb -->
              <button v-if="changedModel==true && changedCard==true"
                      @click="messageBox('open');
                              messageBoxmessage = messages.editing"
                      type="button"
                      class="col-12 col-sm-12 col-md-4 col-lg-3 
                              mx-2 my-2 text-nowrap btn btn-light">
                {{ $t("profile.save_all") }}
              </button>

              <!-- Mégse gomb -->
              <button :disabled="changedModel!=true"
                      @click="restoreDatas(model)"
                      type="button" 
                      class="col-12 col-sm-12 col-md-4 col-lg-3
                            mx-2 my-2 btn btn-secondary">
                {{ $t("profile.unsave") }}
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>
<style scoped>
</style>