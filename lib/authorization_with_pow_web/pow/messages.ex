defmodule AuthorizationWithPowWeb.Pow.Messages do
  use Pow.Phoenix.Messages
  use Pow.Extension.Phoenix.Messages,
    extensions: [PowResetPassword]
  import AuthorizationWithPowWeb.Gettext

  def signed_in(_conn), do: gettext("Welcome Back!")
  def pow_reset_password_a_message(_conn), do: gettext("Email was sent to reset your password!.")
end
