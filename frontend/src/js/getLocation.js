import axios from "axios"
import { reactive, ref, watch } from "vue"

export let activeLocations = ref([])
let getActiveLocations = () => {
  axios.get("http://localhost:3000/createLocationList")
    .then(response => {
     activeLocations.value = response.data
    })
    .catch(e => console.error(e))
}

getActiveLocations()

watch(activeLocations, (value) => activeLocations.value = value)