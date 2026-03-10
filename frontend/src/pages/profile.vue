<script setup>
import { user } from '@/store/user';
import router from '@/router';
import { reactive, ref, watch } from 'vue';
import axios from 'axios';

//securityCheck
if(!user.id)
  router.back()

let model = reactive({
  userID: user.id,
  firstName: user.firstname,
  lastName: user.lasttname,
  middleName: user.middlename,
  email: user.email,
  phoneNum: user.phone_number,
  gender: user.gender,
})

let card = reactive({
  userID: user.id,
  cardNumber: user.cardNumber,
  expirationMonth: user.expirationMonth,
  expirationYear: user.expirationYear
}) 

let passwords = reactive({
    userID: user.id,
    currentPassword :"",
    newPassword:"",
    confirmPassword:""
})

let messages =
{
  editing: "Biztos menti a változtatásokat?",
  deleting:"Biztos törli a fiókját?",
  deletingCardDatas:"Biztos törli a kártya adatokat?",
  passwordError:"Hibás jelenlegi jelszót adott meg!",
  emailError:"A megadott email cím már foglalt! ",
  succesEditing:"Sikeres változtatás!",
  succesDeleting:"Sikeresen törölte a fiókját!"
}

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

// Adatokat ellenőrzése

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
  router.push("/");
}

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

