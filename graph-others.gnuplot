# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 9cm,6.5cm font '\scriptsize' preamble '\usepackage{microtype}'
set output "gen-graph-others.tex"

load "common.gnuplot"

set xlabel "Runtime (ms)"
set ylabel "Number of Instances Solved"
set xrange [1e0:1e6]
set logscale x
set format x '$10^{%T}$'
set yrange [0:14621]
set ytics add ('$14621$' 14621) add ('' 14000)
set key bottom right at 1e6, 250 Left invert

plot \
    "runtimes.data" u (cumx(vf2)):(cumy(vf2)) smooth cumulative w l ti 'VF2' at end ls 5, \
    "runtimes.data" u (cumx(pathlad)):(cumy(pathlad)) smooth cumulative w l ti '\raisebox{-0.15cm}{PathLAD}' at end ls 6, \
    "runtimes.data" u (cumx(norestarts)):(cumy(norestarts)) smooth cumulative w l ti '\raisebox{0.15cm}{Ours}' at end ls 1

