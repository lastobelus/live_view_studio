defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  # called when a request comes from the router.
  # initializes state of the socket
  # params: map containing query & router params
  def mount(_params, _session, socket) do
    IO.puts "MOUNT #{inspect(self())}"
    socket = assign(socket, :brightness, 10)
    # IO.inspect socket
    {:ok, socket}
  end

  def render(assigns) do
    IO.puts "RENDER #{inspect(self())}"
    ~L"""
    <h1>Front Porch Light</h1>
    <div id="light">
      <div class="meter">
        <span style="width: <%= @brightness %>%">
          <%= @brightness %>%
        </span>

      </div>
      <button phx-click="off">
        <img src="images/light-off.svg">
      </button>

      <button phx-click="down">
        <img src="images/down.svg">
      </button>

      <button phx-click="up">
        <img src="images/up.svg">
      </button>

      <button phx-click="on">
        <img src="images/light-on.svg">
      </button>

      <button phx-click="random">
        random
      </button>

      <div>
        <form phx-change="update">
          <input type="range" min="0" max="100"
                name="brightness" value="<%= @brightness %>" />
        </form>
      </div>

    </div>

    """
  end



  # whenever a liveview state changes, render is automatically called to re-render
  # with the new state. The new render is diffed for changes and the changes sent
  # to the client
  def handle_event("on", _event_metadata, socket) do
    IO.puts "ON #{inspect(self())}"
    socket = assign(socket, :brightness, 100)
    {:noreply, socket}
  end

  def handle_event("off", _event_metadata, socket) do
    IO.puts "OFF #{inspect(self())}"
    socket = assign(socket, :brightness, 0)
    {:noreply, socket}
  end

  def handle_event("up", _event_metadata, socket) do
    brightness = socket.assigns.brightness
    socket = assign(socket, :brightness, brightness + 10)
    {:noreply, socket}
  end

  def handle_event("down", _event_metadata, socket) do
    # &() is shorthand capture syntax for creating an anonymous function
    # function will receive the current value of the socket key
    # &1 represents first argument to function
    # socket = update(socket, :brightness, &(&1 - 10)) # -- doesn't stop at 0
    socket = update(socket, :brightness, &min(&1 - 10, 0))
    {:noreply, socket}
  end

    def handle_event("random", _event_metadata, socket) do
    # &() is shorthand capture syntax for creating an anonymous function
    # function will receive the current value of the socket key
    # &1 represents first argument to function
    socket = assign(socket, :brightness, Enum.random(0..100))
    {:noreply, socket}
  end


    def handle_event("update", %{"brightness" => brightness}, socket) do
    # &() is shorthand capture syntax for creating an anonymous function
    # function will receive the current value of the socket key
    # &1 represents first argument to function
    brightness = String.to_integer(brightness)
    socket = assign(socket, :brightness, brightness)
    {:noreply, socket}
  end
end
