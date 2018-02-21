# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 9.5cm,7.5cm font '\scriptsize' preamble '\usepackage{microtype}'
set output "gen-graph-random-restarts-goods-unsat.tex"

load "common.gnuplot"

set xlabel "Runtime (ms)"
set ylabel "Number of Unsat Instances Solved"
set xrange [1e2:1e6]
set logscale x
set format x '$10^{%T}$'
set key bottom right

plot \
    "runtimes.data" u (cumx(randomrestartsgoods)):(cumunsaty(randomrestartsgoods)) smooth cumulative w l ti 'Random, restarts' ls 3, \
    "runtimes.data" u (cumx(randomrestarts)):(cumunsaty(randomrestarts)) smooth cumulative w l ti 'Random, restarts, nogoods' ls 2, \
    "runtimes.data" u (cumx(norestarts)):(cumunsaty(norestarts)) smooth cumulative w l ti 'Degree' ls 1, \

