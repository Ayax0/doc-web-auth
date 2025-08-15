FROM node:slim AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

FROM base AS build
WORKDIR /app

COPY . .
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile
RUN pnpm run build

FROM base
WORKDIR /app
COPY --from=build /app/.output .

ENV NODE_ENV=production
EXPOSE 3000

CMD ["node", "server/index.mjs"]
