defmodule SonaTechTestWeb.PostLive.New do
  use SonaTechTestWeb, :live_view

  alias SonaTechTest.Posts

  def mount(_params, _session, socket) do
    changeset = Posts.Post.changeset(%Posts.Post{})

    socket =
      socket
      |> assign(:page_title, "Create post")
      |> assign(:form, to_form(changeset))

    {:ok, socket}
  end

  def handle_event("submit", %{"post" => payload}, socket) do
    params =
      payload
      |> Map.put("user_id", socket.assigns.current_user.id)

    case Posts.create_post(params) do
      {:ok, _post} ->
        socket =
          socket
          |> put_flash(:info, "Post created successfully")
          |> push_navigate(to: ~p"/")

        {:noreply, socket}

      {:error, changeset} ->
        socket =
          socket
          |> assign(:form, to_form(changeset))

        {:noreply, socket}
    end
  end
end
