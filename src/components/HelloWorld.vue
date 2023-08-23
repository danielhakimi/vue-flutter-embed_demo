<script setup>

import { onMounted } from 'vue'
import { store } from '../state/store.js'
// Sets up a channel to JS-interop with Flutter

(function () {
  "use strict";
  // This function will be called from Flutter when it prepares the JS-interop.
  window._stateSet = function () {
    // window._stateSet = function () {
    //   console.log("Call _stateSet only once!");
    // };

    console.log('window._stateSet');

    // The state of the flutter app, see `class _MyAppState` in lib/main.dart.
    let appState = window._appState;
    window.flutterAppState = appState;


    // let updateState = function () {
    //   console.log('updateState');
    // };

    // Register a callback to update the HTML field from Flutter.
    // appState.addHandler(updateState);

    // Render the first value (0).
    // updateState();



  };
}());
onMounted(() => {

  window.addEventListener("load", function (ev) {
    _flutter.loader.loadEntrypoint({
      entrypointUrl: "flutter/main.dart.js",

      onEntrypointLoaded: async function (engineInitializer) {
        let appRunner = await engineInitializer.initializeEngine({
          assetBase: "flutter/",
          // Pass a reference to "div#flutter_host" into the Flutter engine.
          hostElement: document.querySelector("#flutter_host")
        });
        await appRunner.runApp();
      }
    });
  });


})

defineProps({
  msg: {
    type: String,
    required: true
  }
})
</script>

<template>
  <div id="flutter_host">Loading...</div>

  <component src="flutter/flutter.js" :is="'script'"></component>
</template>

<style scoped>
#flutter_host {
  width: 100%;
  height: 500px;

}
</style>
