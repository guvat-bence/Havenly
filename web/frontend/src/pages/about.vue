<script setup>
import axios from 'axios';
import { computed, reactive, ref, watch } from 'vue';
import router from '@/router';
import {user} from "@/store/user";
import { selectedCurrency } from '@/store/currency';
import { rent } from '@/store/current_rent';
import allIcons from '@/json/icons.json';
import allProblemTypes from '@/json/problemTypes.json';
import { useI18n } from 'vue-i18n';
import { convertStrings } from '@/common';

// étékek át hozása másik oldalról
const props = defineProps(['id','name','table_name'])
const { t } = useI18n();
const {locale} = useI18n();

// változók létrehozása
let item = ref([]);
let reserved_once = ref(false);
let problemTypes = ref([]);
let sendedProblem = ref(false);
let opinions = ref([]);
let modalType = ref("gallery");
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
let problemModel = reactive({
	user_id:"",
	item_id:"",
	name:"",
	description:"",
	type:"",
});
let opinionModel = reactive({
	opinion_id:"",
	user_id:"",
	item_id:"",
	item_type:props.table_name,
	message:"",
	rate:0,
	language_short_name:locale.value
})
let opinionModelEmty = {... opinionModel};
let opinionModelCopie = {... opinionModel};
let deleteType= ref(false);
let choosedType= ref(false);
let problemModelEmty = {... problemModel};
let daysname = computed(()=>(t('about.days_short')).split(","));
let monthsname = computed(()=>(t('about.months')).split(","));
let arriveDayId= ref(null); 
let departureDayId=ref(null); 
let rentedDayIds = ref([]);
let daysInMonth = ref("");

let currentYear= new Date().getFullYear();
let todayMonth = new Date().getMonth();

