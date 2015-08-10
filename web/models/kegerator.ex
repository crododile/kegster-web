defmodule Kegster.Kegerator do
  use Kegster.Web, :model

  schema "kegerators" do
    has_one :left_handle_keg, Kegster.Keg
    has_one :right_handle_keg, Kegster.Keg
    field :name, :string

    timestamps
  end

  @required_fields ~w(name)
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
