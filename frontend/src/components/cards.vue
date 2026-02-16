<script setup>
import { searchInput } from '@/js/getLocation';
import { selectedCurrency } from '@/store/currency';
import axios from 'axios';
import {ref, watch} from 'vue';
import { useI18n } from 'vue-i18n';

const {t} = useI18n();
const {locale} =  useI18n();
// items,toCard definiálása
let items = ref([]);
let toCard = ref([]);
let toImage = ref([]); 

// Props a rugalmasság érdekében
let props = defineProps({
	tableName: {
		type: String,
		required: true
	},
	country_name: {
		type: [String],
		required: true
	},
	accommodation_id: {
		type: [String,Number],
		required: false
	}
})

function getTranslation()
{
	for(let x in toCard.value)
	{
		axios.post(`http://localhost:3000/translate`,
			{item_id:toCard.value[x].id,item_name:props.tableName,language_short_name:locale.value})
		.then(datas=>
		{
			if(datas.data.message == "translation")
			{
				let text  = JSON.parse(datas.data.data[0].item);
				toCard.value[x].name = text["title"];
				toCard.value[x].description = text["text"];
				console.log("fordított");
				
			}
			else if(datas.data.message == "original")
			{
				toCard.value[x].name = datas.data.data[0].name;
				toCard.value[x].description = datas.data.data[0].description;
				console.log("eredeti");
			}
		})
		.catch(err=>
		{
			console.log(err);
		})
	}
}




axios.get(`http://localhost:3000/${props.tableName}`)
.then(response => {

	for(let x in response.data)
	{
		response.data[x].country_trans_name =t(`search.countries.${response.data[x].country_id}`);
		response.data[x].city_trans_name = t(`search.cities.${response.data[x].city_id}`);
	}

	items.value = response.data

	// Csak azokat teszi bele amelyek megegyeznek a props értékével
	if(props.accommodation_id == undefined){
		toCard.value = items.value.filter(country => {
			return country.country_trans_name.toLowerCase() === props.country_name.toLowerCase();
		})
	}
	else
	{
		toCard.value = items.value.filter(accommodation => {
			return accommodation.id == props.accommodation_id;
		})
	}
	
	getTranslation();
})
.catch(e => console.error(e))
// SearchInput változás esetén...
watch(searchInput,(value) => {
	// Ha nincs megadott érték akkor vissza adja azokat az értékeket amelyek a propsban vannak
	if(!value){
		toCard.value = items.value.filter(country => {return country.country_trans_name.toLowerCase() === 
																													props.country_name.toLowerCase();})
		return
	}
	// Ha pedig mégis van akkor pedig azt az érétket adja vissza amelyiket a value tartalmazzas
		toCard.value = items.value.filter(x => x.city_trans_name.toLowerCase()
																											.includes(value.toLowerCase()) || 
																						x.country_trans_name.toLowerCase()
																													.includes(value.toLowerCase()))

	getTranslation();
})

// Convert string metódus
function convertStrings(str) {
  return str.normalize("NFD")
            .replace(/[\u0300-\u036f]/g, "")
            .replaceAll(" ","_")
            .toLowerCase();
}
</script>

<template>
	<div class="row justify-content-center cardhover">
		<div class="card mx-4 col-md-5 g-4 p-0 pb-2 
								bg-transparent text-white border-white
								rounded-4 mb-3" 
				 v-for="x in toCard"
				 :key="x.id"
					style="width: 21rem;">
			<div class="position-relative">
				<img :src="`/countries/${convertStrings(x.country_name)}
										/cities/${convertStrings(x.city_name)}
										/${props.tableName}/${convertStrings(x.folder_name)}/001.png`"
 						 class="card-img-top rounded-top-4" 
						 style="height: 200px; object-fit: cover;">

				<h5 class="card-title text-white position-absolute 
									 bottom-0 start-0 w-100 bg-dark bg-opacity-50 
									 text-center m-0 p-2 border fw-bold ">
					{{ x.name }}
				</h5>
			</div>
			<div class="card-body">
					<p class="card-text w-100">
						{{x.country_trans_name}}, {{x.city_trans_name}}
					</p>
			</div>
			<div class="card-footer border-0">
				<p class="fw-bold">{{(Math.round(x.price * selectedCurrency.currencyMultiplier)).toLocaleString('fi-FI')}} 
								 					 {{ selectedCurrency.currencyShortedName }}
					<span v-if="props.tableName == 'accommodations'">/ {{ $t("card.night") }}</span>
					<span v-if="props.tableName == 'experiences'">/ {{ $t("card.human") }}</span>
				</p>

				<!-- Gomb az adatokhoz ami kattintásra elküldi az adatokat -->
				<router-link 
						:to="{name:'about',params:{table_name:props.tableName,id:x.id,name:x.name	}}"
					 	class="btn btn-outline-light w-100">
					{{ $t("card.interest") }}
				</router-link>
			</div>
		</div>
	</div>
</template>

<style scoped>
.card:hover {
	box-shadow: 0px 0px 20px white;
	transform: translateY(-10px);
	transition: 200ms;
}

.cardhover .card {
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.cardhover .card:hover {
  transform: translateY(-15px) scale(1.03);
  animation: float 2s ease-in-out infinite;
}

</style>