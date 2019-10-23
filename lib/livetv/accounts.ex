defmodule Livetv.Accounts do
  alias Livetv.Accounts.User
  alias Livetv.Repo

  def list_users do
    Repo.all(User)
  end

  def get_user(id) do
    Repo.get(User, id)
    # Enum.find(list_users(), fn elem -> elem.id == id end)
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def get_user_by(params) do
    Repo.get_by(User, params)
    # Enum.find(list_users(), fn elem ->
    #   Enum.all?(params, fn {key, val} -> Map.get(elem, key) == val end)
    # end)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def change_registration(%User{} = user, params) do
    User.registration_changeset(user, params)
  end

  def register_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def authenticate_by_username_and_pass(username, given_pass) do
    user = get_user_by(username: username)
    IO.puts "Signing in"
    IO.puts inspect(user)
    cond do
      user && Pbkdf2.verify_pass(given_pass, user.password_hash) ->
        {:ok, user}

      user ->
        {:error, :unauthorized}

      true ->
        Pbkdf2.no_user_verify()
        {:error, :not_found}
    end
  end
end
