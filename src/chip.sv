`default_nettype none

module my_chip (
    input logic [11:0] io_in, // Inputs to your chip
    output logic [11:0] io_out, // Outputs from your chip
    input logic clock,
    input logic reset // Important: Reset is ACTIVE-HIGH
);
    
    // Basic counter design as an example
    RangeFinder #(.WIDTH(10)) rf (.clock(clock), .reset(reset), .data_in(io_in[9:0]), 
                                  .range(io_out[9:0]), .go(io_in[10]), .finish(io_in[11]),
                                  .debug_error(io_out[10]));  

endmodule
