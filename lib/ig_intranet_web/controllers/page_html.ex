defmodule IgIntranetWeb.PageHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use IgIntranetWeb, :html

  def switch_locale_path(locale, language) do
    ~s|<a href="/?locale=#{locale}">#{language}</a>| |> Phoenix.HTML.raw()
  end

  embed_templates "page_html/*"
end
