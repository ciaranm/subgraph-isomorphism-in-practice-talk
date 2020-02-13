# vim: set et ft=gnuplot sw=4 :

set style line 102 lc rgb '#a0a0a0' lt 1 lw 1
set border ls 102
set colorbox border 102
set key textcolor rgb "black"
set tics textcolor rgb "black"
set label textcolor rgb "black"

outputfile="gen-graph-" . format . "-satisfiable-" . ps . "-l" . l . "-" . ts . ".tex"
proportionsat="data/ps" . ps . "-ts" . ts . "-l" . l . "." . format . ".proportion-sat.plot"

set terminal tikz standalone color size 2.3cm,2.3cm font '\tiny' preamble '\usepackage{microtype}\RequirePackage[tt=false, type1=true]{libertine}\RequirePackage[varqu]{zi4}\RequirePackage[libertine]{newtxmath}\RequirePackage[T1]{fontenc}'

load "chromadiverge.pal"

set lmargin 0
set rmargin 0
set bmargin 0
set tmargin 0

set output outputfile

unset xlabel
unset ylabel
set xrange [-0.005:1.005]
set noxtics
set yrange [-0.005:1.005]
set noytics
set size square

unset colorbox

plot proportionsat u ($2/divide):($1/divide):($3) matrix w image notitle
