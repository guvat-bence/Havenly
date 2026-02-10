<script setup>
import axios from 'axios';
import { computed, reactive, ref, watch } from 'vue';
import router from '@/router';
import {user} from "@/store/user";
import { selectedCurrency } from '@/store/currency';
import { rent } from '@/store/current_rent';
import allIcons from '@/json/icons.json';
import { useI18n } from 'vue-i18n';
const { t } = useI18n();
// étékek át hozása másik oldalról
const props = defineProps(['id','name','table_name'])

// változók létrehozása
let item = ref([]);
let reserved_days = ref([]);
let rent_price = ref(0);
let item_details = ref([]);
let iconsAndTexts = ref([]);
let images = [];
let galleryImages = [];
let currentImage = ref("");
let counter = 0;
let modal = null;
let mode = "plus";
let guests = [];
let calendar = ref([]);
let currentDate = ref("");
let currentMonth = "";
let nextDayDate = ref("");
let model = reactive({guests:1});
let daysname = computed(()=>(t('about.days_short')).split(","));
let monthsname = computed(()=>(t('about.months')).split(","));
let arriveDayId= ref(null); 
let departureDayId=ref(null); 
let rentedDayIds = ref([]);
let daysInMonth = ref("");

let currentYear= new Date().getFullYear();
let todayMonth = new Date().getMonth() + 1;

//lehívja a dátumokat és az alapján hozza létra a naptárba kellő napokat.
//megnézi melyik nap folglat és melyik szabad, ez alapján add neki tulajdonságot is.
function makeCalendar(plusmonth)
{
	// ha a jelenlegi hónap nagyobb mint 0 akkor bele megy
	if(todayMonth>0)
	{
		// változók létrehozása a naptárhoz
		calendar.value=[];
		currentMonth = new Date().getMonth()+plusmonth;
		let currentDay= new Date().getDate();
		daysInMonth.value = new Date(currentYear,currentMonth,0).getDate();
		let lastDayinPriviousMonth  = new Date(currentYear,currentMonth-1,0).getDay();
		let firstDayinMonth  = new Date(currentYear,currentMonth-1,1).getDay();
		let lastDayinMonth  = new Date(currentYear,currentMonth-1,daysInMonth.value).getDay();

		// Átalakítju hogy hétfővel kezdődjön a hetek számolása.
		lastDayinPriviousMonth = lastDayinPriviousMonth==0?6:lastDayinPriviousMonth-1;
		firstDayinMonth = firstDayinMonth==0?6:firstDayinMonth-1;
		lastDayinMonth = lastDayinMonth==0?6:lastDayinMonth-1;

		//az előző hónap azon napjai amelyeketem a jelenlegi hónapban kell megjeleníteni
		for(let i=0;i<lastDayinPriviousMonth+1;i++)
		{
			calendar.value.push("");
		}

		//az előző hónap azon napjai amelyeket kell megjeleníteni
		for(let x=1;x<daysInMonth.value+1;x++)
		{
			calendar.value.push(daysInMonth.value-(daysInMonth.value-x));
		}

		//a következő hónap azon napjai amelyeketem a jelenlegi hónapban kell megjeleníteni
		for(let y=1;y<(6-lastDayinMonth)+1;y++)
		{
			calendar.value.push("");
		}

		// megkeressük a tbody-t
		let tbody = document.querySelector("tbody");

		// beállítjuk a innerHtml értékét ""-ra
		tbody.innerHTML = "";

		// beállítjuik a hónap heteit
		let weeks = 5

		// ha a calendárban több elem van mint 35 akkor át állítja a hetek számát 6-ra 
		if(calendar.value.length>35)
		{
			weeks = 6;
		}

		// a hónap heteinek számával indítunk egy form-ot
		for(let x=0;x<weeks;x++)
		{
			// létrehozzuk a tr-t
			let tr = document.createElement("tr");

			// a hét napjainak számával indítunk egy form-ot
			for(let y=0;y<7;y++)
			{
				// létrehozzuk a td-t
				let td = document.createElement("td");

				//létrehozzuk az indexet, a megfelelő nap kiválasztásához.
				let index = x * 7 + y;

				// az index segítségével meghatározzuk a jelenlegi napot a calendar-ból
				let day = calendar.value[index];

				// ha az érétéke nem "" a nappnak akkor bele megy
				if(calendar.value[index] != ""){

					// ha a naptári hónap megegyezik a jelenlegi hónappal, és a jelenlegi napnál kisebb a naptári nap, akkor megy bele.
					if(currentMonth == todayMonth && calendar.value[index] < currentDay)
					{
						// kiiárja a jelenlegi nap számát
						td.innerHTML = day;
						
						// Hozzáadjuk a megfelelő clast
						td.classList.add("past_day");
					}
					else
					{
						// kiiárja a jelenlegi nap számát
						td.innerHTML = day;

						//a hónapot és a nap számát megkaja id-nak
						td.id = `${currentMonth.toString().length==1?`0${currentMonth}`:currentMonth}.${day.toString().length==1?`0${day}`:day}`;

						// beállítjuk a resevedet false-ra
						let reserved = false;

						// végigmegyünk a lefoglalt napokon
						for(let i=0;i<reserved_days.value.length;i++)
						{
							// ha a naptári nap id-ja megegyezik a lefoglat nappal akkor lefoglalt nappá alakítjuk át
							if(td.id == reserved_days.value[i])
							{
								// megadjuk neki a megfelelő osztályt
								td.classList.add("reserved_day");

								// a reserved-et tru ra állítju és break-elünk
								reserved = true;
								break;
							}
						}

						// ha a reserved fales akkor megy bele
						if(reserved == false)
						{
							// hozzádja a day-clast
							td.classList.add("day");

							// hozzáadjuk a daySelected functiont
							td.addEventListener("click",()=>daySelected(td.id));	
						}
					}
				}
				// tr-be bele rakaja a td-t
				tr.append(td);
			}

			// a tbody-ba belerakja a tr-t
			tbody.append(tr);
		}
	}
}

