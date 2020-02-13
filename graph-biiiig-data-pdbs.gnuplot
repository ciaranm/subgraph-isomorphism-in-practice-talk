# vim: set et ft=gnuplot sw=4 :

load "common.gnuplot"

set terminal tikz standalone color size 9.5cm,6.5cm font '\scriptsize' preamble '\usepackage{microtype}\RequirePackage[tt=false, type1=true]{libertine}\RequirePackage[varqu]{zi4}\RequirePackage[libertine]{newtxmath}\RequirePackage[T1]{fontenc}'
set output "gen-graph-biiiig-data-pdbs.tex"

set xlabel "Recursive calls"
set ylabel "Instances solved"
set yrange [0:3600]
set border 3
set ytics nomirror add ("$3600$" 3600) ("" 3500)
set xtics nomirror
set key bottom right
set title "PDBS"
set logscale x
set format x '$10^{%T}$'
set xrange [1:1e5]

plot \
    "<cut -d' ' -f4 big-data-pdbs-results-vf2.plot" u 1:(1) smooth cumulative w l ls 4 lw 2 ti 'VF2', \
    "<cut -d' ' -f4 big-data-pdbs-results.plot" u 1:(1) smooth cumulative w l ls 2 lw 2 ti 'Gecode'

