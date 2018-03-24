# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 9.5cm,7.5cm font '\scriptsize' preamble '\usepackage{microtype}'
set output "gen-graph-others-zoom-spoiler.tex"

load "common.gnuplot"

set xlabel "Runtime (ms)"
set ylabel "Number of Sat Instances Solved"
set xrange [1e2:1e6]
set logscale x
set format x '$10^{%T}$'
set format y '$~%.0f$'
set yrange [1200:2200]
set key off

plot \
    "runtimes.data" u (cumx(norestarts)):(cumsaty(norestarts)) smooth cumulative w l ti 'Glasgow 2017' at end ls 1, \
    "runtimes.data" u (cumx(final)):(cumsaty(final)) smooth cumulative w l ti 'Glasgow 2018' at end ls 5, \
    "runtimes.data" u (cumx(pathlad)):(cumsaty(pathlad)) smooth cumulative w l ti 'PathLAD' at end ls 6, \
    "runtimes.data" u (cumx(vf2)):(cumsaty(vf2)) smooth cumulative w l ti 'VF2' at end ls 8, \
    "runtimespar.data" u (cumx(7)):(cumsaty(7)) smooth cumulative w l ti '\raisebox{0.1cm}{Par Glasgow 2018}' at end ls 2

