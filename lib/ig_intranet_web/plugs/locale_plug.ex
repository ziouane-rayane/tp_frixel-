defmodule IgIntranetWeb.Plugs.Locale do
  @moduledoc """
  Custom plug to deal with locale.

  """
  import Plug.Conn

  @locales Gettext.known_locales(IgIntranetWeb.Gettext)

  def init(_opts), do: nil

  def call(%Plug.Conn{params: %{"locale" => locale}} = conn, _opts) when locale in @locales do
    conn |> get_session(:locale)
    Gettext.put_locale(IgIntranetWeb.Gettext, locale)

    # le put_session sert à persister le choix de la langue au changement de page
    conn |> put_session(:locale, locale)
  end

  def call(conn, _opts) do
    # on récupère l'éventuel choix de langue précédent
    locale = conn |> get_session(:locale)
    Gettext.put_locale(IgIntranetWeb.Gettext, locale)
    conn
  end
end
