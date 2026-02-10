<script setup>
import { selectedCurrency } from '@/store/currency';
import axios from 'axios';
import { reactive,ref } from 'vue';
import languages from "@/json/languages.json"
import { useI18n } from 'vue-i18n';

const {locale} = useI18n();


let currentLanguage = ref("");

for(let x in languages)
{
	if(x == locale.value)
	{
		currentLanguage.value = languages[x];
		console.log(currentLanguage.value);
		break;
	}
}

let currencyOption = ref(selectedCurrency)
let currencys = ref([]),
		//Definiálom a 'setCurrency' metódust
		setCurrency = () => {
			// Megváltoztatjuk a selectedCurrency értékeit
			// Ha megváltozik akkor a localstorage-ba elementi az értékeket(store/currency.js)
			selectedCurrency.currencyID = currencyOption.value.id;
			selectedCurrency.currencyMultiplier = currencyOption.value.multiplier;
			selectedCurrency.currencyName = currencyOption.value.full_name;
			selectedCurrency.currencyShortedName = currencyOption.value.shorted_name;
		};

axios.get('http://localhost:3000/getCurrency')	
.then(response => {
	currencys.value = response.data
})
.catch(e => console.error(e))



function setLanguage()
{
	console.log((currentLanguage.value.short_name).toLowerCase());

	locale.value = (currentLanguage.value.short_name).toLowerCase();
}

</script>

<template>
	<div class="settings text-center w-auto mx-auto">

		<!-- Főcím -->
		<div>
			<h1 class="display-1 text-center text-white">{{ $t("settings.settings") }}</h1>
		</div>

		<!-- Nyelv választó menüpont -->
		<div class="row text-white border border-white 
								border-1 mx-5 my-5 rounded-3">
			
			<!-- Cím -->
			<h1 class="display-4">{{ $t("settings.language_choose") }}</h1>

			<!-- Select -->
			<select class="form-select bg-dark text-white 
										 my-2 w-auto text-center mx-auto"
							v-on:change="setLanguage(x)"
							v-model="currentLanguage"
							id="languageSelector">

				<!-- Frissítés esetén írja a kiválaszott language-t -->
				<option selected 
								:value="currentLanguage"
								disabled> 
					{{currentLanguage.short_name}} {{ currentLanguage.full_name }}
				</option>
				<!-- Választékok a currencyk közül -->
				<option v-for="x in languages" 
								:value="x">
						{{ x.short_name}} {{ x.full_name}}
				</option>
			</select>
		</div>

		<!-- Valuta választó menüpont -->
		<div class="row text-white border border-white 
								border-1 mx-5 rounded-3">
			
			<!-- Cím -->
			<h1 class="display-4">{{ $t("settings.currency_choose") }}</h1>

			<!-- Select -->
			<select class="form-select bg-dark text-white 
										 my-2 w-auto text-center mx-auto"
							v-on:change="setCurrency()"
							v-model="currencyOption"
							id="currencySelector">

				<!-- Frissítés esetén írja a kiválaszott currency-t -->
				<option selected 
								:value="selectedCurrency"
								disabled> 
								{{selectedCurrency.currencyName}}
				</option>
				<!-- Választékok a currencyk közül -->
				<option v-for="x in currencys" 
								:value="x">
						{{ x.full_name}}
				</option>
			</select>
		</div>
	</div>
</template>