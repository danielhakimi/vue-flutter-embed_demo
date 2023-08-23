<template>
    <div>
        <h1>Cart</h1>
        <ul>
            <li v-for="item in cartItems" :key="item.id">
                {{ item.name }} - {{ item.price }}
            </li>
        </ul>
        <HelloWorld msg="Hello Vue 3 + Vite + Flutter Web" />
    </div>
</template>
  
<script>
import { store } from '../state/store.js'; // Adjust the path
import HelloWorld from './HelloWorld.vue';

export default {
    computed: {
        cartItems() {
            return store.cartItems; // Access cartItems state from the store
        },
    },
    components: { HelloWorld }
};
</script>
  
<style scoped>
/* Your styles */
</style>
  