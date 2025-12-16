<script setup>
import Cards from '@/components/cards.vue';

</script>

<template>
  <h1 class="display-1 text-center text-white">Szállások</h1>
  <Cards tableName="accommodations" 
         :country="1"/>
</template>