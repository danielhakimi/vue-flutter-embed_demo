<template>
    <div class="product-list">
      <h2>Telecom Provider Products</h2>
      <ul>
        <li v-for="product in products" :key="product.id">
          <div class="product">
            <!-- <img :src="product.image" :alt="product.name" class="product-image" /> -->
            <div class="product-info">
              <h3>{{ product.name }}</h3>
              <p class="product-description">{{ product.description }}</p>
              <p class="product-price">{{ product.price }}</p>
              <button @click="addToCart(product)" :id="'add-to-cart-' + product.id">Add to Cart</button>
            </div>
          </div>
        </li>
      </ul>
      <HelloWorld msg="Hello Vue 3 + Vite + Flutter Web" />
    </div>
  </template>
  
  <script>
  import { store } from "../state/store.js";
  import HelloWorld from './HelloWorld.vue';

  export default {
    data() {
      return {
        products: [
          {
            id: 1,
            name: "SuperSpeed Internet",
            description: "Blazing fast internet with up to 1 Gbps speed.",
            price: 49.99,
            image: "path-to-image-1.jpg",
          },
          {
            id: 2,
            name: "Unlimited Talk & Text",
            description: "Stay connected with unlimited talk and text.",
            price: 19.99,
            image: "path-to-image-2.jpg",
          },
          {
            id: 3,
            name: "Entertainment Bundle",
            description: "TV channels, streaming services, and more.",
            price: 79.99,
            image: "path-to-image-3.jpg",
          },
          // Add more imaginative products here
        ],
      };
    },
    methods: {
      addToCart(product) {
        store.cartItems = [...store.cartItems, product];
        flutterAppState.showAlert(JSON.stringify(product));

      },
      
    },
    components: { HelloWorld }
  };
  </script>
  
  <style scoped>
  .product-list {
    padding: 20px;
  }
  
  .product {
    display: flex;
    align-items: flex-start;
    margin-bottom: 20px;
    border: 1px solid #ddd;
    padding: 10px;
    border-radius: 5px;
    box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
  }
  
  .product-image {
    width: 100px;
    height: auto;
    margin-right: 20px;
  }
  
  .product-info {
    flex: 1;
  }
  
  .product-description {
    color: #666;
    margin-bottom: 10px;
  }
  
  .product-price {
    font-weight: bold;
    color: #333;
  }
  
  button {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 5px 10px;
    cursor: pointer;
    border-radius: 5px;
  }
  
  @media (max-width: 600px) {
    .product {
      /* flex-direction: column;
      align-items: center; */
    }
  
    .product-image {
      margin-right: 0;
      margin-bottom: 10px;
    }
  }
  </style>
  