# vim: set et ft=gnuplot sw=4 :

set xtics add ('~~~~t/o' 2e6)
set ytics left offset character -3
set ytics add ('\,t/o' 2e6)

set xrange [1:2e6]
set yrange [1:2e6]

clamp(c)=stringcolumn(c)eq"NaN"?timeout*2:column(c)>=timeout?2*timeout:column(c)==0?1:column(c)
c(x)=stringcolumn(x)eq"NaN"?timeout:column(x)

set key invert

plot \
    plotfile u (c(xcol)==0&&c(ycol)==0?NaN:column(famcol)!=14?NaN:clamp(xcol)):(clamp(ycol)) ls 8 pt 12 ps 0.7 ti 'Images', \
    plotfile u (c(xcol)==0&&c(ycol)==0?NaN:column(famcol)!=13?NaN:clamp(xcol)):(clamp(ycol)) ls 13 pt 8 ps 0.7 ti 'Mesh', \
    plotfile u (c(xcol)==0&&c(ycol)==0?NaN:column(famcol)!=12?NaN:clamp(xcol)):(clamp(ycol)) ls 7 pt 7 ps 0.7 ti 'Phase', \
    plotfile u (c(xcol)==0&&c(ycol)==0?NaN:column(famcol)!=9?NaN:clamp(xcol)):(clamp(ycol)) ls 6 pt 6 ps 0.7 ti 'PR', \
    plotfile u (c(xcol)==0&&c(ycol)==0?NaN:column(famcol)!=7?NaN:clamp(xcol)):(clamp(ycol)) ls 5 pt 10 ps 0.7 ti 'Rand', \
    plotfile u (c(xcol)==0&&c(ycol)==0?NaN:(column(famcol)!=5&&column(famcol)!=6)?NaN:clamp(xcol)):(clamp(ycol)) ls 4 pt 4 ps 0.7 ti 'M4D(r)', \
    plotfile u (c(xcol)==0&&c(ycol)==0?NaN:(column(famcol)!=3&&column(famcol)!=4)?NaN:clamp(xcol)):(clamp(ycol)) ls 3 pt 3 ps 0.7 ti 'BVG(r)', \
    plotfile u (c(xcol)==0&&c(ycol)==0?NaN:(column(famcol)!=2&&column(famcol)!=11)?NaN:clamp(xcol)):(clamp(ycol)) w p ls 2 pt 2 ps 0.7 ti 'LV', \
    plotfile u (c(xcol)==0&&c(ycol)==0?NaN:column(famcol)!=1?NaN:clamp(xcol)):(clamp(ycol)) ls 1 pt 1 ps 0.7 ti 'SF', \
    x w l ls 0 notitle

