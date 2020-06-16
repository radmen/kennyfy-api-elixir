# KennyfyApp

KennySpeak-as-a-service. Written in Elixir.

## Usage

First, start the server:

```
mix run --no-halt
```

### API endpoints

Convert to kennyspeak:

```
curl --location \
  --request POST 'localhost:4000/speak' \
  --header 'Content-Type: application/json' \
  --data-raw '{"text": "Hello there!"}'
```

Decode kennyspeak:

```
curl --location \
  --request POST 'localhost:4000/translate' \
  --header 'Content-Type: application/json' \
  --data-raw '{
      "text": "Mfpmpppmfpmfppf fmpmfpmpppffmpp!"
  }'
```
