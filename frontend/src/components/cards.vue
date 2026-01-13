<script setup>
import axios from 'axios';
import {ref} from 'vue';

let items = ref([]);

let props = defineProps({
	tableName: {
		type: String,
		required: true
	},
	country_id: {
		type: [String,Number],
		required: false
	},
	accommodation_id: {
		type: [String,Number],
		required: false
	}
})

axios.get(`http://localhost:3000/${props.tableName}`)
	.then(response => {

		if(props.accommodation_id == undefined){
			items.value = response.data.filter(country=>
			{
				return country.country_id == props.country_id;
			})
		}
		else{
			items.value = response.data.filter(accommodation=>
			{
				return accommodation.id == props.accommodation_id;
			})
		}
		
	})
	.catch(e => console.error(e))

function convertStrings(str) {  

  return str.normalize("NFD")
            .replace(/[\u0300-\u036f]/g, "")
            .replaceAll(" ","_")
            .toLowerCase();
}
</script>

<template>
	<div class="row justify-content-center cardhover">
		<div class="card mx-4 col-md-5 g-4 p-0 
								bg-transparent text-white border-white
								rounded-4 mb-3" 
				 v-for="x in items"
				 :key="x.id"
					style="width: 21rem;">
			<div class="position-relative">
				<img :src="`/countries/${convertStrings(x.country_name)}
										/cities/${convertStrings(x.city_name)}
										/${props.tableName}/${convertStrings(x.folder_name)}/001.png`"
										
 						 class="card-img-top rounded-top-4" 
						 style="height: 200px; object-fit: cover">
				<h5 class="card-title text-white position-absolute 
									 bottom-0 start-0 w-100 bg-dark bg-opacity-50 
									 text-center m-0 p-2 border fw-bold ">
					{{ x.name }}
				</h5>
			</div>
			<div class="card-body">
					<p class="card-text w-100">
						{{x.country_name}}, {{x.city_name}}
					</p>
			</div>
			<div class="card-footer border-0">
				<p class="fw-bold">{{ x.price}} / éjszaka</p>
				<button class="btn btn-outline-light w-100">
					<router-link 
							:to="{name:'about',params:{table_name:props.tableName,id:x.id,name:x.name}}"
						 	class="nav-link">
						Érdekel
					</router-link>
				</button>
			</div>
		</div>
	</div>
</template>

<style>
.card:hover {
	box-shadow: 0px 0px 20px white;
	transform: translateY(-10px);
	transition: 200ms;
}
</style>