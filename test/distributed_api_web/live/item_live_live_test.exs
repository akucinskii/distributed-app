defmodule DistributedApiWeb.ItemLiveLiveTest do
  use DistributedApiWeb.ConnCase

  import Phoenix.LiveViewTest
  import DistributedApi.ItemsLiveFixtures

  @create_attrs %{name: "some name", description: "some description"}
  @update_attrs %{name: "some updated name", description: "some updated description"}
  @invalid_attrs %{name: nil, description: nil}

  defp create_item_live(_) do
    item_live = item_live_fixture()
    %{item_live: item_live}
  end

  describe "Index" do
    setup [:create_item_live]

    test "lists all items_live", %{conn: conn, item_live: item_live} do
      {:ok, _index_live, html} = live(conn, ~p"/items_live")

      assert html =~ "Listing Items live"
      assert html =~ item_live.name
    end

    test "saves new item_live", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/items_live")

      assert index_live |> element("a", "New Item live") |> render_click() =~
               "New Item live"

      assert_patch(index_live, ~p"/items_live/new")

      assert index_live
             |> form("#item_live-form", item_live: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#item_live-form", item_live: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/items_live")

      html = render(index_live)
      assert html =~ "Item live created successfully"
      assert html =~ "some name"
    end

    test "updates item_live in listing", %{conn: conn, item_live: item_live} do
      {:ok, index_live, _html} = live(conn, ~p"/items_live")

      assert index_live |> element("#items_live-#{item_live.id} a", "Edit") |> render_click() =~
               "Edit Item live"

      assert_patch(index_live, ~p"/items_live/#{item_live}/edit")

      assert index_live
             |> form("#item_live-form", item_live: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#item_live-form", item_live: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/items_live")

      html = render(index_live)
      assert html =~ "Item live updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes item_live in listing", %{conn: conn, item_live: item_live} do
      {:ok, index_live, _html} = live(conn, ~p"/items_live")

      assert index_live |> element("#items_live-#{item_live.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#items_live-#{item_live.id}")
    end
  end

  describe "Show" do
    setup [:create_item_live]

    test "displays item_live", %{conn: conn, item_live: item_live} do
      {:ok, _show_live, html} = live(conn, ~p"/items_live/#{item_live}")

      assert html =~ "Show Item live"
      assert html =~ item_live.name
    end

    test "updates item_live within modal", %{conn: conn, item_live: item_live} do
      {:ok, show_live, _html} = live(conn, ~p"/items_live/#{item_live}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Item live"

      assert_patch(show_live, ~p"/items_live/#{item_live}/show/edit")

      assert show_live
             |> form("#item_live-form", item_live: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#item_live-form", item_live: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/items_live/#{item_live}")

      html = render(show_live)
      assert html =~ "Item live updated successfully"
      assert html =~ "some updated name"
    end
  end
end
