<script setup>
import axios from 'axios';
import { ref } from 'vue';
import { Modal } from 'bootstrap';

// étékek át hozása mási koldalról
const props = defineProps(['id','name','table_name'])

// változók létrehozása
let item = ref([]);
let item_details = ref([]);
let images = [];
let galleryImages = [];
let currentImage = ref("");
let counter = 0;
let modal = null;
let mode = "plus";
let guest = [1,2,3,4,5,6];



let iconsAndTexts = {
	balcony:`<font-awesome-icon icon="fa-solid fa-house" />`
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
		item.value = datas.data;

	})
	.catch(error=>
	{
		console.error(error);
	})

if(props.table_name == "accommodations")
{
	axios.get(`http://localhost:3000/accommodations/accommodations_details/${props.id}`)
		.then(details=>
		{
			item_details.value = details.data;
			item_details.value = item_details.value[0]
			console.log(item_details.value);
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

	// modal megnyitása és meghívása
	modal = new Modal(document.querySelector("#imageShow"));
	modal.show();
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

// mivel functionnal nyitottuk meg  a modalt, igy egy functionnal is zárjuk be
// hogy egységes legyen
function closeModal() {

	modal.hide();

	//kiad egy figylemezetetés a vue, mert a modalt nem preferálja
	//azt tüntettjük el
	console.clear();
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
      	btn.style.visibility = "hidden";
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
      	btn.style.visibility = "visible";
    	});

			return mode ="plus";
		}
	}
	
}