// beállítjuk a countert a prorps.table-name alapján.
switch(props.table_name)
{
	case "accommodations":
		counter = 10;
		break;

	case "experiences":
		counter = 3;
		break;
}

// ha nagyob mint 0 csa k akkor megy bele.
if(counter>0)
{
	// hozáadjuk a listákhoz a képek neveit.
	for(let i=0;i<counter;i++)
	{
		// bele rakja a képeket a images tömb-be.
		images.push(i<9?`00${i+1}.png`:`0${i+1}.png`);

		// ha az i nagyobb mint 3 akkor bele megy
		if(i<3)
		{
			// bele rakja a képeket a galleryImages tömb-be.
			galleryImages.push(i<9?`00${i+1}.png`:`0${i+1}.png`);
		}
	}
}

// adatbázisból lehúzzuk a szállás/élmény többi adatát.
axios.get(`http://localhost:3000/${props.table_name}/${props.id}`)
	.then(datas=>{

		// tömb feltöltése
		item.value = datas.data;

		//ha léétzik a guest_number a tömben akkor bele megy
		if(item.value[0].guest_number)
		{
			// annyi elemet rak a guest-be amennyi vendég van.
			for(let x=0;x<item.value[0].guest_number;x++)
			{
				guests.push(x+1);
			}
		}
	})
	.catch(error=>
	{
		console.error(error);
	})
	

// meghívjuk a makeCalendar függvény a januári hónappal
// késleltetjük az indulását,
// így akkor fog leutni amikor már a hozzá kellő html részel is betöltődtek.
if(props.table_name == "accommodations")
{
	setTimeout(()=>
	{
		makeCalendar(1);
	},50);
}

