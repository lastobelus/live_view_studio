defmodule LiveViewStudioWeb.FlightsLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Flights
  alias LiveViewStudio.Airports


  def mount(_params, _session, socket) do
    socket = assign(
      socket,
      flight_number: "",
      airport: "",
      airport_matches: [],
      flights: Flights.list_flights(),
      loading: false
    )
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Find a Flight</h1>

    <div id="search">
      <div class="flex justify-center">
        <form phx-submit="flight-number-search" class="m-3">
          <input type="text" name="flight_number" value="<%= @flight_number %>"
                autofocus autocomplete="off"
                placeholder="Flight Number"
                <%= if @loading, do: "readonly" %>
                />
          <button type="submit">
            <img src="images/search.svg">
          </button>
        </form>

        <form phx-submit="airport-search" phx-change="suggest-airport" class="m-3">
          <input type="text" name="airport" value="<%= @airport %>"
                autocomplete="off"
                placeholder="Airport Code"
                list="airport_list"
                debounce="250"
                <%= if @loading, do: "readonly" %>
                />
          <button type="submit">
            <img src="images/search.svg">
          </button>

        </form>
      </div>


      <datalist id="airport_list">
        <%= for airport_match <- @airport_matches do %>
          <option value="<%= airport_match %>"><%= airport_match %></option>
        <% end %>
      </datalist>

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

  def handle_event("flight-number-search", %{"flight_number" => flight_number}, socket) do
    if not is_blank?(flight_number) do
      send(self(), {:run_search, &Flights.search_by_number/1, flight_number})
      socket = assign(
        socket,
        loading: true,
        flight_number: flight_number,
        flights: []
      )
    end
    {:noreply, socket}
  end

  def handle_event("suggest-airport", %{"airport" => airport}, socket) do
    socket = assign(
      socket,
      airport_matches: Airports.suggest(airport)
    )
    {:noreply, socket}
  end

  def handle_event("airport-search", %{"airport" => airport}, socket) do
    if not is_blank?(airport) do
      send(self(), {:run_search, &Flights.search_by_airport/1, airport})
      socket = assign(
        socket,
        loading: true,
        airport: airport,
        flights: []
      )
    end
    {:noreply, socket}
  end


  def handle_info({:run_search, search_fn, query}, socket) do
    case search_fn.(query) do
      [] ->
        socket =
          socket
          |> put_flash(:error, "No flights matching \"#{query}\"")
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

  defp is_blank? value do
    "" == value |> to_string() |> String.trim()
  end
end
