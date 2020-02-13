# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 11.5cm,6.0cm preamble '\RequirePackage[tt=false, type1=true]{libertine} \RequirePackage[varqu]{zi4} \RequirePackage[libertine]{newtxmath} \RequirePackage[T1]{fontenc}'
set output "gen-" . ARG0[:(strlen(ARG0)-strlen(".gnuplot"))] . ".tex"

load "chromadiverge.pal"

set xrange [0.00:1.0]
set yrange [1:1e6]
set xlabel "Edge probability"
set ylabel "Number of recursive calls"
set logscale y
set border 3
set grid ls 101
set xtics nomirror
set ytics nomirror
set key Right at screen 0.38, screen 0.92
set format y '$10^{%T}$'

plot \
    for [i=1:150] "data/rcc-150-0-1000-1000-100000-decide-" . i . ".mean_nodes" u ($1/1000.0):4 w l lc rgb '#666666' lw 1 notitle, \
    "data/rcc-150-0-1000-1000-100000.mean_nodes" u ($1/1000.0):4 w l ls 2 lw 3 ti "Total", \
    "data/rcc-150-0-1000-1000-100000.mean_find_nodes" u ($1/1000.0):4 w l ls 3 lw 3 ti "Find", \
    "data/rcc-150-0-1000-1000-100000.mean_prove_nodes" u ($1/1000.0):4 w l ls 4 lw 3 ti "Proof", \
    "" u (NaN):(NaN) w l lc rgb '#666666' lw 1 ti "Decision"