// ha a table_name megegyezik az accommodationnal akkor bele megy
if(props.table_name == "accommodations")
{
	// adatbázisból lehúzzuk a szálláshoz tartozó részleteket
	axios.get(`http://localhost:3000/accommodations/accommodations_details/${props.id}`)
		.then(details=>
		{
			for(let y in allIcons)
			{
				allIcons[y]["text"] = computed(()=>(t(`about.extras.${y}`)));
			
			}

			iconsAndTexts = allIcons;

			// végigmegyünk a részleteken
			for(let x in details.data[0])
			{

				// ha van olyan részlet amit tartalmaz a szállás
				// akkor hozzá adjuk a item_details listához 
				// az adott részlethez tartozó elemet az iconsAndTexts-ből
				if(details.data[0][x] == 1)
				{
					item_details.value.push(iconsAndTexts[x]);
				}
			}
		})
		.catch(error=>
		{
			console.error(error);
		})


	//adatbázisból le kérjük a szálláshoz kapcsolatos foglalásokat, és ezeket napra pontosan el tároljuk
	// hogy a naptárban me gtudjuk őket jeleníteni.
	axios.get(`http://localhost:3000/history/${props.id}`)
	.then(response=>
	{
		// végigmegyünk a response adatain
		for(let x=0;x<response.data.length;x++){

			// létrehozzuk a rent_beginning és a rent_end változókat 
			let rent_beginning = response.data[x]["rent_beginning"].split("T")[0];
			let rent_end = response.data[x]["rent_end"].split("T")[0];

			// az érkezésé is távozási napot dátummá alakítja,
			// a d az érkezési nappa indul,
			//  majd addig megy ameddig a d el nem éri a távozási napot. 
			for (let d = new Date(rent_beginning); d <= new Date(rent_end); d.setDate(d.getDate() + 1)) {

				// csak azokkal a lefoglalt napokkal foglalkozunk amelyek a jelenlegi évre vonatkoznak.
				if(d.toISOString().split("T")[0].split("-")[0] == currentYear)
				{
					// átalakítjuk és szészedjük a d-t
					// és a hónapot és a napot hozzáadjuk a reserved_days-hez.
					reserved_days.value.push(`${d.toISOString().split("T")[0].split("-")[1]}.${d.toISOString().split("T")[0].split("-")[2]}`);
				}
			}
		}
	})
	.catch(error=>{
		console.error(error);
	})
}

//a fáljrendszer elnevezéseihez alakítja át az adatokat
//hogy meg tudja majd keresni a megfelelő képet
function convertStrings(str) {  

  return str.normalize("NFD")
            .replace(/[\u0300-\u036f]/g, "")
            .replaceAll(" ","_")
            .toLowerCase();
}	

//amelyik képre rá megyünk, az jelenik meg a modalban elsőnek.
function imageShow(img)
{
	// végigmegyünk az összes képen.
	for(let x=0;x<images.length;x++)
	{
		//ha a ké megegyezik a listában szereplő képpel akkor bele megy.
		if(images[x] === img)
		{
			// beállítja a jelenlegi képet, amivel indul majd a modal.
			currentImage.value = x;
			break;
		}
	}

	// modal megkeresése
	modal = document.querySelector("#imageShowModal");
	modal.classList.remove("invisible");
	document.body.classList.add("no-scroll");
	return modal;
}

// ha a > re megy akkor a következő képet tölti be.
function imageNext(img)
{
	// ha a lista utolsó képénél van index alapján, akkor beálítja az első képre,
	//  így újra kezdve a kört.
	if(img === images.length-1)
	{
		currentImage.value = 0; 
	}
	// alapvetően pedig csak megnöveli az indexét, így a következő képet tölti be.
	else
	{
		currentImage.value = img+1;
	}
}

// ha a < re meg y akkor az előző képet tölti be.
function imagePrevious(img)
{	
	// ha a lista első képénél van index alapján, akkor beálítja az utolsó képre,
	// így újra kezdve a kört.
	if(img === 0)
	{
		currentImage.value = images.length-1; 
	}
	// alapvetően pedig csak lecsökkenti az indexét, így a következő képet tölti be.
	else
	{
		currentImage.value = img-1;
	}
}

// Modal eltüntetése
function closeModal() {

	modal.classList.add("invisible");
	document.body.classList.remove("no-scroll");
}

// ezzel nagyítjuk vagy kicsinyítjük a modal képeit.
function modalImgResize()
{
	// megkeressük a képet és a gombokat
	let modalImg = document.querySelector(".modalImg");
	let modalbuttons = document.querySelectorAll(".position-absolute");

	// ha megtalálja akkor bele megy
	if(modalImg &&  modalbuttons)
	{
		// ha plusz akkor bele megy
		if(mode == "plus")
		{
			// át állítja a kép nagyságát és a cursort
			modalImg.style.transform = "scale(1.5)";
			modalImg.style.transformOrigin = "center";
			modalImg.style.cursor=" zoom-out";

			// a for ciklussal minden gombot el tüntett
			modalbuttons.forEach(btn => {
      	btn.classList.add("invisible");
    	});

			return mode ="minus";
		}
		// ha minusz akkor bele megy
		else if(mode == "minus")
		{
			// át állítja a kép nagyságát és a cursort
			modalImg.style.transform = "scale(1)";
			modalImg.style.transformOrigin = "center";
			modalImg.style.cursor=" zoom-in";

			// a for ciklussal minden gombot láthatóvá tesz
			modalbuttons.forEach(btn => {
      	btn.classList.remove("invisible");
    	});

			return mode ="plus";
		}
	}
	
}

