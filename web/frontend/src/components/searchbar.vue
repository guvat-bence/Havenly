<script setup>
import { convertStrings } from '@/common';
import { activeLocations, searchInput } from '@/js/getLocation';
import axios from 'axios';
import { computed, reactive, ref } from 'vue';
import { useI18n } from 'vue-i18n';


const {t} = useI18n();
const {locale} = useI18n();
let result = reactive({
	city_name: [],
	country_name: []		
}),
	isFocus = ref(false),
	props  = defineProps({
		tablename: {
			type: String,
			required: true
		}
	}),

	//getActiveLocations függvény
	getActiveLocations = (x) => {
		axios.get(`http://localhost:3000/create${x}LocationList`)
		.then(async response => {

			for(let x in response.data)
			{
				await axios.post('http://localhost:3000/getAllLocations',{country_id:response.data[x].country_ID,
																											city_id:response.data[x].city_id,
																											language_short_name:locale.value})
				.then(async translations=>{

					// beállíítja az adott elemnek az éppen kiválaszott nyelvhez lefordított város és ország nevét.
					response.data[x].country_name = translations.data.countries[0].name;
					response.data[x].city_name = translations.data.cities[0].name;

				})
				.catch(err=>{
					console.log(err);
				})	
			}

			activeLocations.value = response.data;
		})
		.catch(e => console.error(e))
	},

	//Search függvény
	search = (value) => {
		// Változás esetén le nullázza
		result.city_name = [];
		result.country_name = [];

		// A változót feltöltkük a country_name-el amit elsőnek egy setbe rak majd átalakítja tömbé
		let countries = [... new Set(activeLocations.value.map(x => x.country_name))]
		for (let index = 0; index < activeLocations.value.length; index++) {

			// Szétszedi a város nevet szóköznként(ha van), 
			// és megnézi hogy valamelyik része tartalmazza a searchinputba beírtakat
			if ((convertStrings(activeLocations.value[index].city_name)).split(" ")
																																	.filter(x => x.includes(convertStrings(value))).length > 0) {

				// Ha egyezik beleteszi az értéket
				result.city_name.push(activeLocations.value[index])
			}
		}
		
		for (let i = 0; i < countries.length; i++) {
			if ((convertStrings(countries[i])).split(" ")
																				.filter(x => x.includes(convertStrings(value))).length > 0) {

				result.country_name.push(countries[i])
			}
		}
	};
		
//Függvény lefuttatása
getActiveLocations(props.tablename)
</script>

<template>
	<!-- Search bar -->
	<form class="d-flex mb-5" 
				role="search" 
				name="searchbar">
		<div>
			<input class="bg-transparent p-2 border-0 border-bottom h4 me-2 text-white" 
						 type="search" 
						 id="searchinput"
						 :placeholder="t('search.search_title')"
						 v-model="searchInput" 
						 v-on:input="search(searchInput)" 
						 v-on:focus="isFocus = true" 
						 v-on:blur="isFocus = false"
						 autocomplete="off" />

			<ul class="dropdown-menu w-auto bg-dark m-0 p-0 transition" 
					v-if="isFocus"
					:class="result.city_name.length > 0 || result.country_name.length > 0 && isFocus ? 'show' : ''">

				<li v-for="x in result.city_name.slice(0, 4)" 
						v-on:click="searchInput = x.city_name;"
						v-on:mousedown.prevent="isFocus = true" 
						class="searchresult d-flex m-0 p-0 rounded-2 p-3 ">

					<p class="text-white-50 fs-5">{{ x.country_name }}, &nbsp;</p>
					<p class="text-white fs-5">{{ x.city_name }}</p>
				</li>

				<li v-for="y in result.country_name.slice(0, 2)" 
						v-on:click="searchInput = y;"
						v-on:mousedown.prevent="isFocus = true" 
						class="searchresult d-flex m-0 p-0 rounded-2 p-3 ">
					<p class="text-white fs-5">{{ y }}</p>
				</li>
			</ul>
		</div>
	</form>
</template>

<style scoped>
input[type="search"]{
	outline: none !important;
}

.searchresult { 
	opacity: 0; 
	transform: translateY(8px); 
	animation: fadeInUp 0.70s ease forwards;
	} 

@keyframes fadeInUp {
	 to { opacity: 1; 
	 			transform: translateY(0); 
			} 		
		}
</style>	