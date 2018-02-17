# vim: set et ft=gnuplot sw=4 :

set style line 102 lc rgb '#a0a0a0' lt 1 lw 1
set border ls 102
set colorbox border 102
set key textcolor rgb "black"
set tics textcolor rgb "black"
set label textcolor rgb "black"

outputfile="gen-graph-" . format . "-nodes-" . ps . "-" . ts . ".tex"
nodesfile="" . format . "-" . ps . "-" . ts . "-nodes.plot"

set terminal tikz standalone color size 2.3cm,2.3cm font '\tiny'

load "chromasequencefromwhitetoblack.pal"

set output outputfile

set datafile missing "fail"

set lmargin 0
set rmargin 0
set bmargin 0
set tmargin 0

unset xlabel
unset ylabel
set xrange [-0.005:1.005]
set noxtics
set yrange [-0.005:1.005]
set noytics
set size square
set cbtics out scale 0.5 nomirror offset -1
set cbtics 2 add ('fail' 10)

set palette positive
set format cb '$10^{%.0f}$'
unset colorbox
set cbrange [0:10]

plot nodesfile u ($1/divide):($2/divide):($3>=0?log10($3+1):1e10) matrix w image notitle
