defmodule SonaTechTest.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :msg, :string

    belongs_to :post, SonaTechTest.Posts.Post
    belongs_to :user, SonaTechTest.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(comment, attrs \\ %{}) do
    comment
    |> cast(attrs, [:msg, :post_id, :user_id])
    |> validate_required([:msg, :post_id, :user_id])
  end
end
