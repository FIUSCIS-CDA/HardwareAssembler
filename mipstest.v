// This tests the MIPS CPU.

module testbench();

  reg        clk;
  reg        reset;

  wire [31:0] writedata, dataadr;
  wire        memwrite;


  // instantiate device to be tested
  top dut(clk, reset, writedata, dataadr, memwrite);

  // initialize test
  initial
    begin
      reset <= 1; # 20; reset <= 0;
      $display("SYSTEM RESET COMPLETE");
    end

  // generate clock to sequence tests
  always @*
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end

  // check that 7 gets written to address 84
  always@(negedge clk)
    begin
        if(memwrite & dataadr === 84 & writedata === 7) begin
          $display("Simulation succeeded");
          $stop;
        end else if (memwrite & dataadr !== 80) begin
          $display("Simulation failed");
          $stop;
        end
      //end
    end
endmodule



