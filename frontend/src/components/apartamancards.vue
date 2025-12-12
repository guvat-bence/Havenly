<script setup>
import axios from 'axios';
import { ref, onMounted } from 'vue';

const items = ref([]);

onMounted(() => {
  axios.get('http://localhost:3000/apartmans')
    .then(response => {
      items.value = response.data;
    })
    .catch(e => console.error(e));
});
</script>

<template>
  <div class="row row-cols-1 row-cols-md-3 g-4">
    <div class="col" 
         v-for="value in items" 
         :key="value.id">
      <div class="card text-white h-100 border-light bg-transparent">
        <img src="../image/fff.png" 
             class="card-img-top" 
             :alt="value.apartman_name">

        <div class="card-body">
          <h5 class="card-title text-center">
            {{ value.apartman_name }}
          </h5>
          <p class="card-text">
            {{ value.description }}
          </p>
          <button class="btn btn-outline-light 
                         col-11 my-2 mt-3 
                         mx-auto d-block">
                         Érdekel
          </button>
        </div>
        <div class="card-footer">
          <small></small>
        </div>
      </div>
    </div>
  </div>
</template>
