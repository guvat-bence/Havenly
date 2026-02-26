<script setup>
import { user } from '@/store/user';
import router from '@/router';
import { reactive, ref, watch } from 'vue';
import axios from 'axios';

//securityCheck
if(!user.id)
  router.back()

let model = reactive({
  firstName: user.firstname,
  lastName: user.lasttname,
  middleName: user.middlename,
  email: user.email,
  phoneNum: user.phone_number,
  gender: user.gender,
})

let card = reactive({
  cardnumber: user.cardNumber,
  expirationMonth: user.expirationMonth,
  expirationYear: user.expirationYear,
  cvv: user.cvv
}) 

let modelCopie = {... model};
let cardCopie = {... card};
let currentExpYear = ref(new Date().getFullYear().toString().substring(2,4))
let changedModel = ref(false);
let changedCard = ref(false);
let messageBoxType = ref(false);

console.log(card);


function saveDatas(obj)
{
  let url = "allDatas";
  if(changedCard.value==true && changedModel.value==true)
  {
    obj = {model,card};
  } 
  else
  {
    url = obj == model?"Privacy":"Card";
  }
  axios.post(`http://localhost:3000/updateUser/${url}`,obj)
  .then((respose)=>{console.log(respose.data);
  })
  .catch((err)=>{console.error(err)})

  messageBox("close");
}

function saveAllDatas()
{
  if(confirm("Biztos módosítja az adatokat?"))
  {
    axios.post('http://localhost:3000/updateUser',{model,card})
    .then((respose)=>{console.log(respose.data)})
    .catch((err)=>{console.error(err)})
  }
}

function restoreDatas(obj)
{
  let copie = obj == model?modelCopie:cardCopie;
  let changed = obj == model?changedModel:changedCard;
  for(let x in obj)
  {
    if(obj[x]!=copie[x]){
      changed.value = false;
      obj[x]=copie[x];
    }
  }
}

function messageBox(type)
{
  
  setTimeout(() => {
    document.body.classList.toggle("messageBoxShowUp");
  }, 399);
  if(type=="open")
  {
    window.scrollTo({
      top: 0,
      left: 0,
      behavior: 'smooth'
    })
    
    messageBoxType.value = !messageBoxType.value;
  }
  else
  {
    let messageBox = document.body.querySelector(".messageBox");
    messageBox.classList.toggle("fade-out");
    setTimeout(()=>
    {
      messageBoxType.value = !messageBoxType.value;
    },1000)
  }
}

function change(obj)
{
  let copie = obj == model?modelCopie:cardCopie;
  let changed = obj == model?changedModel:changedCard;
  for(let x in obj)
  {
    if(obj[x]!=copie[x]){
      changed.value = true;
      return;
    }
  }
  changed.value = false;
}

watch(model,()=>
{
 change(model); 
},{deep:true})

