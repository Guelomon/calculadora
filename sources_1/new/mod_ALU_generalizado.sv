`timescale 1ns / 1ps

module mod_ALU_generalizado #(parameter n_bits = 8)
    (
	input logic [n_bits-1:0] entrada_a, entrada_b, 
	input logic [1:0] operacion, 
	output logic [n_bits-1:0] resultado
    );
    
	always_comb begin
		case (operacion)
			2'b00:	resultado = entrada_a + entrada_b;
			2'b01:	resultado = entrada_a + (~entrada_b + 'd1);
			2'b10:	resultado = entrada_a & entrada_b;
			2'b11:	resultado = entrada_a | entrada_b; 
			default: resultado = 'd0; 
		endcase
	end
endmodule
