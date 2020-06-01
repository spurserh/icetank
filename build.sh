#!/bin/sh -x
set -e
/home/shmeebegek/.cache/bazel/_bazel_shmeebegek/17f66d1871013aebc7a93f35279587c4/execroot/com_google_xls/bazel-out/k8-opt/bin/xls/contrib/xlscc/driver/xlscc ./test_fpga_combo.cc -T ./types.pb ./test_fpga_combo.ir

/home/shmeebegek/.cache/bazel/_bazel_shmeebegek/17f66d1871013aebc7a93f35279587c4/execroot/com_google_xls/bazel-out/k8-opt/bin/xls/tools/opt_main ./test_fpga_combo.ir > ./test_fpga_combo.opt.ir

/home/shmeebegek/.cache/bazel/_bazel_shmeebegek/17f66d1871013aebc7a93f35279587c4/execroot/com_google_xls/bazel-out/k8-opt/bin/xls/tools/codegen_main ./test_fpga_combo.opt.ir --generator=combinational --use_system_verilog=false > ./xls.v
#/home/shmeebegek/.cache/bazel/_bazel_shmeebegek/17f66d1871013aebc7a93f35279587c4/execroot/com_google_xls/bazel-out/k8-fastbuild/bin/xls/tools/codegen_main ./test_fpga_combo.ir --generator=pipeline --pipeline_stages=1 --flop_inputs=1 --flop_outputs=0  > ./xls.v

make -j20 > ./icestorm.log
sudo iceprog ./example.bin
	