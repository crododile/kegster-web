defmodule Kegster.Beer do
  use Kegster.Web, :model

  schema "beers" do
    field :name, :string
    field :alcohol_content, :decimal

    timestamps
  end

  @required_fields ~w(name alcohol_content)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
