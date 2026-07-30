<div align="center">

<img src="images/uart_rtl_to_gdsii_banner.png" alt="UART RTL-to-GDSII ASIC Implementation Banner" width="100%">

# UART RTL-to-GDSII ASIC Implementation using OpenLane2

### Complete ASIC Design Flow using Verilog HDL, OpenLane2 and SKY130 PDK

</div>

# UART RTL-to-GDSII ASIC Implementation using OpenLane2

### Complete ASIC Design Flow from RTL Design to GDSII using Open-Source EDA Tools

![GitHub repo size](https://img.shields.io/github/repo-size/shivam-du/uart-rtl-to-gdsii)
![GitHub last commit](https://img.shields.io/github/last-commit/shivam-du/uart-rtl-to-gdsii)
![GitHub stars](https://img.shields.io/github/stars/shivam-du/uart-rtl-to-gdsii?style=social)
![GitHub forks](https://img.shields.io/github/forks/shivam-du/uart-rtl-to-gdsii?style=social)
![License](https://img.shields.io/github/license/shivam-du/uart-rtl-to-gdsii)
![OpenLane2](https://img.shields.io/badge/OpenLane-2-blue)
![Sky130](https://img.shields.io/badge/PDK-SKY130-orange)
![Verilog](https://img.shields.io/badge/Language-Verilog-success)
![Platform](https://img.shields.io/badge/Platform-Ubuntu%20WSL-green)

</div>

---

# Project Overview

This repository presents the complete RTL-to-GDSII implementation of a **Universal Asynchronous Receiver Transmitter (UART)** using **Verilog HDL** and the **OpenLane2 ASIC design flow** with the **SkyWater SKY130 Process Design Kit (PDK)**.

The project demonstrates every major stage of a digital ASIC implementation starting from RTL design, functional verification, logic synthesis, floorplanning, placement, clock tree synthesis, routing, physical verification, and finally the generation of the manufacturable **GDSII layout**.

Unlike RTL-only projects, this repository covers the complete front-end and back-end ASIC implementation flow using open-source EDA tools.

---

# Repository Highlights

- Complete UART RTL Design in Verilog HDL
- Modular Design Architecture
- Functional Simulation and Verification
- RTL Synthesis
- OpenLane2 RTL-to-GDSII Flow
- Physical Design using OpenROAD
- Clock Tree Synthesis (CTS)
- Global and Detailed Routing
- Power Distribution Network (PDN)
- Physical Verification
- Final GDSII Layout Generation
- Comprehensive Technical Report
- GitHub Documentation

---

# ASIC Design Flow

<p align="center">
<img src="images/asic_design_flow_full.png" width="95%">
</p>

The complete ASIC implementation follows the standard digital IC design methodology beginning with RTL design and ending with the generation of the final manufacturable GDSII layout.

---

# UART Internal Architecture

<p align="center">
<img src="images/complete_uart_internal_architecture.png" width="90%">
</p>

The UART Top Module integrates four major functional blocks:

- Baud Rate Generator
- UART Transmitter
- UART Receiver
- Top-Level Controller

These modules work together to perform reliable asynchronous serial communication.

---

# Repository Structure

```text
uart_asic_ip/
│
├── rtl/                 # Verilog source files
├── tb/                  # Testbenches
├── sim/                 # Simulation outputs
├── waveforms/           # GTKWave waveforms
├── images/              # Project figures
├── reports/             # Reports
├── runs/                # OpenLane2 implementation results
├── logs/                # Tool execution logs
├── config.json          # OpenLane configuration
├── README.md
└── LICENSE
```

---

# Design Specifications

| Parameter | Value |
|-----------|-------|
| Design | UART |
| Language | Verilog HDL |
| Communication | Asynchronous Serial |
| Data Width | 8-bit |
| Stop Bits | 1 |
| Parity | None |
| PDK | SkyWater SKY130 |
| RTL Synthesis | Yosys |
| Physical Design | OpenROAD |
| Complete Flow | OpenLane2 |
| Layout Viewer | KLayout |
| DRC Tool | Magic |
| LVS Tool | Netgen |

---

# Tools Used

| Tool | Purpose |
|------|----------|
| Verilog HDL | RTL Design |
| Icarus Verilog | Functional Simulation |
| GTKWave | Waveform Analysis |
| Yosys | RTL Synthesis |
| OpenLane2 | RTL-to-GDSII Flow |
| OpenROAD | Physical Design |
| Magic | Physical Verification |
| Netgen | LVS |
| KLayout | GDSII Visualization |
| Git | Version Control |
| GitHub | Project Repository |

---

# UART Design Architecture

<p align="center">
<img src="images/uart_design_architecture.png" width="90%">
</p>

The UART architecture consists of independent transmitter and receiver modules controlled through a common top-level interface. The baud rate generator provides synchronized timing for serial data transmission and reception.

---

# UART Communication Frame

<p align="center">
<img src="images/uart_frame_flowchart.png" width="75%">
</p>

The UART frame consists of:

- Start Bit
- 8-bit Data Field
- Stop Bit

This standard frame format enables asynchronous communication without requiring a shared clock between transmitter and receiver.

---

# RTL Module Architecture

The UART IP is designed using a modular architecture, making each functional block independent, reusable, and easy to verify. The complete RTL design consists of four Verilog modules:

| Module | Description |
|---------|-------------|
| Baud Rate Generator | Generates the baud tick used for UART timing |
| UART Transmitter | Converts 8-bit parallel data into serial data |
| UART Receiver | Converts incoming serial data back into parallel form |
| UART Top Module | Integrates all modules into a complete UART IP |

---

# Baud Rate Generator

The baud rate generator divides the input system clock to generate the required baud tick used by both the transmitter and receiver modules.

### Architecture

<p align="center">
<img src="images/baud_rate_generator_architecture.png" width="70%">
</p>

### RTL Schematic

<p align="center">
<img src="images/baud_generator_rtl.png" width="90%">
</p>

### Functional Verification

<p align="center">
<img src="images/baud_generator_waveform.png" width="90%">
</p>

---

# UART Transmitter

The UART transmitter converts parallel data into serial data by sequentially transmitting the start bit, eight data bits, and the stop bit according to the generated baud clock.

### Architecture

<p align="center">
<img src="images/uart_transmitter_architecture.png" width="70%">
</p>

### RTL Schematic

<p align="center">
<img src="images/uart_tx_rtl.png" width="90%">
</p>

### Functional Verification

<p align="center">
<img src="images/transmitter_waveform.png" width="90%">
</p>

### Transmitter Operation

The UART transmitter performs the following sequence:

1. Waits for the `tx_start` signal.
2. Sends the start bit (`0`).
3. Serially transmits the 8-bit data.
4. Sends the stop bit (`1`).
5. Returns to the idle state.

---

# UART Receiver

The UART receiver continuously monitors the RX line for a valid start bit. After detecting the start bit, it samples the incoming serial data according to the baud clock and reconstructs the original 8-bit parallel data.

### Architecture

<p align="center">
<img src="images/uart_receiver_architecture.png" width="70%">
</p>

### RTL Schematic

<p align="center">
<img src="images/uart_rx_rtl.png" width="90%">
</p>

### Functional Verification

<p align="center">
<img src="images/receiver_waveform.png" width="90%">
</p>

### Receiver Operation

The UART receiver performs the following sequence:

1. Detects the falling edge of the start bit.
2. Samples incoming bits at each baud tick.
3. Stores all eight received bits.
4. Verifies the stop bit.
5. Asserts the `rx_done` signal after successful reception.

---

# UART Top Module

The UART Top Module integrates all submodules into a complete UART communication system.

It provides:

- Common system clock
- Reset synchronization
- Baud clock distribution
- Transmit interface
- Receive interface
- Data path integration

### Top-Level Architecture

<p align="center">
<img src="images/uart_design_architecture.png" width="80%">
</p>

### RTL Schematic

<p align="center">
<img src="images/uart_top.png" width="90%">
</p>

### Functional Verification

<p align="center">
<img src="images/uart_waveform.png" width="90%">
</p>

---

# RTL Design Summary

| Feature | Status |
|----------|--------|
| Baud Generator | ✔ Completed |
| UART Transmitter | ✔ Completed |
| UART Receiver | ✔ Completed |
| UART Top Module | ✔ Completed |
| Functional Simulation | ✔ Verified |
| RTL Verification | ✔ Successful |

The RTL design was verified using simulation before proceeding to synthesis and physical implementation through the OpenLane2 RTL-to-GDSII flow.

---

# OpenLane2 RTL-to-GDSII Implementation

After successful RTL verification, the UART IP Core was implemented using the **OpenLane2** open-source ASIC design flow targeting the **SkyWater SKY130 Process Design Kit (PDK)**.

OpenLane2 integrates multiple open-source EDA tools into a fully automated RTL-to-GDSII implementation flow. The complete flow includes logic synthesis, floorplanning, placement, clock tree synthesis, routing, parasitic extraction, timing analysis, physical verification, and final GDSII generation.

---

# Complete OpenLane2 Workflow

<p align="center">
<img src="images/openlane2_internal_workflow.png" width="95%">
</p>

The complete RTL-to-GDSII implementation is performed automatically through OpenLane2, providing an end-to-end ASIC design methodology using open-source EDA tools.

---

# RTL Synthesis

Logic synthesis was performed using **Yosys**, where the Verilog RTL was optimized and mapped to the **SkyWater SKY130 HD Standard Cell Library**.

### Synthesis Flow

<p align="center">
<img src="images/synthesis_flow.png" width="85%">
</p>

### Synthesis Results

- RTL successfully synthesized
- Technology mapping completed
- Standard cells generated
- Netlist optimized
- Area optimization performed

---

# Physical Design Flow

Following synthesis, the gate-level netlist entered the physical implementation stage.

<p align="center">
<img src="images/physical_design_flow.png" width="90%">
</p>

The physical design stage converts the synthesized netlist into a manufacturable integrated circuit layout while satisfying timing, congestion, and routing constraints.

---

# Floorplanning

The floorplanning stage determines the die dimensions, core area, utilization, placement rows, and I/O pin locations before placement begins.

### Objectives

- Define die dimensions
- Define core utilization
- Create placement rows
- Initialize routing resources

---

# Standard Cell Placement

<p align="center">
<img src="images/Standard_Cell_Placement.png" width="90%">
</p>

During placement, OpenROAD determines the optimal physical location of every standard cell while minimizing total wirelength and preserving timing performance.

### Placement Objectives

- Reduce wirelength
- Improve timing
- Reduce congestion
- Maintain legalization
- Optimize routing resources

---

# Input Pin Placement

<p align="center">
<img src="images/Input_pins_placement.png" width="80%">
</p>

Input pins are positioned around the chip boundary according to the OpenLane floorplan configuration to minimize routing complexity.

---

# Output Pin Placement

<p align="center">
<img src="images/Output_pin_placement.png" width="80%">
</p>

Output pins are similarly optimized to reduce routing congestion and improve signal accessibility.

---

# Clock Tree Synthesis (CTS)

<p align="center">
<img src="images/clock_tree_synthesis.png" width="90%">
</p>

Clock Tree Synthesis inserts buffers and clock distribution networks to minimize clock skew and insertion delay across sequential elements.

### CTS Objectives

- Reduce clock skew
- Improve clock latency
- Maintain timing closure
- Balance clock distribution

---

# Power Distribution Network (PDN)

<p align="center">
<img src="images/Power_Distribution_Network_(PDN)_Generation.png" width="90%">
</p>

A dedicated Power Distribution Network (PDN) was automatically generated to provide reliable power delivery to all standard cells while minimizing IR drop.

---

# Global and Detailed Routing

Routing establishes all signal interconnections between placed cells while satisfying SKY130 design rules.

### Routing Flow

<p align="center">
<img src="images/routing_flow.png" width="80%">
</p>

---

## Top Pin Routing

<p align="center">
<img src="images/top_pins_routing.png" width="90%">
</p>

The top-level routing stage connects external interface pins with the internal routing resources while minimizing congestion.

---

## Bottom Pin Routing

<p align="center">
<img src="images/bottom_pin_routing.png" width="90%">
</p>

Bottom-layer routing ensures complete signal connectivity across the lower boundary of the design.

---

## Detailed Routing

<p align="center">
<img src="images/Detailed_Routing_of_Standard_Cell_Interconnections.png" width="95%">
</p>

Detailed routing finalizes every signal connection while satisfying spacing, width, via, and antenna constraints defined by the SKY130 technology.

---

## Internal Routing

<p align="center">
<img src="images/Detailed_Internal_Routing_with_Filler_Cells_and_Hold_Buffers.png" width="95%">
</p>

The completed routed layout includes filler cells, hold buffers, and optimized interconnections required for timing closure and manufacturability.

---

## Zoomed Routing View

<p align="center">
<img src="images/Zoomed_View_of_Input_Pin_Routing.png" width="48%">
<img src="images/Zoomed_View_of_Output_Pin_Routing.png" width="48%">
</p>

These close-up views highlight the detailed routing topology around the I/O regions and demonstrate the routing quality achieved by OpenLane2.

---

# Physical Design Summary

| Stage | Status |
|---------|--------|
| RTL Synthesis | ✅ Completed |
| Floorplanning | ✅ Completed |
| Standard Cell Placement | ✅ Completed |
| Pin Placement | ✅ Completed |
| Clock Tree Synthesis | ✅ Completed |
| Power Distribution Network | ✅ Completed |
| Global Routing | ✅ Completed |
| Detailed Routing | ✅ Completed |

The OpenLane2 flow successfully transformed the synthesizable Verilog RTL into a fully routed physical layout while satisfying the design constraints of the SKY130 technology.

---

# Physical Verification and Signoff

After completing the routing stage, the layout underwent physical verification to ensure manufacturability and logical correctness. OpenLane2 automatically invokes the necessary verification tools as part of the signoff flow.

---

# Design Rule Checking (DRC)

Design Rule Checking was performed using **Magic** to verify that the layout satisfies all design rules defined by the SKY130 PDK.

<p align="center">
<img src="images/physical_verification.png" width="90%">
</p>

### DRC Objectives

- Verify minimum spacing rules
- Verify minimum width rules
- Check enclosure rules
- Detect overlapping geometries
- Ensure fabrication compliance

---

# Layout Versus Schematic (LVS)

Layout Versus Schematic (LVS) was performed using **Netgen** to verify that the extracted layout is electrically equivalent to the synthesized gate-level netlist.

### LVS Verification

- Layout extraction completed
- Netlist comparison completed
- Connectivity verified
- Logical equivalence confirmed

---

# Manufacturability Verification

The completed design successfully passed all major physical verification stages.

| Verification Stage | Status |
|--------------------|:------:|
| Design Rule Check (DRC) | ✅ PASS |
| Layout Versus Schematic (LVS) | ✅ PASS |
| Routing Verification | ✅ PASS |
| Antenna Check | ✅ PASS |
| Connectivity Check | ✅ PASS |

---

# Final Routed Layout

<p align="center">
<img src="images/Final_Detailed_Routed_Layout_of_the_UART_ASIC.png" width="95%">
</p>

The routed layout contains all standard cells, clock distribution, signal routing, power rails, and filler cells required for fabrication.

---

# Final GDSII Layout

The final physical implementation was exported as a **GDSII** file, the industry-standard format used for semiconductor fabrication.

<p align="center">
<img src="images/Final_GDSII_Layout_in_KLayout.png" width="95%">
</p>

The layout was visualized and inspected using **KLayout**, confirming the successful completion of the complete RTL-to-GDSII implementation flow.

---

# Zoomed Layout View

<p align="center">
<img src="images/Zoomed_GDSII_Layout.png" width="90%">
</p>

The zoomed view illustrates the detailed metal routing, vias, standard-cell placement, and routing density within the final ASIC layout.

---

# Metal Routing Close-Up

<p align="center">
<img src="images/Close-Up_View_of_Metal_Layers_and_Via_Structures.png" width="90%">
</p>

This close-up highlights the routing resources, via structures, and multiple metal layers generated during the detailed routing stage.

---

# Complete Project Flow

```text
Verilog RTL
      │
      ▼
RTL Simulation
      │
      ▼
Functional Verification
      │
      ▼
Logic Synthesis
      │
      ▼
Floorplanning
      │
      ▼
Placement
      │
      ▼
Clock Tree Synthesis
      │
      ▼
Power Distribution Network
      │
      ▼
Global Routing
      │
      ▼
Detailed Routing
      │
      ▼
Physical Verification
      │
      ▼
Final GDSII Layout
```

---

# Project Statistics

| Parameter | Value |
|------------|--------|
| Design | UART IP Core |
| RTL Language | Verilog HDL |
| Communication Protocol | UART |
| RTL Modules | 4 |
| Testbenches | 4 |
| Target PDK | SkyWater SKY130 |
| Synthesis Tool | Yosys |
| Physical Design Tool | OpenROAD |
| RTL-to-GDSII Flow | OpenLane2 |
| Layout Viewer | KLayout |
| DRC Tool | Magic |
| LVS Tool | Netgen |
| Operating System | Ubuntu (WSL2) |

---

# How to Run

## Clone Repository

```bash
git clone https://github.com/shivam-du/uart-rtl-to-gdsii.git
cd uart-rtl-to-gdsii
```

---

## RTL Simulation

```bash
iverilog -o uart_top_tb rtl/*.v tb/tb_uart_top.v

vvp uart_top_tb

gtkwave waveforms/uart_top.vcd
```

---

## OpenLane2 Implementation

```bash
openlane config.json
```

Ensure that:

- OpenLane2 is installed
- SKY130 PDK is configured
- Docker/WSL environment is properly set up

---

# Project Report

A detailed technical report describing every stage of the project is available in the repository.

```text
reports/
└── UART_RTL_to_GDSII_Report.pdf
```

The report includes:

- UART Theory
- RTL Design
- Functional Verification
- OpenLane2 Flow
- Physical Design
- Timing Analysis
- Routing
- Physical Verification
- Final GDSII Layout
- Results and Conclusions

---

# Future Improvements

- Configurable baud-rate generation
- Parity bit support
- Multiple stop-bit configurations
- FIFO-based buffering
- Interrupt support
- APB Interface
- AXI-Lite Interface
- FPGA implementation
- Full SoC integration

---

# References

- OpenLane2 Documentation
- OpenROAD Documentation
- SkyWater SKY130 PDK Documentation
- Yosys Documentation
- Magic VLSI Documentation
- Netgen Documentation
- KLayout Documentation
- GTKWave Documentation

---

# Author

**Shivam Chaurasiya**

**B.Tech – Electronics and Communication Engineering**

### Areas of Interest

- VLSI Design
- RTL Design
- ASIC Physical Design
- Digital IC Design
- Semiconductor Technology
- Open-Source EDA Tools

GitHub: **https://github.com/shivam-du**

---

# License

This project is licensed under the **MIT License**.

See the `LICENSE` file for complete details.

---

# Acknowledgements

This project was completed using the following open-source tools and technologies:

- OpenLane2
- OpenROAD
- SkyWater SKY130 PDK
- Yosys
- Magic
- Netgen
- KLayout
- GTKWave
- Icarus Verilog

Special thanks to the open-source hardware community for developing and maintaining these tools.

---

<div align="center">

## ⭐ If you found this repository useful, please consider giving it a star!

### Thank you for visiting this project.

**Happy Learning and Happy Chip Designing!**

</div>

