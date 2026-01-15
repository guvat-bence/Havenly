<script setup>
import router from '@/router';
import { user } from '@/store/user';
// Ha nincs bejelentkezve a felhasználó dobja vissza az előző oldalra
// if(!user.id)
// 	router.back()


	let logout = () => {
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
		router.push("/")
	},
	cancle = () => {
		router.back()

	}
</script>

<template>
	<div class="logout">
			<div class="text-white justify-content-center text-center 
									border border-1 border-white 
									mx-auto w-50 rounded-4 
									p-1 d-flex flex-column">
				<h6 class="display-6 mb-5">Biztos ki szeretnél jelentkezni?</h6>
				
				<div class="mt-auto">
					<button class="btn mx-5 btn-primary"
									v-on:click="cancle()">
						Mégsem
					</button>

					<button class="btn mx-5 btn-primary"
									v-on:click="logout()">
						Kijelentkezés
					</button>
				</div>
			</div>
	</div>
</template>