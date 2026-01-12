<script setup>
import axios from 'axios';
import { ref } from 'vue';
import { Modal } from 'bootstrap';

// étékek át hozása mási koldalról
const props = defineProps(['id','name','table_name'])

// változók létrehozása
let item = ref([]);
let images = [];
let galleryImages = [];
let currentImage = ref("");
let counter = 0;
let modal = null;
let mode = "plus";


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
axios.get(`http://localhost:3000/${props.table_name}`)
	.then(datas=>{
		item.value = datas.data.filter(response=>
			{
				return response.id == props.id;
			})
	})
	.catch(error=>
	{
		console.error(error);
	})

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
	setTimeout(()=>
	{
		console.clear();
	},180);
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
			<div class="row justify-content-center">

				<!-- Sazállás/élmény neve -->
				<h1 class="display-1 text-center mb-5">
					{{ item[0].name }}
    		</h1>

				<!-- Szállás/élmlny leírása -->
				<p class="display-6 text-center mb-5">
					{{ item[0].description }}
				</p>

				<!-- Galéria -->
				<div class="row justify-content-center">
					<!-- Síma képek -->
					<div v-for="img in galleryImages" class="col-12 col-sm-12 col-md-6 col-lg-6 col-xl-6 col-xxl-4">
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
							 class="col-12 col-sm-12 col-md-6 col-lg-6 col-xl-6 col-xxl-4">
						<img height="300"
								 src="../images/image3.png"
								 class="img my-2 mx-2 card-img-top rounded-5 border border-white border-5"
								 @click="imageShow('004.png')"
								 style="object-fit:cover">
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
	box-shadow: 0px 0px 20px rgb(255, 255, 255);
	transform: translateY(-10px);
	zoom:1.05;
	cursor: pointer;
	transition: 200ms;
}

.modalImg:hover
{
	cursor: zoom-in;
}
</style>