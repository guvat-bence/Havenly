const { reactive, watch } = require("vue");

export let selectedCurrency = reactive(
	{
		currencyID: localStorage.getItem('currencyID') ?? null,
		currencyName: localStorage.getItem('currencyName') ?? 'Euro',
		currencyMultiplier: localStorage.getItem('currencyMultiplier') ?? 1,
		currencyShortedName: localStorage.getItem('currencyShortedName') ?? 'EUR' 
	}
)

watch(selectedCurrency,(value) => {
	localStorage.setItem('currencyID',value.id)
	localStorage.setItem('currencyName',value.name)
	localStorage.setItem('currencyMultiplier',value.multiplier)
	localStorage.setItem('currencyShortedName',value.shorted_name)
})