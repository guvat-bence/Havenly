<script setup>
import axios from 'axios';
import { onMounted, ref } from 'vue';

let items = ref([])

onMounted(() => {
  axios.get('http://localhost:3000/accommodations')
    .then(response => {
      items.value = response.data;
    })
    .catch(e => console.error(e));
});

</script>

<template>
  <div class="row justify-content-center cardhover">
    <div class="card mx-4 col-md-5 g-4 p-0 bg-transparent text-white border-white" 
				 style="width: 25rem;"
				 v-for="x in items">
      <div class="position-relative">
        <img src="../images/fff.jpg" class="card-img-top" alt="..." style="height: 200px; object-fit: cover;">
        <h5 class="card-title text-white position-absolute 
									 bottom-0 start-0 w-100 
									 text-center m-0 p-2 border fw-bold ">
					{{x.name}}
        </h5>
      </div>
      <div class="card-body">
        <p class="card-text w-100">
          {{ x.description }}
        </p>
        <a class=" d-block btn btn-outline-light mx-auto">Go somewhere</a>
      </div>
    </div>
  </div>
</template>

<style>
	.card:hover{
		box-shadow: 0px 0px 20px white;
		transform: translateY(-10px);
		transition: 200ms;
	}
</style>
