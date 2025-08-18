# Frontend

```vue
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
  <div>
    <h1>Counter:</h1>
    <span>{{ counter }}</span>

    <button @click="counter++">Hinzufügen</button>
  </div>
</template>

<style>
.button {
  height: 2rem;
  width: 200px;
}
</style>
```
