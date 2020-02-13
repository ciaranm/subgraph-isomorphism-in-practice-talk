# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 11.5cm,6.0cm preamble '\RequirePackage[tt=false, type1=true]{libertine} \RequirePackage[varqu]{zi4} \RequirePackage[libertine]{newtxmath} \RequirePackage[T1]{fontenc}'
set output "gen-" . ARG0[:(strlen(ARG0)-strlen(".gnuplot"))] . ".tex"

load "glasgow.pal"
load "common.gnuplot"

set xrange [1e2:1e6]
# set yrange [1800:2000]
set xlabel "Runtime (ms)"
set ylabel "Unsat Instances Solved"
set border 3
set grid ls 101 front
set xtics nomirror
set ytics nomirror
set key off
set format x '$10^{%T}$'
set logscale x
set rmargin 10

plot \
    "runtimes.data" u (cumx(norestarts)):(cumunsaty(norestarts)) smooth cumulative w l ti 'Degree' at end ls 1 lw 3, \
    "runtimes.data" u (cumx(dds)):(cumunsaty(dds)) smooth cumulative w l ti '\raisebox{-0.2cm}{DDS}' at end ls 2 lw 3, \

