defmodule Kegster.API.KegeratorControllerTest do
  use Kegster.ConnCase

  alias Kegster.Kegerator
  @valid_attrs %{name: "Third Floor"}
  @invalid_attrs %{name: ""}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, kegerator_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    kegerator = Repo.insert! Kegerator.changeset(%Kegerator{}, @valid_attrs)
    conn = get conn, kegerator_path(conn, :show, kegerator)
    assert json_response(conn, 200)["data"] == %{
      "id" => kegerator.id, 
      "name" => kegerator.name
    }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, kegerator_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, kegerator_path(conn, :create), kegerator: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Kegerator, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, kegerator_path(conn, :create), kegerator: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    kegerator = Repo.insert! %Kegerator{}
    conn = put conn, kegerator_path(conn, :update, kegerator), kegerator: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Kegerator, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    kegerator = Repo.insert! %Kegerator{}
    conn = put conn, kegerator_path(conn, :update, kegerator), kegerator: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    kegerator = Repo.insert! %Kegerator{}
    conn = delete conn, kegerator_path(conn, :delete, kegerator)
    assert response(conn, 204)
    refute Repo.get(Kegerator, kegerator.id)
  end
end
