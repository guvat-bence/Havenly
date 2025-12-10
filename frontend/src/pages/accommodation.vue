<script setup>

import { ref, onMounted } from 'vue';
import axios from 'axios';

const accommodations = ref([]);

onMounted(()=>
{
	axios.get("http://localhost:3000/apartmans")
		.then(response => 
		{
			accommodations.value = response.data
		})
		.catch(error=>{console.error(error)})
		
})
</script>
<template>
    <div class="container">
        <div class="row justify-content-center">
            <div v-for="x in accommodations" x:key="apartman_id" 
                 class="card mx-2 my-2 shadow
                        col-8 col-sm-6 col-md-4 col-lg-3 col-xl-3 col-xxl-3">
                <!-- <img :src="x.path" class="bg-dark mx-auto col-12"> -->
								<div class="card-body col-12">
									<p class="text-center">{{x.apartman_name}}</p>
								</div>
            </div>
        </div>
    </div>
</template>