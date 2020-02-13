# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 11.5cm,6.0cm preamble '\RequirePackage[tt=false, type1=true]{libertine} \RequirePackage[varqu]{zi4} \RequirePackage[libertine]{newtxmath} \RequirePackage[T1]{fontenc}'
set output "gen-" . ARG0[:(strlen(ARG0)-strlen(".gnuplot"))] . ".tex"

load "glasgow.pal"
load "common.gnuplot"

set xrange [1e1:1e6]
set yrange [1e1:1e6]
set xlabel "Degree Search Time (ms)"
set ylabel "Biased Random Search Time (ms)"
set border 3
set grid ls 101 front
set xtics nomirror
set ytics nomirror
set key outside right center
set format x '$10^{%T}$'
set format y '$10^{%T}$'
set logscale xy
set size square

plotfile="searchtimes.data"
satcol="sat"
famcol="family"
xcol=norestarts
ycol=softmax

load "scatter.gnuplot"
