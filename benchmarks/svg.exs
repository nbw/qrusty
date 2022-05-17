# QR
input = "https://elixir-lang.org/"
width = 500
height = 500
format = :svg

qrusty = fn size ->
  {:ok, _ } = Qrusty.qr(input, format, size: size)
end

eqrcode = fn size ->
  input
  |> EQRCode.encode()
  |> EQRCode.svg(width: size, height: size)
end

Benchee.run(
  %{
    "#{format}_qrusty" => fn -> Enum.each(1..10, qrusty) end,
    "#{format}_eqrcode" => fn -> Enum.each(1..10, eqrcode) end,
  }
)
