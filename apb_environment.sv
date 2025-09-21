class apb_env extends uvm_env;
  
  `uvm_component_utils(apb_env)
  
  apb_active_agent act_agt;
  apb_passive_agent pass_agt;
  apb_scoreboard scb;  
  
  function new(string name = "apn_env", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    act_agt = apb_active_agent::type_id::create("act_agt",this);
    pass_agt = apb_passive_agent::type_id::create("pass_agt",this);
    scb = apb_scoreboard::type_id::create("scb",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    act_agt.act_mon.act_mon_port.connect(scb.act_mon_imp);
    pass_agt.pass_mon.pass_mon_port.connect(scb.pass_mon_imp);
  endfunction 
  
endclass
