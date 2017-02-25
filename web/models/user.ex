defmodule Discuss.User do
  use Discuss.Web, :model

  schema "users" do
    field :email, :string
    field :username, :string
    field :status, :string
    field :image_url, :string
    field :auth_provider, :string
    field :auth_token, :string
    has_many :topics, Discuss.Topic
    has_many :comments, Discuss.Comment
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :username, :image_url, :auth_provider, :auth_token])
    |> validate_required([:email, :username, :auth_provider, :auth_token])
  end

  def upsert(changeset) do
    case Discuss.Repo.get_by(Discuss.User, email: changeset.changes.email) do
      nil -> Discuss.Repo.insert(changeset)
      user -> {:ok, user}
    end
  end
end

