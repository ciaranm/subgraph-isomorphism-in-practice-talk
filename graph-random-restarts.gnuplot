# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 9cm,6.5cm font '\scriptsize' preamble '\usepackage{microtype}'
set output "gen-graph-random-restarts.tex"

load "common.gnuplot"

set xlabel "Runtime (ms)"
set ylabel "Number of Sat Instances Solved"
set xrange [1e2:1e6]
set logscale x
set format x '$10^{%T}$'
set yrange [1500:2100]
set key off

plot \
    "runtimes.data" u (cumx(randomrestarts)):(cumsaty(randomrestarts)) smooth cumulative w l ti 'Random + Restarts' at end ls 2, \
    "runtimes.data" u (cumx(norestarts)):(cumsaty(norestarts)) smooth cumulative w l ti 'Degree' at end ls 1, \
    "runtimes.data" u (cumx(random)):(cumsaty(random)) smooth cumulative w l ti 'Random' at end ls 4

