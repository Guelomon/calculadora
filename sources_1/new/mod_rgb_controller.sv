module rgb_ctr(
    input logic reset, //se considero el uso de logica negativa en el boton
    input logic clk_in, //2,1,0 -> azul,verde y rojo.
    input logic [2:0] led_in,
    output logic [2:0] led_out
    );
        logic clk_out;
        localparam COUNTER_MAX = (100000000/(2*60))-1; //determina el valor del contador a partir del parametro de frecuencia
        localparam n_bits = $clog2(COUNTER_MAX); //determina la cantidad de bits para almacenar COUNTER_MAX
        logic [n_bits-1:0] counter = 'd0;
        //operacion normal del reloj
        always @(posedge clk_in)
        begin
            if (~reset == 1'b1)
            begin
                counter <= 'd0;
                clk_out <= 1'b0;
            end
            else if (counter == COUNTER_MAX)
            begin
                counter <= 'd0;
                clk_out <= ~clk_out;
            end
            else
            begin
                counter <= counter + 'd1;
                clk_out <= clk_out;
            end
        end
        always_comb
        begin
            case(led_in)
            3'd0:   led_out =   3'd0;
            3'd1:   led_out =   {2'd0,clk_out};
            3'd2:   led_out =   {1'd0,clk_out,1'd0};
            3'd3:   led_out =   {1'd0,clk_out,clk_out};
            3'd4:   led_out =   {clk_out,2'd0};
            3'd5:   led_out =   {clk_out,1'd0,clk_out};
            3'd6:   led_out =   {clk_out,clk_out,1'd0};
            3'd7:   led_out =   {clk_out,clk_out,clk_out};
            default: led_out=3'd0;
            endcase
        end   
    endmodule