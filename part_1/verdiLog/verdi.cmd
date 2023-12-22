simSetSimulator "-vcssv" -exec "./simv" -args " " -uvmDebug on
debImport "-i" "-simflow" "-dbdir" "./simv.daidir"
srcTBInvokeSim
verdiSetActWin -dock widgetDock_<Member>
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "Instruction_Memory" -win $_nTrace1
srcHBSelect "Instruction_Memory" -win $_nTrace1
wvCreateWindow
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave3
verdiSetActWin -win $_nWave3
srcHBSelect "Single_Cycle_Top_Tb.Single_Cycle_Top.Register_File" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave3
verdiSetActWin -win $_nWave3
verdiWindowBeWindow -win $_nWave3
wvResizeWindow -win $_nWave3 -10 19 1272 386
wvResizeWindow -win $_nWave3 54 115 1483 786
wvResizeWindow -win $_nWave3 108 128 1483 786
verdiSetActWin -dock widgetDock_<Inst._Tree>
verdiSetActWin -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomOut -win $_nWave3
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcTBRunSim
verdiSetActWin -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomOut -win $_nWave3
wvSetCursor -win $_nWave3 771441.135514 -snap {("G2" 0)}
wvSelectGroup -win $_nWave3 {G2}
wvSetCursor -win $_nWave3 340341.677433 -snap {("Register_File" 5)}
verdiSetActWin -dock widgetDock_<Member>
verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "Single_Cycle_Top_Tb.Single_Cycle_Top.Register_File" -win $_nTrace1
verdiSetActWin -win $_nWave3
wvSelectGroup -win $_nWave3 {Instruction_Memory/Register_File}
wvGetSignalOpen -win $_nWave3
wvGetSignalSetScope -win $_nWave3 "/Instruction_Memory"
wvGetSignalSetScope -win $_nWave3 \
           "/Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File"
wvSetPosition -win $_nWave3 {("Instruction_Memory/Register_File" 10)}
wvSetPosition -win $_nWave3 {("Instruction_Memory/Register_File" 10)}
wvAddSignal -win $_nWave3 -clear
wvAddSignal -win $_nWave3 -group {"Instruction_Memory" \
{/Instruction_Memory/rst} \
{/Instruction_Memory/A\[31:0\]} \
{/Instruction_Memory/RD\[31:0\]} \
}
wvAddSignal -win $_nWave3 -group {"Instruction_Memory/Register_File" \
{/Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/clk} \
{/Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/rst} \
{/Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/WE3} \
{/Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/WD3\[31:0\]} \
{/Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/A1\[4:0\]} \
{/Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/A2\[4:0\]} \
{/Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/A3\[4:0\]} \
{/Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/RD1\[31:0\]} \
{/Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/RD2\[31:0\]} \
{/Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/Register\[31:0\]} \
}
wvAddSignal -win $_nWave3 -group {"G2" \
}
wvSelectSignal -win $_nWave3 {( "Instruction_Memory/Register_File" 10 )} 
wvSetPosition -win $_nWave3 {("Instruction_Memory/Register_File" 10)}
wvSetPosition -win $_nWave3 {("Instruction_Memory/Register_File" 10)}
wvSetPosition -win $_nWave3 {("Instruction_Memory/Register_File" 10)}
wvAddSignal -win $_nWave3 -clear
wvAddSignal -win $_nWave3 -group {"Instruction_Memory" \
{/Instruction_Memory/rst} \
{/Instruction_Memory/A\[31:0\]} \
{/Instruction_Memory/RD\[31:0\]} \
}
wvAddSignal -win $_nWave3 -group {"Instruction_Memory/Register_File" \
{/Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/clk} \
{/Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/rst} \
{/Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/WE3} \
{/Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/WD3\[31:0\]} \
{/Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/A1\[4:0\]} \
{/Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/A2\[4:0\]} \
{/Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/A3\[4:0\]} \
{/Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/RD1\[31:0\]} \
{/Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/RD2\[31:0\]} \
{/Single_Cycle_Top_Tb/Single_Cycle_Top/Register_File/Register\[31:0\]} \
}
wvAddSignal -win $_nWave3 -group {"G2" \
}
wvSelectSignal -win $_nWave3 {( "Instruction_Memory/Register_File" 10 )} 
wvSetPosition -win $_nWave3 {("Instruction_Memory/Register_File" 10)}
wvGetSignalClose -win $_nWave3
wvSelectSignal -win $_nWave3 {( "Instruction_Memory/Register_File" 10 )} 
wvExpandBus -win $_nWave3
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvSetCursor -win $_nWave3 306307.509690 -snap {("Register_File" 39)}
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 0
wvTpfCloseForm -win $_nWave3
wvGetSignalClose -win $_nWave3
wvCloseWindow -win $_nWave3
verdiSetActWin -dock widgetDock_<Inst._Tree>
debExit
