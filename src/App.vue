<template>
  <div>
    <header>
      <nav class="navbar">
        <div class="navbar-brand">
          <span class="navbar-logo">Telecom Shop</span>
        </div>
        <div class="navbar-menu">
          <router-link to="/" class="navbar-item">Home</router-link>
          <!-- <router-link to="/cart" class="navbar-item">
            Cart <span class="cart-badge">{{ cartItemsCount }}</span>
          </router-link> -->
        </div>
      </nav>
    </header>
    <main>
      <router-view></router-view>

    </main>
  </div>
</template>

<script>
import { store } from './state/store.js'

export default {
  computed: {
    cartItemsCount() {
      return store.cartItems.length;
    },
  },
};
</script>

<style>
/* Navbar styles */
.navbar {
  background-color: #333;
  color: white;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 20px;
}

.navbar-logo {
  font-size: 24px;
  font-weight: bold;
}

.navbar-item {
  color: white;
  text-decoration: none;
  margin-left: 20px;
  position: relative;
}

.cart-badge {
  background-color: #007bff;
  color: white;
  font-size: 12px;
  padding: 4px 8px;
  border-radius: 50%;
  position: absolute;
  top: -8px;
  right: -8px;
}

/* Other styles... */
</style>
