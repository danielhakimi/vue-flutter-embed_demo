import ProductList from './components/ProductList.vue';
import Cart from './components/Cart.vue'; // Create Cart.vue component
import { createRouter, createWebHistory } from 'vue-router';

const router = createRouter({
    history: createWebHistory(),
    routes: [
        { path: '/', component: ProductList },
        { path: '/cart', component: Cart },
    ]
})

export default router;
