defmodule AuthorizationWithPow.Users.Test do
  use AuthorizationWithPow.DataCase, async: true

  alias AuthorizationWithPow.Users.User

  test "changeset is invalid if password and confirmation do not match" do
    changeset =
      User.changeset(%User{}, %{
        email: "email@email.com",
        username: "username",
        first_name: "fa",
        last_name: "fa",
        password: "foo",
        password_confirmation: "bar",
      })

    assert %{password_confirmation: ["does not match confirmation"]} = errors_on(changeset)
  end

  test "changeset is invalid if password length is < 8" do
    changeset =
      User.changeset(%User{}, %{
        email: "email@email.com",
        username: "username",
        first_name: "fa",
        last_name: "fa",
        password: "foo",
        password_confirmation: "bar",
      })

    assert %{password: ["should be at least 8 character(s)"]} = errors_on(changeset)
  end

end