watch(card,()=>
{
 change(card);
},{deep:true})

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
            Beszélgetéseim
          </button>
        </div>
      </nav>

      <div class="row align-items-top justify-content-center">
        <div class="tab-content text-white
                   text-center bg-dark bg-opacity-50 
                   rounded-5 rounded-top-0 py-5 px-4" 
            id="nav-tabContent">
          <div class="tab-pane fade show active"
              id="nav-datas" 
              role="tabpanel" 
              aria-labelledby="nav-datas-tab" 
              tabindex="0">
            
            <div class="row justify-content-center">

              <form class="col-12 col-sm-10 col-md-8 
                           col-lg-8 col-xl-8 col-xxl-6">
                <h4 class="text-center">Személyes adatok</h4>
                <div class="px-3 py-3 border rounded-3">
                  <!-- Names -->
                  <div class="row justify-content-center mb-3">
                    <div>
                      <h5 class="text-center">Nevek</h5>
                    </div>

                    <!-- FirstName -->
                    <div :class="model.middleName!='null'?
                          'col-lg-4':
                          'col-lg-6'"
                          class="mb-3 m-0 col-12">
                      <label for="InputFirstName" 
                              class="form-label">
                        Keresztnév
                      </label>
                      <input type="text" 
                              class="form-control" 
                              id="InputFirstName" 
                              v-model="model.firstName">
                    </div>

                    <!-- MiddleName -->
                    <div v-if="model.middleName!='null'"
                        class="mb-3 col-12 col-lg-4">
                      <label for="InputMiddleName" 
                              class="form-label">
                        Harmadiknév
                      </label>
                      <input type="text" 
                              class="form-control" 
                              id="InputMiddleName" 
                              v-model="model.middleName">
                    </div>

                    <!-- LastName -->
                    <div :class="model.middleName!='null'?
                          'col-lg-4':
                          'col-lg-6'"
                        class="mb-3 m-0 col-12">
                      <label for="InputLastName" 
                              class="form-label">
                        Vezetéknév
                      </label>
                      <input type="text" 
                              class="form-control" 
                              id="InputLastName"
                              v-model="model.lastName">
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

                  <!-- Gombok -->
                  <div class="row mx-1 justify-content-center">

                    <!-- Mentés gomb -->
                    <button v-if="changedModel==true && changedCard!=true"
                            @click="messageBox('open')"
                            type="button"
                            class="col-12 col-sm-12 col-md-4 col-lg-3
                                   mx-2 my-2 btn btn-light">
                      Mentés
                    </button>

                    <!-- Összes mentése gomb -->
                    <button v-if="changedModel==true && changedCard==true"
                            @click="messageBox('open')"
                            type="button"
                            class="col-12 col-sm-12 col-md-4 col-lg-3 
                                   mx-2 my-2 text-nowrap btn btn-light">
                      Összes mentése
                    </button>

                    <!-- Mégse gomb -->
                    <button :disabled="changedModel!=true"
                            @click="restoreDatas(model)"
                            type="button" 
                            class="col-12 col-sm-12 col-md-4 col-lg-3
                                  mx-2 my-2 btn btn-secondary">
                      Mégsem
                    </button>
                  </div>
                </div>
              </form>

              <form  v-if="card.cardnumber!='null'"
                    class="col-12 col-sm-10 col-md-8 
                           col-lg-8 col-xl-8 col-xxl-6">
                <h4 class="text-center mt-5">
                  Kártya adatok
                </h4>

                <div class="px-3 py-3 border rounded-3">
                  <!-- Card data -->
                  <div class="row justify-content-center">
                    <!-- cardNumber -->
                    <div class="mb-3 col-12">
                      <label for="inputCardNumber" 
                              class="form-label">
                        Kártyaszám
                      </label>
                      <input type="text"
                            class="form-control"
                            id="inputCardNumber"
                            v-model="card.cardnumber">
                    </div>

                    <!-- Month -->
                    <div class="mb-3 col-6 col-lg-4">
                      <label class="form-label"
                              for="inputMonth">
                        Hónap
                      </label>
                      <select class="form-select"
                              id="inputMonth"
                              v-model="card.expirationMonth">
                        <option selected>{{ card.expirationMonth }}</option>
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
                              id="inputYear"
                              v-model="card.expirationYear">
                        <option selected>
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
                    <!-- Gombok -->
                    <div class="row ms-1 justify-content-center">

                      <!-- Mentés gomb -->
                      <button v-if="changedModel!=true && changedCard==true"
                              @click="messageBox('open')"
                              type="button"
                              class="col-12 col-sm-12 col-md-4 col-lg-3
                                     mx-2 my-2 btn btn-light">
                        Mentés
                      </button>

                      <!-- Összes mentése gomb -->
                      <button v-if="changedModel==true && changedCard==true"
                              @click="messageBox('open')"
                              type="button"
                              class="col-12 col-sm-12 col-md-4 col-lg-3
                                     text-nowrap mx-2 my-2 btn btn-light">
                        Összes mentése
                      </button>

                      <!-- Mégse gomb -->
                      <button :disabled="changedCard!=true"
                              @click="restoreDatas(card)"
                              type="button" 
                              class="col-12 col-sm-12 col-md-4 col-lg-3 
                                     mx-2 my-2 btn btn-secondary">
                        Mégsem
                      </button>

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
        <!-- messageBox -->
        <div v-if="messageBoxType==true"
             class="row position-absolute justify-content-center">
          <div class="col-10 col-sm-8 col-md-7 col-lg-4
                     messageBox fade-in bg-secondary
                     border border-3 rounded-5 py-3 px-3">
            <!-- Kérédés -->
            <h1 class="text-center">
              Biztos menti a változtatásokat?
            </h1>
            <!-- Gombok -->
            <div class="row justify-content-center">

              <!-- Mentés gomb -->
              <button
                      @click="saveDatas(changedModel==true?model:card)"
                      type="button"
                      class="col-8 col-sm-5 col-md-5 col-lg-4
                             mx-2 my-2 btn btn-light">
                Igen
              </button>

              <!-- Mégse gomb -->
              <button
                      @click="messageBox('close')"
                      type="button" 
                      class="col-8 col-sm-5 col-md-5 col-lg-4 
                             mx-2 my-2 btn btn-dark">
                Nem
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<style>

/* profile inputok effektusai */
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
.account {
  position: relative;
  z-index: 1020;
}

.messageBox{
  box-shadow: 0 0 100px 1000px rgba(0, 0, 0, 0.8) !important;
}

.messageBox,
.messageBox *{
  pointer-events: auto;
  user-select: auto;

}
body.messageBoxShowUp{
  pointer-events: none;
  overflow: hidden;
}

.fade-in {
  animation: fadeInUp 0.5s ease both;
}

.fade-out {
  animation: fadeOutDown 0.5s ease both;
}

@keyframes fadeInUp {

  0% 	{opacity:0;transform: scale(0); }
  25% 	{opacity:0;transform: scale(0); }
  100% 	{opacity:1;transform: scale(1); }
}

@keyframes fadeOutDown {
  from { opacity:1; transform: scale(1); }
  to   { opacity:0; transform: scale(0); }
}

</style>