# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 11.5cm,6.0cm preamble '\RequirePackage[tt=false, type1=true]{libertine} \RequirePackage[varqu]{zi4} \RequirePackage[libertine]{newtxmath} \RequirePackage[T1]{fontenc}'
set output "gen-" . ARG0[:(strlen(ARG0)-strlen(".gnuplot"))] . ".tex"

load "chromadiverge.pal"

set xrange [0.00:1.0]
set yrange [1:1e5]
set xlabel "Edge probability"
set ylabel "Number of recursive calls"
set logscale y
set border 11
set grid ls 101 front
set xtics nomirror
set ytics nomirror
set key Right at screen 0.42, screen 0.82
set format y '$10^{%T}$'
set y2tics
set y2label "Proportion SAT" rotate by 270 offset character -1, character 0

set title 'Does $G(150, x)$ contain a clique of twenty vertices?'

plot \
    "data/rcc-150-0-1000-1000-100000-decide-20.mean_sat_nodes" u ($1/1000):($3/100000) w filledcurve x1 axes x1y2 ls 10 ti "Sat?", \
    "data/rcc-150-0-1000-1000-100000-decide-20.mean_nodes" u ($1/1000):($4) w l ls 1 lw 3 ti "Mean Search"

