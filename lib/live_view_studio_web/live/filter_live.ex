defmodule LiveViewStudioWeb.FilterLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Boats

  def mount(_params, _session, socket) do
    socket =
      assign(
        socket,
        boats: Boats.list_boats(),
        type: "",
        prices: []
      )

    {:ok, socket}
  end

  def handle_event("filter", %{"type" => type, "prices" => prices}, socket) do
    params = [type: type, prices: prices]
    boats = Boats.list_boats(params)

    socket =
      assign(
        socket,
        params ++ [boats: boats]
      )

    {:noreply, socket}
  end

  defp type_options do
    [
      "All Types": "",
      Fishing: "fishing",
      Sporting: "sporting",
      Sailing: "sailing"
    ]
  end

  defp price_checkbox(assigns) do
    assigns = Enum.into(assigns, %{})

    ~L"""
    <input type="checkbox" name="prices[]" id="<%= @price %>"
          value="<%= @price %>"
          <%= if @selected, do: "checked" %>/>
    <label for="<%= @price %>"><%= @price %></label>
    """
  end
end
