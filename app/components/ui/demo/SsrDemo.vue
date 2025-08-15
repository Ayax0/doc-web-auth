<template>
  <UiDemo>
    <UiDemoActor>Client</UiDemoActor>
    <UiDemoContent>
      <UiDemoAction
        method="get"
        url="/"
        :mock-status-code="303"
        mock-status-message="See Other"
        :mock-output-headers="{
          Location: '/dmz/redirect',
        }"
        disabled
        description="User ruft initial die Seite auf"
      />
      <UiDemoAction
        method="get"
        url="/dmz/redirect"
        :mock-status-code="200"
        mock-status-message="OK"
        :mock-output-headers="{
          'Content-Type': 'text/html; charset=utf-8',
        }"
        disabled
        description="User wird auf Authentifizierungsseite umgeleitet"
        class="mt-4"
      />
      <UiDemoAction
        method="put"
        url="/dmz/auth"
        :mock-status-code="200"
        mock-status-message="OK"
        :mock-output-headers="{
          'Set-Cookie': `access_token=********; HttpOnly; SameSite=Strict; Secure; Path=/; Expires=${new Date(new Date().setTime(new Date().getTime() + 13 * 60 * 1000)).toUTCString()}`,
        }"
        disabled
        description="Refresh Request wird Client-Seitig initiiert"
      />

      <UiDemoAction
        method="get"
        url="/"
        :mock-status-code="200"
        mock-status-message="OK"
        :mock-output-headers="{
          'Content-Type': 'text/html; charset=utf-8',
        }"
        disabled
        description="User wird nach Erfolgreicher Authentifizierung auf Ursprungsseite umgeleitet"
        class="mt-10"
      />
      <UiDemoAction
        method="get"
        url="/dmz/login"
        :mock-status-code="200"
        mock-status-message="OK"
        :mock-output-headers="{
          'Content-Type': 'text/html; charset=utf-8',
        }"
        disabled
        description="User wird nach nicht Erfolgreicher Authentifizierung auf Loginseite umgeleitet"
      />
    </UiDemoContent>
    <UiDemoActor>Server</UiDemoActor>
  </UiDemo>
</template>
