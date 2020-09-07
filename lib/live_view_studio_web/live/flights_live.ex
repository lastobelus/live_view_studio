defmodule LiveViewStudioWeb.FlightsLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Flights

  def mount(_params, _session, socket) do
    socket = assign(
      socket,
      flight_number: "",
      flights: Flights.list_flights(),
      loading: false
    )
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Find a Flight</h1>

    <div id="search">
      <form phx-submit="flight_number_search">
        <input type="text" name="flight_number" value="<%= @flight_number %>"
              autofocus autocomplete="off"
              placeholder=""
              <%= if @loading, do: "readonly" %>
              />
        <button type="submit">
          <img src="images/search.svg">
        </button>
      </form>

      <%= if @loading do %>
        <div class="loader">Loading...</div>
      <% end %>

      <div class="flights">
        <ul>
          <%= for flight <- @flights do %>
            <li>
              <div class="first-line">
                <div class="number">
                  Flight #<%= flight.number %>
                </div>
                <div class="origin-destination">
                  <img src="images/location.svg">
                  <%= flight.origin %> to
                  <%= flight.destination %>
                </div>
              </div>
              <div class="second-line">
                <div class="departs">
                  Departs: <%= flight.departure_time %>
                </div>
                <div class="arrives">
                  Arrives: <%= flight.arrival_time %>
                </div>
              </div>
            </li>
          <% end %>
        </ul>
      </div>
    </div>
    """
  end

  def handle_event("flight_number_search", %{"flight_number" => flight_number}, socket) do
    send(self(), {:run_flight_number_search, flight_number})
    socket = assign(
      socket,
      loading: true,
      flight_number: flight_number,
      flights: []
    )
    {:noreply, socket}
  end

  def handle_info({:run_flight_number_search, flight_number}, socket) do
    case Flights.search_by_number(flight_number) do
      [] ->
        socket =
          socket
          |> put_flash(:error, "No flights matching \"#{flight_number}\"")
          |> assign(loading: false, flights: [])
        {:noreply, socket}

      flights ->
        socket =
          socket
          |> clear_flash()
          |> assign(loading: false, flights: flights)
        {:noreply, socket}
    end


  end
end
