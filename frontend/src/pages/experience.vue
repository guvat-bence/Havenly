<script setup>

import { ref, onMounted } from 'vue';
import axios from 'axios';

const experiences = ref([]);

onMounted(()=>
{
	axios.get("http://localhost:3000/experiences")
		.then(response => 
		{
			experiences.value = response.data
		})
		.catch(error=>{console.error(error)})

})
</script>
<template>
    <div class="container">
        <div class="row justify-content-center mt-5">
            <div v-for="x in experiences" 
                 class="card mx-2 my-2 
                        col-8 col-sm-6 col-md-4 col-lg-3 col-xl-3 col-xxl-3">
                <!-- <img :src="x.path" class="bg-dark mx-auto col-12"> -->
								 <div class="card-body  col-12">
									<p class="text-center">{{x.name}}</p>
								</div>
            </div>
        </div>
    </div>
</template>