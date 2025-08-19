<script lang="ts" setup>
// Reaktive Variabel
const counter = ref<number>(0);

// Variabel-Event-Hooks
watch(counter, (value) =>
  console.log("Die 'counter' Variabel hat sich verändert:", value)
);

// App-Event-Hooks
onMounted(() => console.log("Website ist Client-Seitig fertig geladen!"));
</script>

<template>
  <div class="container">
    <h1>Counter:</h1>
    <h2>{{ counter }}</h2>

    <button @click="counter++">Hinzufügen</button>
  </div>
</template>

<style>
.container {
  margin: auto;
  border: 1px dashed white;
  border-radius: 5px;
  padding: 1rem;
  width: 20rem;
}

button {
  border: 1px solid white;
  border-radius: 5px;
  padding: 3px 8px;
  margin-top: 1rem;
}
</style>
