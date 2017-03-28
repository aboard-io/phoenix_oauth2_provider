defmodule ExOauth2Phoenix.Test.Fixture do
  alias ExOauth2Phoenix.Test.Repo
  alias ExOauth2Phoenix.Test.User
  alias ExOauth2Provider.OauthAccessTokens
  alias ExOauth2Provider.OauthApplications

  def fixture(:user) do
    {:ok, user} = %User{}
    |> User.changeset(%{email: "user@example.com"})
    |> Repo.insert

    user
  end

  def fixture(:application, %{user: user} = attrs) do
    attrs = Map.merge(%{name: "Example", redirect_uri: "https://example.com"}, attrs)
    {:ok, application} = OauthApplications.create_application(user, attrs)

    application
  end
  def fixture(:access_token, %{application: application, user: user} = attrs) do
    attrs = %{
      redirect_uri: application.redirect_uri,
      application: application,
    }
    |> Map.merge(attrs)

    {:ok, access_token} = user
    |> OauthAccessTokens.create_token(attrs)

    access_token
  end
end