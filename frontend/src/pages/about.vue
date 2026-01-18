<script setup>
import axios from 'axios';
import { ref, watch } from 'vue';

// étékek át hozása mási koldalról
const props = defineProps(['id','name','table_name'])

// változók létrehozása
let item = ref([]);
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
let daysname = ["H","K","Sz","Cs","P","Sz","V"];
let monthsname = ["január","február","március","április","május","június","július","augusztus","szeptember","október","november","december"];
let arriveDay= ref(null); 
let arriveDayId= ref(null); 
let departureDay=ref(null); 
let departureDayId=ref(null); 
let rentedDays = ref([]);
let rentedDayIds = ref([]);
let daysInMonth = ref("");

let currentYear= new Date().getFullYear();
const todayMonth = new Date().getMonth() + 1;

makeCalendar(1)

function makeCalendar(plusmonth)
{
	if(todayMonth>0)
	{
		calendar.value=[];
		currentMonth = new Date().getMonth()+plusmonth;
		let currentDay= new Date().getDate();
		daysInMonth.value = new Date(currentYear,currentMonth,0).getDate();
		let daysInPriviousMonth = new Date(currentYear,currentMonth-1,0).getDate();
		let daysInNextMonth = new Date(currentYear,currentMonth+1,1).getDate();
		let lastDayinPriviousMonth  = new Date(currentYear,currentMonth-1,0).getDay();
		let firstDayinMonth  = new Date(currentYear,currentMonth-1,1).getDay();
		let lastDayinMonth  = new Date(currentYear,currentMonth-1,daysInMonth.value).getDay();
		// currentDate = `${currentYear}-${currentMonth}-${currentDay}`;
		// nextDayDate = `${currentYear}-${currentMonth}-${currentDay+1}`;

		lastDayinPriviousMonth = lastDayinPriviousMonth==0?6:lastDayinPriviousMonth-1;
		firstDayinMonth = firstDayinMonth==0?6:firstDayinMonth-1;
		lastDayinMonth = lastDayinMonth==0?6:lastDayinMonth-1;

		for(let i=0;i<lastDayinPriviousMonth+1;i++)
		{
			// calendar.value.push(daysInPriviousMonth-(lastDayinPriviousMonth-i));
			calendar.value.push("");
		}

		for(let x=1;x<daysInMonth.value+1;x++)
		{
			calendar.value.push(daysInMonth.value-(daysInMonth.value-x));
		}

		for(let y=1;y<(6-lastDayinMonth)+1;y++)
		{
			// calendar.value.push(daysInNextMonth-(daysInNextMonth-y));
			calendar.value.push("");
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

// ha nagyob mint 0 csa k akkor mrgy bele
if(counter>0)
{
	// hozáadjuk a listákhoz a képek neveit.
	for(let i=0;i<counter;i++)
	{
		images.push(i<9?`00${i+1}.png`:`0${i+1}.png`);

		if(i<3)
		{
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
			// annyi lelemet rak a guest-be amennyi vendég van.
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

// ha szállásnak a részletét szeretnénk, akkor indul el ez a szerver lehívás
if(props.table_name == "accommodations")
{
	// adatbázisból lehúzzuk a szálláshoz tartozó részleteket
	axios.get(`http://localhost:3000/accommodations/accommodations_details/${props.id}`)
		.then(details=>
		{

			//beolvassuk a iconsAndTexts.json-t 
			//amiben az iconok és a hozzájuk tartozó szöveg van benne 
			axios.get('/jsons/iconsAndTexts.json')
				.then(response=>
				{

					// a tartalmát a iconsAndTexts adjuk át
					iconsAndTexts =	 response.data;

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
		})
		.catch(error=>
		{
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
	for(let x=0;x<images.length;x++)
	{
		if(images[x] === img)
		{
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

// ha a > re megy akkor a következő képet tölti be
function imageNext(img)
{
	if(img === images.length-1)
	{
		currentImage.value = 0; 
	}
	else
	{
		currentImage.value = img+1;
	}
}

// ha a < re meg y akkor az előző képet tölti be
function imagePrevious(img)
{
	if(img === 0)
	{
		currentImage.value = images.length-1; 
	}
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

function monthNext()
{

	makeCalendar(currentMonth+1);

	monthCheck();

	
}

function monthPrevious()
{
	makeCalendar(currentMonth-1);


	monthCheck();

}

function daySelected(month,day)
{
	console.log(month,day);

	let currentDay = document.getElementById(`${month}.${day}`);

	if(currentDay.innerText == "")
	{
		return;
	}

	if(arriveDay.value == currentDay)
	{
		arriveDay.value.style.removeProperty("background-color");
		arriveDayId.value = null;
		arriveDay.value = null;
		currentDate.value = "";
		return;
	}
	else if(departureDay.value  == currentDay)
	{
		departureDay.value.style.removeProperty("background-color");
		if(arriveDayId.value == null)
		{
			departureDayId.value = null;
		}
		departureDay.value = null;
		nextDayDate.value = "";
		return;
	}

	if(arriveDay.value == null)
	{
		arriveDay.value = document.getElementById(`${month}.${day}`);
		arriveDayId.value = `${month}.${day}`;
		arriveDay.value.style.backgroundColor="grey";
		currentDate.value = `${currentYear}-${month}-${day}`;
		return;
	}
	else if(departureDay.value == null && arriveDay.value != currentDay)
	{
		departureDay.value = document.getElementById(`${month}.${day}`);
		departureDayId.value = `${month}.${day}`;
		departureDay.value.style.backgroundColor="grey";
		nextDayDate.value = `${currentYear}-${month}-${day}`;
		return;
	}
}

function monthCheck()
{
	console.log(rentedDayIds.value);
	let rentedDaysinCurrentMonth = [];
	let deletingDays = [];
	

	for(let x =0;x<rentedDays.value.length;x++)
	{
		if((rentedDayIds.value[x]).split(".")[0] == currentMonth)
		{
			rentedDaysinCurrentMonth.push(rentedDayIds.value[x]);
		}
		else
		{
			deletingDays.push(rentedDayIds.value[x]);
		}
	}

	console.log(rentedDaysinCurrentMonth);
	console.log(deletingDays);

	
	if(deletingDays.length>0)
	{	
		for(let x=0;x<deletingDays.length;x++)
		{
			
			let currentDay = document.getElementById(`${deletingDays[x]}`);
			if(currentDay){
				currentDay.style.removeProperty("background-color");
			}
			

		}
	}

	setTimeout(()=>
	{
		if(rentedDaysinCurrentMonth.length>0){

			for(let x=0;x<rentedDaysinCurrentMonth.length;x++)
			{

				let currentDay = document.getElementById(`${rentedDaysinCurrentMonth[x]}`);
				currentDay.style.backgroundColor="darkgray";
			}
		}
	},200)

	console.log(arriveDayId.value);
	
	if(arriveDayId.value!= null){
		if((arriveDayId.value).split(".")[0] == currentMonth){
			arriveDay.value.style.backgroundColor="grey";
		}
		else
		{
			arriveDay.value.style.removeProperty("background-color");
		}
	}

	if(departureDayId.value!=null){
		if((departureDayId.value).split(".")[0] == currentMonth){
			departureDay.value.style.backgroundColor="grey";
		}
		else
		{
			departureDay.value.style.removeProperty("background-color");
		}
	}
}

watch([arriveDay,departureDay],()=>
{
	if(arriveDay.value!=null)
	{
		if(departureDay.value != null)
		{
			if(departureDayId.value.split(".")[0] != arriveDayId.value.split(".")[0])
			{
				for(let y = daysInMonth.value-(daysInMonth.value-1);y<departureDay.value.innerText;y++)
				{
					console.log(y);
					
					let currentDay = document.getElementById(`${currentMonth}.${y}`);
					rentedDays.value.push(currentDay);
					rentedDayIds.value.push(`${currentMonth}.${y}`);
				}
			}
			else
			{
				rentedDays.value = [];
				for(let y = parseInt(arriveDay.value.innerText)+1;y<parseInt(departureDay.value.innerText);y++)
				{
					let currentDay = document.getElementById(`${currentMonth}.${y}`);
					currentDay.style.backgroundColor="darkgray";
					rentedDays.value.push(currentDay);
					rentedDayIds.value.push(`${currentMonth}.${y}`);
				}
			}	
		}
		else
		{
			if((departureDayId.value!=null))
			{
				for(let x =0;x<rentedDays.value.length;x++)
				{
					rentedDays.value[x].style.removeProperty("background-color");
				}
				rentedDays.value = [];
				rentedDayIds.value = [];
				departureDayId.value = null;

			}
			else
			{
				for(let y = parseInt(arriveDay.value.innerText)+1;y<daysInMonth.value+1;y++)
				{
					let currentDay = document.getElementById(`${currentMonth}.${y}`);
					rentedDays.value.push(currentDay);
					rentedDayIds.value.push(`${currentMonth}.${y}`);
				}
			}
		}
	}
	// else if(arriveDay.value!= null && departureDay.value != null)
	// {

	// 	if(asd2 == 2)
	// 	{
	// 		for(let x =0;x<rentedDays.value.length;x++)
	// 		{
	// 			rentedDays.value[x].style.backgroundColor="darkgray";
	// 		}
	// 	}
	// 	else{
	// 		for(let y = parseInt(arriveDay.value.innerText)+1;y<parseInt(departureDay.value.innerText);y++)
	// 		{
	// 			console.log(y);
	// 			let currentDay = document.getElementById(`${currentMonth}.${y}`);
	// 			currentDay.style.backgroundColor="darkgray";
	// 			rentedDays.value.push(currentDay);
	// 			rentedDayIds.value.push(`${currentMonth}.${y}`);
	// 		}
	// 	}
	// }
	else{

		for(let x =0;x<rentedDays.value.length;x++)
		{
			rentedDays.value[x].style.removeProperty("background-color");
		}

		rentedDays.value = [];
		rentedDayIds.value = [];
	}
})

</script>
<template>
	<div class="about">
		<div class="container text-white" v-if="item.length>0">

			<!-- Kép megjelenítés és a szállás/élmény címe -->
			<div class="row justify-content-center">

				<!-- Sazállás/élmény neve -->
				<h1 class="display-1 text-center mb-5">
					{{ item[0].name }}
    		</h1>

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
						<h3 class="mb-4">Amit a szállás kínál</h3>

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
						<form v-if="calendar.length>0" class="pt-4 pb-4">

							<!-- érkezés/távozás szakas -->
							<div class="mb-3 bg-white row justify-content-center rounded-3 py-3 text-dark">
								
								<div class="row justify-content-center">
									<h6 class="col-6">Érkezés időpontja</h6>
									<h6 class="col-6">Távozás időpontja</h6>
									<h6 class="col-6">{{ currentDate }}</h6>
									<h6 class="col-6">{{ nextDayDate }}</h6>
								</div>

								<!-- Balra lapozás gomb -->
								<div class="col-2 my-2 row align-items-center z-1">
									<button class="btn btn-secondary"
													id="monthPrevious"
													type="button"
													:disabled="currentMonth === todayMonth"
													@click="monthPrevious()">
										&lt;
									</button>
								</div>
					
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
												<tr v-for="week in 6">
													<td class="day"
															:id="`${currentMonth}.${calendar[(week-1)*7 + (day-1)]}`"
															@click="daySelected(currentMonth,calendar[(week-1)*7 + (day-1)])"
															v-for="day in 7" >
														{{ calendar[(week-1)*7 + (day-1)] }}
													</td>
												</tr>
										</tbody>
									</table>
								</div>
								
								<!-- Jobbra lapozás gomb -->
								<div class="col-2 my-2 row align-items-center ">
									<button class="btn btn-secondary"
													id="monthNext"
													type="button"
													:disabled="currentMonth === 12"
													@click="monthNext()">
										&gt;
									</button>
								</div>

								<p class="col-12 m-0">{{`${currentYear}.${monthsname[currentMonth-1]}`}}</p>
							</div>

							<!-- személyek száma szakasz -->
							<div class="mb-3 row justify-content-center">

								<!-- személyek száma szakasz label -->
								<label for="guest_number" class="form-label col-12">
                  Személyek száma
                </label>

                <!-- személyek száma szakasz select -->
								<div class="col-5">
									<select class="form-select" id="guest_number">
										<option v-for="x in guests" value="">{{ x }}fő</option>
								</select>
								</div>
							</div>

              <!-- Foglalaás gomb -->
							<button class="btn btn-secondary col-6 
                      rounded-pill disabled">
                Foglalás
              </button>
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

.day:hover
{
	box-shadow: 0px 0px 10px rgb(255, 255, 255);
	cursor: pointer;
	transition: 200ms;
	background-color: white;
	color: black;
}

</style>