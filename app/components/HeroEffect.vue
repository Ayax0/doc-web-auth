<template>
  <div class="group"></div>
</template>

<style scoped>
.group {
  width: 100%;
  position: absolute;
  inset: -30% 0 -100%;
  z-index: -1;
  background:
    url(/noise.webp),
    radial-gradient(
      circle at right center,
      #4b296980,
      #563277 25%,
      #4a378c 40%,
      #4066a8 65%,
      #32517380
    );
  mask-image: radial-gradient(
    ellipse 150% 30% at center center,
    #000 20%,
    #00000080 50%,
    #0000
  );
  opacity: 0.7;
  transition: opacity 1s ease;
}
</style>
