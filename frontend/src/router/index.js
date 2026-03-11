import About from '@/pages/about.vue'
import aboutus from '@/pages/about_us.vue'
import Accommodation from '@/pages/accommodation.vue'
import Basket from '@/pages/basket.vue'
import Data_protection from '@/pages/data_protection.vue'
import Experience from '@/pages/experience.vue'
import Home from '@/pages/home.vue'
import Login from '@/pages/login.vue'
import Logoutconfirmation from '@/pages/logoutconfirmation.vue'
import Proifle from '@/pages/profile.vue'
import Register from '@/pages/register.vue'
import Settings from '@/pages/settings.vue'
import Term_of_use from '@/pages/term_of_use.vue'
import { createRouter, createWebHistory } from 'vue-router'
let routes = [
  {
    path: "/havenly/",
    component: Home 
  },
  {
    path: "/havenly/aboutus",
    component: aboutus
  },
  {
    path: "/havenly/accommodation",
    component: Accommodation
  },
  {
    path: "/havenly/experience",
    component: Experience
  },
  {
    path: "/havenly/register",
    component: Register
  },
  {
    path: "/havenly/login",
    component: Login
  },
  {
    path: "/havenly/data_protection",
    component: Data_protection
  },
  {
    path: "/havenly/term_of_use",
    component: Term_of_use
  },
  {
    name: "about",
    path: "/havenly/about/:table_name:/:id/:name",
    component: About,
    props:true
  },
  {
    path: "/havenly/settings",
    component: Settings
  },
  {
    path: "/havenly/profile",
    component: Proifle
  },
  {
    path: "/havenly/logout",
    component: Logoutconfirmation
  },
  {
    path:"/havenly/basket",
    component: Basket
  }
]
const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes
})

export default router
