# vim: set et ft=gnuplot sw=4 :

load "common.gnuplot"

set terminal tikz standalone color size 9.5cm,6.5cm font '\scriptsize' preamble '\usepackage{microtype}\RequirePackage[tt=false, type1=true]{libertine}\RequirePackage[varqu]{zi4}\RequirePackage[libertine]{newtxmath}\RequirePackage[T1]{fontenc}'
set output "gen-graph-biiiig-data-pcms.tex"

set xrange [0:]
set xlabel "Recursive calls"
set ylabel "Instances solved"
set yrange [0:1800]
set border 3
set xtics nomirror
set ytics nomirror add ("$1800$" 1800)
set key off
set title "PCM"
set logscale x
set xrange [1:1e7]
set format x '$10^{%T}$'
set key bottom right

plot \
    "<cut -d' ' -f4 big-data-pcms-results-vf2.plot" u 1:(1) smooth cumulative w l ls 4 lw 2 ti 'Connectivity', \
    "<cut -d' ' -f4 big-data-pcms-results.plot" u 1:(1) smooth cumulative w l ls 2 lw 2 ti 'Simple CP'


