

`include "xls.v"

module top (
  input  clk,
  output TX,
  output LED0,
  output LED1,
  output LED2,
  output LED3,
  output LED4,
  output LED5,
  output LED6,
  output LED7,
  output MOTORLB,
  output MOTORLF,
  output MOTORRB,
  output MOTORRF,
  output adc_pwm,
  input adc_fb,
  output dbg_en
);

  assign {LED0, LED1, LED2, LED3, LED4, LED5, LED6} = 7'b0000000;

  wire adc_pwm_d;
  wire adc_pwm_en;


  wire [7:0] ios_raw;
  reg [7:0] ios_reg;

  wire dummy;
  assign {adc_pwm_d, adc_pwm_en, dbg_en, LED7, TX, MOTORLB, MOTORLF, MOTORRB, MOTORRF} = ios_reg;

  reg [74:0] state = 0;
  wire [74:0] next_state;
  main Process_m(
    .state(state),
    .io_in(adc_fb),
    .out({ios_raw, next_state})
  );

  always @(posedge clk) begin
    state <= next_state;
    ios_reg <= ios_raw;
  end

  wire in_unused;
  SB_IO #(
      .PIN_TYPE(6'b101001),
      .PULLUP(1'b0)
  ) io_block_instance (
      .PACKAGE_PIN(adc_pwm),
      .OUTPUT_ENABLE(adc_pwm_en),
      .D_OUT_0(adc_pwm_d),
      .D_IN_0(in_unused) 
  );


endmodule


