# SecureClient

Secure encoding and decoding for
[HTTPClient](https://github.com/asonix/http-client-elixir) using
[Cloak](https://github.com/danielberkompas/cloak)
([docs](https://hexdocs.pm/cloak/Cloak.html)) for Encryption and decryption.
Companion project to [SecureServer](https://github.com/asonix/secure-server-elixir).

## Installation

  1. Add `secure_client` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:secure_client, "~> 0.1.0"}]
    end
    ```

  2. Ensure `secure_client` is started before your application:

    ```elixir
    def application do
      [applications: [:secure_client]]
    end
    ```

## Configuration

```elixir
# config/config.exs

config :cloak, Cloak.AES.CTR,
  # Note, this config must be identical to the one used in your server
  # See https://github.com/danielberkompas/cloak for more details encryption
  tag: "AES",
  default: true,
  keys: [
    %{
      tag: <<1>>,
      key: :base64.decode(System.get_env("YOUR_SYMMETRIC_KEY")),
      default: true
    }
  ]

```
See [Cloak](https://github.com/danielberkompas/cloak) for more info about
encryption.

## Usage

secure_client provides Encoders and Decoders as defined in the behaviours from Client

```elixir
do_request(href, payload, headers,
  Client.Encoders.Encrypted,
  Client.Decoders.Encrypted,
  &Client.post(&1, &2, &3)
)
```

### Helpers

To make things easier, make a helper (or 5)

```elixir
def get_json(href, payload, headers)
  do_request(href, payload, headers,
    Client.Encoders.GETURLEncoded,
    Client.Decoders.Encrypted,
    &Client.get(&1, &2, &3)
  )
end

def post_json(href, payload, headers)
  do_request(href, payload, headers,
    Client.Encoders.Encrypted,
    Client.Decoders.Encrypted,
    &Client.post(&1, &2, &3)
  )
end

... # etc

def delete_json(href, headers)
  do_request(href, %{}, headers,
    Client.Encoders.NilEncoder,
    Client.Decoders.Encrypted,
    &Client.delete(&1, &2, &3)
  )
end
```

## Secure Server

See [SecureServer](https://github.com/asonix/secure-server-elixir) for details
on creating a phoenix server to interact with this client.

## License

```
Copyright © 2016 Riley Trautman, <asonix.dev@gmail.com>

This work is free. You can redistribute it and/or modify it under the
terms of the MIT License. See the LICENSE file for more details.
```
