import { reactive,watch } from "vue"


export let selectedCurrency = reactive(
	{
		currencyID: localStorage.getItem('currencyID') ?? 1,
		currencyName: localStorage.getItem('currencyName') ?? 'Euro',
		currencyMultiplier: localStorage.getItem('currencyMultiplier') ?? 1,
		currencyShortedName: localStorage.getItem('currencyShortedName') ?? 'EUR' 
	}
)

watch(selectedCurrency,(value) => {
	localStorage.setItem('currencyID',value.currencyID)
	localStorage.setItem('currencyName',value.currencyName)
	localStorage.setItem('currencyMultiplier',value.currencyMultiplier)
	localStorage.setItem('currencyShortedName',value.currencyShortedName)
})