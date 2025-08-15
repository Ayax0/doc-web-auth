<script lang="ts" setup>
import type { RouterMethod } from "h3";
import { cn } from "~/lib/utils";

interface Props {
  direction?: "left" | "right";
  method?: RouterMethod;
  url?: string;
  headers?: HeadersInit;
  mockInputHeaders?: HeadersInit;
  mockOutputHeaders?: HeadersInit;
  mockStatusCode?: number;
  mockStatusMessage?: string;
  body?: Record<string, any>;
  description?: string;
  disabled?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  direction: "right",
});

const status = ref<"idle" | "pending" | "success" | "error">("idle");
const statusCode = ref<number>();
const statusText = ref<string>();
const header = ref<Headers>();
const data = ref<any>();

async function execute() {
  if (!props.url) return;

  try {
    await $fetch(props.url, {
      method: props.method,
      headers: props.headers,
      body: props.body,
      onRequest() {
        status.value = "pending";
        data.value = undefined;
      },
      onRequestError({ response, error }) {
        console.log(error.message);
        if (!response) return;
        status.value = "error";
        statusCode.value = response.status;
        statusText.value = response.statusText;
        header.value = response.headers;
      },
      onResponse({ response }) {
        if (!response.ok) return;
        status.value = "success";
        statusCode.value = response.status;
        statusText.value = response.statusText;
        header.value = response.headers;
        data.value = response._data;
      },
      onResponseError({ response }) {
        status.value = "error";
        statusCode.value = response.status;
        statusText.value = response.statusText;
        header.value = response.headers;
        data.value = response._data;
      },
    });
  } catch (error) {
    status.value = "error";
  }
}

const bg = computed(() => {
  switch (status.value) {
    case "pending":
      return "bg-blue-500!";
    case "error":
      return "bg-red-500!";
    case "success":
      return "bg-green-500!";
    default:
      return undefined;
  }
});

const border = computed(() => {
  switch (status.value) {
    case "pending":
      return "border-blue-500!";
    case "error":
      return "border-red-500!";
    case "success":
      return "border-green-500!";
    default:
      return undefined;
  }
});
</script>

<template>
  <div class="space-y-4">
    <div class="flex items-center gap-4">
      <div
        v-if="props.method"
        class="http-badge"
        :data-method="props.method.toUpperCase()"
      >
        {{ props.method.toUpperCase() }}
      </div>
      <div class="text-2xl mr-8">
        {{ props.url }}
      </div>
      <div class="flex-1 text-end italic text-xl text-muted-foreground">
        {{ props.description }}
      </div>
    </div>
    <div class="flex items-center relative min-h-6">
      <div :class="cn('flex-1 border-b-2 border-foreground/60', border)"></div>
      <UiHoverCard v-if="!props.disabled">
        <UiHoverCardTrigger as-child>
          <UiButton variant="outline" :class="bg" size="icon" @click="execute">
            <Icon v-if="status !== 'pending'" name="lucide:play" />
            <Icon v-else name="lucide:clock-fading" />
          </UiButton>
        </UiHoverCardTrigger>
        <UiHoverCardContent class="w-[600px]">
          <div class="text-lg font-bold">Headers</div>
          <pre class="bg-accent rounded p-2">{{
            JSON.stringify(
              { ...props.headers, ...props.mockInputHeaders },
              null,
              2
            )
          }}</pre>
          <div class="text-lg font-bold mt-4">Body</div>
          <pre class="bg-accent rounded p-2">{{
            props.body ? JSON.stringify(props.body, null, 2) : "empty"
          }}</pre>
        </UiHoverCardContent>
      </UiHoverCard>

      <div :class="cn('flex-1 border-b-2 border-foreground/60', border)"></div>

      <UiHoverCard>
        <UiHoverCardTrigger as-child>
          <div
            :class="
              cn(
                'border-2 border-foreground/60 bg-background rounded-sm size-8 rotate-45 flex justify-center items-center cursor-pointer absolute',
                bg,
                border,
                props.direction === 'right' ? 'right-0' : 'left-0'
              )
            "
          >
            <Icon
              v-if="status === 'success'"
              name="lucide:check"
              class="-rotate-45"
              size="20"
            />
            <Icon
              v-if="status === 'error'"
              name="lucide:x"
              class="-rotate-45"
              size="20"
            />
          </div>
        </UiHoverCardTrigger>
        <UiHoverCardContent class="w-[650px]" side="right" :side-offset="10">
          <div v-if="status !== 'idle' || disabled">
            <div class="text-2xl font-bold">
              {{ statusCode || mockStatusCode }} -
              {{ statusText || mockStatusMessage }}
            </div>
            <div class="text-lg font-bold">Headers</div>
            <pre class="bg-accent rounded p-2">{{
              JSON.stringify({ ...header, ...props.mockOutputHeaders }, null, 2)
            }}</pre>
            <div class="text-lg font-bold mt-4">Body</div>
            <pre class="bg-accent rounded p-2">{{
              data ? JSON.stringify(data, null, 2) : "empty"
            }}</pre>
          </div>
          <div v-else class="italic text-xl text-muted-foreground">idle</div>
        </UiHoverCardContent>
      </UiHoverCard>
    </div>
  </div>
</template>

<style scoped>
pre {
  white-space: pre-wrap; /* Since CSS 2.1 */
  white-space: -moz-pre-wrap; /* Mozilla, since 1999 */
  white-space: -pre-wrap; /* Opera 4-6 */
  white-space: -o-pre-wrap; /* Opera 7 */
  word-wrap: break-word; /* Internet Explorer 5.5+ */
}
</style>
