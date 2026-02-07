<template>
  <div class="about_us">
    <div class="container text-white">
      <div class="row justify-content-center">

        <!-- Cím -->
        <h1 class="display-1  text-center">
          {{ $t("about_us.about_us") }}
        </h1>

        <!-- Fő kép -->
        <div class="col-12 col-sm-12 col-md-12 
                    col-lg-10 col-xl-10 col-xxl-10">
						<img height="400"
								 src="../images/image3.png"
								 class="my-2 mx-2 card-img-top rounded-5 
                        border border-white border-5"
								 style="object-fit:cover">
				</div>

        <!-- tartalom div -->
        <div class="mt-3">

          <!--Kik vagyunk rész -->
          <h3>{{ $t("about_us.who_are_we") }}</h3>
          <p>{{ $t("about_us.who_are_we_text") }}</p>

          <!-- Fotók -->
          <div class="row justify-content-center mb-3">
            <!-- Máté fotó -->
            <div class="col-12 col-sm-12 col-md-6 col-lg-6 col-xl-6 col-xxl-6">
              <img height="400"
                  src="../images/image3.png"
                  class="my-2 mx-2 card-img-top rounded-5 border border-white border-5"
                  style="object-fit:cover">
            </div>

            <!-- Bence fotó -->
            <div class="col-12 col-sm-12 col-md-6 col-lg-6 col-xl-6 col-xxl-6">
              <img height="400"
                  src="../images/image3.png"
                  class="my-2 mx-2 card-img-top rounded-5 border border-white border-5"
                  style="object-fit:cover">
            </div>
          </div>

          <!-- A Havenly küldetése rész -->
          <h3>{{ $t("about_us.havenly_mission") }}</h3>
          <p>{{ $t("about_us.havenly_mission_text") }}</p>

          <!-- Mit kínál a Havenly a felhasználóknak rész -->
          <h3>{{ $t("about_us.havenly_offer_title") }}</h3>
          <p>{{ $t("about_us.havenly_offer_alt_title") }}</p>
          <!-- leírás listája -->
          <ul>
            <li>{{ $t("about_us.havenly_offer.first_offer") }}</li>
            <li>{{ $t("about_us.havenly_offer.second_offer") }}</li>
            <li>{{ $t("about_us.havenly_offer.third_offer") }}</li>
            <li>{{ $t("about_us.havenly_offer.fourth_offer") }}</li>
            <li>{{ $t("about_us.havenly_offer.fifth_offer") }}</li>
            <li>{{ $t("about_us.havenly_offer.sixth_offer") }}</li>
          </ul>
          
          <!--Foglalás és biztonság rész  -->
          <h3>{{ $t("about_us.booking_and_security_title") }}</h3>
          <p>{{ $t("about_us.booking_and_security_text") }}</p>

          <!-- Kapcsolattartás és kommunikáció rész -->
          <h3>{{ $t("about_us.contact_and_communication") }}</h3>
          <p>{{ $t("about_us.contact_and_communication_text") }}</p>

          <!-- Többnyelvűség és jövőkép rész  -->
          <h3>{{ $t("about_us.multilingualism_and_future_title") }}</h3>
          <p>{{ $t("about_us.multilingualism_and_future_text") }}</p>
        </div>
      </div>
    </div>
  </div>  
</template>