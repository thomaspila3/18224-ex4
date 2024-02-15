module RangeFinder
    #(parameter WIDTH=16)
    (input logic [WIDTH-1:0] data_in,
    input logic clock, reset,
    input logic go, finish,
    output logic [WIDTH-1:0] range,
    output logic debug_error);

    logic [WIDTH-1:0] largest, largest_ff, smallest_ff,  smallest;
    logic going;

    assign range = largest_ff - smallest_ff;

    always_ff @ (posedge clock, posedge reset) begin
        if (reset) begin
            largest <= ~'b0;
            smallest <= 'b0;
            going <= 'b0;
            debug_error <= 'b0;
        end else begin
            if (~going) begin
                if (finish)
                    debug_error <= 'b1;
                if (go & ~finish) begin
                    going <= 1'b1;
                    largest_ff = data_in;
                    smallest_ff = data_in;
                    debug_error <= 'b0;
                end
            end else begin // going already
                if (data_in > largest)
                    largest_ff = data_in;
                else if (data_in < smallest)
                    smallest_ff = data_in;

                if (finish) begin
                    largest <= ~'b0;
                    smallest <= 'b0;
                    going <= 'b0;
                end else begin
                    largest <= largest_ff;
                    smallest <= smallest_ff;
                end
            end
        end
    end

endmodule: RangeFinder
