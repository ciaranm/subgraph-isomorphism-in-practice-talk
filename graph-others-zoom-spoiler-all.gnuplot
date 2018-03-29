# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 9.5cm,6.5cm font '\scriptsize' preamble '\usepackage{microtype,amsmath}'
set output "gen-graph-others-zoom-spoiler-all.tex"

load "common.gnuplot"

set xlabel "Runtime (ms)"
set ylabel "Number of Instances Solved"
set xrange [1e3:1e6]
set logscale x
set format x '$10^{%T}$'
set format y '$~%.0f$'
set yrange [13800:14621]
set ytics add ('$14621$' 14621) add ('' 14600)
set key off

plot \
    "runtimes.data" u (cumx(norestarts)):(cumy(norestarts)) smooth cumulative w l ti '\raisebox{0.15cm}{LION 2016 (a)}' at end ls 1, \
    "runtimespar.data" u (cumx(9)):(cumy(9)) smooth cumulative w l ti '{$\overset{\text{\scriptsize Somewhere Exotic}}{\text{\scriptsize (not yet written)~~}}$}' at end ls 2, \
    "runtimes.data" u (cumx(final)):(cumy(final)) smooth cumulative w l ti '\raisebox{-0.1cm}{$\overset{\text{\scriptsize IJCAI 2018\hspace*{2.6em}}}{\text{\scriptsize (not yet rejected)}}$}' at end ls 5, \
    "runtimes.data" u (cumx(pathlad)):(cumy(pathlad)) smooth cumulative w l ti 'LION 2016 (b)' at end ls 6, \
    "runtimes.data" u (cumx(vf2)):(cumy(vf2)) smooth cumulative w l ti 'VF2' at end ls 8, \
    "runtimes.data" u (cumx(18)):(cumy(18)) smooth cumulative w l ti '\raisebox{-0.15cm}{CP 2015}' at end ls 3, \
    "runtimes.data" u (cumx(lad)):(cumy(lad)) smooth cumulative w l ti '\raisebox{0.0cm}{AIJ 2010}' at end ls 10

