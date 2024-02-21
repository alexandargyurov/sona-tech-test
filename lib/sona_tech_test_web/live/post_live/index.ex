defmodule SonaTechTestWeb.PostLive.Index do
  use SonaTechTestWeb, :live_view

  alias SonaTechTest.Posts

  def mount(_params, _session, socket) do
    if connected?(socket), do: Posts.subscribe()

    socket =
      socket
      |> assign(:page_title, "All posts")
      |> assign(:posts, Posts.list_posts())

    {:ok, socket}
  end

  def handle_info({:post_created, post}, socket) do
    {:noreply, update(socket, :posts, fn posts -> [post | posts] end)}
  end
end
