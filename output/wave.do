onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /core_tb_00/DUT/clk
add wave -noupdate /core_tb_00/DUT/rst
add wave -noupdate /core_tb_00/DUT/write_r
add wave -noupdate /core_tb_00/DUT/read_r
add wave -noupdate /core_tb_00/DUT/PC_en
add wave -noupdate /core_tb_00/DUT/ac_ena
add wave -noupdate /core_tb_00/DUT/ram_ena
add wave -noupdate /core_tb_00/DUT/rom_ena
add wave -noupdate /core_tb_00/DUT/ram_write
add wave -noupdate /core_tb_00/DUT/ram_read
add wave -noupdate /core_tb_00/DUT/rom_read
add wave -noupdate /core_tb_00/DUT/ad_sel
add wave -noupdate /core_tb_00/DUT/fetch
add wave -noupdate -radix unsigned /core_tb_00/DUT/data
add wave -noupdate -radix unsigned /core_tb_00/DUT/addr
add wave -noupdate -radix unsigned /core_tb_00/DUT/accum_out
add wave -noupdate -radix unsigned /core_tb_00/DUT/alu_out
add wave -noupdate -radix unsigned /core_tb_00/DUT/ir_ad
add wave -noupdate -radix unsigned /core_tb_00/DUT/pc_ad
add wave -noupdate -radix unsigned /core_tb_00/DUT/reg_ad
add wave -noupdate /core_tb_00/DUT/ins
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5038 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 202
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {2625 ps} {7654 ps}
