module stopwatch(clk, btn, contar_tempo, pausar_display, zerar_tempo, hex0,hex1,hex2,hex3);

input clk;
input[3:0] btn;
reg[3:0] pressed;
output reg contar_tempo;
output reg pausar_display;
output reg zerar_tempo;

parameter delay = 5000000;
parameter reset = 0, contando = 1, pausado = 2, parado = 3;

reg[1:0] state;

//combinational
always @(negedge clk) begin
	case(state)
	reset: begin
		contar_tempo <= 0;
		pausar_display <= 0;
		zerar_tempo <= 1;
	end
	
	contando: begin
		contar_tempo <= 1;
		pausar_display <= 0;
		zerar_tempo <= 0;
	end
	
	pausado: begin
		contar_tempo <= 1;
		pausar_display <= 1;
		zerar_tempo <= 0;
	end
	
	parado: begin
		contar_tempo <= 0;
		pausar_display <= 0;
		zerar_tempo <= 0;
	end
	endcase
end


//sequencial
always @(posedge clk) begin
	if(!btn[0] == 1) pressed[0] <= 1;
	if(!btn[1] == 1) pressed[1] <= 1;
	if(!btn[2] == 1) pressed[2] <= 1;
	if(!btn[3] == 1) pressed[3] <= 1;
	
	if(!btn[3] == 1 && pressed[3] == 1) state <= reset;
	
	case(state) 
		reset: begin
			if(!btn[2] == 1 && pressed[2] == 1) state <= contando;
		end
		
		contando: begin
			if(!btn[1] == 1 && pressed[1] == 1) state <= pausado;
			if(!btn[0] == 1 && pressed[0] == 1) state <= parado;
		end
		
		pausado: begin
			if(!btn[2] == 1 && pressed[2] == 1) state <= contando;
			if(!btn[0] == 1 && pressed[0] == 1) state <= parado;
		end
		parado: begin
			if(!btn[2] == 1 && pressed[2] == 1) state <= contando;
		end
		endcase
	
end


wire [13:0] counter;
wire [3:0]  num0,num1,num2,num3;
delay_counter d_counter(clk, contar_tempo, zerar_tempo, counter);
converter conv(counter, pausar_display, num0,num1,num2,num3);

output [0:6] hex0,hex1,hex2,hex3;

decoder decimal(num0, hex0);
decoder unidade(num1, hex1);
decoder dezena(num2, hex2);
decoder centena(num3, hex3);

endmodule
