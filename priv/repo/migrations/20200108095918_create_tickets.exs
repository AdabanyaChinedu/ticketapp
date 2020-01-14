defmodule Ticketapp.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :ref_no, :string
      add :name, :string
      add :email, :string
      add :subject, :string
      add :department, :string
      add :message, :string
      add :assignee, :string
      add :status, :string

      timestamps()
    end

  end
end
