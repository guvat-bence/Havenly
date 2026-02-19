<script setup>
    import { user } from '@/store/user';
    import router from '@/router';

    //securityCheck
if(!user.id)
  router.back()
</script>
<template>
  <div class="account">
    <div class="container">
      <nav>
        <div class="nav nav-tabs justify-content-center" 
             id="nav-tab" 
             role="tablist">
          <button class="nav-link active"
                  id="nav-home-tab"
                  data-bs-toggle="tab"
                  data-bs-target="#nav-home"
                  type="button" role="tab"
                  aria-controls="nav-home"
                  aria-selected="true">
            Adataim
          </button>
          <button class="nav-link" 
                  id="nav-profile-tab" 
                  data-bs-toggle="tab" 
                  data-bs-target="#nav-profile" 
                  type="button" role="tab" 
                  aria-controls="nav-profile" 
                  aria-selected="false">
            Közzétételeim
          </button>
          <button class="nav-link" 
                  id="nav-contact-tab" 
                  data-bs-toggle="tab" 
                  data-bs-target="#nav-contact" 
                  type="button" 
                  role="tab" 
                  aria-controls="nav-contact" 
                  aria-selected="false">
            Beszégetéseim
          </button>
        </div>
      </nav>

      <div class="tab-content text-white justify-content-center
                  text-center bg-dark py-4 rounded-2" 
            id="nav-tabContent">
        <div class="tab-pane fade show active"
             id="nav-home" 
             role="tabpanel" 
             aria-labelledby="nav-home-tab" 
             tabindex="0">
          Lorem ipsum dolor sit amet, consectetur adipisicing elit. Optio quas, deleniti expedita eos, possimus fuga rem quos totam nam, quaerat quisquam obcaecati illo? Quia eligendi nulla architecto, aliquid unde sed?
        </div>
        <div class="tab-pane fade" 
             id="nav-profile" 
             role="tabpanel" 
             aria-labelledby="nav-profile-tab" 
             tabindex="0">
          Lorem ipsum dolor sit amet consectetur adipisicing elit. Dolores cumque excepturi nemo odio qui. Quam magni odio debitis eius temporibus ex natus, alias doloribus veritatis, quasi eligendi, ratione nulla voluptates.
        </div>
        <div class="tab-pane fade"
             id="nav-contact" 
             role="tabpanel" 
             aria-labelledby="nav-contact-tab" 
             tabindex="0">
          Lorem ipsum dolor sit amet consectetur adipisicing elit. Rerum laudantium, est qui voluptate sint tempore quasi ipsa repellendus esse mollitia quos velit fugit voluptas, perferendis, quas blanditiis neque. Optio, sit?
        </div>
        <div class="tab-pane fade"
             id="nav-disabled"
             role="tabpanel" 
             aria-labelledby="nav-disabled-tab" 
             tabindex="0">
          Lorem, ipsum dolor sit amet consectetur adipisicing elit. Inventore modi corrupti veniam ab eaque doloremque, id sint expedita at dolorum soluta doloribus impedit eius voluptates tempore mollitia molestias. Ut, reprehenderit?
        </div>
      </div>
    </div>
  </div>
</template>
<style scoped>
.nav-tabs {
    --bs-nav-tabs-link-active-color: black;
}

.nav-link {
    --bs-nav-link-color:rgb(149, 158, 152);
    --bs-nav-link-hover-color: white;
}
</style>