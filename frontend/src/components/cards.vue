<script setup>
import { selectedCurrency } from '@/store/currency';
import axios from 'axios';
import {ref} from 'vue';
// items definiálása
let items = ref([]);

// Props a rugalmasság érdekében
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

// Ha nincs szállás id akkor hívja le a random 5 id alapján
if(props.accommodation_id == undefined)
{
	axios.get(`http://localhost:3000/${props.tableName}/country/${props.country_id}`)
		.then(response =>
		{
			items.value = response.data;
		})
		.catch(error=>
		{
			console.error(error);
		})
}

// Ha van id akkor az alapján keressen
else
{
	axios.get(`http://localhost:3000/${props.tableName}/${props.accommodation_id}`)
		.then(response=>
		{
			items.value = response.data;
		})
		.catch(error=>
		{
			console.error(error);
		})
}
// convertString függvény
function convertStrings(str) {  
	// A megadott szöveget átalakítja hogy folder alapján megtalálja
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

			<!-- Név és kép -->
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

			<!-- Települési adatok -->
			<div class="card-body">
					<p class="card-text w-100">
						{{x.country_name}}, {{x.city_name}}
					</p>
			</div>
			
			<!-- Ki írja az árat és a valuta formátumát az árat megszorozza a valauta szorzójával -->
			<div class="card-footer border-0">
				<p class="fw-bold">{{(Math.round(x.price * selectedCurrency.currencyMultiplier)).toLocaleString('fi-FI')}} 
								 					 {{ selectedCurrency.currencyShortedName }}
													 <span v-if="props.tableName == 'accommodations'">/ éjszaka</span>
													 <span v-if="props.tableName == 'experiences'">/ fő</span>
				</p>

				<!-- Gomb az adatokhoz ami kattintásra elküldi az adatokat -->
				<router-link 
						:to="{name:'about',params:{table_name:props.tableName,id:x.id,name:x.name}}"
					 	class="btn btn-outline-light w-100">
					Érdekel
				</router-link>
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