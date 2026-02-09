<script setup>
import { rent } from '@/store/current_rent';

console.log(rent);
</script>
<template>
  <div class="container">
    <h1 class="display-1 text-center text-center text-white">Kosár</h1>

    <div class="row">
      <button class="btn btn-outline-light mx-auto w-auto mb-5 mt-3" 
              type="button" 
              data-bs-toggle="collapse"
              data-bs-target="#billingCollapse" aria-expanded="false" aria-controls="billingCollapse">
        Számlázási adatok
      </button>

      <div class="collapse" id="billingCollapse">
        <div class="card bg-transparent text-white border-white text-black card-body">
          <form>
            <!-- LABEL SOR -->
            <div class="row mb-3">
              <div class="col-4">
                <label for="InputFirstName" class="form-label">Keresztnév:</label>
              </div>
              <div class="col-4">
                <label for="InputLastName" class="form-label">Vezetéknév:</label>
              </div>

              <div class="col-4">
                <label for="InputLastName" class="form-label">Másodiknév:</label>
              </div>
            </div>

            <!-- INPUT SOR -->
            <div class="row mb-3">
              <div class="col-4">
                <input type="text" class="bg-transparent border-0 border-bottom text-white w-100" id="InputFirstName"
                  placeholder="Keresztnév">
              </div>

              <div class="col-4">
                <input type="text" class="bg-transparent border-0 border-bottom text-white w-100" id="InputLastName"
                  placeholder="Vezetéknév">
              </div>

              <div class="col-4">
                <input type="text" class="bg-transparent border-0 border-bottom text-white w-100" id="InputMiddleName"
                  placeholder="Másodiknév">
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>
<style>
input {
  outline: none;
}
</style>