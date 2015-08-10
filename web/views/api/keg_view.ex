defmodule Kegster.API.KegView do
  use Kegster.Web, :view

  def render("index.json", %{kegs: kegs}) do
    %{data: render_many(kegs, Kegster.API.KegView, "keg.json")}
  end

  def render("show.json", %{keg: keg}) do
    %{data: render_one(keg, Kegster.API.KegView, "keg.json")}
  end

  def render("keg.json", %{keg: keg}) do
    %{id: keg.id}
  end
end
