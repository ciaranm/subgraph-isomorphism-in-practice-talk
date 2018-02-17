# vim: set et ft=gnuplot sw=4 :

set style line 102 lc rgb '#a0a0a0' lt 1 lw 1
set border ls 102
set colorbox border 102
set key textcolor rgb "black"
set tics textcolor rgb "black"
set label textcolor rgb "black"

outputfile="gen-graph-" . format . "-satisfiable-" . ps . "-" . ts . ".tex"
proportionsat="" . format . "-" . ps . "-" . ts . "-satisfiable.plot"
predictedline="ps" . ps . "-ts" . ts . "." . format . ".predicted-line.plot"

set terminal tikz standalone color size 2.3cm,2.3cm font '\tiny'

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

if (satlines == 0) { \
    plot proportionsat u ($1/divide):($2/divide):($3) matrix w image notitle \
} else { if (satlines == 1) { \
    plot proportionsat u ($1/divide):($2/divide):($3) matrix w image notitle, \
        predictedline u 1:2 w line notitle lc "black" \
} else { \
    plot proportionsat u ($1/divide):($2/divide):($3) matrix w image notitle, \
        predictedline u 1:2 w line notitle lc "black", \
        predictedline u 4:5 w line notitle lc "black" \
} }

