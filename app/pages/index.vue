<script setup lang="ts">
const { data: docs } = await useAsyncData(() =>
  queryCollection("content").order("id", "ASC").all()
);

// useSeoMeta({
//   title: home.value?.title,
//   description: home.value?.description,
// });
</script>

<template>
  <section
    v-for="doc of docs"
    :key="doc.id"
    class="w-full h-svh snap-start p-10 grid justify-center items-center"
  >
    <ContentRenderer :value="doc" />
  </section>
</template>
