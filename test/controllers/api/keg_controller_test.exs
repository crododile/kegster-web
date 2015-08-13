defmodule Kegster.API.KegControllerTest do
  use Kegster.ConnCase
  use Timex

  alias Kegster.Keg
  alias Kegster.Beer
  alias Kegster.Kegerator

  @valid_attrs %{floated_at: Date.now, tapped_at: Date.now, beer: %Beer{}, left_kegerator_handle: %Kegerator{}}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    beer = Beer.changeset(%Beer{}, %{name: "Beer", alcohol_content: 6.0})
      |> Repo.insert!
    kegerator = Kegerator.changeset(%Kegerator{}, %{name: "Level 1"})
      |> Repo.insert!
    IO.puts inspect(beer)
    {:ok, conn: conn, beer: beer, kegerator: kegerator}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, keg_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn, beer: beer, kegerator: kegerator} do
    keg = Keg.changeset(%Keg{}, @valid_attrs |> Map.put(:beer_id, beer.id) |> Map.put(:left_kegerator_handle_id, kegerator.id))
      |> Repo.insert! 
    conn = get conn, keg_path(conn, :show, keg)
    assert json_response(conn, 200)["data"] == %{
      "id" => keg.id
    }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, keg_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, keg_path(conn, :create), keg: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Keg, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, keg_path(conn, :create), keg: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    keg = Repo.insert! %Keg{}
    conn = put conn, keg_path(conn, :update, keg), keg: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Keg, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    keg = Repo.insert! %Keg{}
    conn = put conn, keg_path(conn, :update, keg), keg: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    keg = Repo.insert! %Keg{}
    conn = delete conn, keg_path(conn, :delete, keg)
    assert response(conn, 204)
    refute Repo.get(Keg, keg.id)
  end
end
