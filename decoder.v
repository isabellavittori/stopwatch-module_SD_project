module decoder(number, display);

input [3:0] number;
output reg[0:6] display;

always@(number) begin
	case(number)
		4'd1: display <= 7'b1001111;
		4'd2: display <= 7'b0010010;
		4'd3: display <= 7'b0000110;
		4'd4: display <= 7'b1001100;
		4'd5: display <= 7'b0100100;
		4'd6: display <= 7'b0100000;
		4'd7: display <= 7'b0001111;
		4'd8: display <= 7'b0000000;
		4'd9: display <= 7'b0000100;
		default: display <= 7'b0000001;
		endcase
end
endmodule
