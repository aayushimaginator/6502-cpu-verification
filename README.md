# 6502 CPU: Vivado Simulation

Simulation and verification of an open-source Verilog 6502 core in Vivado.

**Credit:** `cpu.v` and `ALU.v` are by Arlet Ottens (see the copyright header in `cpu.v`), used under his stated terms. They are not my design. My own contribution is the testbench `tb.v`.

## Testbench
`tb.v` loads a short 6502 program at `0x0200` (reset vector `0xFFFC`): count up with ADC, store to `0x10`, loop with CMP/BNE until 10, then LDY #7 and STY to `0x11`. It checks `mem[0x10] == 10` and `mem[0x11] == 7` and prints PASS or FAIL.

## Run
Open `cpu_6052.xpr` in Vivado and run a behavioural simulation with `tb` as top.

## Author
Aayush, EEE @ NIT Goa
