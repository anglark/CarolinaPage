defmodule CarolinaPageWeb.PageController do
  use CarolinaPageWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