// a következő hónapot generáltatja ki
function monthNext()
{
	// meghívja a makeCalendar függvényt a következő hónappal
	makeCalendar(currentMonth);

	// meghívjuk a showDays függvényt.
	showDays();
}

// az előző hónapot generáltatja ki
function monthPrevious()
{
	// meghívja a makeCalendar függvényt az előző hónappal
	makeCalendar(currentMonth-2);

	// meghívjuk a showDays függvényt.
	showDays();
}

// ezzel a függvénnyel szerezzük meg az érkezési és távozási napot és tároljuk el változókban.
// az id-az a nap amelyre rá kattintunk.
function daySelected(id)
{

	// definiáljuk a jelenlegi napot, ez éppen az amire rá kattintottunk.
	let currentDay = document.getElementById(id);

	// a reserved-et false-al definiáljuk
	let reserved = false;

	//ha a jelenlegi nap megegyezik az érkezés napjával,
	// ergó megint rá kattintottunk az érkezési napra
	// akkor vissza vonja róla a jelölést
	if(arriveDayId.value == currentDay.id)
	{
		currentDay.classList.remove("selected");
		arriveDayId.value = null;
		currentDate.value = "";
		return;
	}

	//ha a jelenlegi nap megegyezik az távozás napjával,
	// ergó megint rá kattintottunk az távozási napra
	// akkor vissza vonja róla a jelölést
	else if(departureDayId.value  == currentDay.id)
	{
		currentDay.classList.remove("selected");
		departureDayId.value = null;
		nextDayDate.value = "";
		return;
	}

	// ha még nincsen meghatározva érkezési nap akkor bele megyy
	// meghatározza a jelenlegi napot az érkezés napjának
	// ennnek a pontos dátumát is beállítja a megjelenítéshez
	if(arriveDayId.value == null)
	{
		let day = document.getElementById(id);
		arriveDayId.value = id;
		day.classList.add("selected");
		currentDate.value = `${currentYear}-${id.split(".")[0]}-${id.split(".")[1]}`;
		return;
	}

	// ha még nincsen meghatározva távozási,
	//  és a jelenlegi nap nem egyezik az érkezés napjával,
	// és az érkezési nap nem nagyobb mint a jelenlegi nap akkor bele megyy.
	// meghatározza a jelenlegi napot az érkezés napjának
	// ennnek a pontos dátumát is beállítja a megjelenítéshez.
	else if(departureDayId.value == null && arriveDayId.value != currentDay.id && currentDay.id > arriveDayId.value)
	{
		// végigmegyünk a lefoglat időpontokon.
		for(let x of reserved_days.value)
		{
			//ha az érkezési és távozási nap között akár csak 1 db foglat nap is van, akkor nem állítja be a távozási időpontot.
			if(x>arriveDayId.value && x< currentDay.id)
			{
				reserved = true;
				break;
			}
		}
		// ha nincsen ilyen foglalt nap akkor pedig beállítja a távozás napját.
		if(reserved == false){

			let day = document.getElementById(id);
			departureDayId.value = id;
			day.classList.add("selected");
			nextDayDate.value = `${currentYear}-${id.split(".")[0]}-${id.split(".")[1]}`;
		}
	}
}

