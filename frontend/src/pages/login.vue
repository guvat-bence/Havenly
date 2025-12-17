<template>
  <div class="d-flex justify-content-center align-items-center">
    <form class="border p-3 border-1 border-white text-white rounded-3 bg-dark bg-opacity-50">
      <div>
        <h1 class="text-center text-white display-5">Bejelentkezés</h1>
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
        Bejelentkezés
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