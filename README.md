# Qrusty

QR Code generator that leverages [precompiled Rust](https://github.com/philss/rustler_precompiled).

The "precompiled" implies that using this library does not require installing Rust.

## Installation

QRusty at the moment is NOT on Hex.

~~The package can be installed by adding `qrusty` to your list of dependencies in `mix.exs`:~~

```elixir
def deps do
  [
    {:qrusty, github: "nbw/qrusty"}
  ]
end
```

## Usage

The following QR formats are supported:

- SVG (`:svg`)
- PNG (`:png`)
- JPG (`:jpg`)
- base64 PNG (`:png64`)
- base64 JPG (`:jpg64`)

### SVG

```elixir
> {:ok, %Qrusty.QR{encoded_data: svg}} = Qrusty.qr("https://elixir-lang.org/", :svg, size: 200)

File.write("./samples/qr.svg", svg)
```

### PNG/JPG

```elixir
> {:ok, %Qrusty.QR{encoded_data: binary}} = Qrusty.qr("https://elixir-lang.org/", :png, width: 200, height: 200)

File.write("./samples/qr.png", binary)

> {:ok, %Qrusty.QR{encoded_data: binary}} = Qrusty.qr("https://elixir-lang.org/", :jpg, width: 200, height: 200)

File.write("./samples/qr.jpg", binary)
```

### Base64 PNG/JPG

```elixir
# :png64 or :jpg64
> {:ok, %Qrusty.QR{encoded_data: binary_64}} = Qrusty.qr("https://elixir-lang.org/", :png64, width: 200, height: 200)

# Heex Template (for example)
<a href={"data:image/png;base64, " <> binary_64} download="qr.png">
  <img src={"data:image/png;base64, "<> binary_64}></img>
</a>
```

| Format | Sample                           |
| ------ | -------------------------------- |
| SVG    | ![ svg ](/samples/qr.svg)        |
| PNG    | ![ png ](/samples/qr.png)        |
| JPG    | ![ jpg ](/samples/qr.jpg)        |
| PNG64  | [ sample ](/samples/base65.html) |
| JPG64  | --                               |

## Benchmarks

For raw benchmarks comparing Qrusty to [EQRCode](https://github.com/SiliconJungles/eqrcode), run the following:

```
mix run benchee/png.exs
mix run benchee/svg.exs
```

## Development

You will need the following installed:

- Elixir
- Rust
- [Cross](https://github.com/cross-rs/cross)

### Compiling QRusty

```
mix compile.local
```

## Contributions

Contributions are welcome.

### Rust Contribution Rules

- The Rust layer should be as thin as possible
- The Rust layer should not deal with errors caused by human input (ex: invalid input args). Deal with interface errors in Elixir
- Default values, etc. should all be handled on the Elixir side

Basically, the end user is an Elixir developer, so keep as much code as possible in Elixir for readability. Leverage Rust only for it's performance benefits/access to system level libraries, etc. 🙏
