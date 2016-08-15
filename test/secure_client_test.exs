defmodule SecureClientTest do
  use ExUnit.Case
  doctest SecureClient

  @generic_data %{"test" => "test"}

  test "Encrypted.encode encodes data" do
    with {:ok, encoded} <- Client.Encoders.Encrypted.encode(@generic_data),
      do: assert is_binary(encoded)
  end

  test "Encrypted.decode decodes encoded data" do
    with {:ok, encoded} <- Client.Encoders.Encrypted.encode(@generic_data),
      do: with {:ok, decoded} <- Client.Decoders.Encrypted.decode(encoded),
        do: assert @generic_data == decoded
  end

  test "Encrypted.encode! encodes data" do
    assert is_binary(Client.Encoders.Encrypted.encode!(@generic_data))
  end

  test "Encrypted.decode! decodes encoded data" do
    decoded = @generic_data
      |> Client.Encoders.Encrypted.encode!
      |> Client.Decoders.Encrypted.decode!

    assert decoded == @generic_data
  end

end
