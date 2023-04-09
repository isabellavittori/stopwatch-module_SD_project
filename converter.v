module converter(counter, pausar_dis, num0, num1, num2, num3);

input [14:0] counter;
input pausar_dis;

output reg [3:0] num0, num1, num2, num3;

always@(counter) begin
	if(pausar_dis != 1) begin
		num0 <= counter % 10;
		num1 <= (counter / 10) % 10;
		num2 <= (counter / 100) % 10;
		num3 <= (counter / 1000) % 10;
	end
end
endmodule
