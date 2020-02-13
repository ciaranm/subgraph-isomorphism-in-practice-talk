set terminal tikz standalone color size 11.5cm,6.0cm preamble '\RequirePackage[tt=false, type1=true]{libertine} \RequirePackage[varqu]{zi4} \RequirePackage[libertine]{newtxmath} \RequirePackage[T1]{fontenc}'
set output "gen-" . ARG0[:(strlen(ARG0)-strlen(".gnuplot"))] . ".tex"

load "glasgow.pal"
load "common.gnuplot"

set xrange [1e0:1e6]
set yrange [0:14500]
set xlabel "Runtime (ms)"
set ylabel "Instances Solved"
set logscale x
set border 3
set grid ls 101 front
set xtics nomirror
set ytics nomirror
set key off
set format x '$10^{%T}$'
set rmargin 10

plot \
    "runtimes.data" u (cumx(vf2)):(cumy(vf2)) smooth cumulative w l ti 'VF2' at end ls 8, \
    "runtimes.data" u (cumx(ri)):(cumy(ri)) smooth cumulative w l ti '\raisebox{-0.12cm}{RI}' at end ls 4, \
    "runtimes.data" u (cumx(pathlad)):(cumy(pathlad)) smooth cumulative w l ti '\raisebox{-0.0cm}{PathLAD}' at end ls 6, \
    "runtimes.data" u (cumx(final)):(cumy(final)) smooth cumulative w l ti '\raisebox{0.20cm}{Glasgow}' at end ls 5

