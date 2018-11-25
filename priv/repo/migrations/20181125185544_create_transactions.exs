defmodule Teacher.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :from, :string
      add :to, :string
      add :amount, :integer

      timestamps()
    end

  end
end
