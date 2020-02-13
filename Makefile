all : tables graphs
	latexmk -pdf -pdflatex='pdflatex -interaction=nonstopmode %O %S' talk

TABLES =

GRAPHS = \
	gen-graph-value-ordering.pdf \
	gen-graph-value-ordering-unsat.pdf \
	gen-graph-value-ordering-dds.pdf \
	gen-graph-value-ordering-dds-unsat.pdf \
	gen-graph-value-ordering-dds-scatter.pdf \
	gen-graph-sbs.pdf \
	gen-graph-sbs-unsat.pdf \
	gen-graph-sbs-scatter.pdf \
	gen-graph-par.pdf \
	gen-graph-par-scatter.pdf \
	gen-graph-dist.pdf \
	gen-graph-bias-scatter.pdf \
	gen-graph-others.pdf \
	gen-graph-rsr.pdf \
	gen-graph-rsr-scatter.pdf \
	gen-graph-phase-transition.pdf \
	gen-graph-waves.pdf \
	gen-graph-biiiig-data-aids.pdf \
	gen-graph-biiiig-data-pcms.pdf \
	gen-graph-biiiig-data-pdbs.pdf \
	gen-graph-biiiig-data-ppigo.pdf \
	gen-graph-others.pdf \
	 $(foreach ps, 10 20 30, \
		 gen-graph-non-induced-satisfiable-$(ps)-150.pdf \
		 gen-graph-non-induced-nodes-$(ps)-150.pdf \
		 gen-graph-vf2-non-induced-nodes-$(ps)-150.pdf )  \
	$(foreach l, 2 3 5 20, \
		 gen-graph-non-induced-satisfiable-20-l$(l)-150.pdf \
		 gen-graph-vf2-non-induced-nodes-20-l$(l)-150.pdf \
		 gen-graph-non-induced-nodes-20-l$(l)-150.pdf ) \

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
    $(foreach f, non-induced vf2-non-induced, \
    $(eval $(call hardsip_GRAPH_template,$(f),$(ps),150,1,100))))

define hardsip_LGRAPH_template =
gen-graph-$(1)-satisfiable-$(2)-l$(3)-$(4).pdf : graph-lsatisfiable-template.gnuplot
	gnuplot -e "ps=$(2)" -e "ts=$(4)" -e "l=$(3)" -e "format='$(1)'" -e "satlines=$(5)" -e "divide=$(6)" `basename $$<` && \
	latexmk -pdf gen-graph-$(1)-satisfiable-$(2)-l$(3)-$(4)

gen-graph-$(1)-nodes-$(2)-l$(3)-$(4).pdf : graph-lnodes-template.gnuplot
	gnuplot -e "ps=$(2)" -e "ts=$(4)" -e "l=$(3)" -e "format='$(1)'" -e "plotsize='$(5)'" -e "divide=$(6)" `basename $$<` && \
	latexmk -pdf gen-graph-$(1)-nodes-$(2)-l$(3)-$(4)
endef

$(foreach l, 2 3 5 20, \
    $(foreach f, non-induced vf2-non-induced, \
    $(eval $(call hardsip_LGRAPH_template,$(f),20,$(l),150,2,100))))


