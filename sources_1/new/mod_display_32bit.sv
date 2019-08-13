`timescale 1ns / 1ps

module mod_display_32bit(
    input logic [31:0] numero_entrada,
    input power_on, clk, // prende el display
	
    output logic [6:0] sevenSeg,
    output logic [7:0] AN
	);
	logic clk_display;
	localparam COUNTER_MAX = (100000000/(2*480))-1;
    logic [2:0] contador_anodo = 3'b0;
    logic [31:0] contador_display = 'd0;
    logic [3:0] bus_out;
    
    always @(posedge clk) begin
        	if (contador_display == COUNTER_MAX)
        	begin
        		contador_display <= 'd0;
        		clk_display <= ~clk_display;
        	end
        	else
        	begin
        		contador_display <= contador_display + 'd1;
        		clk_display <= clk_display;
        	end
        end
    
    always @(posedge clk_display) begin
    	contador_anodo = contador_anodo + 3'b1;
    end
    
	always_comb begin
		if (power_on == 1'b0)
		begin
    		AN[7:0] = 8'b11111111;
    	end
    	else 
    	begin
     		case (contador_anodo) 
        		3'd0 : AN[7:0] = 8'b11111110;
        		3'd1 : AN[7:0] = 8'b11111101;
				3'd2 : AN[7:0] = 8'b11111011;
				3'd3 : AN[7:0] = 8'b11110111;                              
				3'd4 : AN[7:0] = 8'b11101111;
				3'd5 : AN[7:0] = 8'b11011111;
				3'd6 : AN[7:0] = 8'b10111111;
				3'd7 : AN[7:0] = 8'b01111111;        
          		default : AN[7:0] = 8'b11111111;
      		endcase
 		end
 	end

	always_comb begin
    	case (contador_anodo) 
    		3'd0 :  bus_out = numero_entrada[3:0];
			3'd1 :  bus_out = numero_entrada[7:4];
			3'd2 :  bus_out = numero_entrada[11:8];
			3'd3 :  bus_out = numero_entrada[15:12];
			3'd4 :  bus_out = numero_entrada[19:16];
			3'd5 :  bus_out = numero_entrada[23:20];
			3'd6 :  bus_out = numero_entrada[27:24];
			3'd7 :  bus_out = numero_entrada[31:28];
			default: bus_out = 4'b0000;                            
    	endcase
 	end
    
	always_comb begin
    	case(bus_out)
			4'd0:  sevenSeg = 7'b0000001;
			4'd1:  sevenSeg = 7'b1001111; 
			4'd2:  sevenSeg = 7'b0010010;
			4'd3:  sevenSeg = 7'b0000110;
			4'd4:  sevenSeg = 7'b1001100;
			4'd5:  sevenSeg = 7'b0100100;
			4'd6:  sevenSeg = 7'b0100000;
			4'd7:  sevenSeg = 7'b0001111;
			4'd8:  sevenSeg = 7'b0000000;
			4'd9:  sevenSeg = 7'b0001100;
			4'd10: sevenSeg = 7'b0001000; 
			4'd11: sevenSeg = 7'b1100000;
			4'd12: sevenSeg = 7'b0110001;
			4'd13: sevenSeg = 7'b1000010;
			4'd14: sevenSeg = 7'b0110000;
			4'd15: sevenSeg = 7'b0111000;
			default: sevenSeg = 7'b1111111;
     	endcase
 	end
endmodule
