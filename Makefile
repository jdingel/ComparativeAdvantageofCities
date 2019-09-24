## MASTER MAKEFILE

SERIAL_TARGETS1= $(addsuffix /code, install_packages downloaddata initialdata skillintensities shares populationelasticities wage_regressions permutation_prep)
TARGET_PARALLEL = permutation_tests/code
SERIAL_TARGETS2 = pairwise_comparisons/code printpaper/code


.PHONY: all $(SERIAL_TARGETS1) $(TARGET_PARALLEL) $(SERIAL_TARGETS2)

all: $(SERIAL_TARGETS1) $(TARGET_PARALLEL) $(SERIAL_TARGETS2)

$(SERIAL_TARGETS1):
	$(MAKE) -C $@

$(TARGET_PARALLEL):
	$(MAKE) -C $@ -j 30

$(SERIAL_TARGETS2):
	$(MAKE) -C $@
