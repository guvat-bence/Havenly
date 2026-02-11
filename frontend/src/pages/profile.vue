<script setup>
    import { user } from '@/store/user';
    import router from '@/router';

    //securityCheck
if(!user.id)
  router.back()
</script>
<template>
    <div class="account">
        
    </div>
</template>