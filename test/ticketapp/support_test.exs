defmodule Ticketapp.SupportTest do
  use Ticketapp.DataCase

  alias Ticketapp.Support

  describe "tickets" do
    alias Ticketapp.Support.Ticket

    @valid_attrs %{assignee: "some assignee", department: "some department", email: "some email", message: "some message", name: "some name", ref_no: "some ref_no", status: "some status", subject: "some subject"}
    @update_attrs %{assignee: "some updated assignee", department: "some updated department", email: "some updated email", message: "some updated message", name: "some updated name", ref_no: "some updated ref_no", status: "some updated status", subject: "some updated subject"}
    @invalid_attrs %{assignee: nil, department: nil, email: nil, message: nil, name: nil, ref_no: nil, status: nil, subject: nil}

    def ticket_fixture(attrs \\ %{}) do
      {:ok, ticket} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Support.create_ticket()

      ticket
    end

    test "list_tickets/0 returns all tickets" do
      ticket = ticket_fixture()
      assert Support.list_tickets() == [ticket]
    end

    test "get_ticket!/1 returns the ticket with given id" do
      ticket = ticket_fixture()
      assert Support.get_ticket!(ticket.id) == ticket
    end

    test "create_ticket/1 with valid data creates a ticket" do
      assert {:ok, %Ticket{} = ticket} = Support.create_ticket(@valid_attrs)
      assert ticket.assignee == "some assignee"
      assert ticket.department == "some department"
      assert ticket.email == "some email"
      assert ticket.message == "some message"
      assert ticket.name == "some name"
      assert ticket.ref_no == "some ref_no"
      assert ticket.status == "some status"
      assert ticket.subject == "some subject"
    end

    test "create_ticket/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Support.create_ticket(@invalid_attrs)
    end

    test "update_ticket/2 with valid data updates the ticket" do
      ticket = ticket_fixture()
      assert {:ok, %Ticket{} = ticket} = Support.update_ticket(ticket, @update_attrs)
      assert ticket.assignee == "some updated assignee"
      assert ticket.department == "some updated department"
      assert ticket.email == "some updated email"
      assert ticket.message == "some updated message"
      assert ticket.name == "some updated name"
      assert ticket.ref_no == "some updated ref_no"
      assert ticket.status == "some updated status"
      assert ticket.subject == "some updated subject"
    end

    test "update_ticket/2 with invalid data returns error changeset" do
      ticket = ticket_fixture()
      assert {:error, %Ecto.Changeset{}} = Support.update_ticket(ticket, @invalid_attrs)
      assert ticket == Support.get_ticket!(ticket.id)
    end

    test "delete_ticket/1 deletes the ticket" do
      ticket = ticket_fixture()
      assert {:ok, %Ticket{}} = Support.delete_ticket(ticket)
      assert_raise Ecto.NoResultsError, fn -> Support.get_ticket!(ticket.id) end
    end

    test "change_ticket/1 returns a ticket changeset" do
      ticket = ticket_fixture()
      assert %Ecto.Changeset{} = Support.change_ticket(ticket)
    end
  end
end
