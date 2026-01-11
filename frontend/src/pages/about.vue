<script setup>
import axios from 'axios';
import { ref } from 'vue';

const props = defineProps(['id','name','table_name'])

let item = ref([]);
let images = [];
let currentImages = "";
let counter = 0;

switch(props.table_name)
{
	case "accommodations":
		counter = 10;
		break;

	case "experiences":
		counter = 3;
		break;
}

if(counter>0)
{
	for(let i=0;i<counter;i++)
	{
		images.push(i<9?`00${i+1}.png`:`0${i+1}.png`);
	}
}

console.log(images);

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

function convertStrings(str) {  

  return str.normalize("NFD")
            .replace(/[\u0300-\u036f]/g, "")
            .replaceAll(" ","_")
            .toLowerCase();
}	
</script>
<template>
	<div class="about">
		<div class="container text-white" v-if="item.length>0">
			<div class="row justify-content-center">

				<h1 class="display-1 text-center mb-5">
					{{ item[0].name }}
    		</h1>

				<p class="display-6 text-center mb-5">
					{{ item[0].description }}
				</p>

				<div class="row justify-content-center">
					<div v-for="img in images" class="col-12 col-sm-12 col-md-6 col-lg-6 col-xl-6 col-xxl-6">
						<img height="500" :src="`/countries/${convertStrings(item[0].country_name)}
																		/cities/${convertStrings(item[0].city_name)}
																		/${props.table_name}/${convertStrings(item[0].folder_name)}/${img}`"
							class="img my-2 mx-2 card-img-top rounded-5 border border-white border-5"
							data-bs-toggle="modal" data-bs-target="#imageShow"
							style="object-fit:cover">
					</div>
				</div>
			</div>

			<!-- Modal -->
			<div class="modal fade" id="imageShow"data-bs-keyboard="false" 
					 data-bs-backdrop="static" tabindex="-1" aria-hidden="true">
					 
				<div class="modal-dialog modal-dialog-centered modal-xl">
					<div class="modal-content bg-dark bg-opacity-10">
						<div class="modal-body position-relative"
								 style="height: 75vh;">

							<!-- Kép -->
							<div class="position-absolute top-50 start-50 translate-middle">
								<img style="max-width: 1050px; max-height: 700px;"
										 :src="`/countries/${convertStrings(item[0].country_name)}`+
										 				`/cities/${convertStrings(item[0].city_name)}
														/${props.table_name}/${convertStrings(item[0].folder_name)}/${images[0]}`">
							</div>

							<!-- Balra lapozás gomb -->
							<div class="position-absolute top-50 start-0 translate-middle-y">
								<button class="btn btn-secondary"><</button>
							</div>

							<!-- Jobbra lapozás gomb -->
							<div class="position-absolute top-50 end-0 translate-middle-y">
								<button class="btn btn-secondary">></button>
							</div>

							<!-- Bazáró gomb -->
							 <div class="position-absolute top-0 end-0">
								<button class="btn btn-secondary" 
												data-bs-dismiss="modal">
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
	box-shadow: 0px 0px 20px white;
	transform: translateY(-10px);
	zoom:1.05;
	cursor: pointer;
	transition: 200ms;
}
</style>