function changeDatas(obj)
{
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
  axios.post(`http://localhost:3000/${url}`,obj)
  .then((response)=>{

    console.log(response.data);
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

function restoreDatas(obj)
{
  let copie = obj == model?modelCopie:obj==card?cardCopie:passwordCopie;
  let changed = obj == model?changedModel:obj==card?changedCard:null;

  for(let x in obj)
  {
    if(obj[x]!=copie[x]){
      if(changed!=null)
        changed.value = false;
      obj[x]=copie[x];
    }
  }
}

function deleteUser()
{
  messageBoxmessage.value = messages.deleting;
  messageType.value = "deleteUser";
  messageBox("open");
}

function deleteCardDatas()
{
  messageBoxmessage.value = messages.deletingCardDatas;
  messageType.value = "deleteCardDatas";
  messageBox("open");
}

function updatePassword()
{
  messageBoxmessage.value = messages.editing;
  messageType.value = "password";
  messageBox("open");
}

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

function change(obj)
{
  let copie = obj == model?modelCopie:cardCopie;
  let changed = obj == model?changedModel:changedCard;
  for(let x in obj)
  {
    if(obj[x]!=copie[x]){
      validateUserDatas()?changed.value = true:changed.value = false;
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

      <!-- Kiválasztható opciók -->
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

      <!-- Opciók és a messageBox -->
      <div class="row align-items-top justify-content-center">

        <!-- Opciókat összegző div -->
        <div class="tab-content text-white
                   text-center bg-dark bg-opacity-50 
                   rounded-5 rounded-top-0 py-5 px-4" 
             id="nav-tabContent">

          <!-- Adatok opció -->
          <div class="tab-pane fade show active"
              id="nav-datas" 
              role="tabpanel" 
              aria-labelledby="nav-datas-tab" 
              tabindex="0">
            
              <!-- Adatok megjelenítése -->
            <div class="row justify-content-center">

              <!-- Személyes adatok form megjelenítő gomb -->
              <div class="row justify-content-center col-12">  
                <button class="col-6 col-sm-5 col-md-3 
                               text-nowrap mx-2 my-2 btn btn-outline-light"
                      data-bs-toggle="collapse"
                      data-bs-target="#collpasePrivacyDatas">
                  Személyes adatok
                </button>
              </div>

              <!-- Személyes adatok -->
              <form id="collpasePrivacyDatas"
                    class="col-12 col-sm-10 col-md-8 
                           col-lg-8 col-xl-8 col-xxl-6
                           collapse my-4">

                <!-- Cím -->
                <h4 class="text-center">
                  Személyes adatok
                </h4>

                <!-- Adatok és gombok -->
                <div class="px-3 py-3 border rounded-3">

                  <!-- Names -->
                  <div class="row justify-content-center mb-3">
                    <div>
                      <h5 class="text-center">Nevek</h5>
                    </div>

                    <!-- FirstName -->
                    <div :class="model.middleName!=''?
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
                    <div v-if="model.middleName!=''"
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
                    <div :class="model.middleName!=''?
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
                            @click="messageBox('open');
                                    messageBoxmessage = messages.editing"
                            type="button"
                            class="col-12 col-sm-12 col-md-4 col-lg-3
                                   mx-2 my-2 btn btn-light">
                      Mentés
                    </button>

                    <!-- Összes mentése gomb -->
                    <button v-if="changedModel==true && changedCard==true"
                            @click="messageBox('open');
                                    messageBoxmessage = messages.editing"
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

              <!-- Kártya információk form megjelenítő gomb -->
              <div class="row justify-content-center col-12">  
                <button class="col-6 col-sm-5 col-md-3 
                                mx-2 my-2 btn btn-outline-light"
                      data-bs-toggle="collapse"
                      data-bs-target="#collpaseCardDatas">
                  Kártya adatok
                </button>
              </div>

              <!-- Kártya információk -->
              <form id="collpaseCardDatas"
                    class="col-12 col-sm-10 col-md-8 
                           col-lg-8 col-xl-8 col-xxl-6
                           collapse my-4">

                <!-- Cím -->
                <h4 class="text-center">
                  Kártya adatok
                </h4>

                <!-- Adatok és gombok -->
                <div class="px-3 py-3 border rounded-3
                            row justify-content-center">

                  <!-- cardNumber -->
                  <div class="mb-3 col-10">
                    <label for="inputcardNumber" 
                            class="form-label">
                      Kártyaszám
                    </label>
                    <input type="text"
                            :maxlength="19"
                            class="form-control"
                            id="inputcardNumber"
                            v-model="card.cardNumber">
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
                      Mentés
                    </button>

                    <!-- Összes mentése gomb -->
                    <button v-if="changedModel==true && changedCard==true"
                            @click="messageBox('open');
                                    messageBoxmessage = messages.editing"
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

                      <!-- Adatok tölrlése gomb -->
                    <button v-if="cardCopie.cardNumber!=''&&
                                  cardCopie.expirationMonth!='' && 
                                  cardCopie.expirationYear!=''"
                            @click="deleteCardDatas(card)"
                            type="button" 
                            class="col-12 col-sm-12 col-md-4 col-lg-3 
                                    mx-2 my-2 btn btn-danger">
                      Adatok törlése
                    </button>
                  </div>
                </div>
              </form>

              <!-- Jelszó form megjelenítő gomb -->
              <div class="row justify-content-center col-12">
                <button class="col-6 col-sm-5 col-md-3 
                                mx-2 my-2 btn btn-outline-light"
                      data-bs-toggle="collapse"
                      data-bs-target="#collpasePasswords">
                  Jelszó módosítása
                </button>
              </div>

              <!-- Jelszó  módosítás-->
              <form id="collpasePasswords"
                    class="col-12 col-sm-10 col-md-8 
                           col-lg-8 col-xl-8 col-xxl-6
                           collapse my-4">

                <!-- Cím -->
                <h4 class="text-center">
                  Jelszó módosítása
                </h4>

                <!-- Adatok és gombok -->
                <div class="px-3 py-3 row justify-content-center border rounded-3">

                  <!-- Eredeti elszó-->
                  <div class="mb-3 col-10">
                    <label for="originalPassword" 
                          class="form-label">
                      Eredeti jelszó
                    </label>
                    <input :type="showpasscheck ? 'text' : 'password'" 
                          class="form-control" 
                          id="originalPassword"
                          autocomplete="off"
                          minlength="6"
                          maxlength="40" 
                          v-model="passwords.currentPassword">
                  </div>

                  <!-- Jelszó-->
                  <div class="mb-3 col-10">
                    <label for="newPassword" 
                          class="form-label">
                      Új jelszó
                    </label>
                    <input :type="showpasscheck ? 'text' : 'password'" 
                          class="form-control" 
                          id="newPassword"
                          autocomplete="off"
                          minlength="6"
                          maxlength="40" 
                          v-model="passwords.newPassword">
                      <div class="form-text text-white fw-bold">
                        {{ $t("register.password_requirement") }}
                      </div>
                      <div class="form-text text-white fw-bold">
                        {{ $t("register.password_requirement_second") }}
                      </div>
                      <div class="form-text text-white fw-bold">
                        A régi és az új jelszó nem egyezhet
                      </div>
                  </div>

                  <!-- Jelszó mégegyszer -->
                  <div class="mb-3 col-10">
                    <label for="inputconfirmpass" 
                          class="form-label">
                      Új jelszó mégegyszer
                    </label>
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
                    <label class="w-auto form-check-label mx-1 text-start" 
                          for="flexCheckDefault">
                      {{ $t("register.show_password") }}
                    </label>
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
                      Mentés
                    </button>

                    <!-- Mégse gomb -->
                    <button :disabled="validatePasswords()==false"
                            @click="passwords.currentPassword='';
                                    passwords.newPassword='';
                                    passwords.confirmPassword=''"
                            type="button" 
                            class="col-12 col-sm-12 col-md-4 col-lg-3
                                  mx-2 my-2 btn btn-secondary">
                      Mégsem
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
                  Fiók törlése
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
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Dolores cumque excepturi nemo odio qui. Quam magni odio debitis eius temporibus ex natus, alias doloribus veritatis, quasi eligendi, ratione nulla voluptates.
          </div>
          
          <!-- Beszélgetések opció -->
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
                Igen
              </button>

              <!-- Mégse gomb -->
              <button v-if="showOkBtn!=true"
                      @click="messageBox('close'); 
                      messageBoxmessage = messages.editing;
                      messageType = '';"
                      type="button" 
                      class="col-8 col-sm-5 col-md-5 col-lg-4 
                             mx-2 my-2 btn btn-dark">
                Nem
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
                OK
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