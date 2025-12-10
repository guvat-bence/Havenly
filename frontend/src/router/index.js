import Abaut_us from '@/pages/abaut_us.vue'
import Accommodation from '@/pages/accommodation.vue'
import Experience from '@/pages/experience.vue'
import Home from '@/pages/home.vue'
import Login from '@/pages/login.vue'
import Register from '@/pages/register.vue'
import { createRouter, createWebHistory } from 'vue-router'
let routes = [
  {
    path: "/",
    component: Home 
  },
  {
    path: "/abaut_us",
    component: Abaut_us
  },
  {
    path: "/accommodation",
    component: Accommodation
  },
  {
    path: "/experience",
    component: Experience
  },
  {
    path: "/register",
    component: Register
  },
  {
    path: "/login",
    component: Login
  }
]
const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes
})

export default router
