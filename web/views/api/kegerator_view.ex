defmodule Kegster.API.KegeratorView do
  use Kegster.Web, :view

  def render("index.json", %{kegerators: kegerators}) do
    %{data: render_many(kegerators, Kegster.API.KegeratorView, "kegerator.json")}
  end

  def render("show.json", %{kegerator: kegerator}) do
    %{data: render_one(kegerator, Kegster.API.KegeratorView, "kegerator.json")}
  end

  def render("kegerator.json", %{kegerator: kegerator}) do
    %{id: kegerator.id, name: kegerator.name}
  end
end
