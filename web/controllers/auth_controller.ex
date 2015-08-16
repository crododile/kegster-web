defmodule Kegster.AuthController do
  use Kegster.Web, :controller
  alias Kegster.User
  plug :action

  def index(conn, _params) do
    redirect conn, external: Flux.authorize_url!
  end

  def callback(conn, %{"code" => code}) do
    token = Flux.get_token!(code: code)
    user = OAuth2.AccessToken.get!(token, "/api/v1/me")
    IO.puts inspect(user)
    IO.puts inspect(token)
  end
end
