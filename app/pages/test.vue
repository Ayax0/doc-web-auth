<script lang="ts" setup>
const username = ref<string>();
const password = ref<string>();

const basicAuth = computed(() =>
  toBase64(`${username.value}:${password.value}`)
);
</script>

<template>
  <div class="p-10">
    <UiCard class="mb-8 w-80">
      <UiCardContent class="space-y-2">
        <UiLabel for="username">Username</UiLabel>
        <UiInput v-model="username" id="username" />
        <UiLabel for="password">Password</UiLabel>
        <UiInput v-model="password" id="password" type="password" />
      </UiCardContent>
    </UiCard>

    <UiDemo>
      <UiDemoActor>Client</UiDemoActor>
      <UiDemoContent>
        <UiDemoAction
          method="post"
          url="/api/auth"
          :headers="{
            Authorization: `Basic ${basicAuth}`,
          }"
          :mock-output-headers="{
            'Set-Cookie': `refresh_token=********; HttpOnly; SameSite=Strict; Secure; Path=/api/auth; Expires=${new Date(new Date().setDate(new Date().getDate() + 30)).toUTCString()}`,
          }"
          description="Username / Passwort Auth um einen Refresh Token zu bekommen"
        />
        <UiDemoAction
          method="put"
          url="/api/auth"
          :mock-input-headers="{
            Cookie: `refresh_token=********;`,
          }"
          :mock-output-headers="{
            'Set-Cookie': `access_token=********; HttpOnly; SameSite=Strict; Secure; Path=/; Expires=${new Date(new Date().setTime(new Date().getTime() + 13 * 60 * 1000)).toUTCString()}`,
          }"
          description="refresh_token in einen Access Token umtauschen"
        />
        <UiDemoAction
          method="delete"
          url="/api/auth"
          :mock-input-headers="{
            Cookie: `refresh_token=********; access_token=********;`,
          }"
          description="Session beenden und Tokens löschen"
        />
        <UiDemoAction
          method="get"
          url="/api/data"
          :mock-input-headers="{
            Cookie: `access_token=********;`,
          }"
          description="geschützte Daten abrufen"
          class="mt-20"
        />
      </UiDemoContent>
      <UiDemoActor>Server</UiDemoActor>
    </UiDemo>
  </div>
</template>
