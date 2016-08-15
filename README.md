# SecureClient

Secure encoding and decoding for [HTTPClient](https://github.com/asonix/http-client-elixir)

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

info coming soon...
