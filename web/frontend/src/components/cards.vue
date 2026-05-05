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


// végigmegy a kártya összes elemén, majd megnézi adatbázisban hogy van-e neki az adott nyelvre fordítása,
// ha nincsen rá fordítás, de azon a nyelven vagyunk amilye nnyelven feltöltöttük az adottott tárgyat,
// akkor az eredeti verzióját tölti be.
// HA egy dolognak nincsen fordítása és eredeti verziója sem paszzol a jelenlegi nyelvhez,
//  akkor api segítségével lefordítja és feltölti adatbázisba a fordítások közé, és újra idítja az oldalt,
// utána pendig az egész függvény előröl kezdődik és így már be fogja tölteni az adot tárgy fordítását.
// ha esetleg hiba akana afordítással akkor a művele megszakad é kiírja a konzolbon.
function getTranslation()
{
	for(let x in toCard.value)
	{
		axios.post(`http://localhost:3000/translate`,
			{item_id:toCard.value[x].id,item_name:props.tableName,language_short_name:locale.value})
		.then(datas=>
		{
			// ha a translationed üzenettl tér vissza, akkor tudjuk, hogy mgtalálta az elem fodítását.
			if(datas.data.message == "translationed")
			{
				try{
					// az adatbázisban tárolt json fáljt beolvassuk és átadjuk az értékét.
					let text  = JSON.parse(datas.data.data[0].item);
					toCard.value[x].name = text["title"];
				}
				catch{
					return;
				}
				
			}
			// ha az original üzenettel tér vissza, akkor tudjuk, hogy az elem eredeti verzióját találta meg.
 			else if(datas.data.message == "original")
			{
				// ezután beállítjuk és felhasználjuk az erdeti verzió értékeit.
				toCard.value[x].name = datas.data.data[0].name;
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
			return;
		})
	}
}

axios.get(`http://localhost:3000/${props.tableName}`)
.then(async response => {

	for(let x in response.data)
	{

		await axios.post('http://localhost:3000/getAllLocations',{country_id:response.data[x].country_id,
																												city_id:response.data[x].city_id,
																												language_short_name:locale.value})
		.then(translations=>{

			// beállíítja az adott elemnek az éppen kiválaszott nyelvhez lefordított város és ország nevét.
			response.data[x].country_trans_name = translations.data.countries[0].name;
			response.data[x].city_trans_name = translations.data.cities[0].name;
			
		})
		.catch(err=>{
			console.log(err);
		})
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
});

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