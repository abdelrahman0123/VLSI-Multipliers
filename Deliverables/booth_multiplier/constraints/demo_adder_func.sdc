
######################################################################
# 
#  ------------------------------------------------------------------
#   Design    : demo_Adder
#  ------------------------------------------------------------------
#     SDC timing constraint file
#  ------------------------------------------------------------------
#


set pad_load            10  
set transition          0.707321
set io_clock_period     2.0
set clock_period        2.0   


create_clock -name sysclk -period ${clock_period} [ get_ports clk ]
#create_clock -name vsysclk -period ${io_clock_period} 

set_false_path -from [get_ports rst]

#set_false_path   -from [ get_ports reset_n ]

set_load                ${pad_load}   [ all_outputs ]
set_input_transition    ${transition} [ all_inputs ]
set_input_delay          0.2 [all_inputs]

set_output_delay -clock sysclk [ expr 0.5 * ${io_clock_period} ] [ all_outputs ] 
 #   [ remove_from_collection [ all_outputs ] [ get_ports { usb_plus usb_minus }] ]












