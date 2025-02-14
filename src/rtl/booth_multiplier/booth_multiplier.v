module booth_multiplier #(
    parameter N = 32
  ) (
    input clk,
    input rst,
    input en,
    input [N-1 : 0] a,
    input [N-1 : 0 ]b ,
    output reg [ (N*2) - 1 : 0] c

  );

  reg[N-1:0] A;
  reg[N:0] Q;

  reg [6:0] SC ;//= N;
  reg signed [N*2:0] temp_c;
  reg [N-1: 0] multiplicand, multiplier;

  //sign of the result is xoring the last bits of the 2 operands
  reg out_sign;// out_sign = a[N-1] ^ b[N-1];

  wire start;

  assign start = (SC ==  0);


  always @(posedge clk)
  begin

    if(rst == 1'b1)
    begin
      A = 0;
      SC = 0;
      c = 'bz;
    end
    else
    begin
        if(en)
        begin

          if(start)
          begin

              out_sign = a[N-1] ^ b[N-1];
              
              //check for 1st operand's sign
              //if -ve then get its 2's complement
              multiplicand = (a[N-1] == 1'b0)? a: ~a +1;
              //check for 2nd operand's sign
              //if -ve then get its 2's complement
              multiplier = (b[N-1] == 1'b0)? b: ~b +1;


              Q[N:1] = multiplier;//[N-1:0];
              Q[0] = 0;
          end

          case (Q[1:0])
            2'b01 :
              A = A + multiplicand;
            2'b10 :
              A = A - multiplicand;
            default:
              A = A;
          endcase
          temp_c = {A, Q};
          temp_c = temp_c >>> 1;
          // temp_c = {Q[1],A,Q[N:1]};

          Q[0] = temp_c[0];
          Q[N:1] = temp_c[N:1];
          A = temp_c[N*2:N+1];

          // end
          if(SC == N-1)
            begin
              SC = 0;
              c= (out_sign==0 ) ? temp_c[(N*2) -1 : 1] : ~temp_c[(N*2) -1 : 1] +1 ;

            end
          else
            begin
              
              SC <= SC+1;
            end



        end
        else
        begin
          c = 'bz;
        end

    end
  end


endmodule
