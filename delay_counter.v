module delay_counter(clk, contar_tempo, zerar_tempo, counter);

input clk;
input contar_tempo;
input zerar_tempo;

output reg[14:0] counter;

reg[23:0] delay = 5000000;
reg[24:0] i;

always@(posedge clk) begin
	if(i + 1 == delay) begin
		counter <= counter + 1;
		i <= 0;
		if(counter == 10000) counter <= 0;
	end
	else if(contar_tempo == 1 && zerar_tempo == 0) i <= i + 1;
	else if(zerar_tempo == 1) begin
		i <= 0;
		counter <= 0;
	end
end
endmodule

//reg [3:0] a = 3'd1;
