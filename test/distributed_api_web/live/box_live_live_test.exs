defmodule DistributedApiWeb.BoxLiveLiveTest do
  use DistributedApiWeb.ConnCase

  import Phoenix.LiveViewTest
  import DistributedApi.BoxesLiveFixtures

  @create_attrs %{name: "some name", description: "some description"}
  @update_attrs %{name: "some updated name", description: "some updated description"}
  @invalid_attrs %{name: nil, description: nil}

  defp create_box_live(_) do
    box_live = box_live_fixture()
    %{box_live: box_live}
  end

  describe "Index" do
    setup [:create_box_live]

    test "lists all boxes_live", %{conn: conn, box_live: box_live} do
      {:ok, _index_live, html} = live(conn, ~p"/boxes_live")

      assert html =~ "Listing Boxes live"
      assert html =~ box_live.name
    end

    test "saves new box_live", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/boxes_live")

      assert index_live |> element("a", "New Box live") |> render_click() =~
               "New Box live"

      assert_patch(index_live, ~p"/boxes_live/new")

      assert index_live
             |> form("#box_live-form", box_live: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#box_live-form", box_live: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/boxes_live")

      html = render(index_live)
      assert html =~ "Box live created successfully"
      assert html =~ "some name"
    end

    test "updates box_live in listing", %{conn: conn, box_live: box_live} do
      {:ok, index_live, _html} = live(conn, ~p"/boxes_live")

      assert index_live |> element("#boxes_live-#{box_live.id} a", "Edit") |> render_click() =~
               "Edit Box live"

      assert_patch(index_live, ~p"/boxes_live/#{box_live}/edit")

      assert index_live
             |> form("#box_live-form", box_live: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#box_live-form", box_live: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/boxes_live")

      html = render(index_live)
      assert html =~ "Box live updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes box_live in listing", %{conn: conn, box_live: box_live} do
      {:ok, index_live, _html} = live(conn, ~p"/boxes_live")

      assert index_live |> element("#boxes_live-#{box_live.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#boxes_live-#{box_live.id}")
    end
  end

  describe "Show" do
    setup [:create_box_live]

    test "displays box_live", %{conn: conn, box_live: box_live} do
      {:ok, _show_live, html} = live(conn, ~p"/boxes_live/#{box_live}")

      assert html =~ "Show Box live"
      assert html =~ box_live.name
    end

    test "updates box_live within modal", %{conn: conn, box_live: box_live} do
      {:ok, show_live, _html} = live(conn, ~p"/boxes_live/#{box_live}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Box live"

      assert_patch(show_live, ~p"/boxes_live/#{box_live}/show/edit")

      assert show_live
             |> form("#box_live-form", box_live: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#box_live-form", box_live: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/boxes_live/#{box_live}")

      html = render(show_live)
      assert html =~ "Box live updated successfully"
      assert html =~ "some updated name"
    end
  end
end
