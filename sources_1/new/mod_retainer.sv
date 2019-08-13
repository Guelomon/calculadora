`timescale 1ns / 1ps

module mod_retainer #(parameter N=8)
(	input  logic           clk,
	input  logic           reset,
	input  logic   [N-1:0] switches,
	input  logic           retain,
	output logic   [N-1:0] retain_output
);

    logic [N-1:0] Q, Q_next;
    assign retain_output = Q;

	always_ff @(posedge clk) begin
	   if (reset) begin
	       Q <= 2'd0;
	   end else begin
	       Q <= Q_next;
	   end
	end

	always_comb begin
		case (retain)
		  1'b0: 	  Q_next = switches;
		  1'b1: 	  Q_next = Q;
        endcase
	end

endmodule
