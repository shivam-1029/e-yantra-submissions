onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/clk_50MHz
add wave -noupdate /tb/clk_1MHz
add wave -noupdate /tb/exp_clk_out_1
add wave -noupdate /tb/error_clk_1
add wave -noupdate /tb/clk_500Hz
add wave -noupdate /tb/exp_clk_out_2
add wave -noupdate /tb/error_clk_2
add wave -noupdate /tb/pulse_width
add wave -noupdate /tb/pwm_signal
add wave -noupdate /tb/exp_pwm_out
add wave -noupdate /tb/error_pwm
add wave -noupdate /tb/error_count
add wave -noupdate /tb/i
add wave -noupdate /tb/fw
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {19999999363 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {21 ms}
