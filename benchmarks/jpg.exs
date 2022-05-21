input = "https://elixir-lang.org/"
format = :jpg
times = 100
inputs = %{
  "100x100 QR (#{times} codes)" => 100,
  "200x200 QR (#{times} codes)" => 200,
  "500x500 QR (#{times} codes)" => 500
}

qrusty = fn size ->
  {:ok, _qr} = Qrusty.qr(input, format, size: size)
end

# "eqrcode" does not support a JPG format
Benchee.run(
  %{
    "#{format}_qrusty" => fn size -> Enum.each(1..times, fn _ -> qrusty.(size) end) end,
  },
  inputs: inputs
)
