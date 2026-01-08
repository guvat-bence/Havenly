<script setup>
const props = defineProps(['id','name'])
</script>
<template>
	<div class="about">
		<h1 class="display-5 text-center text-white">
			{{ props.name }}
    </h1>
	</div>
</template>