<script lang="ts" setup>
interface Props {
  id: string;
}

defineProps<Props>();
</script>

<template>
  <h1
    :id="id"
    class="text-6xl font-bold tracking-tight"
    style="line-height: 100px"
  >
    <slot />
  </h1>
  <UiSeparator class="mb-4" />
</template>
