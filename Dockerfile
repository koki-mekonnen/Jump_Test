FROM elixir:1.14-alpine AS build
RUN mix local.hex --force && mix local.rebar --force
WORKDIR /app
COPY . .
RUN mix deps.get && cd assets && npm install && cd .. && mix assets.deploy && mix compile && mix release

FROM alpine:latest
RUN apk add --no-cache openssl ncurses libstdc++
WORKDIR /app
COPY --from=build /app/_build/prod/rel/markdown_editor .
ENV PORT=4000
CMD ["bin/markdown_editor", "start"]