// ezzel e fügvénnyel kiolvassuk a változókból és be állítjuk az adott érkezési és távozási napot, 
// valamint a kettő közötti napok megjelenítéstés a hónapok között.
function showDays()
{
	// formázzuk az adott hónapot az összehasonlításokhoz.
	let formattedMonth = currentMonth.toString().length === 1 ? `0${currentMonth}` : currentMonth.toString();

	// ha az arriveDayId nem null akkor bele megy.
	if(arriveDayId.value != null)
	{
		// ha az érekzés időponta abban a hónapban van mint a jelenlegi hónap akkor bele megy.
		if(arriveDayId.value.split(".")[0] == formattedMonth)
		{
			// beállítja az érkezési napot.
			let day = document.getElementById(arriveDayId.value);
			day.classList.add("selected");
		}
	}

	// ha a departureDayId nem null akkor bele megy.
	if(departureDayId.value != null)
	{
		// ha a távozási időponta abban a hónapban van mint a jelenlegi hónap akkor bele megy.
		if(departureDayId.value.split(".")[0] == formattedMonth)
		{
			// beállítja a távozási napot.
			let day = document.getElementById(departureDayId.value);
			day.classList.add("selected");
		}
	}

	// ha a rentedDayIds nem null akkor bele megy.
	if(rentedDayIds != null)
	{

		rent_price.value = (item.value[0].price * (rentedDayIds.value.length-1))*model.guests;

		// annyiszor ismétli magát amennyi nap van a rentedDayIds-ban.
		for(let x=0;x<rentedDayIds.value.length;x++)
		{
			// ha az adott nap a jelellegi hónapban van akkor bele megy.
			if(rentedDayIds.value[x]!=arriveDayId.value && rentedDayIds.value[x]!=departureDayId.value){

				// ha az adott nap abban a hónapban van mint a jelenlegi hónap akkor bele megy.
				if(rentedDayIds.value[x].split(".")[0] == formattedMonth)
				{
					// beállítja a távozási napot.
					let day = document.getElementById(rentedDayIds.value[x]);
					day.classList.add("rented");
				}
			}
		}
	}
}

function renting()
{
	rent.accommodation_full_price = rent_price.value;
	rent.rent_beginning = currentDate.value;
	rent.rent_end = nextDayDate.value;
	rent.accommodation_path = window.location.href;
	rent.accommodation =JSON.stringify(item.value[0]);

	router.replace({path:'/basket'})
}

// figyeleli az érekezési és távozási napok változását.
// ha mind a kettőnek van értéke akkor a kettő dátum közötti napokat hozzáadja a rentedDayIds-hez.
// ha nincs értékük de viszont a rentedDayIds-nak van, akkor pedig törli a benne lévő napokat.
watch([arriveDayId,departureDayId],()=>{

	// formázzuk az adott hónapot az összehasonlításokhoz.
	let formattedMonth = currentMonth.toString().length === 1 ? `0${currentMonth}` : currentMonth.toString();

	// ha nem null az érkezési és távozási nap akkor bele megy.
	if(arriveDayId.value != null && departureDayId.value != null)
	{
		// az érkezésé is távozási napot dátummá alakítja,
		// a d az érkezési nappa indul,
		//  majd addig megy ameddig a d el nem éri a távozási napot. 
		for (let d = new Date(currentDate.value); d <= new Date(nextDayDate.value); d.setDate(d.getDate() + 1)) {

			// átalakítjuk és szészedjük a d-t
			// és a hónapot és a napot hozzáadjuk a rentedDayIds-hez.
			rentedDayIds.value.push(`${d.toISOString().split("T")[0].split("-")[1]}.${d.toISOString().split("T")[0].split("-")[2]}`);
		}
		// meghívjuk a showDays-függvényt.
		showDays();
	}

	// ha a lefoglalt napok száma nagyobb mint 0 akkor bele megy.
	else if(rentedDayIds.value.length>0)
	{
		// annyiszor ismételi meg ahány lefoglat nap van.
		for(let x=0;x<rentedDayIds.value.length;x++)
		{
			// ha az adott nap abban a hónapban van mint a jelenlegi hónap akkor bele megy.
			if(rentedDayIds.value[x].split(".")[0] == formattedMonth)
			{
				// beállítja a napotm majd törli a tulajdonságát
				let day = document.getElementById(rentedDayIds.value[x]);
				day.classList.remove("rented");
			}
		}
		// rentedDayIds listát üresre állítjuk.
		rentedDayIds.value=[];
	}
})

