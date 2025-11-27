import Accommodation from '@/pages/accommodation.vue'
import Home from '@/pages/home.vue'
import { createRouter, createWebHistory } from 'vue-router'
let routes = [
  {
    path: "/",
    component: Home 
  },
  {
    path: "/accommodation",
    component: Accommodation
  }
]
const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes
})

export default router
