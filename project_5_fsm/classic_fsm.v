// File: classic_fsm.v
// Generated by MyHDL 0.11
// Date: Sat Dec  5 19:56:33 2020


`timescale 1ns/10ps

module classic_fsm (
    clk_i,
    inputs_i,
    outputs_o
);


input clk_i;
input [1:0] inputs_i;
output [3:0] outputs_o;
reg [3:0] outputs_o;

wire [1:0] dbnc_inputs;
reg [1:0] prev_inputs;
reg [1:0] fsm_state;
wire [1:0] input_chgs;
reg [1:0] reset_cnt;
reg [16:0] k_debounce_cnt;
reg k_prev_button;
reg k_button_o;
reg [16:0] chunk_insts_0_debounce_cnt;
reg chunk_insts_0_prev_button;
reg chunk_insts_0_button_o;
wire [1:0] chunk_insts_0_chunk_insts_2_a;

assign chunk_insts_0_chunk_insts_2_a[1] = k_button_o;
assign chunk_insts_0_chunk_insts_2_a[0] = chunk_insts_0_button_o;


always @(posedge clk_i) begin: CLASSIC_FSM_LOC_INSTS_CHUNK_INSTS_0_LOC_INSTS_CHUNK_INSTS_0
    if ((inputs_i[0] == chunk_insts_0_prev_button)) begin
        if ((chunk_insts_0_debounce_cnt != 0)) begin
            chunk_insts_0_debounce_cnt <= (chunk_insts_0_debounce_cnt - 1);
        end
    end
    else begin
        chunk_insts_0_debounce_cnt <= 120000;
    end
    chunk_insts_0_prev_button <= inputs_i[0];
end


always @(posedge clk_i) begin: CLASSIC_FSM_LOC_INSTS_CHUNK_INSTS_0_LOC_INSTS_CHUNK_INSTS_K
    if ((chunk_insts_0_debounce_cnt == 0)) begin
        chunk_insts_0_button_o <= chunk_insts_0_prev_button;
    end
end


always @(fsm_state) begin: CLASSIC_FSM_LOC_INSTS_CHUNK_INSTS_1_C
    case (fsm_state)
        2'b00: begin
            outputs_o = 1;
        end
        2'b01: begin
            outputs_o = 2;
        end
        2'b10: begin
            outputs_o = 4;
        end
        2'b11: begin
            outputs_o = 8;
        end
        default: begin
            outputs_o = 15;
        end
    endcase
end



assign dbnc_inputs = chunk_insts_0_chunk_insts_2_a;


always @(posedge clk_i) begin: CLASSIC_FSM_LOC_INSTS_CHUNK_INSTS_3
    if (($signed({1'b0, reset_cnt}) < (4 - 1))) begin
        fsm_state <= 2'b00;
        reset_cnt <= (reset_cnt + 1);
    end
    else if ((fsm_state == 2'b00)) begin
        if (input_chgs[0]) begin
            fsm_state <= 2'b01;
        end
        else if (input_chgs[1]) begin
            fsm_state <= 2'b11;
        end
    end
    else if ((fsm_state == 2'b01)) begin
        if (input_chgs[0]) begin
            fsm_state <= 2'b10;
        end
        else if (input_chgs[1]) begin
            fsm_state <= 2'b00;
        end
    end
    else if ((fsm_state == 2'b10)) begin
        if (input_chgs[0]) begin
            fsm_state <= 2'b11;
        end
        else if (input_chgs[1]) begin
            fsm_state <= 2'b01;
        end
    end
    else if ((fsm_state == 2'b11)) begin
        if (input_chgs[0]) begin
            fsm_state <= 2'b00;
        end
        else if (input_chgs[1]) begin
            fsm_state <= 2'b10;
        end
    end
    else begin
        fsm_state <= 2'b00;
    end
    prev_inputs <= dbnc_inputs;
end



assign input_chgs = (dbnc_inputs & (~prev_inputs));


always @(posedge clk_i) begin: CLASSIC_FSM_LOC_INSTS_CHUNK_INSTS_K_LOC_INSTS_CHUNK_INSTS_0
    if ((inputs_i[1] == k_prev_button)) begin
        if ((k_debounce_cnt != 0)) begin
            k_debounce_cnt <= (k_debounce_cnt - 1);
        end
    end
    else begin
        k_debounce_cnt <= 120000;
    end
    k_prev_button <= inputs_i[1];
end


always @(posedge clk_i) begin: CLASSIC_FSM_LOC_INSTS_CHUNK_INSTS_K_LOC_INSTS_CHUNK_INSTS_K
    if ((k_debounce_cnt == 0)) begin
        k_button_o <= k_prev_button;
    end
end

endmodule
