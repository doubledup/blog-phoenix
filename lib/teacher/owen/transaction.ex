defmodule Teacher.Owen.Transaction do
  use Ecto.Schema
  import Ecto.Changeset


  schema "transactions" do
    field :amount, :integer
    field :from, :string
    field :to, :string

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:from, :to, :amount])
    |> validate_required([:from, :to, :amount])
  end
end