// figyeli a model értékét és hogyha a valaki megváltoztatja a fők számát akkor átírja az árát
watch(model,()=>
{
	// beállítja az aktuális fizetendő összeget 
	rent_price.value = (item.value[0].price * (rentedDayIds.value.length-1))*model.guests;
})
</script>
<template>
	<div class="about">
		<div class="container text-white" v-if="item.length>0">

			<!-- Kép megjelenítés és a szállás/élmény címe -->
			<div class="row justify-content-center">

				<!-- Szállás/élmény országa,városa,neve -->
				<div class="row justify-content-center mb-3">

					<!-- Sazállás/élmény országa, városa -->
					<h1 class=" text-start col-5 ms-1">
						{{ item[0].country_name}}, {{ item[0].city_name}}
					</h1>

					<!-- Szállás/élmény neve -->
					<h1 class=" text-end col-6">
						{{ item[0].name }}
					</h1>
				</div>
		
				<!-- Galéria -->
				<div class="row justify-content-center">
					<!-- Síma képek -->
					<div v-for="img in galleryImages" class="col-12 col-sm-12 col-md-6 col-lg-6 col-xl-3 col-xxl-3">
						<img height="300" :src="`/countries/${convertStrings(item[0].country_name)}
																		/cities/${convertStrings(item[0].city_name)}
																		/${props.table_name}/${convertStrings(item[0].folder_name)}/${img}`"
							class="img my-2 mx-2 card-img-top rounded-5 border border-white border-5"
							@click="imageShow(img)"
							style="object-fit:cover">
					</div>

					<!-- Ha 3-nál több kép van,akkor ez a kép is megjelenik -->
					 <!-- Mutatva hogy folytatódik galária(...) -->
					<div v-if="props.table_name=='accommodations'" 
							 class=" col-12 col-sm-12 col-md-6 col-lg-6 col-xl-3 col-xxl-3">
						<img height="300"
								 src="../images/image3.png"
								 class="img my-2 mx-2 card-img-top rounded-5 border border-white border-5"
								 @click="imageShow('004.png')"
								 style="object-fit:cover">
					</div>
				</div>

			</div>
			
			<!-- adatok megjelenítése -->
			<div class="row justify-content-center mt-5">

				<!-- részletek csoportosítása -->
				<div class="row justify-content-center">

					<!-- iconok plusz dolgok megjelenítése -->
					<div v-if="props.table_name=='accommodations'" 
              class="row justify-content-center text-center 
              			 pt-3 mx-2 my-3 border border-2 rounded-3
										 bg-dark bg-opacity-50 col-12 col-md-10 col-xl-4">

						<!-- Cím -->
						<h3 class="mb-4">{{ $t("about.accommodation_extras") }}</h3>

						<!-- iconok megjelenítése-->
						<p v-for="x in item_details" class="col-4	text-center">
              <font-awesome-icon :icon="x.icon" size="xl" />
							{{ x.text }}
            </p>

					</div>

					<!-- Az adott szállás/élmény leírása -->
					<div class="row justify-content-center my-3 mx-3 py-3 bg-dark bg-opacity-50
                     text-center align-items-center border border-2 rounded-3 
										 col-12 col-md-4 col-xl-4">
						<p>	{{ item[0].description }}</p>
					</div>

					<!-- A lefoglaláshoz kellő form -->
					<div v-if="props.table_name=='accommodations'" 
               class="row justify-content-center text-center mx-2 my-3
											border border-2 rounded-3 bg-dark bg-opacity-50
							  			col-12 col-md-6 col-xl-4">

						<!-- Maga a form -->
						<form  class="pt-4 pb-4">

							<!-- érkezés/távozás szakas -->
							<div class="mb-3 bg-white row justify-content-center rounded-3 py-3 text-dark">
								
								<div class="row justify-content-center">
									<h6 class="col-6">{{ $t("about.arrive_time") }}</h6>
									<h6 class="col-6">{{ $t("about.departure_time") }}</h6>
									<h6 class="col-6">{{ currentDate }}</h6>
									<h6 class="col-6">{{ nextDayDate }}</h6>
								</div>

								<!-- Balra lapozás gomb -->
								<div class="col-2 my-2 row align-items-center pe-0 me-1 me-sm-0 z-1">
									<button class="btn btn-secondary"
													id="monthPrevious"
													type="button"
													:disabled="currentMonth === todayMonth"
													@click="monthPrevious()">
										&lt;
									</button>
								</div>
					
								<!-- maga a table -->
								<div id="tableDiv"
										 class="row bg-dark col-8 h-100 
														justify-content-center align-items-center 
														rounded-2 text-white">
									<table>
										<thead>
												<tr>
													<th v-for="day in daysname">
														{{ day }}
													</th>
												</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
								</div>
								
								<!-- Jobbra lapozás gomb -->
								<div class="col-2 my-2 row align-items-center ps-0 ms-1 z-1">
									<button class="btn btn-secondary"
													id="monthNext"
													type="button"
													:disabled="currentMonth === 12"
													@click="monthNext()">
										&gt;
									</button>
								</div>

								<!-- a naptár alján lévő év és hónap -->
								<p v-if="calendar.length>0" 
									 class="col-12 m-0">
									{{`${currentYear}. ${monthsname[currentMonth-1]}`}}
								</p>

								<p v-if="rentedDayIds.length!=0" 
									 class="col-12 m-0 pt-1">
								{{ $t("about.sum") }} {{(Math.round(rent_price * selectedCurrency.currencyMultiplier)).toLocaleString('fi-FI')}}
													  {{ selectedCurrency.currencyShortedName }}
								</p>
							</div>

							<!-- személyek száma szakasz -->
							<div class="mb-3 row justify-content-center">

								<!-- személyek száma szakasz label -->
								<label for="guest_number" class="form-label col-12">
                 {{ $t("about.number_of_guest") }}
                </label>

                <!-- személyek száma szakasz select -->
								<div class="col-5">
									<select class="form-select" id="guest_number" v-model="model.guests">
										<option v-for="x in guests" :value="x">{{ x }}{{ $t("about.human") }}</option>
								</select>
								</div>
							</div>

              <!-- Foglalaás gomb -->
							<button v-if="user.id!=''"
											v-bind:disabled="rentedDayIds.length==0"
											@click="renting()"
											type="button"
										  class="btn btn-secondary col-6 
                      			 rounded-pill">
                {{ $t('about.renting') }}
              </button>

							 <!-- Bejelentkezés gomb gomb -->
							<router-link to="/login" v-if="user.id ==''"
										  class="btn btn-secondary col-6 
                      				rounded-pill">
                {{ $t('about.login') }}
              </router-link>
						</form>
					</div>
				</div>
			</div>

			<!-- saját modal -->
			<div class="bg-black bg-opacity-75 invisible 
									d-flex justify-content-center 
									align-items-center position-fixed"
					 id="imageShowModal"
					 style="z-index:1020;inset:0;">

				<div class="position-relative w-75">

					<!-- Kép -->
					<div class="d-flex justify-content-center">
						<img style="max-width:1050px; max-height:700px;object-fit:cover;"
									class="col-12 modalImg rounded-4"
									@click="modalImgResize()"
									:src="`/countries/${convertStrings(item[0].country_name)}`+
												`/cities/${convertStrings(item[0].city_name)}`+
												`/${props.table_name}/${convertStrings(item[0].folder_name)}`+
												`/${images[currentImage]}`">
					</div>

					<!-- Kép száma -->
					<p class="text-center text-white 
										mt-3 border border-1 
										rounded-3  mx-auto col-1 bg-dark">
						{{ currentImage+1 }}/{{ images.length }}
					</p>

					<!-- Balra lapozás gomb -->
					<div class="position-absolute top-50 start-0 translate-middle-y">
						<button class="btn btn-secondary"
										@click="imagePrevious(currentImage)">
							&lt;
						</button>
					</div>

					<!-- Jobbra lapozás gomb -->
					<div class="position-absolute top-50 end-0 translate-middle-y">
						<button class="btn btn-secondary"
										@click="imageNext(currentImage)">
							&gt;
						</button>
					</div>

					<!-- Bazáró gomb -->
						<div class="position-absolute top-0 end-0">
						<button class="btn btn-danger" 
										@click="closeModal()">
							X
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>
<style>

/* szállás/élményy képeinek kiemelése */
.img:hover {
	box-shadow: 0px 0px 40px rgb(255, 255, 255);
	cursor: pointer;
	transition: 200ms;
}

/* a kép nagyításához */
.modalImg:hover
{
	cursor: zoom-in;
}

/* a görgetés letiltása */
body.no-scroll {
  overflow: hidden;
}

/* ha egy nap fölöt van az egér */
.day:hover
{
	box-shadow: 0px 0px 10px rgb(255, 255, 255);
	cursor: pointer;
	transition: 200ms;
	background-color: white;
	color: black;
	border-radius: 10%;
}

/* maga a kiválaszott nap */
.day.selected
{
	background-color: gray;
	box-shadow:0px 0px 7px rgb(170, 170, 170);
}

/* két kiválasztott nap között */
.day.rented
{
	background-color: darkgray;
	box-shadow:0px 0px 5px rgb(82, 81, 81);
	border-radius: 10%;
}

/* az elmúlt napok */
.past_day
{
	opacity: 0.5;
}

/* lefoglalt napok */
.reserved_day
{
	background-color:rgb(119, 70, 70);
	opacity: 0.8;
}
</style>