<script setup>
import axios from 'axios';
import { ref } from 'vue';

const props = defineProps(['id','name','table_name'])

let item = ref([]);

axios.get(`http://localhost:3000/${props.table_name}`)
	.then(datas=>{
		item.value = datas.data.filter(response=>
			{
				return response.id == props.id;
			})
	})
	.catch(error=>
	{
		console.error(error);
	})

function convertStrings(str) {  

  return str.normalize("NFD")
            .replace(/[\u0300-\u036f]/g, "")
            .replaceAll(" ","_")
            .toLowerCase();
}	
</script>
<template>
	<div class="about">
		<div class="container text-white" v-if="item.length>0">
			<div class="row justify-content-center">
				<h1 class="display-5 text-center">
					{{ item[0].name }}
    		</h1>
				<img height="700" :src="`/countries/${convertStrings(item[0].country_name)}
																/cities/${convertStrings(item[0].city_name)}
																/${props.table_name}/${convertStrings(item[0].folder_name)}/001.png`"

 						 class="my-5 card-img-top rounded-5">
				<p class=" text-center">
					{{ item[0].description }}
				</p>
			</div>
		</div>

	</div>
</template>