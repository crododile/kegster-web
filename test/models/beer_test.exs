defmodule Kegster.BeerTest do
  use Kegster.ModelCase

  alias Kegster.Beer

  @valid_attrs %{alcohol_content: 6.0, name: "Beer"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Beer.changeset(%Beer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Beer.changeset(%Beer{}, @invalid_attrs)
    refute changeset.valid?
  end
end
