# QR
input = "https://elixir-lang.org/"
format = :png
inputs = %{
  "100" => 100,
  "200" => 200,
  "500" => 500
}

qrusty = fn size ->
  Qrusty.qr(input, format, width: size, height: size)
end

eqrcode = fn size ->
  input
  |> EQRCode.encode()
  |> EQRCode.png(width: size, height: size)
end

Benchee.run(
  %{
    "#{format}_qrusty" => fn size -> Enum.each(1..10, fn _ -> qrusty.(size) end) end,
    "#{format}_eqrcode" => fn size -> Enum.each(1..10, fn _ -> eqrcode.(size) end) end,
  },
  inputs: inputs,
  formatters: [
    # Benchee.Formatters.HTML,
    Benchee.Formatters.Console
  ]
)
