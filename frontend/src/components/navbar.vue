<script setup>
let mainRoutes = [
	{
		name: "Szállások",
		path: "/accommodation"
	},
	{
		name: "Élmények",
		path: "/experience"
	},	
	// {
	// 	name: "Rólunk",
	// 	path: "/aboutus"
	// }
]
let sideRoutes=[
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
	<nav class="navbar navbar-expand-md bg-dark" 
			 data-bs-theme="dark">
		<div class="container-fluid">
			<router-link to="/">			
				<img style="height: 48px;" 
					 	 class="navbar-brand d-inline-block align-text-top" 
					 	 src="../images/image.png" 
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

					<li v-for="x in mainRoutes" 
							class="nav-item">

						<router-link :to="x.path" 
												 class="nav-link">
							{{ x.name }}
						</router-link>
					</li>
				</ul>
				<ul class="navbar-nav ms-auto">
					<li v-for="y in sideRoutes" 
							class="nav-item">

						<router-link :to="y.path" 
												 class="nav-link">
							{{ y.name }}
						</router-link>
					</li>
				</ul>
			</div>
		</div>
	</nav>
</template>