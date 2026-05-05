<script setup>
import { user } from '@/store/user';
import router from '@/router';
import { reactive, ref, watch } from 'vue';
import axios from 'axios';
import { useI18n } from 'vue-i18n';
import { selectedCurrency } from '@/store/currency';
import { convertStrings } from '@/common';

const {t} = useI18n();
const {locale} = useI18n();
//securityCheck.
if(!user.id)
  router.back()

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

// A felhasználó kártya adatai.
let card = reactive({
  userID: user.id,
  cardNumber: user.cardNumber,
  expirationMonth: user.expirationMonth,
  expirationYear: user.expirationYear
}) 

// A felhasználó jelszavai
let passwords = reactive({
    userID: user.id,
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

//Beszélgetéshez szükséges adatok
let sendingMessage = reactive({
  from_id:"",
  to_id:"",
  message:"",
});

// Változók definiállása.
let history = ref([]);
let userItems = ref([]);
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
let userContacts = ref(""); 
let reports = ref([]);

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
  router.push("/");
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

// Lehívjuk azokat a beszélgetések amik az adott userhez tartoznak  
function openMessages(data)
{
  // adatbázisból lehúzzuk a szálláshoz tartozó részleteket
  axios.post(`http://localhost:3000/getMessages`,{from_id:data.from_user_id,to_id:data.to_user_id})
  .then(details=>
  {
    // beállítjuk az alavető adatokat
    sendingMessage.message = '';
    sendingMessage.from_id = user.id;
    sendingMessage.to_id = data.from_user_id;
    userMessages.value = details.data;

    // automatikusan le görgetünk a beszélgetések aljára.
    scrollToBottom();
  })
  .catch(error=>
  {
    console.error(error);
  })

  // Annak a neve akivel a user éppen beszélget.
  talkingWith.value = `${data.first_name} ${data.middle_name} ${data.last_name}` ;
}

// Contactok lehúzása
function getContacts()
{
// adatbázisból lehúzzuk a szálláshoz tartozó részleteket
axios.get(`http://localhost:3000/getContacts/${user.id}`)
.then(details=>
{
  userContacts.value = details.data;
})
.catch(error=>
{
  console.error(error);
})
}

// Ennek a függvénynek a segítségével görgetünk a beszélgetés aljára.
function scrollToBottom()
{
  setTimeout(()=>{
    
    let messageBox = document.body.querySelector("div#messageBox");
    messageBox.scrollTop = messageBox.scrollHeight;

  },50)
}

// Ezzel küldünk el új üzeneteket.
function sendMessage()
{

  axios.post(`http://localhost:3000/sendMessages`,sendingMessage)
  .then(response=>{
    
    if(response.data.affectedRows>0)
    {
      // adatbázisból lehúzzuk a szálláshoz tartozó részleteket
      axios.post(`http://localhost:3000/getMessages`,{from_id:sendingMessage.from_id,to_id:sendingMessage.to_id})
      .then(details=>
      {
        userMessages.value = details.data;
        sendingMessage.message = '';
        sendingMessage.from_id = user.id;

        scrollToBottom();
      })
      .catch(error=>
      {
        console.error(error);
      })
    }
  })
  .catch(err=>{
    console.log(err);
  })
}

function getUserItems()
{
  axios.get(`http://localhost:3000/getUserItems/${user.id}`)
  .then(async response =>{
    userItems.value = response.data;

    for(let x in userItems.value)
    { 
      getTranslationUserTypes(userItems.value[x]);
    }
    
  })
  .catch(err=>{
    console.log(err);
  })
}
// végigmegy a history összes elemén, majd megnézi adatbázisban hogy van-e neki az adott nyelvre fordítása,
// ha nincsen rá fordítás, de azon a nyelven vagyunk amilye nnyelven feltöltöttük az adottott tárgyat,
// akkor az eredeti verzióját tölti be.
// HA egy dolognak nincsen fordítása és eredeti verziója sem paszzol a jelenlegi nyelvhez,
//  akkor api segítségével lefordítja és feltölti adatbázisba a fordítások közé, és újra idítja az oldalt,
// utána pendig az egész függvény előröl kezdődik és így már be fogja tölteni az adot tárgy fordítását.
// ha esetleg hiba akana afordítással akkor a művele megszakad é kiírja a konzolbon.
function getTranslation(item)
{
	for(let x in item.value)
	{
		axios.post(`http://localhost:3000/translate`,
			{item_id:item.value[x].accommodation_id,item_name:'accommodations',language_short_name:locale.value})
		.then(datas=>
		{
			// ha a translationed üzenettl tér vissza, akkor tudjuk, hogy mgtalálta az elem fodítását.
			if(datas.data.message == "translationed")
			{
				// az adatbázisban tárolt json fáljt beolvassuk és átadjuk az értékét.
				let text  = JSON.parse(datas.data.data[0].item);
				item.value[x].accommodation_name = text["title"];
				
			}
			// ha az original üzenettel tér vissza, akkor tudjuk, hogy az elem eredeti verzióját találta meg.
 			else if(datas.data.message == "original")
			{
				// ezután beállítjuk és felhasználjuk az erdeti verzió értékeit.
				item.value[x].accommodation_name = datas.data.data[0].name;
			}
			// ha az üzenet failed akkor megy bele
			else if(datas.data.message == "failed")
			{
				console.log("Hiba történt az api forítás során!");
				return false;
			}
			// minden ellenkező esetben pedig újra töltjük az oldalt.
			else{
				location.reload();
			}
		})
		.catch(err=>
		{
			console.log(err);
		})
	}
}

// végigmegy a userItems összes elemén, majd megnézi adatbázisban hogy van-e neki az adott nyelvre fordítása,
// ha nincsen rá fordítás, de azon a nyelven vagyunk amilye nnyelven feltöltöttük az adottott tárgyat,
// akkor az eredeti verzióját tölti be.
// HA egy dolognak nincsen fordítása és eredeti verziója sem paszzol a jelenlegi nyelvhez,
//  akkor api segítségével lefordítja és feltölti adatbázisba a fordítások közé, és újra idítja az oldalt,
// utána pendig az egész függvény előröl kezdődik és így már be fogja tölteni az adot tárgy fordítását.
// ha esetleg hiba akana afordítással akkor a művele megszakad é kiírja a konzolbon.
function getTranslationUserTypes(item)
{

	for(let x in item)
	{

    axios.post('http://localhost:3000/getAllLocations',{country_id:item[x].country_id,
                                                      city_id:item[x].city_id,
                                                      language_short_name:locale.value})
    .then(translations=>{

      // beállíítja az adott elemnek az éppen kiválaszott nyelvhez lefordított város és ország nevét.
      item[x].country_trans_name = translations.data.countries[0].name;
      item[x].city_trans_name = translations.data.cities[0].name;
      
    })
    .catch(err=>{
      console.log(err);
    })
    
		axios.post(`http://localhost:3000/translate`,
			{item_id:item[x].id,item_name:item[x].table_type,language_short_name:locale.value})
		.then(datas=>
		{
      
			// ha a translationed üzenettl tér vissza, akkor tudjuk, hogy mgtalálta az elem fodítását.
			if(datas.data.message == "translationed")
			{
				// az adatbázisban tárolt json fáljt beolvassuk és átadjuk az értékét.
				let text  = JSON.parse(datas.data.data[0].item);
				item[x].name = text["title"];
				
			}
			// ha az original üzenettel tér vissza, akkor tudjuk, hogy az elem eredeti verzióját találta meg.
 			else if(datas.data.message == "original")
			{
				// ezután beállítjuk és felhasználjuk az erdeti verzió értékeit.
				item[x].name = datas.data.data[0].name;
			}
			// ha az üzenet failed akkor megy bele
			else if(datas.data.message == "failed")
			{
				console.log("Hiba történt az api forítás során!");
				return false;
			}
			// minden ellenkező esetben pedig újra töltjük az oldalt.
			else{
				location.reload();
			}
		})
		.catch(err=>
		{
			console.log(err);
		})
	}
}

/**
 * @param {int} id - felhasználó id
 * Lekéri az adott id alapján a felhasználóhoz rendelet előzményeket
 */
let getHistory = (id) => {
  axios.post('http://localhost:3000/getHistory',{id:id})
  .then(datas => {

    // tömb feltöltése
    history.value = datas.data;

    getTranslation(history);
  })
  .catch(e => console.error(e.response))
}

let getReports = () => {
  axios.get('http://localhost:3000/getReports ')
  .then(datas => {

    // tömb feltöltése
    reports.value = datas.data;
    console.log(reports.value)

  })
  .catch(e => console.error(e.response))
}

let sendValdation = (statusNum, id) => {
  axios.post('http://localhost:3000/sendReportValidation',{status: statusNum, id: id})
  .then(data => {
    alert(data.data)
    getReports()
  })
  .catch(e => {
    alert(e.response.data)
  })
}

function deleteUserItem()
{
  if(!confirm("Biztosan törölni szeretné?"))
  {
    return;
  }
  console.log(("asadad"));
  
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
                  aria-selected="false"
                  @click="getUserItems()">
            <i class="fa-solid fa-upload fa-lg"></i>
            {{ $t("profile.nabar_posts") }}
          </button>

          <!-- Adminisztráció opció -->
          <button class="nav-link" 
                  id="nav-posts-tab" 
                  data-bs-toggle="tab" 
                  data-bs-target="#nav-admin" 
                  type="button" role="tab" 
                  aria-controls="nav-posts" 
                  aria-selected="false"
                  @click="getReports()"
                  v-if="user.user_type === 'A'">
            <i class="fa-solid fa-user-tie fa-lg"></i>
            {{ $t("profile.navbar_admin") }}
          </button>

          <!-- Beszélgetéseim opció -->
          <button class="nav-link" 
                  id="nav-chats-tab" 
                  data-bs-toggle="tab" 
                  data-bs-target="#nav-chats" 
                  type="button" 
                  role="tab" 
                  aria-controls="nav-chats" 
                  aria-selected="false"
                  @click="getContacts()">
            <i class="fa-solid fa-comments fa-lg"></i>
            {{ $t("profile.navbar_messages") }}
          </button>

          <!-- Előzmények opció -->
          <button class="nav-link" 
                  id="nav-chats-tab" 
                  data-bs-toggle="tab" 
                  data-bs-target="#nav-history" 
                  type="button" 
                  role="tab" 
                  aria-controls="nav-chats" 
                  aria-selected="false"
                  v-on:click="getHistory(user.id)">
            <i class="fa-solid fa-clock fa-lg"></i>
             {{ $t("profile.navbar_history") }}
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
                               mx-2 my-2 btn btn-outline-light"
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
                               mx-3 my-3
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

              <!-- feltöltött elemek -->
              <div class="overflow-y-auto overflow-x-hidden py-2" 
                  style="height: 400px !important;">

                <!-- Új elem -->
                <div class="d-flex nav-link text-white 
                            mb-4 bg-black bg-opacity-25 
                            rounded-3 p-2 border border-1 
                            border-white">

                  <!-- Elem képe -->
                  <img  style="height: 170px; width: 170px;"
                        src="../images/image3.png"
                        class="justify-content-start rounded-3 img-fluid" 
                        alt="accomodation_image">

                  <!-- Elem adatai -->
                  <div class="mx-auto pt-4">

                    <!-- Elem neve -->
                    <div class="row">
                      <h3 class="text-white mx-auto 
                                  text-center fw-light 
                                  col-12">
                        Új elem feltöltése
                      </h3>
                    </div>
                    
                    <!-- Gombok -->
                    <div class="row justify-content-center mt-5">

                      <!-- Módosít gomb -->
                      <RouterLink to="/userItem/accommodations/0/new"
                                  class="btn btn-secondary mx-1 w-auto">
                        <i class="fa-solid fa-pen-to-square"></i>
                        Szállás feltötése
                      </RouterLink>

                      <!-- Módosít gomb -->
                      <RouterLink to="/userItem/experiences/0/new"
                                  class="btn btn-secondary mx-1 w-auto">
                        <i class="fa-solid fa-pen-to-square"></i>
                        Élmény feltötése
                      </RouterLink>
                    </div>
                  </div>
                </div>
                <div v-for="items in userItems"
                     v-if="userItems.length!=0">
                  <!-- Elemek -->
                  <div v-for="x in items"
                        class="d-flex nav-link text-white 
                              mb-4 bg-black bg-opacity-25 
                              rounded-3 p-2 border border-1 
                              border-white">

                    <!-- Elem képe -->
                    <img  style="height: 170px; width: 170px;"
                          :src="`/countries/${convertStrings(x.country_name)}` +
                              `/cities/${convertStrings(x.city_name)}` +
                              `/${x.table_type}/${convertStrings(x.folder_name)}/001.png`"
                          class="justify-content-start rounded-3 img-fluid" 
                          alt="accomodation_image">

                    <!-- Elem adatai -->
                    <div class="mx-auto pt-4">

                      <!-- Elem neve -->
                      <div class="row">
                        <h3 class="text-white mx-auto 
                                    text-center fw-light 
                                    col-12">
                          {{ x.name }}
                        </h3>
                      </div>

                      <!-- Elem helye és gombok -->
                      <div>
                        <!--Elem helye -->
                        <p class="text-white-50">
                          {{x.country_trans_name}}, {{ x.city_trans_name }}
                        </p>
                      </div>
                      
                      <!-- Gombok -->
                      <div class="row justify-content-center">

                        <!-- Megnéz gomb -->
                       <RouterLink :to="{name:'about',params:{table_name:x.table_type,id:x.id,name:x.name}}"
                               class="btn btn-primary mx-1 
                                     w-auto">
                          <i class="fa-solid fa-arrow-up-right-from-square"></i>
                          Megnéz
                       </RouterLink>

                       <!-- Módosít gomb -->
                       <RouterLink :to="{name:'userItem',params:{table_name:x.table_type,id:x.id,name:x.name}}"
                                    class="btn btn-secondary mx-1 w-auto">
                          <i class="fa-solid fa-pen-to-square"></i>
                          Módosít

                       </RouterLink>

                       <!-- Töröl gomb -->
                       <button @click="deleteUserItem()"
                               class="btn btn-danger mx-1  
                                      w-auto">
                          <i class="fa-solid fa-circle-minus"></i>
                          Töröl
                       </button>
                      </div>
                    </div>
                  </div>
                  <h2 v-if="userItems.length==0">
                    {{ $t("profile.text_accommodations") }}
                  </h2>
                </div>
              </div>

          </div>

          <!-- Adminisztráció opció -->
          <div  class="tab-pane fade" 
                id="nav-admin" 
                role="tabpanel" 
                aria-labelledby="nav-posts-tab" 
                tabindex="0">
            <div class="row my-2"
                  v-for="x in reports">
              <div class="bg-black bg-opacity-25 rounded-3">
                <div class="row">
                  <div class="text-white-50 m-1 top-0 d-flex justify-content-between">
                    <p>
                      {{ $t("profile.navbar_admin_group.id") }} #{{ x.id }}
                    </p>

                    <p>
                     {{ $t("profile.navbar_admin_group.type") }} {{ x.item_type }}
                    </p>
                  </div>

                  <div class="text-white-50 m-1 top-0 d-flex justify-content-end">

                    <p class="text-white">Indokoltság</p>

                    <button class="btn btn-outline-success mx-2"
                            v-on:click="sendValdation(1, x.id)">
                      <i class="fa-solid fa-check"></i>
                    </button>

                    <button class="btn btn-outline-danger"
                            v-on:click="sendValdation(2, x.id)">
                      <i class="fa-solid fa-xmark"></i>
                    </button>
                  </div>

                  <h5 class="text-white top-0">
                    {{ x.full_name }}
                  </h5>
                </div>
                
                <div class="row">
                  <h6>
                    {{ x.message_type }}
                  </h6>
                </div>

                <div class="row mt-3">
                  <p class="text-capitalize">
                    {{ x.message }}
                  </p>
                </div>

                <div class="row mt-3">
                  <button class="btn btn-outline-primary"
                          v-on:click="x.place_name 
                              ? router.push({ 
                                  name: 'about', 
                                  params: { 
                                      table_name: x.place_type, 
                                      id: x.item_id, 
                                      name: x.place_name 
                                  } 
                              })
                              : router.push('/invalidPlace')">
                    <i class="fa-solid fa-arrow-up-right-from-square"></i>
                  </button>
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
              <div v-if="userContacts!=''" 
                   class="row justify-content-center 
                          overflow-y-hidden" 
                   style="height:600px;">
              
                <!-- Bal oldali emberek megjelenítése -->
                <div class="col-3 col-sm-4 border 
                            border-1 border-white 
                            rounded-start p-0 h-100">

                  <!-- Beszélgető partnerek -->
                  <div class="h-100 overflow-y-auto">

                    <!-- Beszélgető partnerek -->
                    <span class="people d-flex 
                                 align-items-center 
                                 border-bottom border-secondary 
                                 ps-2"  
                          v-for="x in userContacts"
                          style="min-height: 55px;"
                          @click="openMessages(x)">
                      {{ `${x.first_name} ${x.middle_name} ${x.last_name}`  }}
                    </span>
                  </div>
                </div>

                <!-- Jobb oldali üzenet megjelenítés -->
                <div v-if="talkingWith!=''"
                     class="slide-fade-in col-9 col-sm-8 
                            d-flex flex-column bg-white 
                            rounded-end text-black p-0" 
                     style="height: 600px;">
                  
                  <!-- Címzett kiírása -->
                  <div class="d-flex w-100 align-items-center 
                              border-bottom border-secondary 
                              bg-secondary bg-opacity-25" 
                       style="height: 40px;">

                    <!-- Címzett -->
                    <span class="ms-1">
                      {{ talkingWith }}
                    </span>
                  </div>

                  <!-- Üzenet rész -->
                  <div class="flex-grow-1 
                              overflow-y-auto 
                              overflow-x-hidden"
                        id = "messageBox">

                    <!-- Üzenetek -->
                    <div class="row col-12 my-3"
                         style="min-height: 40px;" 
                         v-for="x in userMessages"
                        :class="x.from_user_id == user.id?'justify-content-end':'justify-content-start'" >

                      <span>
                        {{ x.sended_time }}
                      </span>

                      <div class="row col-10 col-sm-8 col-md-6 mt-2"
                           :class="x.from_user_id == user.id?'justify-content-end':'justify-content-start ms-2'" >
                        <div class="text-white rounded-3 w-auto d-inline-block p-2"
                            :class="x.from_user_id == user.id?'bg-dark ms-1':'bg-secondary'">
                          <!-- Üzenet -->
                          <span class="w-auto text-break">
                          {{ x.message }}
                          </span>
                        </div>
                      </div>
                    </div>
                  </div>

                  <!-- messageBar -->
                  <div class=" d-flex justify-content-center py-2 bg-secondary bg-opacity-50 rounded-end">
                    
                    <!-- üzenet írása -->
                    <div class="ms-1 me-2 col-6 col-md-10">
                        <input v-model="sendingMessage.message"
                               class="form-control" 
                               type="search" 
                               name="messageBar" 
                               @keydown="$event.key=='Enter'&&sendingMessage.message!=''?sendMessage():''"
                               id="messageBar">
                    </div>

                    <!-- Üzenet küldés gomb -->
                    <button class="w-auto btn btn-outline-light"
                            @click="sendMessage()"
                            :disabled="sendingMessage.message==''">
                      <i class="fa-solid fa-paper-plane fa-xl"></i>
                    </button>
                  </div>
                </div>
              </div>

              <!--  HA nincs még beszélgetése opció -->
              <div v-if="userContacts==''"
                   class="text-center">
                <h2>{{ $t('profile.text_messages') }}</h2>
              </div>
          </div>

          <!-- Előzmények opció -->
          <div class="tab-pane fade"
               id="nav-history" 
               role="tabpanel" 
               aria-labelledby="nav-chats-tab" 
               tabindex="0">

               <!-- előzmények rész -->
               <div class="overflow-y-auto py-2" 
                    style="height: 400px !important;">

                  <!-- Lefoglat szállások -->
                  <RouterLink :to="{name:'about',params:{table_name:'accommodations',id:x.accommodation_id,name:x.accommodation_name}}"
                       v-if="history.length!=0"
                       v-for="x in history"
                       class="d-flex nav-link text-white 
                              mb-4 bg-black bg-opacity-25 
                              rounded-3 p-2 border border-1 
                              border-white">

                    <!-- Szállás képe -->
                    <img  style="height: 170px; width: 170px;"
                          :src="`/countries/${convertStrings(x.country_name)}` +
                              `/cities/${convertStrings(x.city_name)}` +
                              `/accommodations/${convertStrings(x.accommodation_folder_name)}/001.png`"
                          class="justify-content-start rounded-3 img-fluid" 
                          alt="accomodation_image">

                    <!-- Foglalás adatai -->
                    <div class="mx-auto">

                      <!-- szállás neve -->
                      <div class="row">
                        <h3 class="text-white mx-auto 
                                   text-center fw-light 
                                   col-12">
                          {{ x.accommodation_name }}
                        </h3>
                      </div>

                      <!-- szállás ára és bérlési dátuma -->
                      <div>
                        <p>{{ $t("profile.navbar_history_group.price") }}
                          {{ x.price * selectedCurrency.currencyMultiplier }} 
                          {{ selectedCurrency.currencyShortedName }}
                        </p>

                        <!-- Bérlés dátuma -->
                        <p class="text-white-50">
                          {{ $t("profile.navbar_history_group.rent") }} {{ x.rent_date }}
                        </p>
                      </div>
                      
                      <!-- Bérlés kezdete és vége -->
                      <div class="row">

                        <!-- Bérlés kezdete -->
                        <p class="text-white-50 col-12 
                                  col-md-6 text-nowrap">
                         {{ $t("profile.navbar_history_group.start") }} {{ x.rent_beginning }}
                        </p>

                        <!-- Bérlés vége -->
                        <p class="text-white-50 col-12 
                                  col-md-6 text-nowrap">
                          {{ $t("profile.navbar_history_group.end") }} {{ x.rent_end }}
                        </p>
                      </div>
                    </div>
                  </RouterLink>

                  <!-- Nincs még lefoglalt szállás szöveg -->
                  <div v-if="history.length==0"
                       class="text-center">
                    <h2>{{ $t("profile.text_accommodations") }}</h2>
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

.people:hover{

  background-color: hsl(210, 5%, 25%);
  cursor: pointer;
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

.slide-fade-in {
  animation: slideFadeIn 0.6s ease forwards;
}

@keyframes slideFadeIn {
  0% {
    transform: translateX(-80px);
    opacity: 0;
  }
  100% {
    transform: translateX(0);
    opacity: 1;
  }
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
.reportCards {
  transition: 0.8s;
}

.reportCards:hover{
  transform: scale(1.02);
  cursor: pointer;
}
</style>