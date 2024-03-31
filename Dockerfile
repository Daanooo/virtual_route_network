FROM hexpm/elixir:1.16.2-erlang-26.2.2-alpine-3.19.1    

RUN apk add --no-cache git 

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN mix local.hex --force

CMD /app/entrypoint.sh

