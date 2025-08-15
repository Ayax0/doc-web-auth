<script lang="ts" setup>
const username = ref<string>();
const password = ref<string>();

const basicAuth = computed(() =>
  toBase64(`${username.value}:${password.value}`)
);

onMounted(() =>
  $fetch("/api/auth", { method: "DELETE" }).catch(() =>
    console.log("no open session")
  )
);
</script>

<template>
  <UiDemo>
    <UiDemoActor>
      <span class="mr-4">Client</span>
      <UiDialog>
        <UiDialogTrigger as-child>
          <UiButton variant="outline" size="icon">
            <Icon name="lucide:key-round" />
          </UiButton>
        </UiDialogTrigger>
        <UiDialogContent>
          <UiDialogHeader>
            <UiDialogTitle>Login</UiDialogTitle>
            <UiDialogDescription>
              Bitte geben Sie Ihre Anmeldeinformationen ein.
            </UiDialogDescription>
          </UiDialogHeader>
          <UiDialogContent class="space-y-2">
            <UiLabel for="username">Username</UiLabel>
            <UiInput v-model="username" id="username" />
            <UiLabel for="password">Password</UiLabel>
            <UiInput v-model="password" id="password" type="password" />
          </UiDialogContent>
        </UiDialogContent>
      </UiDialog>
    </UiDemoActor>
    <UiDemoContent>
      <UiDemoAction
        method="get"
        url="/api/data"
        :mock-input-headers="{
          Cookie: `access_token=********;`,
        }"
        description="geschützte Daten abrufen"
        class="mb-20"
      />
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
        description="Refresh Token in einen Access Token umwandeln"
      />
      <UiDemoAction
        method="delete"
        url="/api/auth"
        :mock-input-headers="{
          Cookie: `refresh_token=********; access_token=********;`,
        }"
        description="Session beenden und Tokens löschen"
      />
    </UiDemoContent>
    <UiDemoActor>Server</UiDemoActor>
  </UiDemo>
</template>
