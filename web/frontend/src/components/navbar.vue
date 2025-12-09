<script setup>
let routes = [
	{
		name: "Rólunk",
		path: "/"
	},
	{
		name: "Szállások",
		path: "/accommodation"
	},
	{
		name: "Élmények",
		path: "/experience"
	},
	{
		name: "Regisztráció",
		path: "/register"
	},
	{
		name: "Bejelentkezés",
		path: "/login"
	}
];
</script>

<template>
	<nav class="navbar navbar-expand-md bg-black" 
			 data-bs-theme="dark">
		<div class="container-fluid">
			<router-link to="/">			
				<img style="height: 48px;" 
					 	 class="navbar-brand d-inline-block align-text-top" 
					 	 src="../image/image.png" 
					 	 alt="havenly_icon">
			</router-link>

			<button class="navbar-toggler" 
							type="button" 
							data-bs-toggle="collapse" 
							data-bs-target="#navbarSupportedContent"
							aria-controls="navbarSupportedContent" 
							aria-expanded="false" 
							aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" 
					 id="navbarSupportedContent">
				<ul class="navbar-nav me-auto">

					<li v-for="x in routes" 
							class="nav-item">

						<router-link :to="x.path" 
												 class="nav-link">
							{{ x.name }}
						</router-link>
					</li>
				</ul>
			</div>
		</div>
	</nav>
</template>