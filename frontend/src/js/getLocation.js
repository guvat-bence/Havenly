import axios from "axios"
import { ref, watch } from "vue"
export let searchInput = ref("")
export let activeLocations = ref([])

watch(activeLocations, (value) => activeLocations.value = value)