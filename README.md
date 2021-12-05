# Quizzez

To use Google Auth:

- Get your `Client ID` and `Client Secret` from [Google Console](https://console.cloud.google.com)
- Rename `.env.sample` to `.env` and insert values from earlier step
- Make sure to make the env values avaible to the Pheonix server by running `source .env` before `mix phx.server`
- Or in one go: `source .env && iex -S mix phx.server`

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
