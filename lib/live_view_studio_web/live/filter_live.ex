defmodule LiveViewStudioWeb.FilterLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Boats

  def mount(_params, _session, socket) do
    socket = assign_defaults(socket)
    # temporary_assigns is an option for performance optimization
    # since mount is creating a stateful process, we don't want
    # to keep the list of boats in memory between renders, since
    # all our events query a new list anyway.
    # temporary assigns is a keyword list whose keys are the
    # assigns that are temporary, and whose values are the
    # values those assigns should be reset to on mount.
    # It is often used with `phx-update="append"` in an element
    # that contains a list comprehension.
    # [more info](https://hexdocs.pm/phoenix_live_view/dom-patching.html)
    {:ok, socket, temporary_assigns: [boats: []]}
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

  def handle_event("clear-filters", _, socket) do
    socket = assign_defaults(socket)

    {:noreply, socket}
  end

  defp assign_defaults(socket) do
    assign(
      socket,
      boats: Boats.list_boats(),
      type: "",
      prices: []
    )
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
