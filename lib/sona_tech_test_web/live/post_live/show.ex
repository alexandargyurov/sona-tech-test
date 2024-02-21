defmodule SonaTechTestWeb.PostLive.Show do
  use SonaTechTestWeb, :live_view

  alias SonaTechTest.Posts

  def mount(params, _session, socket) do
    socket =
      socket
      |> assign(:post, Posts.get_post!(params["id"]))

    {:ok, socket}
  end
end
