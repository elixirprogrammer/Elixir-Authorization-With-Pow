defmodule AuthorizationWithPowWeb.Pow.Messages do
  use Pow.Phoenix.Messages
  import AuthorizationWithPowWeb.Gettext

  def signed_in(_conn), do: gettext("Welcome Back!")
end
