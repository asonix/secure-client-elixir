defmodule Client.Encoders.Encrypted do
  @behaviour Client.Encoders

  def headers, do: %{"Content-Type" => "application/encrypted"}

  def encode(payload) do
    with {:ok, json} <- Poison.encode(payload),
      do: {:ok, Cloak.encrypt(json) |> :base64.encode }
  end

  def encode!(payload),
    do: payload |> Poison.encode! |> Cloak.encrypt |> :base64.encode

end
