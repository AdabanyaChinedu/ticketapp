defmodule TicketappWeb.TicketControllerTest do
  use TicketappWeb.ConnCase

  alias Ticketapp.Support

  @create_attrs %{assignee: "some assignee", department: "some department", email: "some email", message: "some message", name: "some name", ref_no: "some ref_no", status: "some status", subject: "some subject"}
  @update_attrs %{assignee: "some updated assignee", department: "some updated department", email: "some updated email", message: "some updated message", name: "some updated name", ref_no: "some updated ref_no", status: "some updated status", subject: "some updated subject"}
  @invalid_attrs %{assignee: nil, department: nil, email: nil, message: nil, name: nil, ref_no: nil, status: nil, subject: nil}

  def fixture(:ticket) do
    {:ok, ticket} = Support.create_ticket(@create_attrs)
    ticket
  end

  describe "index" do
    test "lists all tickets", %{conn: conn} do
      conn = get(conn, Routes.ticket_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Tickets"
    end
  end

  describe "new ticket" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.ticket_path(conn, :new))
      assert html_response(conn, 200) =~ "New Ticket"
    end
  end

  describe "create ticket" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.ticket_path(conn, :create), ticket: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.ticket_path(conn, :show, id)

      conn = get(conn, Routes.ticket_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Ticket"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.ticket_path(conn, :create), ticket: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Ticket"
    end
  end

  describe "edit ticket" do
    setup [:create_ticket]

    test "renders form for editing chosen ticket", %{conn: conn, ticket: ticket} do
      conn = get(conn, Routes.ticket_path(conn, :edit, ticket))
      assert html_response(conn, 200) =~ "Edit Ticket"
    end
  end

  describe "update ticket" do
    setup [:create_ticket]

    test "redirects when data is valid", %{conn: conn, ticket: ticket} do
      conn = put(conn, Routes.ticket_path(conn, :update, ticket), ticket: @update_attrs)
      assert redirected_to(conn) == Routes.ticket_path(conn, :show, ticket)

      conn = get(conn, Routes.ticket_path(conn, :show, ticket))
      assert html_response(conn, 200) =~ "some updated assignee"
    end

    test "renders errors when data is invalid", %{conn: conn, ticket: ticket} do
      conn = put(conn, Routes.ticket_path(conn, :update, ticket), ticket: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Ticket"
    end
  end

  describe "delete ticket" do
    setup [:create_ticket]

    test "deletes chosen ticket", %{conn: conn, ticket: ticket} do
      conn = delete(conn, Routes.ticket_path(conn, :delete, ticket))
      assert redirected_to(conn) == Routes.ticket_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.ticket_path(conn, :show, ticket))
      end
    end
  end

  defp create_ticket(_) do
    ticket = fixture(:ticket)
    {:ok, ticket: ticket}
  end
end
