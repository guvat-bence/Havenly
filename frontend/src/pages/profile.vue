<script setup>
import { user } from '@/store/user';
import router from '@/router';
import { reactive, ref, watch } from 'vue';
import axios from 'axios';
import { useI18n } from 'vue-i18n';

const {t} = useI18n();

//securityCheck.
if(!user.id)
  router.back()

// A felhasználó alap adatai.
let model = reactive({
  userID: user.id.split(" ")[0],
  firstName: user.firstname,
  lastName: user.lasttname,
  middleName: user.middlename,
  email: user.email,
  phoneNum: user.phone_number,
  gender: user.gender,
})

// A felhasználó kártya adatai.
let card = reactive({
  userID: user.id.split(" ")[0],
  cardNumber: user.cardNumber,
  expirationMonth: user.expirationMonth,
  expirationYear: user.expirationYear
}) 

// A felhasználó jelszavai
let passwords = reactive({
    userID: user.id.split(" ")[0],
    currentPassword :"",
    newPassword:"",
    confirmPassword:""
})

// A messagebox üzenetei.
let messages =
{
  editing:t("profile.messages.editing"),
  deleting:t("profile.messages.deleting"),
  deletingCardDatas:t("profile.messages.deletingCardDatas"),
  passwordError: t("profile.messages.passwordError"),
  emailError: t("profile.messages.emailError"),
  succesEditing: t("profile.messages.succesEditing"),
  succesDeleting: t("profile.messages.succesDeleting")
}

// Változók definiállása.
let modelCopie = reactive({... model});
let cardCopie = reactive({... card});
let passwordCopie = {... passwords};
let currentExpYear = ref(new Date().getFullYear().toString().substring(2,4))
let changedModel = ref(false);
let changedCard = ref(false);
let messageBoxType = ref(false);
let messageBoxmessage = ref("");
let messageType = ref("");
let showpasscheck = ref(false);
let showOkBtn = ref(false);
let talkingWith = ref("");
let userMessages = ref(""); 

// Adatokat ellenőrzése.
function validateUserDatas(){

  if (!/^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test(model.email))
    return false;

  if (!/^\+?[0-9\s\-\(\)]{7,20}$/.test(model.phoneNum))
    return false;

  if(!/^[\p{L} ]+$/u.test(model.firstName))
    return false;

  if(!/^[\p{L} ]+$/u.test(model.lastName))
    return false;

  if(model.middleName!="" && !/^[\p{L} ]+$/u.test(model.middleName))
    return false;

  if(card.cardNumber!="" && !/^[0-9]{13,19}$/.test(card.cardNumber))
    return false;

  if(card.expirationMonth!="" && card.expirationMonth.length==0)
    return false;

  if(card.expirationYear!="" && card.expirationYear.length==0)
    return false;

  return true;
};

// Jelszavak ellenőrzése.
function validatePasswords()
{

  if (!/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,40}$/.test(passwords.currentPassword))
    return false;

  if (!/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,40}$/.test(passwords.newPassword))
    return false;

  if (passwords.newPassword !== passwords.confirmPassword ||
       passwords.newPassword === passwords.currentPassword)
    return false;

  return true;
}

// ha a fiók törlését válasszuk ki, 
// az adatbázisból való törlés után a localstorage adatait is töröljük.
function removeDeletedUserValues()
{
  user.id = "";
  user.firstname = "";
  user.lasttname = "";
  user.middlename = "";
  user.phone_number = "";
  user.gender = "";
  user.user_type = "";
  user.cardNumber = "";
  user.expiration = "";
  router.push("/havenly");
}

// Az újként megadott adatokat állítjuk be alapértelmezetre.
function setNewDatas(obj)
{

  if(obj?.card)
  {
    Object.assign(modelCopie,model);
    Object.assign(cardCopie,card);
    changedModel.value = false;
    changedCard.value = false;
    
  }
  else
  {
    let copie = obj == model?modelCopie:cardCopie;
    let changed = obj == model?changedModel:changedCard;
    Object.assign(copie,obj);
    changed.value = false;
  }
}

