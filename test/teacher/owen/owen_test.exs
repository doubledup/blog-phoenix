defmodule Teacher.OwenTest do
  use Teacher.DataCase

  alias Teacher.Owen

  describe "transactions" do
    alias Teacher.Owen.Transaction

    @valid_attrs %{amount: 42, from: "some from", to: "some to"}
    @update_attrs %{amount: 43, from: "some updated from", to: "some updated to"}
    @invalid_attrs %{amount: nil, from: nil, to: nil}

    def transaction_fixture(attrs \\ %{}) do
      {:ok, transaction} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Owen.create_transaction()

      transaction
    end

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Owen.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Owen.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      assert {:ok, %Transaction{} = transaction} = Owen.create_transaction(@valid_attrs)
      assert transaction.amount == 42
      assert transaction.from == "some from"
      assert transaction.to == "some to"
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Owen.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{} = transaction} = Owen.update_transaction(transaction, @update_attrs)
      assert transaction.amount == 43
      assert transaction.from == "some updated from"
      assert transaction.to == "some updated to"
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Owen.update_transaction(transaction, @invalid_attrs)
      assert transaction == Owen.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Owen.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Owen.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Owen.change_transaction(transaction)
    end
  end
end
