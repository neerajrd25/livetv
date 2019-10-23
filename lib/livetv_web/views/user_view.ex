defmodule LivetvWeb.UserView do
  use LivetvWeb, :view
  alias Livetv.Accounts

  def first_name(%Accounts.User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end
end