// Ez a function felelős az összes profil adatának módosításáért,
// beállyytja a megfelelő útvonalat és megfelelő adatokat az adatbázishoz,
// majd ezek után a visszajövő értékekkel elvégzi az adott kiválaszott folyamatott.
function changeDatas(obj)
{
  // Létrehozzuk az urlt,
  // és beállítjuk az url-t alapértelmezetten az összes opcióra.
  let url = "updateUser/allDatas";

  if(messageType.value =="deleteUser")
  {
    url = "deleteUser";
    messageType.value = "";
  }
  else if(messageType.value=="deleteCardDatas")
  {
    url = "deleteCardDatas";
    messageType.value = "";
  }
  else if(messageType.value=="password")
  {
    messageType.value ="";
    url = "updateUser/Password";
    obj = passwords;
  }
  else if(changedCard.value==true && changedModel.value==true)
  {
    obj = {model,card};
  } 
  else
  {
    url = obj == model?"updateUser/Privacy":"updateUser/Card";
  }

  // meghíjva az aktuális adatbázis hívást a kiválasztott értékekkel.
  axios.post(`http://localhost:3000/${url}`,obj)
  .then((response)=>{

    // attól függően, hogy milyen adatokkal tér vissza a hivás,
    // az alapján fut tovább a program.

    // ha van data.message akkor megnézi hogy melyik falytát kapja vissza belőle,
    // ezek után elvégzi az aktuális folyamatokat és a végén tályékoztatja az usert.

    if(response.data.message == "incorrectPassword")
    {
      messageBoxmessage.value = messages.passwordError;
      showOkBtn.value = true;
      messageBox("open");
    }
    else if(response.data.message == "reservedEmail")
    {
      messageBoxmessage.value = messages.emailError;
      showOkBtn.value = true;
      messageBox("open");
    }
    else if(response.data.message == "deletedProfile")
    {
      messageBoxmessage.value = messages.succesDeleting;
      showOkBtn.value = true;
      messageBox("open");
    }
    else if(response.data.message == "deletedCardDatas")
    {
      messageBoxmessage.value = messages.succesEditing;
      let list = [user,card,cardCopie];

      for(let x of list)
      {
        x.cardNumber = "";
        x.expirationMonth = "";
        x.expirationYear = "";
      }
      showOkBtn.value = true;
      messageBox("open");

    }

    // ha nincsen data.message, akkor a  data.affectedRows-t foglya nézi az adatok frissítéséhez,
    // ezek utén minden adatott meg próbál frissíteni, ha valahol akadályba ütközik akkor magától lekezeli.

    if(response.data?.affectedRows || response.data[0]?.affectedRows)
    {
      try{
        response.data[1] = response.data[1][0];
        user.firstname = response.data[1].first_name;
        user.lasttname = response.data[1].last_name;
        user.middlename = response.data[1].middle_name;
        user.phone_number = response.data[1].phone_number;
        user.email = response.data[1].email;
        user.gender = response.data[1].gender;
        user.cardNumber = response.data[1].card_number;

        try{
          user.expirationMonth = response.data[1].expiration.split("/")[0];
          user.expirationYear = response.data[1].expiration.split("/")[1];
        }        
        catch
        {
          user.expirationMonth = "";
          user.expirationYear = "";
        }

        setNewDatas(obj);

      }
      catch
      {
        restoreDatas(obj);
      }

      messageBoxmessage.value = messages.succesEditing;
      showOkBtn.value = true;
      messageBox("open");
    }

  })
  .catch((err)=>{console.error(err)})

  messageBox("close");
}

// Ez a function vissza állítja az adatok az eredeti változatukra.
function restoreDatas(obj)
{
  let copie = obj == model 
                     ? modelCopie 
                     : obj==card 
                     ? cardCopie 
                     : passwordCopie;

  let changed = obj == model 
                       ? changedModel 
                       : obj==card 
                       ? changedCard 
                       : null;

  for(let x in obj)
  {
    if(obj[x]!=copie[x]){
      if(changed!=null)
        changed.value = false;
      obj[x]=copie[x];
    }
  }
}

