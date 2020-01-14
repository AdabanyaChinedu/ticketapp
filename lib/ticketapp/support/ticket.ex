defmodule Ticketapp.Support.Ticket do
  use Ecto.Schema
  import Ecto.Changeset
@derive {Jason.Encoder, only: [:id, :assignee, :ref_no, :subject, :email,:status, :inserted_at,]}

  schema "tickets" do
    field :assignee, :string, default: "Olumide"
    field :department, :string, default: "Support"
    field :email, :string
    field :message, :string
    field :name, :string
    field :ref_no, :string, default: "RQT-123-123456"
    field :status, :string, default: "Waiting for support"
    field :subject, :string

    timestamps()
  end

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [:ref_no, :name, :email, :subject, :department, :message, :assignee, :status])
    |> validate_required([:ref_no, :name, :email, :subject, :department, :message, :assignee, :status])
  end
end
