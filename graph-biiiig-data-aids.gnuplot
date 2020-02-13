# vim: set et ft=gnuplot sw=4 :

load "common.gnuplot"

set terminal tikz standalone color size 9.5cm,6.5cm font '\scriptsize' preamble '\usepackage{microtype}\RequirePackage[tt=false, type1=true]{libertine}\RequirePackage[varqu]{zi4}\RequirePackage[libertine]{newtxmath}\RequirePackage[T1]{fontenc}'

set output "gen-graph-biiiig-data-aids.tex"

set xlabel "Recursive calls"
set ylabel "Thousands of instances solved"
set yrange [0:240]
set border 3
set xtics nomirror
set ytics nomirror add ("$240$" 240)
set key bottom right
set title "AIDS"
set logscale x
set format x '$10^{%T}$'
set xrange [1:1e6]
set logscale x

plot \
    "<cut -d' ' -f4 big-data-aids-results-vf2.plot" u 1:(1e-3) smooth cumulative w l ls 4 lw 2 ti 'VF2', \
    "<cut -d' ' -f4 big-data-aids-results.plot" u 1:(1e-3) smooth cumulative w l ls 2 lw 2 ti 'Gecode'

