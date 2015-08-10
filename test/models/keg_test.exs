defmodule Kegster.KegTest do
  use Kegster.ModelCase

  alias Kegster.Keg
  use Timex

  @valid_attrs %{beer_id: 42, floated_at: Date.now, right_kegerator_handle_id: 42, tapped_at: Date.now}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Keg.changeset(%Keg{}, @valid_attrs)
    IO.puts inspect(changeset.errors)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Keg.changeset(%Keg{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "keg has to belong to a kegerator handle" do
    changeset = Keg.changeset(%Keg{}, %{})
    assert Enum.any?(changeset.errors, fn(error) -> error == {:handles, "cannot be blank"} end)
  end

  test "that keg can't be on both sides of the kegerator" do
    changeset = Keg.changeset(%Keg{}, %{right_kegerator_handle_id: 42, left_kegerator_handle_id: 42})
    assert Enum.any?(changeset.errors, fn(error) -> error == {:left_kegerator_handle_id, "cannot be on two taps"} end)
  end
end
