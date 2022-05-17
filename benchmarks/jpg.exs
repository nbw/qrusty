# QR
input = "https://elixir-lang.org/"
format = :jpg
inputs = %{
  "100" => 100,
  "200" => 200,
  "500" => 500
}

qrusty = fn _ ->
  {:ok, _ } = Qrusty.qr(input, format, width: width, height: height)
end

# "eqrcode" does not support a JPG format

Benchee.run(
  %{
    "#{format}_qrusty" => fn -> Enum.each(1..10, qrusty) end,
  }
  formatters: [
    # Benchee.Formatters.HTML,
    Benchee.Formatters.Console
  ]
)
