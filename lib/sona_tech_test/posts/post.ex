defmodule SonaTechTest.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :description, :string
    field :title, :string

    belongs_to :user, SonaTechTest.Accounts.User

    has_many :comments, SonaTechTest.Posts.Comment

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs \\ %{}) do
    post
    |> cast(attrs, [:title, :description, :user_id])
    |> validate_required([:title, :description])
  end
end
