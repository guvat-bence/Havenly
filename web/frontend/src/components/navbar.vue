<script setup>
import { user } from '@/store/user';
import {computed} from 'vue';
import { useI18n } from 'vue-i18n'

const { t } = useI18n();

// A navbar elemek deifiniálása
let mainRoutes = computed(()=>( [
	{
		name: t('navbar.accommodations'),
		path: "/accommodation"
	},
	{
		name: t('navbar.experiences'),
		path: "/experience"
	},
	{
		name: t("navbar.about_us"),
		path: "/aboutus"
	}
]));

let	authentication = computed(()=>([
		{
			name: t("navbar.registration"),
			path: "/register",
			icon:"fa-solid fa-user-plus fa-lg"
		},
		{
			name: t("navbar.login"),
			path: "/login",
			icon:"fa-solid fa-user-check fa-lg"
		}
]));

let	account = [
		{
			name : (`${user.firstname}${user.middlename!="null"?' '+user.middlename+' ':" "}${user.lasttname}`),
			path: "/profile",
		}
];

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

				<!-- Bejelentkezés/regisztráció -->
				<ul class="navbar-nav ms-auto">
					<li v-for="y in authentication" 
							v-if="!user.id"
							class="nav-item">

						<router-link :to="y.path" 
												 class="nav-link">
							<i :class="y.icon"></i>
							{{ y.name }}
						</router-link>
					</li>	

					<!-- Beállítások -->
					<li class="nav-item">
						<router-link 	to="/settings"
													class="nav-link">
							<i class="fa-solid fa-gears fa-lg"></i>
							{{ $t("navbar.settings") }}
						</router-link>
					</li>

					<!-- Fiók -->
					<li v-for="y in account" 
							v-if="user.id"
							class="nav-item">

						<router-link :to="y.path" 
												 class="nav-link"
												 key="users">
							<i class="fa-solid fa-circle-user fa-lg"></i>
							{{ y.name }}
						</router-link>
					</li>

					<!-- Kijelentkezés -->
					<router-link class="nav-link"
											 v-if="user.id"
											 to="/logout">
						<i class="fa-solid fa-arrow-right-from-bracket fa-lg"></i>
						{{ $t("navbar.logout") }}
					</router-link>
				</ul>
			</div>
		</div>
	</nav>
</template>
<style scoped>
	
.searchinput:hover{
	background-color: white !important;
	box-shadow: 0px 0px 10px white !important;
	transition: 200ms;
	color: black !important;
}
</style>