defmodule SonaTechTestWeb.PostLive.Show do
  use SonaTechTestWeb, :live_view

  alias SonaTechTest.Posts
  alias SonaTechTest.Comments
  alias SonaTechTest.Accounts

  def mount(params, session, socket) do
    post_id = params["id"]
    changeset = Comments.Comment.changeset(%Comments.Comment{})

    current_user =
      if session["user_token"],
        do: Accounts.get_user_by_session_token(session["user_token"]),
        else: nil

    if connected?(socket), do: Comments.subscribe(post_id)

    post = Posts.get_post!(post_id)

    socket =
      socket
      |> assign(:page_title, "#{post.title}")
      |> assign(:post, post)
      |> assign(:comments, Comments.list_comments(post_id))
      |> assign(:new_comment, to_form(changeset))
      |> assign(:current_user, current_user)

    {:ok, socket}
  end

  def handle_event("new-comment", %{"comment" => payload}, socket) do
    params =
      payload
      |> Map.put("post_id", socket.assigns.post.id)

    case Comments.create_comment(params) do
      {:ok, _comment} ->
        {:noreply, socket}

      {:error, changeset} ->
        socket =
          socket
          |> assign(:new_comment, to_form(changeset))

        {:noreply, socket}
    end
  end

  def handle_info({:comment_created, comment}, socket) do
    {:noreply, update(socket, :comments, fn comments -> [comment | comments] end)}
  end
end
