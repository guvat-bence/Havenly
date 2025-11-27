<script setup>
let routes = [
	{
		name: "Szállások",
		path: "/accommodation"
	}
];
</script>

<template>
	<nav class="navbar navbar-expand-md bg-body-tertiary" 
			 data-bs-theme="dark">
		<div class="container-fluid">
			<img style="height: 48px;" 
					 class="navbar-brand d-inline-block align-text-top" 
					 src="../image/image.png" 
					 alt="havenly_icon">

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
					 id="navbarSupportedContenet">
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