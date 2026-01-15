import About from '@/pages/about.vue'
import aboutus from '@/pages/about_us.vue'
import Accommodation from '@/pages/accommodation.vue'
import Data_protection from '@/pages/data_protection.vue'
import Experience from '@/pages/experience.vue'
import Home from '@/pages/home.vue'
import Login from '@/pages/login.vue'
import Logoutconfirmation from '@/pages/logoutconfirmation.vue'
import Proifle from '@/pages/proifle.vue'
import Register from '@/pages/register.vue'
import Settings from '@/pages/settings.vue'
import Term_of_use from '@/pages/term_of_use.vue'
import { user } from '@/store/user'
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
  },
  {
    name: "about",
    path: "/about/:table_name:/:id/:name",
    component: About,
    props:true
  },
  {
    path: "/settings",
    component: Settings
  },
  {
    path: "/profile",
    component: Proifle
  },
  {
    path: "/logout",
    component: Logoutconfirmation
  }
]
const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes
})

export default router
