SIM ?= questa
TEST ?= pc
#expand
PC_SRCS := rtl/interfaces/pc_if.sv rtl/modules/pc.sv tb/pc_tb.sv
ALU_SRCS := rtl/packages/alu_pkg.sv rtl/interfaces/alu_if.sv rtl/modules/alu.sv tb/alu_tb.sv
#expand
ifeq ($(TEST),pc)
SRCS := $(PC_SRCS)
TOP := pc_tb
else ifeq ($(TEST),alu)
SRCS := $(ALU_SRCS)
TOP := alu_tb
else
$(error Unsupported TEST '$(TEST)'; use pc or alu)
endif
VLIB ?= vlib
VLOG ?= vlog
VSIM ?= vsim
IVERILOG ?= iverilog
VVP ?= vvp
LIB := sim_$(TEST)_work
#expand
.PHONY: pc alu compile run
pc:
	$(MAKE) run TEST=pc
alu:
	$(MAKE) run TEST=alu
ifeq ($(SIM),questa)

$(LIB)/_info:
	$(VLIB) $(LIB)
compile: $(LIB)/_info $(SRCS)
	$(VLOG) -sv -work $(LIB) $(SRCS)
run: compile
	$(VSIM) -c $(LIB).$(TOP) -do "onerror {quit -code 1}; onbreak {quit -code 1}; run -all; quit -code 0"
else ifeq ($(SIM),iverilog)
# Icarus has limited SystemVerilog support. This mode is useful for
# supported designs with flat ports, not the interface/modport lessons.
compile: $(SRCS)
	$(IVERILOG) -g2012 -s $(TOP) -o $(TOP).vvp $(SRCS)
run: compile
	$(VVP) $(TOP).vvp
else
$(error Unsupported SIM '$(SIM)'; use questa or iverilog)
endif