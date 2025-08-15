export default function (input: string) {
  if (import.meta.client) return window.btoa(input);
  return Buffer.from(input, "ascii").toString("base64");
}
