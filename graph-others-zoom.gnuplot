# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 9cm,6.5cm font '\scriptsize' preamble '\usepackage{microtype}'
set output "gen-graph-others-zoom.tex"

load "common.gnuplot"

set xlabel "Runtime (ms)"
set ylabel "Number of Sat Instances Solved"
set xrange [1e2:1e6]
set logscale x
set format x '$10^{%T}$'
set format y '$~%.0f$'
set yrange [1200:2100]
set key off

plot \
    "runtimes.data" u (cumx(norestarts)):(cumsaty(norestarts)) smooth cumulative w l ti 'Ours' at end ls 1, \
    "runtimes.data" u (cumx(pathlad)):(cumsaty(pathlad)) smooth cumulative w l ti 'PathLAD' at end ls 6, \
    "runtimes.data" u (cumx(vf2)):(cumsaty(vf2)) smooth cumulative w l ti 'VF2' at end ls 5