//lehívja a dátumokat és az alapján hozza létra a naptárba kellő napokat.
//megnézi melyik nap folglat és melyik szabad, ez alapján add neki tulajdonságot is.
function makeCalendar(plusmonth)
{
	// ha a jelenlegi hónap nagyobb mint 0 akkor bele megy
	if(todayMonth)
	{
		// változók létrehozása a naptárhoz
		calendar.value=[];
		currentMonth = plusmonth==0?new Date().getMonth():plusmonth;
		let currentDay= new Date().getDate();
		daysInMonth.value = new Date(currentYear,currentMonth+1,0).getDate();
		let firstDayinMonth  = new Date(currentYear,currentMonth,1).getDay();
		let lastDayinMonth  = new Date(currentYear,currentMonth,daysInMonth.value).getDay();

		// Átalakítju hogy hétfővel kezdődjön a hetek számolása.
		firstDayinMonth = (firstDayinMonth+6)%7;
		lastDayinMonth = (lastDayinMonth+6)%7;

		//az előző hónap azon napjai amelyeketem a jelenlegi hónapban kell megjeleníteni
		for(let i=0;i<firstDayinMonth;i++)
		{
			calendar.value.push("");
		}

		//az előző hónap azon napjai amelyeket kell megjeleníteni
		for(let x=1;x<=daysInMonth.value;x++)
		{
			calendar.value.push(x);
		}

		//a következő hónap azon napjai amelyeketem a jelenlegi hónapban kell megjeleníteni
		for (let i = calendar.value.length; i < 42; i++) {
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
						td.id = `${currentMonth.toString().length==1?`0${currentMonth+1}`:currentMonth+1}.${day.toString().length==1?`0${day}`:day}`;

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

// Az összes véleményy lehívása
getAllOpinions();

console.log(props)
// adatbázisból lehúzzuk a szállás/élmény többi adatát.
axios.get(`http://localhost:3000/${props.table_name}/${props.id}`)
.then(datas=>{

	datas.data[0].country_trans_name =t(`search.countries.${datas.data[0].country_id}`);
	datas.data[0].city_trans_name = t(`search.cities.${datas.data[0].city_id}`);

	// tömb feltöltése
	item.value = datas.data;
	
	
	// végigmegy a kártya összes elemén, majd megnézi adatbázisban hogy van-e neki az adott nyelvre fordítása,
	// ha nincsen rá fordítás, de azon a nyelven vagyunk amilye nnyelven feltöltöttük az adottott tárgyat,
	// akkor az eredeti verzióját tölti be.
	// HA egy dolognak nincsen fordítása és eredeti verziója sem paszzol a jelenlegi nyelvhez,
	//  akkor api segítségével lefordítja és feltölti adatbázisba a fordítások közé, és újra idítja az oldalt,
	// utána pendig az egész függvény előröl kezdődik és így már be fogja tölteni az adot tárgy fordítását.
	// ha esetleg hiba akadna a fordítással akkor a művele megszakad é kiírja a konzolbon.
	axios.post(`http://localhost:3000/translate`,
		{item_id:item.value[0].id,item_name:props.table_name,language_short_name:locale.value})
	.then(datas=>
	{
		// ha a translationed üzenettl tér vissza, akkor tudjuk, hogy mgtalálta az elem fodítását.
		if(datas.data.message == "translationed")
		{
			// az adatbázisban tárolt json fáljt beolvassuk és átadjuk az értékét.
			let text  = JSON.parse(datas.data.data[0].item);
			item.value[0].name = text["title"];
			item.value[0].description = text["description"];
			
		}
		// ha az original üzenettel tér vissza, akkor tudjuk, hogy az elem eredeti verzióját találta meg.
		else if(datas.data.message == "original")
		{
			// ezután beállítjuk és felhasználjuk az erdeti verzió értékeit.
			item.value[0].name = datas.data.data[0].name;
			item.value[0].description = datas.data.data[0].description;
		}
		// ha az üzenet failed akkor megy bele
		else if(datas.data.message == "failed")
		{
			console.log("Hiba tölrtént az api forítás során!");
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

// meghívjuk a makeCalendar függvényt
// késleltetjük az indulását,
// így akkor fog leutni amikor már a hozzá kellő html részel is betöltődtek.
if(props.table_name == "accommodations")
{
	setTimeout(()=>
	{
		try{
			makeCalendar(0);
		}
		catch{
			setTimeout(()=>
			{
				makeCalendar(0);
			},200)
		}
	},500);
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

	axios.post('http://localhost:3000/getHistory',{id:user.id})
    .then(datas => {
		
			for(let x of datas.data)
			{
				if(x.accommodation_id == item?.value[0]?.id)
				{
					reserved_once.value = true;
					break;
				}
			}

    })
    .catch(e => console.error(e))


	//adatbázisból le kérjük a szálláshoz kapcsolatos foglalásokat, és ezeket napra pontosan el tároljuk
	// hogy a naptárban me gtudjuk őket jeleníteni.
	axios.get(`http://localhost:3000/history/${props.id}`)
	.then(response=>
	{
		// végigmegyünk a response adatain
		for(let x=0;x<response.data.length;x++){

			// létrehozzuk a rent_beginning és a rent_end változókat 
			let rent_beginning = response.data[x]["rent_beginning"];
			let rent_end = response.data[x]["rent_end"];

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

	modalType.value = "gallery";

	// modal megkeresése
	openModal();
}

// Modal meghívása
function openModal()
{
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
	makeCalendar(currentMonth+1);

	// meghívjuk a showDays függvényt.
	showDays();
}

// az előző hónapot generáltatja ki
function monthPrevious()
{
	// meghívja a makeCalendar függvényt az előző hónappal
	makeCalendar(currentMonth-1);

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
	let formattedMonth = currentMonth.toString().length === 1 ? `0${currentMonth+1}` : (currentMonth+1).toString();

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

// Átküldjük a foglalás oldanak a szükséges adatokat.
function renting()
{
	rent.accommodation_full_price = rent_price.value;
	rent.rent_beginning = currentDate.value;
	rent.rent_end = nextDayDate.value;
	rent.accommodation_path = window.location.href;
	rent.guests = model.guests;
	rent.accommodation =JSON.stringify(item.value[0]);

	router.replace({path:'/basket'})
}

// beállítjuk modalt az alapján hogy, mit szeretnénk megvalósítani.
function setReportModal(datas)
{
	sendedProblem.value = false;

	Object.assign(problemModel,problemModelEmty);

	// ha van owner_id akkor a szállások/élmények problémák listáját tölti be.
	if(datas?.owner_id){
		problemTypes.value = allProblemTypes["itemsProblemTypes"];
		for(let x of problemTypes.value)
		{
			x.label = t(`about.report.itemsProblemTypes.${x.value}`)
		}
		problemModel.type = props.table_name;
	
	}
	// ha nincs owner_id-ja akkor pedig a vélemények probléma listáját tölti be.
	else{
		problemTypes.value = allProblemTypes["reviewProblemTypes"];
		for(let x of problemTypes.value)
		{
			x.label = t(`about.report.reviewProblemTypes.${x.value}`)
		}
		problemModel.type = "opinions";
	}

	// beállítjuk az id-kat és a a modelType-ot. 
	modalType.value = "report";
	problemModel.item_id = datas.id;
	problemModel.user_id = user.id;

	// Megnyitjuk a modalt().
	openModal();
}

// feltöltjük az adott problémát a az adatbázisba.
function sendProblem(){
	
	axios.post("http://localhost:3000/sendProblem",problemModel)
	.then(response=>{

		// Ha sikeres volt a feltöltés akkor bele megy.
		if(response.data.affectedRows)
		{
			// átállítjuk a modalhoz kapcsolatos értékeket.
			choosedType.value = true;
			sendedProblem.value = true;
		}
	})
	.catch(err=>{
		console.log(err);
	})
}

// Beállítjuk az értékeléshez a csillagokat
function selectStar(x)
{
	let star = document.querySelectorAll(".opinion-star");
	opinionModel.rate = 0;

	star.forEach(item=>{
		item.classList.remove("text-warning");
		item.classList.add("text-secondary");
	})

	for(let y = 0;y<x;y++)
	{
		star = document.getElementById(y+1);
		star.classList.toggle("text-warning");
		star.classList.toggle("text-secondary");
		star.classList.contains("text-warning")?opinionModel.rate++:opinionModel.rate--;
	}
}

// Megszerezzük az összes értékelés azt adott tárgyhoz 
function getAllOpinions()
{
	axios.post(`http://localhost:3000/opinions`,
			{item_id:props.id,item_type:props.table_name,
			 language_short_name:locale.value})
	.then(datas=>{
		opinions.value = datas.data;
	})
	.catch(error=>{
		console.error(error);
	})
}

// Elküldjük az adott vélemény az adatbázisba.
function sendOpinion()
{
	console.log(opinionModel.rate);

	// Beállítjuk az id-kat
	opinionModel.item_id = item.value[0].id;
	opinionModel.user_id = user.id;
	
	let url = "";

	//beállítjuk az url-t attól függően, hogy módosítjuk vagy feltöltjük a az adott véleményt
	switch(opinionModelCopie.opinion_id)
	{
		case '':
			url = 'sendOpinion';
			break;
		default:
			url = 'editOpinion';
			break;
	}

	// feltöltjük a váleményt
	axios.post(`http://localhost:3000/${url}`,opinionModel)
	.then(response=>{

		// HA sikeres volt a feltöltés akkkor bele megy.
		if(response.data.affectedRows)
		{
			// Vissza állítjuk az értékeket az alaplvető beállításokra
			// A modalt pedig hogy jelezze a feltöltés sikerét
			modalType.value = 'report';
			sendedProblem.value = true;
			Object.assign(opinionModel,opinionModelEmty);
			let star = document.querySelectorAll(".opinion-star");

			star.forEach(item=>{
				item.classList.remove("text-warning");
				item.classList.add("text-secondary");
			})

			// MEnyitjuk a modalt
			openModal();

			// Lehívjuk az összes véleményt
			getAllOpinions();
		}
	})
	.catch(err=>{
		console.log(err);
	})
}

// HA módosítani szeretnénk az éréteket a véleménynél,
// akkor ez írja át a szükséges adatokat hozzá.
function editOpinion(x)
{
	opinionModel.opinion_id=x.id;
	opinionModel.user_id=x.user_id;
	opinionModel.item_id=x.item_id;
	opinionModel.message=x.opinion;
	opinionModel.rate=x.rate;
	Object.assign(opinionModelCopie,opinionModel);

	let star = document.querySelectorAll(".opinion-star");

	for(let x = 0;x<opinionModel.rate;x++)
	{
		if(star[x].id == x+1)
		{
			star[x].classList.add("text-warning");
		}
	}

}

// Visszaállítjuk a véleményt alapra.
function resetOpinion()
{
	Object.assign(opinionModel,opinionModelEmty);
	Object.assign(opinionModelCopie,opinionModelEmty);
	let star = document.querySelectorAll(".opinion-star");

	star.forEach(item=>{
		item.classList.remove("text-warning");
		item.classList.add("text-secondary");
	})
}

// Ennek segítségével törlünk ki véleményket.
function deleteOpinion(x)
{
	axios.post(`http://localhost:3000/deleteOpinion`,x)
	.then(response=>{

		// HA sikeres volt a törlés akkor bele megy.
		if(response.data.affectedRows)
		{
			// Vissza állítjuk az értékeket az alaplvető beállításokra
			// A modalt pedig hogy jelezze a feltöltés sikerét
			modalType.value = 'report';
			sendedProblem.value = true;
			opinionModel.opinion_id = "";
			Object.assign(opinionModel,opinionModelEmty);
			let star = document.querySelectorAll(".opinion-star");

			star.forEach(item=>{
				item.classList.remove("text-warning");
				item.classList.add("text-secondary");
			})

			// Megnyitja a modalt és lehívja az összes vélemény.
			openModal();
			getAllOpinions();
		}
	})
	.catch(err=>{
		console.log(err);
	})
}

// Beállítjuk hogy melyik folyamatott szeretnénk csinálni.
function opinionsOptions(value)
{
	choosedType.value = true;
	
	if(deleteType.value == true)
	{
		deleteOpinion(value);	
	}
	else
	{
		sendOpinion();
	}
}

// figyeleli az érekezési és távozási napok változását.
// ha mind a kettőnek van értéke akkor a kettő dátum közötti napokat hozzáadja a rentedDayIds-hez.
// ha nincs értékük de viszont a rentedDayIds-nak van, akkor pedig törli a benne lévő napokat.
watch([arriveDayId,departureDayId],()=>{

	// formázzuk az adott hónapot az összehasonlításokhoz.
	let formattedMonth = currentMonth.toString().length === 1 ? `0${currentMonth+1}` : (currentMonth+1).toString();

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
						{{ item[0].country_trans_name}}, {{ item[0].city_trans_name}}
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
              <i :class="x.icon +' fa-xl'"></i>
							{{ x.text }}
            </p>

					</div>

					<!-- Az adott szállás/élmény leírása -->
					<div  :class="props.table_name=='experiences'
													?'col-md-8 col-xl-8'
													:'col-md-4 col-xl-4'"
								class="row justify-content-center my-3 mx-3 py-3 bg-dark bg-opacity-50
                     text-center align-items-center border border-2 rounded-3 
										 col-12">
						<p>	{{ item[0].description }}</p>
					</div>

					<!-- Élénye árai, tájékoztató jellegű szöveg -->
					<div v-if="props.table_name=='experiences'"
							 class="row justify-content-center my-3 mx-3 py-3 bg-dark bg-opacity-50
                     text-center align-items-center border border-2 rounded-3 
										 col-12 col-sm-12 col-md-8 col-lg-3">
						<p class="fw-bold">{{(Math.round(item[0].price * 
																	selectedCurrency.currencyMultiplier)).toLocaleString('fi-FI')}} 
								 					 {{ selectedCurrency.currencyShortedName }}
							<span>/ {{ $t("card.human") }}</span>
						</p>
						<p>
							{{ $t("about.information_text") }}
						</p>
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
													:disabled="currentMonth === 11"
													@click="monthNext()">
										&gt;
									</button>
								</div>

								<!-- a naptár alján lévő év és hónap -->
								<p v-if="calendar.length>0" 
									 class="col-12 m-0">
									{{`${currentYear}. ${monthsname[currentMonth]}`}}
								</p>

								<p v-if="rentedDayIds.length!=0" 
									 class="col-12 m-0 pt-1">
								{{ $t("about.sum") }} {{(Math.round(rent_price * selectedCurrency.currencyMultiplier)).toLocaleString('fi-FI')}}
													  {{ selectedCurrency.currencyShortedName }}
								</p>
							</div>

							<!-- személyek száma szakasz -->
							<div v-if="user.id != item[0].owner_id"
									 class="mb-3 row justify-content-center">

								<!-- személyek száma szakasz label -->
								<label for="guest_number" class="form-label col-12">
                 {{ $t("about.number_of_guest") }}
                </label>

                <!-- személyek száma szakasz select -->
								<div class="col-5">
									<select class="form-select" id="guest_number" v-model="model.guests">
										<option v-for="x in guests" :value="x">{{ x }} {{ $t("about.human") }}</option>
								</select>
								</div>
							</div>

              <!-- Foglalaás gomb -->
							<button v-if="user.id!='' && user.id != item[0].owner_id"
											v-bind:disabled="rentedDayIds.length==0"
											@click="renting()"
											type="button"
										  class="btn btn-secondary col-6 
                      			 rounded-pill">
                {{ $t('about.renting') }}
              </button>

							 <!-- Bejelentkezés gomb gomb -->
							<router-link to="/login"
													 v-if="user.id =='' && user.id != item[0].owner_id"
										       class="btn btn-secondary col-6 
                      				rounded-pill">
                {{ $t('about.login') }}
              </router-link>
						</form>
					</div>
				</div>

				<!-- Probléma jelentése rész -->
				<div class="row justify-content-center text-center mx-2 my-3
										border border-2 rounded-3 bg-dark bg-opacity-50
										col-12 col-sm-6 col-md-4 p-2">
					<h4>{{ $t("about.report.any_problems") }}</h4>
					<h4>{{ $t("about.report.report_to_we") }}</h4>
					<button @click=" setReportModal(item[0])"
									:disabled="user.id==''"
									class="my-2 btn w-auto rounded-3 btn-danger">
						<i class="fa-solid fa-ban"></i>
						{{ $t("about.report.report_problem") }}
					</button>

				</div>
		
				<!-- Vélemény címe -->
				<h4 v-if="opinions.length!=0"
						class="my-3 text-center">{{ $t("about.opinion.others_opinion") }}
					<span>({{ opinions.length }} {{ $t("about.opinion.opinion") }})</span>
				</h4>

				<!-- Vélemény írása --> 
				<div v-if="reserved_once || (props.table_name=='experiences' && user.id!='' && user.id != item[0].owner_id)"
						 class="row justify-content-center">

					<!-- A vélemény form-ja -->
					<form class="row justify-content-center 
											col-12 col-md-5 m-3 
											rounded-3 bg-white 
											text-dark border border-white">

						<!-- Label -->
						<div class="row mb-3 mt-3">

							<!-- Label -->
							<label class="form-label col-5" 
										 for="asd">
								{{ $t("about.opinion.write_opinion") }}
							</label>

							<!-- értékelési szintje -->
							<div class="ms-auto col-7 text-end text-secondary">
								<i v-for="x in 5"
									 @click="selectStar(x)"
									 :id="x"
									 class="fa-solid fa-star opinion-star"></i>
							</div>

							<!-- Vélemény -->
							<textarea class="form-control col-10" 
										 id="asd" 
										 type="text"
										 value=""
										 rows="5"
										 maxlength="200"
										 v-model="opinionModel.message">
							</textarea>
						</div>
					
						<!-- Vélemény beküldése gomb -->
						<button @click="modalType = 'report';
										 				deleteType = false;
														sendedProblem = true;openModal();"
										class="my-2 btn w-auto rounded-4 
													 btn-primary"
										type="button"
										:disabled="opinionModel.message==''|| opinionModel.rate==0
											|| JSON.stringify(opinionModel)==JSON.stringify(opinionModelCopie)">
							<i class="fa-solid fa-arrow-up-from-bracket"></i>
							{{ $t("about.opinion.send_opinion") }}
						</button>

						<!-- Mégsem gomb -->
						<button @click="resetOpinion()"
										class="my-2 ms-1 btn w-auto rounded-4 
													 btn-secondary"
										type="button"
										:disabled="JSON.stringify(opinionModel)==JSON.stringify(opinionModelEmty)">
							<i class="fa-solid fa-circle-xmark"></i>
							{{ $t("about.opinion.back") }}
						</button>

					</form>
				</div>

				<!-- Vélemény --> 
				<div  v-for="opinion in opinions"
							class="row col-12 col-md-5 m-3 
										 rounded-3 bg-white 
										 text-dark border border-white">

					<!-- Vélémy író neve -->
					<h5 class="mt-2 col-6">
						{{ `${opinion["first_name"]} 
								${opinion["middle_name"]} 
								${opinion["last_name"]}`}}
					</h5>

					<!-- értékelési szintje -->
					<div class="mt-2 ms-auto col-6 text-end text-warning">
						<i v-for="x in opinion['rate']"
								class="fa-solid fa-star"></i>
					</div>

					<!-- maga a vélemény -->
					<p class="my-3 text-break">{{opinion["opinion"] }}</p>

					<div class="d-flex justify-content-center p-0">

						<div class="d-flex justify-content-start col-6">

							<!-- Vélemény szerkesztése gomb -->
							<button v-if="user.id == opinion.user_id"
											@click="deleteType = false;
															editOpinion(opinion);"
											:disabled="user.id==''"
											class="my-1 mx-1 btn w-auto rounded-4 
														btn-primary">
								<i class="fa-regular fa-pen-to-square"></i>
							</button>
							
							<!-- Vélemény törlése gomb -->
							<button v-if="user.user_type=='A'"
											@click="modalType = 'report';
															sendedProblem = true;
															deleteType = true;
															opinionModel.opinion_id = opinion.id;
															openModal();"
											:disabled="user.id==''"
											class="btn w-auto rounded-4 
														my-1 mx-1 btn-secondary">
								<i class="fa-solid fa-trash-can"></i>
							</button>

						</div>
						<div class="d-flex justify-content-end col-6">
							<!-- Vélemény jelentés gomb -->
							<button @click=" setReportModal(opinion)"
											:disabled="user.id==''"
											class="my-1 mx-1 btn w-auto rounded-4 
														btn-danger">
								<i class="fa-solid fa-ban"></i>
								{{ $t("about.opinion.report") }}
							</button>
						</div>
					</div>
				</div>
			</div>

			<!-- saját modal -->
			<div class="bg-black bg-opacity-75 invisible 
									d-flex justify-content-center 
									align-items-center position-fixed"
					 id="imageShowModal"
					 style="z-index:1020;inset:0;">
				
				<!-- galéria modal rész -->
				<div v-if="modalType == 'gallery'"
						 class="position-relative w-75">

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
										@click="closeModal()"
										type="button">
							X
						</button>
					</div>
				</div>

				<!-- probléma jelentése rész -->
				<div v-if="modalType == 'report'"
						 class="row justify-content-center">
					
					<!-- Probléma jelentés form -->
					<form class= "row p-0 m-0 justify-content-center 
												bg-white rounded-3 col-10 text-dark">

						<!-- Bezáró gomb -->
						<div class="d-flex justify-content-end p-0 m-0">
							<button type="button"
											class="btn btn-danger"
											@click="closeModal();choosedType = false;">
								X
							</button>
						</div>

						<!-- probléma rész -->
						<div v-if="sendedProblem!= true"
								 class="row justify-content-center">

							<!-- Probléma fajtája -->
							<div class="mb-3 col-10">

								<!-- Label -->
								<label for="problem_type" 
											class="form-label">
									{{ $t("about.report.report_type") }}
								</label>

								<!-- Select -->
								<select v-model="problemModel.name"
												class="form-control text-center"
												name="problem_type" 
												id="problem_type">

									<!-- alapvető válasz -->
									<option value="" 
													selected hidden>
										{{ $t("about.report.choose") }} 
									</option>
									<option v-for="item in problemTypes"
													:value="item.value">
										{{ item.label }}
									</option>
								</select>
							</div>

							<!-- Probléma részletei -->
							<div class="mb-3 col-10">

								<!-- Label -->
								<label for="problem_description" 
											class="form-label">
									{{ $t("about.report.report_detail") }} 
								</label>

								<!-- Textarea -->
								<textarea v-model="problemModel.description"
													class="form-control" 
													name="problem_description" 
													id="problem_description"
													rows="5"
													value=""
													maxlength="200">
								</textarea>
							</div>

							<!-- Beküldés gomb -->
							<div class="mb-3 d-flex justify-content-center">
								<!-- Beküldés gomb -->
								<button :disabled="problemModel.description==''|| problemModel.name==''"
												type="button"
												class="btn btn-dark w-auto mb-2"
												@click="sendProblem()">
									<i class="fa-solid fa-arrow-up-from-bracket"></i>
									{{ $t("about.report.send") }}
								</button>
							</div>
						</div>

						<!-- visszajelzés rész -->
						<div v-if="sendedProblem" 
								 class="row justify-content-center">
							<h1 class="text-center m-4">
								{{ choosedType
										?$t('about.opinion.succes_upload'):
										$t('about.opinion.upload_question') }}
							</h1>

							<!-- Igen gomb -->
							<button v-if="choosedType!=true"
											type="button"
											class="btn btn-primary w-auto mb-2"
											@click="opinionsOptions(opinionModel)">
								{{ $t("about.report.yes") }}
							</button>

							<!-- Nem gomb -->
							<button v-if="choosedType!=true"
											type="button"
											class="btn btn-secondary w-auto mb-2 mx-1"
											@click="closeModal()">
								{{ $t("about.report.no") }}
							</button>
						</div>
					</form>
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

.opinion-star:hover{
	cursor: pointer;
}
</style>