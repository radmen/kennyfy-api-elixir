defmodule KennyfyApp.ControllerTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias KennyfyApp.Controller, as: Controller

  setup do
    %{controller: Controller.init([])}
  end

  test "encode given text", %{controller: controller} do
    conn("POST", "/speak", %{text: "Lorem ipsum"})
    |> put_req_header("content-type", "application/json")
    |> Controller.call(controller)
    |> sent_resp()
    |> validate_response("Pmfppfpffmppppm mffpfmfmmfmfppm")
  end

  test "decode given text", %{controller: controller} do
    conn("POST", "/translate", %{text: "Pmfppfpffmppppm mffpfmfmmfmfppm"})
    |> put_req_header("content-type", "application/json")
    |> Controller.call(controller)
    |> sent_resp()
    |> validate_response("Lorem ipsum")
  end

  test "return 404 for other routes", %{controller: controller} do
    {status, _headers, _body} =
      conn("GET", "/")
      |> Controller.call(controller)
      |> sent_resp()

    assert status == 404
  end

  defp validate_response({status, headers, body}, expected_text) do
    {:ok, data} = Poison.decode(body)

    assert status == 200
    assert {"content-type", "application/json; charset=utf-8"} in headers
    assert Map.get(data, "text") == expected_text
  end
end
