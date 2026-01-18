<script setup>
import { activeLocations } from '@/js/getLocation';
import { user } from '@/store/user';
import { faSearch } from '@fortawesome/free-solid-svg-icons';
import axios from 'axios';
import { reactive, ref, watch } from 'vue';
import { routerKey, useRoute } from 'vue-router';
// A navbar elemek deifiniálása
let mainRoutes = [
	{
		name: "Szállások",
		path: "/accommodation"
	},
	{
		name: "Élmények",
		path: "/experience"
	},
	{
		name: "Rólunk",
		path: "/aboutus"
	}
],
	authentication = [
		{
			name: "Regisztráció",
			path: "/register"
		},
		{
			name: "Bejelentkezés",
			path: "/login"
		}
	],
	account = [
		{
			name: user.lasttname + " " + user.firstname,
			path: "/profile",
		}
	],
	searchInput = ref(""),
	result = ref([]),
	isFocus = ref(false),
	convertStrings = (str) => {

		return str.normalize("NFD")
			.replace(/[\u0300-\u036f]/g, "")
			.replaceAll(" ", "_")
			.toLowerCase();

	},
	search = (value) => {
		result.value = [];
		for (let index = 0; index < activeLocations.value.length; index++) {

			if ((convertStrings(activeLocations.value[index].city_name)).split(" ")
				.filter(x => x.includes(convertStrings(value))).length > 0) {

				result.value.push(activeLocations.value[index])
			}
		}
	};

</script>

<template>
	<!-- Navbar -->
	<nav class="navbar navbar-expand-md bg-dark" 
			 data-bs-theme="dark">
		<div class="container-fluid">
			<!-- Home gomb -->
			<router-link to="/">			
				<img style="height: 48px;" 
					 	 class="navbar-brand d-inline-block align-text-top" 
					 	 src="../images/image.png" 
					 	 alt="havenly_icon">
			</router-link>
			<!-- Hamburger icon -->
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

					<!-- Routeok -->
					<li v-for="x in mainRoutes" 
							class="nav-item">

						<router-link :to="x.path" 
												 class="nav-link">
							{{ x.name }}
						</router-link>
					</li>
				</ul>

				<!-- Search bar -->
				<form class="d-flex position-relative" 
							role="search" 
							name="searchbar" 
							v-if="$route.fullPath === '/accommodation' ||
										$route.fullPath === '/experience'">
					<div>
						<input class="form-control me-2" 
									 type="search" 
									 id="searchinput" 
									 placeholder="Search" 
									 aria-label="Search"
									 v-model="searchInput"
									 v-on:input="search(searchInput)"
									 v-on:focus="isFocus = true"
									 v-on:blur="isFocus = false"
									 autocomplete="off"	/>

						<ul class="dropdown-menu w-100 m-0 p-0"
								:class="result.length > 0 && isFocus ? 'show' : ''">
							<li v-for="x in result"
									v-on:click="searchInput = x.city_name;"
									v-on:mousedown.prevent="isFocus = true"
									class="searchresult d-flex justify-content-between m-0 p-0 rounded-2">
								<p class="text-white">{{ x.city_name }}</p>
								<p class="text-white-50">{{ x.country_name }}</p>
							</li>
						</ul>
					</div>

					<button class="btn btn-outline-light mx-2" 
									type="button">
						<font-awesome-icon :icon="faSearch" size="l" />
					</button>
				</form>

				<!-- Bejelentkezés/regisztráció -->
				<ul class="navbar-nav ms-auto">
					<li v-for="y in authentication" 
							v-if="!user.id"
							class="nav-item">

						<router-link :to="y.path" 
												 class="nav-link">
							{{ y.name }}
						</router-link>
					</li>	

					<!-- Beállítások -->
					<li class="nav-item">
						<router-link 	to="/settings"
													class="nav-link">
							Beállítások
						</router-link>
					</li>

					<!-- Fiók -->
					<li v-for="y in account" 
							v-if="user.id"
							class="nav-item">

						<router-link :to="y.path" 
												 class="nav-link"
												 key="users">
							{{ y.name }}
						</router-link>
					</li>

					<!-- Kijelentkezés -->
					<router-link class="btn btn-outline-danger"
											 v-if="user.id"
											 to="/logout">
						Kijelentkezés
					</router-link>
				</ul>
			</div>
		</div>
	</nav>
</template>
<style>
	
#searchinput:hover{
	background-color: white !important;
	box-shadow: 0px 0px 10px white !important;
	transition: 200ms;
	color: black !important;
}
</style>