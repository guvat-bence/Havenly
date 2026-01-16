<script setup>
import { user } from '@/store/user';
import axios from 'axios';
import { ref } from 'vue';
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
 	authentication=[
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
			name:  user.lasttname + " " + user.firstname,
			path: "/profile",	 
		}
	]
	
	let searchInput = ref(""),
			searchInDB = (value) => {
				axios.post('',)
			}
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
				<form class="d-flex" 
							role="search"
							name="searchbar"
							v-if="$route.fullPath !== '/'" >
					<input class="form-control me-2" 
								 type="search" 
								 id="searchinput"
								 placeholder="Search" 
								 aria-label="Search"
								 v-on:input="searchInDB(searchInput)"
								 v-model="searchInput"/>
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