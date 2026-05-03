<script setup>
import router from '@/router';
import { user } from '@/store/user';
// Ha nincs bejelentkezve a felhasználó dobja vissza az előző oldalra
if(!user.id)
	router.back()


	let logout = () => {
		
	  localStorage.removeItem("id");
    localStorage.removeItem("first_name");
    localStorage.removeItem("last_name");
    localStorage.removeItem("middle_name");
    localStorage.removeItem("email");
    localStorage.removeItem("phone_number");
    localStorage.removeItem("gender");
    localStorage.removeItem("user_type");
    localStorage.removeItem("card_number");
    localStorage.removeItem("expiration");
    localStorage.removeItem("accommodation_full_price");
    localStorage.removeItem("rent_beginning");
    localStorage.removeItem("rent_end");
    localStorage.removeItem("accommodation_path");
    localStorage.removeItem("guests_number");
    localStorage.removeItem("accommodation");
    localStorage.removeItem("currencyID");
    localStorage.removeItem("currencyName");
    localStorage.removeItem("currencyMultiplier");
    localStorage.removeItem("currencyShortedName");
    localStorage.removeItem("locale_name");
    localStorage.removeItem("accommodation_full_price");
    localStorage.removeItem("rent_beginning");
    localStorage.removeItem("rent_end");
    localStorage.removeItem("accommodation_path");
    localStorage.removeItem("guests_number");
    localStorage.removeItem("accommodation");
    localStorage.removeItem("expirationYear");
    localStorage.removeItem("expirationMonth");

		router.push("/");
    location.reload();
	},
	cancel = () => {
		router.back()

	}
</script>

<template>
	<div class="logout">
			<div class="text-white justify-content-center text-center 
									border border-1 border-white 
									mx-auto w-50 rounded-4 
									p-1">
				<h6 class="display-6 mb-5">{{ $t("log_out.log_out") }}</h6>
				
				<div class="mt-auto">
					<button class="btn mx-5 my-3 btn-light"
									v-on:click="cancel()">
						<i class="fa-solid fa-arrow-rotate-left fa-lg"></i>
						{{ $t("log_out.no") }}
					</button>

					<button class="btn mx-5 my-3 btn-danger"
									v-on:click="logout()">
						<i class="fa-solid fa-arrow-right-from-bracket fa-lg"></i>
						{{ $t("log_out.yes") }}
					</button>
				</div>
			</div>
	</div>
</template>