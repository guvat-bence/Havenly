<script setup>
let accommodations = [
	{
		name: "Szállások",
		path: "../src/image/image.png"
	},
    {
		name: "Szállások",
		path: "../src/image/image.png"
	},
    {
		name: "Szállások",
		path: "../src/image/image.png"
	},
    {
		name: "Szállások",
		path: "../src/image/image.png"
	},
    {
		name: "Szállások",
		path: "../src/image/image.png"
	},
    {
		name: "Szállások",
		path: "../src/image/image.png"
	},
    {
		name: "Szállások",
		path: "../src/image/image.png"
	},
    {
		name: "Szállások",
		path: "../src/image/image.png"
	},
    {
		name: "Szállások",
		path: "../src/image/image.png"
	},
    {
		name: "Szállások",
		path: "../src/image/image.png"
	},
    {
		name: "Szállások",
		path: "../src/image/image.png"
	},
    {
		name: "Szállások",
		path: "../src/image/image.png"
	},
];
</script>
<template>
    <div class="container">
        <div class="row justify-content-center mt-5">
            <div v-for="x in accommodations" 
                 class="card mx-2 my-2 text-nowrap 
                        col-8 col-sm-6 col-md-4 col-lg-3 col-xl-2 col-xxl-2">
                <img :src="x.path" class="bg-dark mx-auto col-12">
            </div>
        </div>
    </div>
</template>