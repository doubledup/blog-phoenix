require Logger

defmodule TeacherWeb.TransactionController do
  use TeacherWeb, :controller

  alias Teacher.Owen
  alias Teacher.Owen.Transaction

  action_fallback TeacherWeb.FallbackController

  def index(conn, _params) do
    transactions = Owen.list_transactions()
    render(conn, "index.json", transactions: transactions)
  end

  def create(conn, %{"user_id" => user_id, "command" => "/owen", "text" => text}) do
    Logger.info("user_id: #{user_id}")
    Logger.info("text: #{text}")

    %{"to" => to, "amount" => amount} = Regex.named_captures(~r/\<@(?<to>.*)\> (?<amount>\d+)/, text)

    Logger.info("to: #{to}")
    Logger.info("amount: #{amount}")

    amount = String.to_integer(amount)

    with {:ok, %Transaction{} = transaction} <- Owen.create_transaction(%{from: user_id, to: text, amount: amount}) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.transaction_path(conn, :show, transaction))
      |> render("show.json", transaction: transaction)
    end
  end

  def show(conn, %{"id" => id}) do
    transaction = Owen.get_transaction!(id)
    render(conn, "show.json", transaction: transaction)
  end

  def update(conn, %{"id" => id, "transaction" => transaction_params}) do
    transaction = Owen.get_transaction!(id)

    with {:ok, %Transaction{} = transaction} <- Owen.update_transaction(transaction, transaction_params) do
      render(conn, "show.json", transaction: transaction)
    end
  end

  def delete(conn, %{"id" => id}) do
    transaction = Owen.get_transaction!(id)

    with {:ok, %Transaction{}} <- Owen.delete_transaction(transaction) do
      send_resp(conn, :no_content, "")
    end
  end
end
