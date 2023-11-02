module project(
		input clk,jump,rst,
		output reg [0:15] column,
		output reg [0:31] com
		);

reg map[0:31][15:0];
reg [3:0] ball_place;
reg [4:0]count;
reg[5:0]div,div2,Radom;
reg ball_clk,jump_en,die;
integer i,j,sorce,speed=50;

parameter zero=8'b11111100;

initial begin
for(i=0;i<32;i=i+1)begin
	for(j=0;j<16;j=j+1)begin
		map[i][j]=0;
	end
end

count=0;
Radom=0;
div=0;
div2=0;
ball_clk=0;
jump_en=1;
die=0;
ball_place=0;
com=32'h80000000;
sorce=0;
end

always @(posedge clk)begin
Radom=Radom+div;
div=div+1;
if(div==speed && die==0)begin
	ball_clk=~ball_clk;
	div=0;
	end
end

always @(posedge ball_clk)begin

	map[2][(ball_place+1)] = 0;
	map[2][(ball_place+2)] = 0;
	map[3][(ball_place)]   = 0;
	map[3][(ball_place+1)] = 0;
	map[3][(ball_place+2)] = 0;
	map[3][(ball_place+3)] = 0;
	map[4][(ball_place)]   = 0;
	map[4][(ball_place+1)] = 0;
	map[4][(ball_place+2)] = 0;
	map[4][(ball_place+3)] = 0;
	map[5][(ball_place+1)] = 0;
	map[5][(ball_place+2)] = 0;
	
	
	for(j=0;j<16;j=j+1)begin
		for(i=0;i<31;i=i+1)begin
			map[i][j]=map[i+1][j];
		end
		map[31][j]=0;
	end

	if(ball_place==0)jump_en=1;
	if(ball_place==7)jump_en=0;

	if(jump == 1 && jump_en==1)begin
		if(ball_place<7)ball_place=ball_place+1;
		end
	else if(ball_place>0)begin
		jump_en=0;
		ball_place=ball_place-1;
		end
		
	die = (map[2][(ball_place+1)]|map[2][(ball_place+2)]|map[3][(ball_place)]|map[3][(ball_place+1)]|map[3][(ball_place+2)]|map[3][(ball_place+3)]|
		map[4][(ball_place)]|map[4][(ball_place+1)]|map[4][(ball_place+2)]|map[4][(ball_place+3)]|map[5][(ball_place+1)]|map[5][(ball_place+2)]);
		
	map[2][(ball_place+1)] = 1;
	map[2][(ball_place+2)] = 1;
	map[3][(ball_place)]   = 1;
	map[3][(ball_place+1)] = 1;
	map[3][(ball_place+2)] = 1;
	map[3][(ball_place+3)] = 1;
	map[4][(ball_place)]   = 1;
	map[4][(ball_place+1)] = 1;
	map[4][(ball_place+2)] = 1;
	map[4][(ball_place+3)] = 1;
	map[5][(ball_place+1)] = 1;
	map[5][(ball_place+2)] = 1;
	
	div2=div2+1;
	
	if(div2==50-sorce)begin
		if(sorce<35)sorce=sorce+2;
		else speed=speed-2;
		case(Radom%3)
		6'd0:begin
				map[30][0]  = 1;
				map[30][1]  = 1;
				map[31][0]  = 1;
				map[31][1]  = 1;
			end
		6'd1:begin
				map[29][0]  = 1;
				map[29][1]  = 1;
				map[30][0]  = 1;
				map[30][1]  = 1;
				map[31][0]  = 1;
				map[31][1]  = 1;
			end
		6'd2:begin
				map[30][0]  = 1;
				map[30][1]  = 1;
				map[30][2]  = 1;
				map[30][3]  = 1;
				map[31][0]  = 1;
				map[31][1]  = 1;
				map[31][2]  = 1;
				map[31][3]  = 1;
			end
		endcase
	div2=0;
	end
	
	
	
end



always @(posedge clk)begin
com=com>>1;
if(com==0)com=32'h80000000;
count=count+1;

column = {map[count][15],map[count][14],map[count][13],map[count][12],map[count][11],map[count][10],map[count][9],map[count][8],map[count][7],map[count][6],
				map[count][5],map[count][4],map[count][3],map[count][2],map[count][1],map[count][0]};

end


endmodule 
