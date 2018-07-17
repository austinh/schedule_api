FROM bitwalker/alpine-elixir-phoenix:latest

WORKDIR /app

ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

COPY . .
