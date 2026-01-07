<template>
  <!-- Footer -->
  <footer class="bg-dark">
    <div class="row text-white text-center 
                justify-content-center mt-2 mx-3">

      <!-- Bal oldali rész -->
      <section class="col-12 col-sm-6 col-md-4 col-lg-4 
                     col-xl-3 col-xxl-3 text-white mb-5 mb-sm-4 mb-md-0">
        <!-- Cím -->

        <h3>Gyors elérések:</h3>

        <!-- Fő oldal elérése -->
        <router-link class="nav-link mb-2 mt-md-3" 
                    to="/"> 
          Főoldal 
        </router-link>

        <!-- Rólunk oldal elérése -->
        <router-link class="nav-link mb-2 mt-md-3" 
                     to="/aboutus"> 
          Rólunk 
        </router-link>

        <!-- Szállások oldal elérése -->
        <router-link class="nav-link mb-2 mt-md-3" 
                     to="/accommodation"> 
          Szállások
        </router-link>

        <!-- Élmények oldal elérése -->
        <router-link class="nav-link mb-2 mt-md-3" 
                     to="/experience"> 
          Élmények
        </router-link>
      </section>
      <!-- Középső rész -->
      <section class="col-12 col-sm-6 col-md-4 
                      col-lg-4 col-xl-6 col-xxl-6 mb-5 mb-sm-4 mb-md-0">
        <!-- Cím -->
        <h3>Havenly</h3>

        <!-- Mottó -->
        <p class="mt-4 mb-sm-3 mb-md-4 mb-lg-5">
          "-Az élmények határtalanok, az otthon érzése pedig mindig veled tart."
        </p>
        <!-- Adatvédelmi oldal -->
        <a class="nav-link mt-1 mt-sm-2 mt-lg-4" href="/data_protection">Adatvédelem</a>
        <!-- Felhasználói feltételek -->
        <a class="nav-link mt-1 mt-sm-2 mt-lg-4" href="/term_of_use">Felhasználói feltételek</a>
      </section>

      <!-- Jobb oldali rész -->
      <section class="col-12 col-sm-6 col-md-4 col-lg-4 col-xl-3 col-xxl-3 ">

        <!-- Cím -->
        <h3>Elérhetőségeink:</h3>

        <!-- Email cím -->
        <a class="nav-link mb-1 mb-1 mt-md-3" 
           href="mailto:guvat.bence-2021@keri.mako.hu">
            <font-awesome-icon icon="fa-solid fa-envelope" size="xl"/>
             havenly@gmail.com
        </a>

        <!-- Telefonszám -->
        <a class="nav-link mb-1 mb-1 mt-md-3" 
           href="tel:+36304583453">
            <font-awesome-icon icon="fa-solid fa-phone" size="xl"/> 
             +36303425678
        </a>

        <!-- Cím -->
        <a class="nav-link mb-1 mb-1 mt-md-3" 
           href="https://www.google.com/maps/@46.9096969,19.683835,3a,75y,47.16h,89.48t/data=!3m7!1e1!3m5!1sJGuIwHNr92f18NEz_5t74A!2e0!6shttps:%2F%2Fstreetviewpixels-pa.googleapis.com%2Fv1%2Fthumbnail%3Fcb_client%3Dmaps_sv.tactile%26w%3D900%26h%3D600%26pitch%3D0.5193384297109134%26panoid%3DJGuIwHNr92f18NEz_5t74A%26yaw%3D47.15601703953956!7i16384!8i8192?entry=ttu&g_ep=EgoyMDI1MTIwOS4wIKXMDSoKLDEwMDc5MjA2OUgBUAM%3D">
            <font-awesome-icon icon="fa-solid fa-location-dot" size="xl"/>
             Kecskemét, József Attila u. 5
        </a>
        <!-- Social Media -->
        <div class="d-flex justify-content-center align-items-center mt-4">

          <!-- Facebook -->
          <a class="nav-link" 
             href="">
              <font-awesome-icon icon="fa-brands fa-square-facebook" size="xl"/>
            </a>

          <!-- Instagram -->
          <a class="nav-link"
             href="">
              <font-awesome-icon icon="fa-brands fa-instagram" size="xl"/>
          </a>

          <!-- Twitter -->
          <a class="nav-link" 
             href="">
              <font-awesome-icon icon="fa-brands fa-x-twitter" size="xl"/>
          </a>
        </div>
      </section>

      <!-- Legalja -->
      <section class="col-12">
        <hr>
        <!-- Copyright -->
        <p><span>&copy; 2025-2026 Havenly</span></p>
      </section>
    </div>
  </footer>
</template>