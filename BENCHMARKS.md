# PNG

```
qrusty ~ mix run benchmarks/png.exs
Operating System: macOS
CPU Information: Intel(R) Core(TM) i7-1060NG7 CPU @ 1.20GHz
Number of Available Cores: 8
Available memory: 16 GB
Elixir 1.12.2
Erlang 24.0.6

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 ns
reduction time: 0 ns
parallel: 1
inputs: 100x100 QR (100 codes), 200x200 QR (100 codes), 500x500 QR (100 codes)
Estimated total run time: 42 s

Benchmarking png_eqrcode with input 100x100 QR (100 codes) ...
Benchmarking png_eqrcode with input 200x200 QR (100 codes) ...
Benchmarking png_eqrcode with input 500x500 QR (100 codes) ...
Benchmarking png_qrusty with input 100x100 QR (100 codes) ...
Benchmarking png_qrusty with input 200x200 QR (100 codes) ...
Benchmarking png_qrusty with input 500x500 QR (100 codes) ...

##### With input 100x100 QR (100 codes) #####
Name                  ips        average  deviation         median         99th %
png_qrusty          10.51       0.0952 s     ±6.01%       0.0945 s        0.122 s
png_eqrcode          0.38         2.61 s     ±0.11%         2.61 s         2.61 s

Comparison:
png_qrusty          10.51
png_eqrcode          0.38 - 27.43x slower +2.52 s

##### With input 200x200 QR (100 codes) #####
Name                  ips        average  deviation         median         99th %
png_qrusty           6.68        0.150 s     ±4.83%        0.149 s        0.166 s
png_eqrcode          0.35         2.82 s     ±3.25%         2.82 s         2.89 s

Comparison:
png_qrusty           6.68
png_eqrcode          0.35 - 18.86x slower +2.67 s

##### With input 500x500 QR (100 codes) #####
Name                  ips        average  deviation         median         99th %
png_qrusty           2.07         0.48 s     ±4.04%         0.48 s         0.54 s
png_eqrcode          0.29         3.48 s     ±2.00%         3.48 s         3.53 s

Comparison:
png_qrusty           2.07
png_eqrcode          0.29 - 7.21x slower +3.00 s
```

# SVG

[last run: 2022/05/30]

```
qrusty ~ mix run benchmarks/svg.exs
Operating System: macOS
CPU Information: Intel(R) Core(TM) i7-1060NG7 CPU @ 1.20GHz
Number of Available Cores: 8
Available memory: 16 GB
Elixir 1.12.2
Erlang 24.0.6

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 ns
reduction time: 0 ns
parallel: 1
inputs: 100x100 QR (100 codes), 200x200 QR (100 codes), 500x500 QR (100 codes)
Estimated total run time: 1.05 min

Benchmarking svg_eqrcode with input 100x100 QR (100 codes) ...
Benchmarking svg_eqrcode with input 200x200 QR (100 codes) ...
Benchmarking svg_eqrcode with input 500x500 QR (100 codes) ...
Benchmarking svg_qr_code with input 100x100 QR (100 codes) ...
Benchmarking svg_qr_code with input 200x200 QR (100 codes) ...
Benchmarking svg_qr_code with input 500x500 QR (100 codes) ...
Benchmarking svg_qrusty with input 100x100 QR (100 codes) ...
Benchmarking svg_qrusty with input 200x200 QR (100 codes) ...
Benchmarking svg_qrusty with input 500x500 QR (100 codes) ...

##### With input 100x100 QR (100 codes) #####
Name                  ips        average  deviation         median         99th %
svg_qrusty          16.96       58.96 ms     ±4.88%       59.45 ms       65.25 ms
svg_qr_code          1.43      700.02 ms     ±2.69%      705.75 ms      722.42 ms
svg_eqrcode          0.40     2503.15 ms     ±3.04%     2503.15 ms     2556.95 ms

Comparison:
svg_qrusty          16.96
svg_qr_code          1.43 - 11.87x slower +641.07 ms
svg_eqrcode          0.40 - 42.46x slower +2444.19 ms

##### With input 200x200 QR (100 codes) #####
Name                  ips        average  deviation         median         99th %
svg_qrusty          16.78       59.61 ms     ±5.36%       59.48 ms       66.47 ms
svg_qr_code          1.42      702.20 ms     ±1.47%      699.68 ms      720.98 ms
svg_eqrcode          0.39     2545.46 ms     ±3.13%     2545.46 ms     2601.82 ms

Comparison:
svg_qrusty          16.78
svg_qr_code          1.42 - 11.78x slower +642.59 ms
svg_eqrcode          0.39 - 42.70x slower +2485.85 ms

##### With input 500x500 QR (100 codes) #####
Name                  ips        average  deviation         median         99th %
svg_qrusty          16.71       59.86 ms     ±5.30%       59.95 ms       65.86 ms
svg_qr_code          1.39      719.70 ms     ±2.94%      714.83 ms      759.50 ms
svg_eqrcode          0.39     2557.34 ms     ±1.40%     2557.34 ms     2582.59 ms

Comparison:
svg_qrusty          16.71
svg_qr_code          1.39 - 12.02x slower +659.84 ms
svg_eqrcode          0.39 - 42.72x slower +2497.48 ms
```

# JPG

```
qrusty ~ mix run benchmarks/jpg.exs
Operating System: macOS
CPU Information: Intel(R) Core(TM) i7-1060NG7 CPU @ 1.20GHz
Number of Available Cores: 8
Available memory: 16 GB
Elixir 1.12.2
Erlang 24.0.6

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 ns
reduction time: 0 ns
parallel: 1
inputs: 100x100 QR (100 codes), 200x200 QR (100 codes), 500x500 QR (100 codes)
Estimated total run time: 21 s

Benchmarking jpg_qrusty with input 100x100 QR (100 codes) ...
Benchmarking jpg_qrusty with input 200x200 QR (100 codes) ...
Benchmarking jpg_qrusty with input 500x500 QR (100 codes) ...

##### With input 100x100 QR (100 codes) #####
Name                 ips        average  deviation         median         99th %
jpg_qrusty         10.18       98.21 ms     ±4.51%       97.48 ms      110.02 ms

##### With input 200x200 QR (100 codes) #####
Name                 ips        average  deviation         median         99th %
jpg_qrusty          4.81      207.93 ms     ±3.95%      207.71 ms      232.28 ms

##### With input 500x500 QR (100 codes) #####
Name                 ips        average  deviation         median         99th %
jpg_qrusty          2.67      374.62 ms    ±10.49%      366.16 ms      457.37 ms
```
