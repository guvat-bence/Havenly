import aboutus from '@/pages/about_us.vue'
import Accommodation from '@/pages/accommodation.vue'
import Data_protection from '@/pages/data_protection.vue'
import Experience from '@/pages/experience.vue'
import Home from '@/pages/home.vue'
import Login from '@/pages/login.vue'
import Register from '@/pages/register.vue'
import Term_of_use from '@/pages/term_of_use.vue'
import { createRouter, createWebHistory } from 'vue-router'
let routes = [
  {
    path: "/",
    component: Home 
  },
  {
    path: "/aboutus",
    component: aboutus
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
  },
  {
    path: "/data_protection",
    component: Data_protection
  },
  {
    path: "/term_of_use",
    component: Term_of_use
  }
]
const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes
})

export default router
