# vim: set et ft=gnuplot sw=4 :

load "common.gnuplot"

set terminal tikz standalone color size 9.5cm,6.5cm font '\scriptsize' preamble '\usepackage{microtype}\RequirePackage[tt=false, type1=true]{libertine}\RequirePackage[varqu]{zi4}\RequirePackage[libertine]{newtxmath}\RequirePackage[T1]{fontenc}'
set output "gen-graph-biiiig-data-ppigo.tex"

set xlabel "Recursive calls"
set ylabel "Instances solved"
set yrange [0:100]
set border 3
set xtics nomirror
set ytics nomirror
set title "PPI"
set logscale x
set xrange [1:1e4]
set format x '$10^{%T}$'
set key bottom right

plot \
    "<cut -d' ' -f4 big-data-ppigo-results-vf2.plot" u 1:(1) smooth cumulative w l ls 4 lw 2 ti 'VF2', \
    "<cut -d' ' -f4 big-data-ppigo-results.plot" u 1:(1) smooth cumulative w l ls 2 lw 2 ti 'Gecode'

