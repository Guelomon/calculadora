`timescale 1ns / 1ps

module FSM2(
	input logic reset, BTNC,BTND, clk,
	input logic [15:0] SW,
	input logic [16:0] resultado,
	output logic [2:0] enable,
	output logic  power_on,
	output logic [16:0] salida_display,
	output logic [1:0] estado
    );
    enum logic [1:0] {wait_op1, wait_op2, wait_op, show_result} state, next_state;
    
    always_ff @(posedge clk) begin
    	if (reset) begin
    		state <= wait_op1;
    	end
    	else begin
    		state <= next_state;
    	end
    end
    
    always_comb begin
    	next_state = wait_op1;
    	case (state)
    		wait_op1:	if (BTNC == 1 && BTND == 0) next_state = wait_op2;
    					else if (BTND == 1 && BTNC == 0) next_state = wait_op1;
    					else next_state = wait_op1;
    		wait_op2:	if (BTNC == 1 && BTND == 0) next_state = wait_op;
    					else if (BTND == 1 && BTNC == 0) next_state = wait_op1;
    					else next_state = wait_op2;
			wait_op:	if (BTNC == 1 && BTND == 0) next_state = show_result;
						else if (BTND == 1 && BTNC == 0) next_state = wait_op2;
    					else next_state = wait_op;
			show_result:	if (BTNC == 1 && BTND == 0) next_state = wait_op1;
							else if (BTND == 1 && BTNC == 0) next_state = wait_op;
    						else next_state = show_result;
    		default:	next_state = wait_op1;
    	endcase
    end
    
    always_comb begin
    case (state)
        		wait_op1:	salida_display = SW;
        		wait_op2:	salida_display = SW;
    			wait_op:	salida_display = SW;
    			show_result:	salida_display = resultado;
        		default:	salida_display = SW;
        	endcase
    end
    always_comb begin
    case (state)
        	wait_op1:	enable = 3'b011;
        	wait_op2:	enable = 3'b101;
        	wait_op:	enable = 3'b110;
      		show_result:	enable = 3'b111;
      		default:	enable = 3'b111;
    endcase    
    end
    
    always_comb begin
        case (state)
            	wait_op1:	power_on = 1'b1;
            	wait_op2:	power_on = 1'b1;
            	wait_op:	power_on = 1'b0;
          		show_result:	power_on = 1'b1;
          		default:	power_on = 1'b1;
        endcase    
        end
    always_comb begin
            case (state)
                	wait_op1:	power_on = 1'b1;
                	wait_op2:	power_on = 1'b1;
                	wait_op:	power_on = 1'b0;
              		show_result:	power_on = 1'b1;
              		default:	power_on = 1'b1;
            endcase    
            end

    assign estado = state;
endmodule
