defmodule DistributedApiWeb.BoxControllerTest do
  use DistributedApiWeb.ConnCase

  import DistributedApi.BoxesFixtures

  @create_attrs %{name: "some name", description: "some description"}
  @update_attrs %{name: "some updated name", description: "some updated description"}
  @invalid_attrs %{name: nil, description: nil}

  describe "index" do
    test "lists all boxes", %{conn: conn} do
      conn = get(conn, ~p"/boxes")
      assert html_response(conn, 200) =~ "Listing Boxes"
    end
  end

  describe "new box" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/boxes/new")
      assert html_response(conn, 200) =~ "New Box"
    end
  end

  describe "create box" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/boxes", box: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/boxes/#{id}"

      conn = get(conn, ~p"/boxes/#{id}")
      assert html_response(conn, 200) =~ "Box #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/boxes", box: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Box"
    end
  end

  describe "edit box" do
    setup [:create_box]

    test "renders form for editing chosen box", %{conn: conn, box: box} do
      conn = get(conn, ~p"/boxes/#{box}/edit")
      assert html_response(conn, 200) =~ "Edit Box"
    end
  end

  describe "update box" do
    setup [:create_box]

    test "redirects when data is valid", %{conn: conn, box: box} do
      conn = put(conn, ~p"/boxes/#{box}", box: @update_attrs)
      assert redirected_to(conn) == ~p"/boxes/#{box}"

      conn = get(conn, ~p"/boxes/#{box}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, box: box} do
      conn = put(conn, ~p"/boxes/#{box}", box: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Box"
    end
  end

  describe "delete box" do
    setup [:create_box]

    test "deletes chosen box", %{conn: conn, box: box} do
      conn = delete(conn, ~p"/boxes/#{box}")
      assert redirected_to(conn) == ~p"/boxes"

      assert_error_sent 404, fn ->
        get(conn, ~p"/boxes/#{box}")
      end
    end
  end

  defp create_box(_) do
    box = box_fixture()
    %{box: box}
  end
end
