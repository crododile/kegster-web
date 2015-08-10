defmodule Kegster.API.KegeratorController do
  use Kegster.Web, :controller

  alias Kegster.Kegerator

  plug :scrub_params, "kegerator" when action in [:create, :update]

  def index(conn, _params) do
    kegerators = Repo.all(Kegerator)
    render(conn, "index.json", kegerators: kegerators)
  end

  def create(conn, %{"kegerator" => kegerator_params}) do
    changeset = Kegerator.changeset(%Kegerator{}, kegerator_params)

    case Repo.insert(changeset) do
      {:ok, kegerator} ->
        conn
        |> put_status(:created)
        |> render("show.json", kegerator: kegerator)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Kegster.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    kegerator = Repo.get!(Kegerator, id)
    render conn, "show.json", kegerator: kegerator
  end

  def update(conn, %{"id" => id, "kegerator" => kegerator_params}) do
    kegerator = Repo.get!(Kegerator, id)
    changeset = Kegerator.changeset(kegerator, kegerator_params)

    case Repo.update(changeset) do
      {:ok, kegerator} ->
        render(conn, "show.json", kegerator: kegerator)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Kegster.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    kegerator = Repo.get!(Kegerator, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    kegerator = Repo.delete!(kegerator)

    send_resp(conn, :no_content, "")
  end
end
