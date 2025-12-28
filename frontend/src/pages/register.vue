<template>

  <div class="d-flex justify-content-center mt-4 mb-4">
    <div class="progress w-50 bg-black border border-1 border-white" 
       role="progressbar" 
       aria-label="Animated striped example" 
       aria-valuenow="0" 
       aria-valuemin="0" 
       aria-valuemax="100">
      <div class="progress-bar progress-bar-striped progress-bar-animated bg-white" style="width: 0%"></div>
    </div>
  </div>

  <div class="d-flex justify-content-center align-items-center">

    <form class="border p-3 border-1 border-white text-white rounded-3 bg-dark bg-opacity-50 mb-3">
      <div>
        <h1 class="text-center text-white display-5">Regisztráció</h1>
      </div>
      <div class="mb-3">
        <div class="form-label text-white d-flex gap-1">
            <span>Teljesnév:</span>
            <span class="text-danger">*</span>
        </div>

        <div class="row">
          <div class="col-xxl-4 col-lg-4 col-md-4 col-sm-4 col-12 p-1">
            <input type="email" 
                   class="form-control bg-transparent text-white" 
                   id="lastName">
            <div class="form-text text-white text-center 
                        d-flex justify-content-center align-items-center 
                        gap-1">
              <label for="lastName">
                <span>vezetéknév</span>
                <span class="text-danger">*</span>
              </label>
            </div>
          </div>

          <div class="col-xxl-4 col-lg-4 col-md-4 col-sm-4 col-12 p-1">
            <input type="email" 
                   class="form-control bg-transparent text-white" 
                   id="firstName">
            <div class="form-text text-white text-center 
                        d-flex justify-content-center align-items-center 
                        gap-1">
              <label for="firstName">
                <span>keresztnév</span>
                <span class="text-danger">*</span>
              </label>
            </div>
          </div>

          <div class="col-xxl-4 col-lg-4 col-md-4 col-sm-4 col-12 p-1">
            <input type="email" 
                   class="form-control bg-transparent text-white" 
                   id="middleName">
            <div class="form-text text-white text-center 
                        d-flex justify-content-center align-items-center 
                        gap-1">
              <label for="middleName">
                <span>harmadiknév</span>
              </label>
            </div>
          </div>

        </div>

      </div>
      <div class="mb-3">
        <label for="InputEmail1" 
               class="form-label">
          <span>Email</span>
          <span class="text-danger">*</span>
        </label>
        <input type="email" 
               class="form-control bg-transparent text-white" 
               id="InputEmail1" 
               aria-describedby="emailHelp">
      </div>

      <div class="mb-3">
        <label for="phoneNumber" 
               class="form-label">
          <span>Telefonszám</span>
          <span class="text-danger">*</span>
        </label>
        <input type="email" 
               class="form-control bg-transparent text-white" 
               id="phoneNumber">
      </div>

      <div class="mb-3 my-3">
        <label for="InputPassword1" 
               class="form-label">
          <span>Jelszó</span>
          <span class="text-danger">*</span>
        </label>
        <input type="password" 
               class="form-control bg-transparent text-white"  
               id="InputPassword1">
      </div>

      <button type="submit" 
              class="btn btn-outline-light 
                     text-center rounded-3 w-100
                     w-auto d-block mx-auto ">
        Regisztráció
      </button>
    </form>
  </div>
</template>

<style scoped>
input:focus,input:hover,input::after{
  background-color: white !important;
  box-shadow: 0px 0px 10px white !important;
  transition: 200ms;
  color: black !important;
}
</style>