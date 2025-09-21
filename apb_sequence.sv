`include "defines.svh"

class apb_sequence extends uvm_sequence#(apb_seq_item);
  
  // declaring a seq_item that has to be sent to the driver
  apb_seq_item req;
  
  // factory registeration
  `uvm_object_utils(apb_sequence)
  
  //new constructor
  function new(string name = "apb_sequence");
    super.new("apb_sequence");
  endfunction
  
  task body();
    
    req = apb_seq_item::type_id::create("req");//creating seq_item
    repeat(`num_of_txns) begin
      start_item(req);
      assert(req.randomize());
      `uvm_info(get_type_name(), $sformatf("| SEQUENCE GENERATED | READ_WRITE = %0b | apb_write_paddr = %9b | apb_read_paddr = %9b | apb_write_data = %8d | ",req.READ_WRITE,req.apb_write_paddr,req.apb_read_paddr, req.apb_write_data),UVM_MEDIUM);
      finish_item(req);
    end
  endtask
endclass

class  write_read_seq extends uvm_sequence#(apb_seq_item);
  
  `uvm_object_utils(write_read_seq)
  
  bit [8:0] temp_read_paddr;
  
  function new(string name = "write_read_seq");
    super.new(name);
  endfunction
  
  task body();
    repeat(`num_of_txns) begin
      `uvm_do_with(req,{req.READ_WRITE == 0; req.apb_write_paddr inside {[255:319]};})
      temp_read_paddr = req.apb_write_paddr;
      `uvm_do_with(req, {req.READ_WRITE == 1; req.apb_read_paddr == temp_read_paddr;})      
    end    
  endtask
  
endclass
