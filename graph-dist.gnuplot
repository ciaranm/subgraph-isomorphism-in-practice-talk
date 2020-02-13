# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 11.5cm,6.0cm preamble '\RequirePackage[tt=false, type1=true]{libertine} \RequirePackage[varqu]{zi4} \RequirePackage[libertine]{newtxmath} \RequirePackage[T1]{fontenc}'
set output "gen-" . ARG0[:(strlen(ARG0)-strlen(".gnuplot"))] . ".tex"

load "glasgow.pal"
load "common.gnuplot"

isfaillong(x)=(stringcolumn(x) eq "NaN" || column(x) >= 1e7)
cumxlong(x)=(isfaillong(x) ? 1e7 : column(x))
cumylong(x)=(isfaillong(x) ? 1e-10 : 1)

solvedtimerlong=0
solvedpartimer=0
solveddist20=0
lasttimerlong=-1
solvedtimerlong=0
set table "/dev/null"
plot "runtimes.data" u (cumxlong(timerlong)):(solvedtimerlong=solvedtimerlong+(isfaillong(timerlong)?0:1)) smooth cumulative
plot "runtimes.data" u (cumx(partimer)):(solvedpartimer=solvedpartimer+(isfail(partimer)?0:1)) smooth cumulative
plot "runtimes.data" u (cumminx(dist20)):(solveddist20=solveddist20+(isfail(dist20)?0:1)) smooth cumulative
plot "runtimes.data" u (cumxlong(timerlong)):(lasttimerlong=(isfaillong(timerlong)||cumxlong(timerlong)<lasttimerlong?lasttimerlong:cumxlong(timerlong))) smooth cumulative
unset table

set table "gen-as-runtimes-partimer.data"
set format x '%.0f'
set format x '%.0f'
plot "runtimes.data" u (cumx(partimer)):(isfail(partimer)?0:1) smooth cumulative
unset table

set table "gen-as-runtimes-dist20.data"
set format x '%.0f'
set format x '%.0f'
plot "runtimes.data" u (cumminx(dist20)):(isfail(dist20)?0:1) smooth cumulative
unset table

partimerthreshold=1e6
set table "/dev/null"
plot "gen-as-runtimes-partimer.data" u 1:(partimerthreshold=($2>=solvedtimerlong&&valid(1)&&$1<partimerthreshold)?(sprintf("%d",$1)):(partimerthreshold))
unset table

dist20threshold=1e6
set table "/dev/null"
plot "gen-as-runtimes-dist20.data" u 1:(dist20threshold=($2>=solvedtimerlong&&valid(1)&&$1<dist20threshold)?(sprintf("%d",$1)):(dist20threshold))
unset table

set xrange [1e3:1e7]
set yrange [14000:14500]
set xlabel "Runtime (ms)"
set ylabel "Instances Solved"
set logscale x
set border 3
set grid ls 101 front
set xtics nomirror
set ytics nomirror
set key off
set format x '$10^{%T}$'
set rmargin 10

set arrow 1 from lasttimerlong, solvedtimerlong to partimerthreshold, solvedtimerlong front ls 7 lw 3
set arrow 2 from lasttimerlong, solvedtimerlong to dist20threshold, solvedtimerlong front ls 7 lw 3

plot \
    "runtimes.data" u (cumx(norestarts)):(cumy(norestarts)) smooth cumulative w l ti 'DFS' at end ls 1 lw 3, \
    "runtimes.data" u (cumxlong(timerlong)):(cumylong(timerlong)) smooth cumulative w l ti '\raisebox{-0.2cm}{SBS}' at end ls 3 lw 3, \
    "runtimes.data" u (cumx(partimer)):(cumy(partimer)) smooth cumulative w l ti '\raisebox{0.1cm}{36 Threads, '.sprintf("$%.1f{\\times}$", (lasttimerlong / (0.0+partimerthreshold)))."}" at end ls 4 lw 3, \
    "runtimes.data" u (cumminx(dist20)):(cumy(dist20)) smooth cumulative w l ti '\raisebox{0.2cm}{20 Hosts, '.sprintf("$%.1f{\\times}$", (lasttimerlong / (0.0+dist20threshold))).'}' at end ls 5 lw 3, \

