defmodule AuthorizationWithPowWeb.PowResetPassword.MailerView do
  use AuthorizationWithPowWeb, :mailer_view

  def subject(:reset_password, _assigns), do: "Reset password link"
end
