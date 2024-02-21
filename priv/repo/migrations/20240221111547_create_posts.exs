defmodule SonaTechTest.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :text
      add :description, :text

      timestamps(type: :utc_datetime)
    end
  end
end
