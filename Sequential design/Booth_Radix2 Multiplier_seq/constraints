# Clock constraint: ~83 MHz (12 ns period)
create_clock -period 12.0 -name clk [get_ports clk]

# Input delays (adjust if needed)
set_input_delay 2.0 -clock clk [get_ports A]
set_input_delay 2.0 -clock clk [get_ports B]
set_input_delay 2.0 -clock clk [get_ports start]
set_input_delay 2.0 -clock clk [get_ports rst]

# Output delays (adjust if needed)
set_output_delay 2.0 -clock clk [get_ports P]
set_output_delay 2.0 -clock clk [get_ports done]
