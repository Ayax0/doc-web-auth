<ui-title>Frontend</ui-title>

```ts
export default function (
  req: Ref<ReqT> | ReqT | (() => ReqT),
  opts?: UseFetchOptions<_ResT, DataT, PickKeys, DefaultT, ReqT, Method>
) {
  const _request = useFetch(req, {
    ...opts,
    onResponseError: [
      async ({ request }) => {
        if (request === "/api/auth") return;

        await $fetch("/api/auth", {
          method: "PUT",
          async onResponse({ response }) {
            if (!response.ok) return;
            await _request.refresh();
          },
          async onResponseError() {
            await navigateTo("/dmz/login");
          },
        });
      },
      ...(opts?.onResponseError ? [opts.onResponseError] : []),
    ],
  });

  return _request;
}
```
