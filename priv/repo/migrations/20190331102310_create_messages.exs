defmodule SimpleChat.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :text, :string
      add :sender, :string

      timestamps()
    end

  end
end
