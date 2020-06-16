defmodule KennyfyApp.Controller do
  use Plug.Router

  plug(Plug.Logger)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  plug(:match)
  plug(:dispatch)

  post "/speak" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{text: encode(conn.body_params)}))
  end

  post "/translate" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{text: decode(conn.body_params)}))
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end

  defp encode(%{"text" => text}), do: Kennyfy.encode(text)

  defp decode(%{"text" => text}), do: Kennyfy.decode(text)
end
