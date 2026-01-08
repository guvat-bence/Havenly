<script setup>
import { user } from '@/store/user';

let mainRoutes = [
	{
		name: "Rólunk",
		path: "/aboutus"
	},
	{
		name: "Szállások",
		path: "/accommodation"
	},
	{
		name: "Élmények",
		path: "/experience"
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
			path: "/account" 
		},
		{
			name: "Beállítások",
			path: "/settings"
		}
	],
	logout = () => {
		user.id = "";
		user.firstname = "";
		user.lasttname = "";
		user.middlename = "";
		user.phone_number = "";
		user.gender = "";
		user.user_type = "";
		user.cardNumber = "";
		user.expiration = "";
		user.cvv = "";
	} 
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
					<li v-for="y in authentication" 
							v-if="!user.id"
							class="nav-item">

						<router-link :to="y.path" 
												 class="nav-link">
							{{ y.name }}
						</router-link>
					</li>

										
					<li v-for="y in account" 
							v-if="user.id"
							class="nav-item">

						<router-link :to="y.path" 
												 class="nav-link">
							{{ y.name }}
						</router-link>
					</li>
					<button class="btn btn-outline-danger"
									v-if="user.id"
									v-on:click="logout()">
							Kijelentkezés
					</button>
				</ul>
			</div>
		</div>
	</nav>
</template>