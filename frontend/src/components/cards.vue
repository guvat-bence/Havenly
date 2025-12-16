<script setup>
import axios from 'axios';
import { onMounted, ref } from 'vue';

let items = ref([]);

let props = defineProps({
	tableName: {
		type: String,
		required: true
	},
	country: {
		type: [String,Number],
		required: false
	}
})

onMounted(() =>{
	axios.get(`http://localhost:3000/${props.tableName}`)
	.then(response => {
		items.value = response.data;
	})
	.catch(e => console.error(e))
})
</script>

<template>
	<div class="row justify-content-center cardhover">
		<div class="card mx-4 col-md-5 g-4 p-0 
								bg-transparent text-white border-white
								rounded-4" 
				 v-for="x in items"
				 :key="x.id"
					v-show="x.country_id === props.country"
				 style="width: 21rem;">
			<div class="position-relative">
				<img src="../images/fff.png" class="card-img-top rounded-top-4" 
						 style="height: 200px; object-fit: cover;">
				<h5 class="card-title text-white position-absolute 
									 bottom-0 start-0 w-100 bg-dark bg-opacity-50 
									 text-center m-0 p-2 border fw-bold ">
					{{ x.name }}
				</h5>
			</div>
			<div class="card-body">
					<p class="card-text w-100">
					{{ x.description }}
					{{ x.country_id }}
					</p>
			</div>
			<div class="card-footer border-0">
				<button class="btn btn-outline-light w-100">Érdekel</button>
			</div>
		</div>
	</div>
</template>

<style>
.card:hover {
	box-shadow: 0px 0px 20px white;
	transform: translateY(-10px);
	transition: 200ms;
}
</style>