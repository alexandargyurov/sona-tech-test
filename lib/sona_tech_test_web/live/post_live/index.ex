defmodule SonaTechTestWeb.PostLive.Index do
  use SonaTechTestWeb, :live_view

  alias SonaTechTest.Posts

  def mount(_params, _session, socket) do
    socket = socket |> assign(:posts, Posts.list_posts())

    {:ok, socket}
  end
end