defmodule TeacherWeb.TransactionView do
  use TeacherWeb, :view
  alias TeacherWeb.TransactionView

  def render("index.json", %{transactions: transactions}) do
    %{data: render_many(transactions, TransactionView, "transaction.json")}
  end

  def render("show.json", %{transaction: transaction}) do
    %{data: render_one(transaction, TransactionView, "transaction.json")}
  end

  def render("transaction.json", %{transaction: transaction}) do
    %{id: transaction.id,
      from: transaction.from,
      to: transaction.to,
      amount: transaction.amount}
  end

  def render("echo.json", %{text: text}) do
    %{text: text}
  end
end
