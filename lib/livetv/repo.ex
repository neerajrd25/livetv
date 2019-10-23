defmodule Livetv.Repo do
  use Ecto.Repo,
    otp_app: :livetv,
    adapter: Ecto.Adapters.MyXQL
end