// HA a fiók törlése opciót válasszuk, akkor ez a function fut le először,
// és állytja be a szükségs dolgokat a fiók kitörlésének folytatásához.
function deleteUser()
{
  messageBoxmessage.value = messages.deleting;
  messageType.value = "deleteUser";
  messageBox("open");
}

// ha a kártya adatok törlése opciót válasszuk, akkor ez a function fut le először,
// és állítja be a szükségs dolgokat a kártya adatok kitörlésének folytatásához.
function deleteCardDatas()
{
  messageBoxmessage.value = messages.deletingCardDatas;
  messageType.value = "deleteCardDatas";
  messageBox("open");
}

// ha a jelszó módosíása opciót válasszuk, akkor ez a function fut le először,
// és állítja be a szükségs dolgokat a jelszó módosításának folytatásához.
function updatePassword()
{
  messageBoxmessage.value = messages.editing;
  messageType.value = "password";
  messageBox("open");
}

// Ez a function kezeli a messageBox megjelenését és eltünésést
function messageBox(type)
{
  setTimeout(() => {
    document.body.classList.toggle("messageBoxShowUp");
  }, 200);

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

// Ha valamilyen változsá törtéánik akkor ez a function nézi meg,
// hogy a mostani adat tényleg különbözik e az alapértelmezettől,
// és azt is, hogy megfelelő formátumú-e. 
function change(obj)
{
  let copie = obj == model 
                     ? modelCopie 
                     : cardCopie;

  let changed = obj == model 
                       ? changedModel 
                       : changedCard;
  for(let x in obj)
  {
    if(obj[x]!=copie[x]){
      validateUserDatas() ? changed.value = true 
                          : changed.value = false;
      return;
    }
  }
  changed.value = false;
}

function openMessages(data)
{
  talkingWith.value = data;
  
}

// ezzel a watch-al a model adatait figyeljük,
// amikor megváltozik bármelyik adata, akkor meghívja a "change" függvényt.
watch(model,()=>
{
 change(model); 
},{deep:true})

// ezzel a watch-al a card adatait figyeljük,
// amikor megváltozik bármelyik adata, akkor meghívja a "change" függvényt.
watch(card,()=>
{
 change(card);
},{deep:true})

// adatbázisból lehúzzuk a szálláshoz tartozó részleteket
axios.get(`http://localhost:3000/getCardNetwork`)
  .then(details=>
  {
    userMessages.value = details.data;
  })
  .catch(error=>
  {
    console.error(error);
  })

</script>
<template>
  <div class="account">
    <div class="container">

      <!-- Kiválasztható opciók -->
      <nav>
        <!-- opciók összesége -->
        <div class="nav nav-tabs justify-content-center" 
             id="nav-tab" 
             role="tablist">

          <!-- Adataim opció -->
          <button class="nav-link active"
                  id="nav-datas-tab"
                  data-bs-toggle="tab"
                  data-bs-target="#nav-datas"
                  type="button" role="tab"
                  aria-controls="nav-datas"
                  aria-selected="true">
            <i class="fa-solid fa-user-pen fa-lg"></i>
            {{ $t("profile.navbar_datas") }}
          </button>

          <!-- Közzétételeim opcció -->
          <button class="nav-link" 
                  id="nav-posts-tab" 
                  data-bs-toggle="tab" 
                  data-bs-target="#nav-posts" 
                  type="button" role="tab" 
                  aria-controls="nav-posts" 
                  aria-selected="false">
            <i class="fa-solid fa-upload fa-lg"></i>
            {{ $t("profile.nabar_posts") }}
          </button>

          <!-- Beszélgetéseim opció -->
          <button class="nav-link" 
                  id="nav-chats-tab" 
                  data-bs-toggle="tab" 
                  data-bs-target="#nav-chats" 
                  type="button" 
                  role="tab" 
                  aria-controls="nav-chats" 
                  aria-selected="false">
            <i class="fa-solid fa-comments fa-lg"></i>
            {{ $t("profile.navbar_messages") }}
          </button>
        </div>
      </nav>

      <!-- Opciók és a messageBox -->
      <div class="row align-items-top justify-content-center">

        <!-- Opciókat összegző div -->
        <div class="tab-content text-white
                   text-center bg-dark bg-opacity-50 
                   rounded-5 rounded-top-0 py-5 px-4" 
             id="nav-tabContent">

          <!-- Adatim opció -->
          <div class="tab-pane fade show active"
              id="nav-datas" 
              role="tabpanel" 
              aria-labelledby="nav-datas-tab" 
              tabindex="0">
            
              <!-- Adatok megjelenítése -->
            <div class="row justify-content-center">

              <!-- Személyes adatok form megjelenítő gomb -->
              <div class="row justify-content-center col-12">
                
                <!-- Maga a gomb -->
                <button class="col-6 col-sm-5 col-md-3 
                               text-nowrap mx-2 my-2 btn btn-outline-light"
                      data-bs-toggle="collapse"
                      data-bs-target="#collpasePrivacyDatas">
                  <i class="fa-solid fa-address-card fa-xl"></i>
                  {{ $t("profile.personal_detail") }}
                </button>
              </div>

              <!-- Személyes adatok -->
              <form id="collpasePrivacyDatas"
                    class="col-12 col-sm-10 col-md-8 
                           col-lg-8 col-xl-8 col-xxl-6
                           collapse my-4">

                <!-- Cím -->
                <h4 class="text-center">
                  <i class="fa-solid fa-address-card"></i>
                  {{ $t("profile.personal_detail") }}
                </h4>

                <!-- Adatok és gombok -->
                <div class="px-3 py-3 border rounded-3">

                  <!-- Nevek -->
                  <div class="row justify-content-center mb-3">

                    <!-- Cím -->
                    <h5 class="text-center">
                      <i class="fa-solid fa-id-card-clip fa-lg"></i>
                      {{ $t("profile.names") }}
                    </h5>
                  
                    <!-- Keresztnév -->
                    <div :class="model.middleName!=''?
                          'col-lg-4':
                          'col-lg-6'"
                          class="mb-3 m-0 col-12">

                      <!-- Label -->
                      <label for="InputFirstName" 
                              class="form-label">
                        <i class="fa-solid fa-chalkboard-user"></i>
                        {{ $t("profile.first_name") }}
                      </label>

                      <!-- Input -->
                      <input type="text" 
                              class="form-control" 
                              id="InputFirstName" 
                              v-model="model.firstName">
                    </div>

                    <!-- Második név -->
                    <div v-if="model.middleName!=''"
                        class="mb-3 col-12 col-lg-4">

                      <!-- Label -->
                      <label for="InputMiddleName" 
                              class="form-label">
                        <i class="fa-solid fa-chalkboard-user"></i>
                        {{ $t("profile.middle_name") }}
                      </label>

                      <!-- Input -->
                      <input type="text" 
                              class="form-control" 
                              id="InputMiddleName" 
                              v-model="model.middleName">
                    </div>

                    <!-- Vezetéknév -->
                    <div :class="model.middleName!=''?
                          'col-lg-4':
                          'col-lg-6'"
                        class="mb-3 m-0 col-12">

                      <!-- Label -->
                      <label for="InputLastName" 
                              class="form-label">
                        <i class="fa-solid fa-chalkboard-user"></i>
                        {{ $t("profile.last_name") }}
                      </label>

                      <!-- Input -->
                      <input type="text" 
                              class="form-control" 
                              id="InputLastName"
                              v-model="model.lastName">
                    </div>
                  </div>

                  <!-- elérhetőségek -->
                  <div class="row">

                    <!-- Cím -->
                    <h5 class="text-center">
                      <i class="fa-solid fa-envelope fa-lg"></i>
                      {{ $t("profile.contact") }}
                    </h5>

                    <!-- Email -->
                    <div class="mb-3 col-12 col-lg-6">

                      <!-- Label -->
                      <label for="InputEmail" 
                              class="form-label">
                        <i class="fa-solid fa-at"></i>
                        {{ $t("profile.email") }}
                      </label>

                      <!-- Input -->
                      <input type="email" 
                              class="form-control" 
                              id="InputEmail" 
                              v-model="model.email">
                    </div>

                    <!-- Telefonszán -->
                    <div class="mb-3 col-12 col-lg-6">

                      <!-- Label -->
                      <label for="InputPhoneNum" 
                              class="form-label">
                        <i class="fa-solid fa-phone"></i>
                        {{ $t("profile.phone_number") }}
                      </label>

                      <!-- Input -->
                      <input type="text" 
                              class="form-control" 
                              id="InputPhoneNum" 
                              v-model="model.phoneNum">
                    </div>
                  </div>

                  <!-- Nem -->
                  <div class="row mb-4">   

                    <!-- Cím -->
                    <h5 class="text-center">
                      <i class="fa-solid fa-mars-and-venus fa-lg"></i>
                      {{ $t("profile.gender") }}
                    </h5>

                    <!-- Nekem label-je -->
                    <div class="row justify-content-center text-center">

                      <!-- Férfi -->
                      <label for="genderMale" 
                            class="form-label col-6">
                        <span>
                          <i class="fa-solid fa-mars"></i>
                          {{ $t("profile.male") }}
                        </span> 
                      </label>

                      <!-- Nő -->
                      <label for="genderFemale" 
                            class="form-label col-6">
                        <span>
                          <i class="fa-solid fa-venus"></i>
                          {{ $t("profile.female") }}
                        </span>
                      </label>
                    </div>

                    <!-- Nemek gombjai -->
                    <div class="row justify-content-center">

                      <!-- Férfi -->
                      <div class="d-flex col-6 justify-content-center">
                        <input type="radio"
                          name="genderMale"
                          class="form-check-input" 
                          id="genderMale"
                          value="M"
                          v-model="model.gender">
                      </div>

                      <!--Nő -->
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

              <!-- Kártya információk form megjelenítő gomb -->
              <div class="row justify-content-center col-12">  

                <!-- Maga a gomb -->
                <button class="col-6 col-sm-5 col-md-3 
                                mx-2 my-2 btn btn-outline-light"
                      data-bs-toggle="collapse"
                      data-bs-target="#collpaseCardDatas">
                 <i class="fa-solid fa-credit-card fa-xl"></i>
                 {{ $t("profile.card_datas") }}
                </button>
              </div>

              <!-- Kártya információk -->
              <form id="collpaseCardDatas"
                    class="col-12 col-sm-10 col-md-8 
                           col-lg-8 col-xl-8 col-xxl-6
                           collapse my-4">

                <!-- Cím -->
                <h4 class="text-center">
                  <i class="fa-solid fa-credit-card"></i>
                  {{ $t("profile.card_datas") }}
                </h4>

                <!-- Adatok és gombok -->
                <div class="px-3 py-3 border rounded-3
                            row justify-content-center">

                  <!-- Kártyaszám -->
                  <div class="mb-3 col-10">

                    <!-- Label -->
                    <label for="inputcardNumber" 
                            class="form-label">
                      <i class="fa-solid fa-arrow-down-1-9"></i>
                      {{ $t("profile.card_number") }}
                    </label>

                    <!-- Input -->
                    <input type="text"
                            :maxlength="19"
                            class="form-control"
                            id="inputcardNumber"
                            v-model="card.cardNumber">
                  </div>

                  <!-- Hónap -->
                  <div class="mb-3 col-6 col-lg-4">

                    <!-- Label -->
                    <label class="form-label"
                            for="inputMonth">
                      <i class="fa-solid fa-calendar-days"></i>
                      {{ $t("profile.card_month") }}
                    </label>

                    <!-- Select -->
                    <select class="form-select"
                            id="inputMonth"
                            v-model="card.expirationMonth">
                      <option v-for="x in 12">{{ x.toString().padStart(2,'0') }}</option>
                    </select>
                  </div>

                  <!-- ÉV -->
                  <div class="mb-3 col-6 col-sm-3 col-lg-4">

                    <!-- Label -->
                    <label class="form-label"
                            for="inputYear">
                      <i class="fa-solid fa-calendar"></i>
                      {{ $t("profile.card_year") }}
                    </label>

                    <!-- Select -->
                    <select class="form-select"
                            id="inputYear"
                            v-model="card.expirationYear">
                      <option v-for="x in 5" >
                        {{ parseInt(currentExpYear) + x }}
                      </option>
                    </select>
                  </div>

                  <!-- Gombok -->
                  <div class="row ms-1 justify-content-center">

                    <!-- Mentés gomb -->
                    <button v-if="changedModel!=true && changedCard==true"
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
                                    text-nowrap mx-2 my-2 btn btn-light">
                      {{ $t("profile.save_all") }}
                    </button>

                    <!-- Mégse gomb -->
                    <button :disabled="changedCard!=true"
                            @click="restoreDatas(card)"
                            type="button" 
                            class="col-12 col-sm-12 col-md-4 col-lg-3 
                                    mx-2 my-2 btn btn-secondary">
                      {{ $t("profile.unsave") }}
                    </button>

                    <!-- Adatok tölrlése gomb -->
                    <button v-if="cardCopie.cardNumber!=''&&
                                  cardCopie.expirationMonth!='' && 
                                  cardCopie.expirationYear!=''"
                            @click="deleteCardDatas(card)"
                            type="button" 
                            class="col-12 col-sm-12 col-md-4 col-lg-3 
                                    mx-2 my-2 btn btn-danger">
                      {{ $t("profile.delete_datas") }}
                    </button>
                  </div>
                </div>
              </form>

              <!-- Jelszó form megjelenítő gomb -->
              <div class="row justify-content-center col-12">

                <!-- Maga a gomb -->
                <button class="col-6 col-sm-5 col-md-3 
                                mx-2 my-2 btn btn-outline-light"
                      data-bs-toggle="collapse"
                      data-bs-target="#collpasePasswords">
                  <i class="fa-solid fa-key fa-xl"></i>  
                  {{ $t("profile.password_modify") }}
                </button>
              </div>

              <!-- Jelszó  módosítás-->
              <form id="collpasePasswords"
                    class="col-12 col-sm-10 col-md-8 
                           col-lg-8 col-xl-8 col-xxl-6
                           collapse my-4">

                <!-- Cím -->
                <h4 class="text-center">
                  <i class="fa-solid fa-key"></i>
                  {{ $t("profile.password_modify") }}
                </h4>

                <!-- Adatok és gombok -->
                <div class="px-3 py-3 row justify-content-center border rounded-3">

                  <!-- Eredeti elszó-->
                  <div class="mb-3 col-10">

                    <!-- LAbel -->
                    <label for="originalPassword" 
                          class="form-label">
                      <i class="fa-solid fa-lock"></i>
                      {{ $t("profile.original_password") }}
                    </label>

                    <!-- Input -->
                    <input :type="showpasscheck ? 'text' : 'password'" 
                          class="form-control" 
                          id="originalPassword"
                          autocomplete="off"
                          minlength="6"
                          maxlength="40" 
                          v-model="passwords.currentPassword">
                  </div>

                  <!--Új Jelszó-->
                  <div class="mb-3 col-10">

                    <!-- Label -->
                    <label for="newPassword" 
                          class="form-label">
                      <i class="fa-solid fa-unlock"></i>
                      {{ $t("profile.new_password") }}
                    </label>

                    <!-- Input -->
                    <input :type="showpasscheck ? 'text' : 'password'" 
                          class="form-control" 
                          id="newPassword"
                          autocomplete="off"
                          minlength="6"
                          maxlength="40" 
                          v-model="passwords.newPassword">
                      
                      <!-- Jelszó követelmények -->
                      <div class="form-text text-white fw-bold">
                        {{ $t("profile.password_requirement")}}<br>
                        {{ $t("profile.password_requirement_second") }}<br>           
                        {{ $t("profile.password_requirement_third") }}
                      </div>
                  </div>

                  <!--Új Jelszó mégegyszer -->
                  <div class="mb-3 col-10">

                    <!-- LAbel -->
                    <label for="inputconfirmpass" 
                          class="form-label">
                      <i class="fa-solid fa-unlock"></i>
                      {{ $t("profile.password_again") }}
                    </label>

                    <!-- Input -->
                    <input :type="showpasscheck ? 'text' : 'password'" 
                          class="form-control" 
                          id="inputconfirmpass"
                          minlength="6"
                          maxlength="40"
                          autocomplete="off" 
                          v-model="passwords.confirmPassword">
                  </div>

                  <!-- Jelszó megjelenítése -->
                  <div class="d-flex mb-3 mt-3 justify-content-center">

                    <!-- label -->
                    <label class="w-auto form-check-label mx-1 text-start" 
                          for="flexCheckDefault">
                      {{ $t("profile.show_password") }}
                    </label>

                    <!-- Input -->
                    <input class="form-check-input float-end" 
                          type="checkbox" 
                          id="flexCheckDefault"
                          v-model="showpasscheck">
                  </div>

                  <!-- Gombok -->
                  <div class="row mx-1 justify-content-center">

                    <!-- Mentés gomb -->
                    <button v-if="validatePasswords()!=false"
                            @click="updatePassword()"
                            type="button"
                            class="col-12 col-sm-12 col-md-4 col-lg-3
                                   mx-2 my-2 btn btn-light">
                      {{ $t("profile.save") }}
                    </button>

                    <!-- Mégse gomb -->
                    <button :disabled="validatePasswords()==false"
                            @click="passwords.currentPassword='';
                                    passwords.newPassword='';
                                    passwords.confirmPassword=''"
                            type="button" 
                            class="col-12 col-sm-12 col-md-4 col-lg-3
                                  mx-2 my-2 btn btn-secondary">
                      {{ $t("profile.unsave") }}
                    </button>
                  </div>
                </div>
              </form>
            </div>

            <!-- Törlési funkció -->
            <div class="row justify-content-center">

              <!-- Felhasználó törlési gomb -->
              <div class="mx-2 row justify-content-center 
                          border border-danger mt-4 rounded-3
                          col-6 col-sm-6 col-md-4 col-lg-4 col-xl-4">

                <!-- Törlés gomb -->
                <button @click="deleteUser()"
                        type="button" 
                        class="col-10
                               text-nowrap mx-3 my-3
                               btn btn-danger">
                  <i class="fa-solid fa-user-xmark fa-xl"></i>
                  {{ $t("profile.delete_user") }}
                </button>
              </div>
            </div>
          </div>

          <!-- Közzétételek opció -->
          <div class="tab-pane fade" 
              id="nav-posts" 
              role="tabpanel" 
              aria-labelledby="nav-posts-tab" 
              tabindex="0">

            <div class="card mb-3 col-5">
              <div class="row g-0">

                <div class=" col-xl-6">
                  <img src="../images/fff.jpg" class="img-fluid rounded-start" alt="...">
                </div>

                <div class="col-xl-6">
                  <div class="card-body">

                    <h5 class="card-title">
                      Card title
                    </h5>

                    <div class="row justify-content-center">
                      <button class="btn btn-secondary m-1 col-4">
                        Megnéz
                      </button>
                      <button class="btn btn-info  m-1  col-4">
                        Módosít
                      </button>
                      <button class="btn btn-danger  m-1  col-4">
                        Töröl
                      </button>
                    </div>

                  </div>
                </div>
              </div>
            </div>

          </div>
          
          <!-- Beszélgetések opció -->
          <div class="tab-pane fade"
              id="nav-chats" 
              role="tabpanel" 
              aria-labelledby="nav-chats-tab" 
              tabindex="0">

              <!-- Maga az egész beszélgetés -->
              <div class="row justify-content-center 
                          overflow-y-hidden" 
                   style="height:600px;">
              
                <!-- Bal oldali emberek megjelenítése -->
                <div class="col-5 col-sm-4 border 
                            border-1 border-white 
                            rounded-start p-0 h-100">

                  <!-- Beszélgető partnerek -->
                  <div class="h-100 overflow-y-auto">

                    <!-- Beszélgető partnerek -->
                    <span class="people d-flex 
                                 align-items-center 
                                 border-bottom border-secondary 
                                 ps-2"  
                          v-for="x in userMessages"
                          style="min-height: 55px;"
                          @click="openMessages(x)">
                      {{ x.network_name }}
                    </span>
                  </div>
                </div>

                <!-- Jobb oldali üzenet megjelenítés -->
                <div class="col-7 col-sm-8 
                            d-flex flex-column bg-white 
                            rounded-end text-black p-0" 
                      style="height: 600px;">
                  
                  <!-- Címzett kiírása -->
                  <div class="d-flex w-100 align-items-center 
                              border-bottom border-secondary 
                              bg-secondary bg-opacity-25" 
                        style="height: 40px;">

                    <!-- Címzett -->
                    <span>
                      {{ talkingWith }}
                    </span>
                  </div>

                  <!-- Üzenet rész -->
                  <div class="flex-grow-1 
                              overflow-y-auto 
                              overflow-x-hidden">

                    <!-- Üzenetek -->
                    <div class="text-end p-3" 
                         style="height: 40px;" 
                         v-for="x in userMessages">

                      <!-- Üzenet -->
                      <span class="bg-dark text-white rounded-3 p-2">
                      {{ x.network_name }}
                      </span>
                    </div>
                  </div>

                  <!-- messageBar -->
                  <div class=" py-2 bg-secondary rounded-end">
                    <input class="form-control col-8" 
                           type="search" 
                           name="messageBar" 
                           id="messageBar">
                  </div>
                </div>
              </div>
          </div>
        </div>
        
        <!-- messageBox -->
        <div v-if="messageBoxType==true"
             class="row position-absolute justify-content-center">

          <!-- Tartalom -->
          <div class="col-10 col-sm-8 col-md-7 col-lg-4
                     messageBox fade-in bg-secondary
                     border border-3 rounded-5 py-3 px-3">

            <!-- Kérdés -->
            <h1 class="text-center">
              {{ messageBoxmessage }}
            </h1>

            <!-- Gombok -->
            <div class="row justify-content-center">

              <!-- Mentés gomb -->
              <button v-if="showOkBtn!=true"
                      @click="changeDatas(changedModel==true?model:card)"
                      type="button"
                      class="col-8 col-sm-5 col-md-5 col-lg-4
                             mx-2 my-2 btn btn-light">
                {{ $t("profile.yes") }}
              </button>

              <!-- Mégse gomb -->
              <button v-if="showOkBtn!=true"
                      @click="messageBox('close'); 
                      messageBoxmessage = messages.editing;
                      messageType = '';"
                      type="button" 
                      class="col-8 col-sm-5 col-md-5 col-lg-4 
                             mx-2 my-2 btn btn-dark">
                {{ $t("profile.no") }}
              </button>

              <!-- ok gomb -->
              <button v-if="showOkBtn==true"
                      @click="messageBox('close'); 
                              messageBoxmessage == messages.succesDeleting ? 
                                  removeDeletedUserValues() : 
                                  showOkBtn = false;"
                      type="button" 
                      class="col-8 col-sm-5 col-md-5 col-lg-4 
                             mx-2 my-2 btn btn-light">
                {{ $t("profile.ok") }}
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

.people:hover{

  background-color: hsl(210, 5%, 25%);
  cursor: pointer;
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
  box-shadow: 0 0 100px 10000px rgba(0, 0, 0, 0.8) !important;
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
  animation: fadeInUp 1s ease both;
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