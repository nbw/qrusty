############################
## ======== PNG  ======== ## 
############################

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


############################
## ======== SVG  ======== ## 
############################

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
Estimated total run time: 42 s

Benchmarking svg_eqrcode with input 100x100 QR (100 codes) ...
Benchmarking svg_eqrcode with input 200x200 QR (100 codes) ...
Benchmarking svg_eqrcode with input 500x500 QR (100 codes) ...
Benchmarking svg_qrusty with input 100x100 QR (100 codes) ...
Benchmarking svg_qrusty with input 200x200 QR (100 codes) ...
Benchmarking svg_qrusty with input 500x500 QR (100 codes) ...

##### With input 100x100 QR (100 codes) #####
Name                  ips        average  deviation         median         99th %
svg_qrusty          14.17       0.0706 s     ±7.74%       0.0691 s       0.0887 s
svg_eqrcode          0.33         3.02 s     ±0.65%         3.02 s         3.04 s

Comparison:
svg_qrusty          14.17
svg_eqrcode          0.33 - 42.83x slower +2.95 s

##### With input 200x200 QR (100 codes) #####
Name                  ips        average  deviation         median         99th %
svg_qrusty          14.10       0.0709 s     ±5.55%       0.0709 s       0.0817 s
svg_eqrcode          0.32         3.12 s     ±0.51%         3.12 s         3.13 s

Comparison:
svg_qrusty          14.10
svg_eqrcode          0.32 - 44.02x slower +3.05 s

##### With input 500x500 QR (100 codes) #####
Name                  ips        average  deviation         median         99th %
svg_qrusty          13.90       0.0719 s     ±6.99%       0.0715 s       0.0870 s
svg_eqrcode          0.32         3.16 s     ±2.20%         3.16 s         3.21 s

Comparison:
svg_qrusty          13.90
svg_eqrcode          0.32 - 43.87x slower +3.08 s


############################
## ======== JPG  ======== ## 
############################

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


