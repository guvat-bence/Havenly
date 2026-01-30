<script setup lang="ts">
import { activeLocations, searchInput } from '@/js/getLocation';
import axios from 'axios';
import { ref } from 'vue';

let result = ref([]),
		isFocus = ref(false),
		//convertString függvény 
		convertStrings = (str) => {

			return str.normalize("NFD")
				.replace(/[\u0300-\u036f]/g, "")
				.replaceAll(" ", "_")
				.toLowerCase();

		},
		getActiveLocations = () => {
			axios.get(`http://localhost:3000/createLocationList`)
				.then(response => {
				 activeLocations.value = response.data
				})
				.catch(e => console.error(e))
		},

		//Search függvény
		search = (value) => {
			result.value = [];
			for (let index = 0; index < activeLocations.value.length; index++) {

				if ((convertStrings(activeLocations.value[index].city_name)).split(" ")
						.filter(x => x.includes(convertStrings(value))).length > 0) {

					result.value.push(activeLocations.value[index])
				}
			}
		}
		
		getActiveLocations()
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
						 placeholder="Keresés"
						 v-model="searchInput" 
						 v-on:input="search(searchInput)" 
						 v-on:focus="isFocus = true" 
						 v-on:blur="isFocus = false"
						 autocomplete="off" />

			<ul class="dropdown-menu w-auto bg-dark m-0 p-0 transition" 
					:class="result.length > 0 && isFocus ? 'show' : ''">

				<li v-for="x in result.slice(0, 6)" 
						v-on:click="searchInput = x.city_name;"
						v-on:mousedown.prevent="isFocus = true" 
						class="searchresult d-flex m-0 p-0 rounded-2 p-3 ">

					<p class="text-white-50 fs-5">{{ x.country_name }}, &nbsp;</p>
					<p class="text-white fs-5">{{ x.city_name }}</p>
				</li>
			</ul>
		</div>
	</form>
</template>

<style scoped>
input[type="search"]{
	outline: none !important;
}

.searchresult { opacity: 0; 
								transform: translateY(8px); 
								animation: fadeInUp 0.70s ease forwards; } 

@keyframes fadeInUp {
	 to { opacity: 1; 
	 			transform: translateY(0); 
			} 		
		}
</style>	