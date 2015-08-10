defmodule Kegster.Keg do
  use Kegster.Web, :model

  schema "kegs" do
    belongs_to :beer, Kegster.Beer
    belongs_to :left_kegerator_handle, Kegster.Kegerator
    belongs_to :right_kegerator_handle, Kegster.Kegerator
    field :tapped_at, Timex.Ecto.DateTime
    field :floated_at, Timex.Ecto.DateTime


    timestamps
  end

  @required_fields ~w(beer_id)
  @optional_fields ~w(right_kegerator_handle_id left_kegerator_handle_id tapped_at floated_at)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_kegs_with_kegerator
  end

  def validate_kegs_with_kegerator(changeset) do
    left_handle = get_field(changeset, :left_kegerator_handle_id)
    right_handle = get_field(changeset, :right_kegerator_handle_id)
    cond do
      left_handle == nil && right_handle == nil ->
        add_error(changeset, :handles, "cannot be blank")
      left_handle == right_handle ->
        add_error(changeset, :left_kegerator_handle_id, "cannot be on two taps")
      true ->
        changeset
    end
  end
end
