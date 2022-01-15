# Quizzez

A quiz platform built with Elixir / Pheonix framework

## Get started

First of you need to setup Google Auth:

- Get your `Client ID` and `Client Secret` from [Google Console](https://console.cloud.google.com)
- Rename `.env.sample` to `.env` and insert values from earlier step

Make sure you have a Postgresql database up and running and the correct credentials is in `config/dev.exs`

Run the app:

- Make sure to make the env values avaible to the Pheonix server by running `source .env` before `mix phx.server`
- Or in one go: `source .env && iex -S mix phx.server`

## Resources

- Illustrations used from https://www.pixeltrue.com/

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
