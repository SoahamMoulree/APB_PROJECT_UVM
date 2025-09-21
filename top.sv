// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
`include "apb_interface.sv"
`include "apb_pkg.sv"
`include "apbtop.v"

module top;
  import uvm_pkg::*;
  import apb_pkg::*;

  bit PCLK;
  bit PRESETn;
  bit transfer;

  always #5 PCLK = ~PCLK;

  apb_intf intf(PCLK, PRESETn,transfer);

  APB_Protocol dut (
    .PCLK(PCLK),
    .PRESETn(PRESETn),
    .transfer(transfer),
    .apb_write_paddr(intf.apb_write_paddr),
    .apb_read_paddr(intf.apb_read_paddr),
    .apb_write_data(intf.apb_write_data),
    .READ_WRITE(intf.READ_WRITE),
    .apb_read_data_out(intf.apb_read_data_out),
    .PSLVERR(intf.PSLVERR)
    
  );

  initial begin
    
    transfer = 1;
    PRESETn = 0;
    #5  
    PRESETn = 1;
  end
  initial begin
    uvm_config_db#(virtual apb_intf)::set(null, "*", "apb_intf", intf);
    run_test("write_read_test");
  end
endmodule
