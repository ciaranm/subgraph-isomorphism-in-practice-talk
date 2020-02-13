# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 11.5cm,6.0cm preamble '\RequirePackage[tt=false, type1=true]{libertine} \RequirePackage[varqu]{zi4} \RequirePackage[libertine]{newtxmath} \RequirePackage[T1]{fontenc}'
set output "gen-" . ARG0[:(strlen(ARG0)-strlen(".gnuplot"))] . ".tex"

load "glasgow.pal"
load "common.gnuplot"

set xrange [1e2:1e6]
# set yrange [1400:2000]
set xlabel "Runtime (ms)"
set ylabel "Unsat Instances Solved"
set logscale x
set border 3
set grid ls 101 front
set xtics nomirror
set ytics nomirror
set key off
set format x '$10^{%T}$'
set rmargin 10

plot \
    "runtimes.data" u (cumx(norestarts)):(cumunsaty(norestarts)) smooth cumulative w l ti 'All' at end ls 1 lw 3, \
    "runtimes.data" u (cumx(random)):(cumunsaty(random)) smooth cumulative w l notitle ls 2 lw 3, \
    "runtimes.data" u (cumx(anti)):(cumunsaty(anti)) smooth cumulative w l notitle ls 4 lw 3

