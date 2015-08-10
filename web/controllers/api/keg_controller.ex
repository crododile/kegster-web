defmodule Kegster.API.KegController do
  use Kegster.Web, :controller

  alias Kegster.Keg

  plug :scrub_params, "keg" when action in [:create, :update]

  def index(conn, _params) do
    kegs = Repo.all(Keg)
    render(conn, "index.json", kegs: kegs)
  end

  def create(conn, %{"keg" => keg_params}) do
    changeset = Keg.changeset(%Keg{}, keg_params)

    case Repo.insert(changeset) do
      {:ok, keg} ->
        conn
        |> put_status(:created)
        |> render("show.json", keg: keg)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Kegster.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    keg = Repo.get!(Keg, id)
    render conn, "show.json", keg: keg
  end

  def update(conn, %{"id" => id, "keg" => keg_params}) do
    keg = Repo.get!(Keg, id)
    changeset = Keg.changeset(keg, keg_params)

    case Repo.update(changeset) do
      {:ok, keg} ->
        render(conn, "show.json", keg: keg)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Kegster.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    keg = Repo.get!(Keg, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    keg = Repo.delete!(keg)

    send_resp(conn, :no_content, "")
  end
end
