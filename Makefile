all : tables graphs
	latexmk -pdf -pdflatex='pdflatex -interaction=nonstopmode %O %S' talk

TABLES =

GRAPHS = \
	 gen-graph-others.pdf \
	 gen-graph-others-zoom.pdf \
	 gen-graph-others-zoom-spoiler.pdf \
	 gen-graph-value-ordering-heuristics.pdf \
	 gen-graph-value-ordering-heuristics-unsat.pdf \
	 gen-graph-scatter-dds.pdf \
	 gen-graph-random-restarts-goods.pdf \
	 gen-graph-random-restarts.pdf \
	 gen-graph-random-restarts-goods-unsat.pdf \
	 gen-graph-scatter-random.pdf \
	 gen-graph-scatter-random-goods.pdf \
	 gen-graph-value-ordering-heuristics-biased.pdf \
	 gen-graph-restarts.pdf \
	 gen-graph-scatter-final.pdf \
	 gen-graph-scatter-biased.pdf \
	 $(foreach ps, 10 20 30, \
		 gen-graph-non-induced-satisfiable-$(ps)-150.pdf \
		 gen-graph-non-induced-nodes-$(ps)-150.pdf ) \
	$(foreach ps, 10 14 15 16 20, \
		 gen-graph-induced-satisfiable-$(ps)-150.pdf \
		 gen-graph-induced-nodes-$(ps)-150.pdf )

tables : $(TABLES)

graphs : $(GRAPHS)

gen-graph-%.pdf : graph-%.gnuplot common.gnuplot glasgow.pal
	gnuplot $<
	sed -i -e '19,20s/^\(\\path.*\)/\% \1/' gen-graph-$*.tex # epic haxx
	latexmk -pdf gen-graph-$*

define hardsip_GRAPH_template =

gen-graph-$(1)-satisfiable-$(2)-$(3).pdf : graph-satisfiable-template.gnuplot
	gnuplot -e "ps=$(2)" -e "ts=$(3)" -e "format='$(1)'" -e "satlines=$(4)" -e "divide=$(5)" `basename $$<` && \
	latexmk -pdf gen-graph-$(1)-satisfiable-$(2)-$(3)

gen-graph-$(1)-nodes-$(2)-$(3).pdf : graph-nodes-template.gnuplot
	gnuplot -e "ps=$(2)" -e "ts=$(3)" -e "format='$(1)'" -e "divide=$(5)" `basename $$<` && \
	latexmk -pdf gen-graph-$(1)-nodes-$(2)-$(3)

endef

$(foreach ps, 10 20 30, \
    $(foreach f, non-induced, \
    $(eval $(call hardsip_GRAPH_template,$(f),$(ps),150,1,100))))

$(foreach ps, 10 14 15 16 20, \
    $(foreach f, induced, \
    $(eval $(call hardsip_GRAPH_template,$(f),$(ps),150,2,100))))

