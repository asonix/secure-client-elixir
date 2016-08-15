defmodule Client.Decoders.Encrypted do
  @behaviour Client.Decoders

  def headers, do: %{"Accept" => "application/encrypted"}

  def decode(data),
    do: data |> :base64.decode |> Cloak.decrypt |> Poison.decode

  def decode!(data),
    do: data |> :base64.decode |> Cloak.decrypt |> Poison.decode!

end
