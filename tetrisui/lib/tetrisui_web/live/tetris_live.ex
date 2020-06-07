defmodule TetrisuiWeb.TetrisLive do
  use Pheonix.LiveView
  import Pheonix.HTML, only: [raw: 1]

  def mount(_session, socket) do
    {
        :ok,
      assign(socket,
        hello: world,
        next: :key
        )
    }
  end

  def render(assigns) do
    ~L"""
      <h1>Hello, world</h1>
    """
  end
end
