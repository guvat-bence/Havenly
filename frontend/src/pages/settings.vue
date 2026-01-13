<script setup>
import { selectedCurrency } from '@/store/currency';
import axios from 'axios';
import { reactive,ref } from 'vue';
let currencys = ref([]),
		setCurrency = () => {
			selectedCurrency.currencyID = currencys.value.id
			selectedCurrency.currencyMultiplier = currencys.value.multiplier
			selectedCurrency.currencyName = currencys.value.name
			selectedCurrency.currencyShortedName = currencys.value.shorted_name
		}

axios.get('http://localhost:3000/getCurrency')	
.then(response => {
	currencys.value = response.data
	console.log(response.data)
})
.catch(e => console.error(e))
</script>

<template>
	<div class="settings text-center">
		<div>
			<h1 class="display-1 text-center text-white">Beállítások</h1>
		</div>

		<div class="row text-white border border-white 
								border-1 mx-5 rounded-3">
			<h1 class="display-4">Nyelv választás</h1>

			<select class="form-select bg-dark text-white 
										 my-2 w-auto text-center mx-auto"
							v-on:change="setCurrency()">
				<option selected 
								value='0'> 
								Euro 
				</option>

				<option v-for="x in currencys" 
								:value="x.id">
						{{ x.name}}
				</option>
			</select>
		</div>
	</div>
</template>