</script>
<template>
	<div class="about">
		<div class="container text-white" v-if="item.length>0">

			<!-- Kép megjelenítés -->
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
							 class="col-12 col-sm-12 col-md-6 col-lg-6 col-xl-3 col-xxl-3">
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

				<div class="row justify-content-center">
					<div v-if="props.table_name=='accommodations'" class="row justify-content-center text-center py-3 col-10 border border-2 rounded-3">
						<h3 class="mb-4">Amit a szállás kínál</h3>
						<p class="col-4" v-if="item_details.balcony == 1"><font-awesome-icon icon="fa-solid fa-house" size="xl" /> erkély</p>
						<p class="col-4" v-if="item_details.basic_spices == 1"><font-awesome-icon icon="fa-solid fa-jar" size="xl" /> fűszerek</p>
						<p class="col-4" v-if="item_details.bluetooth_speaker == 1"><font-awesome-icon icon="fa-solid fa-radio"size="xl"/> bluetooth-os hangszóró</p>
						<p class="col-4" v-if="item_details.board_games == 1"><font-awesome-icon icon="fa-solid fa-users-rectangle" size="xl"/> társasjátékok</p>
						<p class="col-4" v-if="item_details.coffee_maker == 1"><font-awesome-icon icon="fa-solid fa-mug-hot" size="xl"/> kávéfőző</p>
						<p class="col-4" v-if="item_details.darkening == 1"><font-awesome-icon icon="fa-solid fa-window-maximize" size="xl"/> sötétítő</p>
						<p class="col-4" v-if="item_details.dishes == 1"><font-awesome-icon icon="fa-solid fa-plate-wheat" size="xl"/> edények</p>
						<p class="col-4" v-if="item_details.extra_bed_linen == 1"><font-awesome-icon icon="fa-solid fa-bed" size="xl"/> extra ágynemű</p>
						<p class="col-4" v-if="item_details.free_wifi == 1"><font-awesome-icon icon="fa-solid fa-wifi" size="xl"/> wifi</p>
						<p class="col-4" v-if="item_details.hair_dryer == 1"><font-awesome-icon icon="fa-solid fa-wind" size="xl"/> hajszárító</p>
						<p class="col-4" v-if="item_details.iron == 1"><font-awesome-icon icon="fa-solid fa-fax" size="xl"/> vasaló</p>
						<p class="col-4" v-if="item_details.kettle == 1"><font-awesome-icon icon="fa-solid fa-water" size="xl"/> vízforraló</p>
						<p class="col-4" v-if="item_details.microwave == 1"><font-awesome-icon icon="fa-solid fa-house-tsunami" size="xl"/> mikró</p>
						<p class="col-4" v-if="item_details.night_lamp == 1"><font-awesome-icon icon="fa-regular fa-lightbulb" size="xl"/> éjjeli lámpa</p>
						<p class="col-4" v-if="item_details.parking_lot == 1"><font-awesome-icon icon="fa-solid fa-car-side" size="xl"/> parkoló</p>
						<p class="col-4" v-if="item_details.safe == 1"><font-awesome-icon icon="fa-solid fa-vault" size="xl"/> széf</p>
						<p class="col-4" v-if="item_details.smart_tv == 1"><font-awesome-icon icon="fa-solid fa-tv" size="xl"/> okos-tv</p>
						<p class="col-4" v-if="item_details.suitcase_rack == 1"><font-awesome-icon icon="fa-solid fa-suitcase" size="xl"/> bőrönd tartó</p>
						<p class="col-4" v-if="item_details.towels == 1"><font-awesome-icon icon="fa-solid fa-rug" size="xl"/> törölközők</p>
						<p class="col-4" v-if="item_details.usb_charger == 1"><font-awesome-icon icon="fa-solid fa-bolt" size="xl"/> usb töltő</p>
						<p class="col-4" v-if="item_details.work_table == 1"><font-awesome-icon icon="fa-solid fa-table" size="xl"/> munka asztal</p>
			
						<!-- <p v-for="x in item_details" class="col-2	text-center"><font-awesome-icon icon="fa-solid fa-bed"/> vendégágy</p> -->
					</div>
					<div class="row justify-content-center col-5 my-3 ms-1 py-3 text-center align-items-center  border border-2 rounded-3">
						<p>	{{ item[0].description }}</p>
					</div>
					<div v-if="props.table_name=='accommodations'" class="row justify-content-center col-5 text-center ms-2 my-3 ">
						<form class="border border-2 rounded-3 pt-4 pb-4">
							<div class="mb-3 row">

								<label for="erkezes" class="form-label col-6">Érkezés időpontja</label>
								<label for="tavozas" class="form-label col-6">Távozás időpontja</label>

								<div class="col-6">
									<input type="date" class="form-control" id="erkezes">
								</div>
								<div class="col-6">
									<input type="date" class="form-control" id="tavozas">
								</div>
								
							</div>
							<div class="mb-3 row justify-content-center">
								<label for="exampleInputPassword1" class="form-label col-12">Személyek száma</label>
								<div class=" col-5">
									<select class="form-select" name="" id="">
										<option v-for="x in guest" value="">{{ x }}fő</option>
								</select>
								</div>
							</div>
							<button class="btn btn-secondary col-6 rounded-pill">Foglalás</button>
						</form>
					</div>
				</div>
			</div>
			<!-- Modal -->
			<div class="modal fade col-12" id="imageShow" data-bs-keyboard="false" 
					 data-bs-backdrop="static" tabindex="-1" aria-hidden="true">	 
				<div class="modal-dialog modal-dialog-centered modal-xl">
					<div class="modal-content bg-dark bg-opacity-50">
						<div class="modal-body position-relative">

							<!-- Kép -->
							<div class="d-flex justify-content-center">
								<img style="max-width: 1050px; max-height: 700px;object-fit:cover;"
										 class="col-12 modalImg"
										 @click="modalImgResize()"
										 :src="`/countries/${convertStrings(item[0].country_name)}`+
										 			 `/cities/${convertStrings(item[0].city_name)}`+
													 `/${props.table_name}/${convertStrings(item[0].folder_name)}`+
													 `/${images[currentImage]}`">
							</div>

							<!-- Kép száma -->
							<p class="text-center text-white mt-3">{{ currentImage+1 }}/{{ images.length }}</p>

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
		</div>
	</div>
</template>

<style>
.img:hover {
	box-shadow: 0px 0px 40px rgb(255, 255, 255);
	cursor: pointer;
	transition: 200ms;
}

.modalImg:hover
{
	cursor: zoom-in;
}
</style>