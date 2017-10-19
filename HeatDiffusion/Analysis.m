error00 = HeatDiffusion( .02, .02, .5, [-1,1], 1 );

error10 = HeatDiffusion( .1, .1, .5, [-1,1], 1 );
error11 = HeatDiffusion( .05, .1, .5, [-1,1], 1 );
error12 = HeatDiffusion( .1, .05, .5, [-1,1], 1 );

error20 = HeatDiffusion( .05, .05, .5, [-1,1], 1 );
error21 = HeatDiffusion( .025, .05, .5, [-1,1], 1 );
error22 = HeatDiffusion( .05, .025, .5, [-1,1], 1 );

error30 = HeatDiffusion( .025, .025, .5, [-1,1], 1 );
error31 = HeatDiffusion( .0125, .025, .5, [-1,1], 1 );
error32 = HeatDiffusion( .025, .0125, .5, [-1,1], 1 );

error40 = HeatDiffusion( .0125, .0125, .5, [-1,1], 1 );
error41 = HeatDiffusion( .00625, .0125, .5, [-1,1], 1 );
error42 = HeatDiffusion( .0125, .00625, .5, [-1,1], 1 );

T1 = table;
T1.Grid_Node = error00(1:101,1);
T1.Absolute_Error = error00(1:101,2);
T1.Percent_Error = error00(1:101,3);
writetable(T1, 'Grid Point Error Analysis.xlsx','Sheet',1,'Range','A2');

T2 = table;
T2.Grid_Node = error10(1:21,1);
T2.Absolute_Error = error10(1:21,2);
T2.Percent_Error = error10(1:21,3);
writetable(T2, 'Grid Point Error Analysis.xlsx','Sheet',1,'Range','D2');

T3 = table;
T3.Grid_Node = error20(1:41,1);
T3.Absolute_Error = error20(1:41,2);
T3.Percent_Error = error20(1:41,3);
writetable(T3, 'Grid Point Error Analysis.xlsx','Sheet',1,'Range','G2');

T4 = table;
T4.Grid_Node = error30(1:81,1);
T4.Absolute_Error = error30(1:81,2);
T4.Percent_Error = error30(1:81,3);
writetable(T4, 'Grid Point Error Analysis.xlsx','Sheet',1,'Range','J2');

T5 = table;
T5.Grid_Node = error40(1:161,1);
T5.Absolute_Error = error40(1:161,2);
T5.Percent_Error = error40(1:161,3);
writetable(T5, 'Grid Point Error Analysis.xlsx','Sheet',1,'Range','M2');

T6 = table;
T6.Grid_Node = error40(1:8:161,1);
T6.Percent_Error_20_Grid_Nodes = error10(1:21,3);
T6.Percent_Error_40_Grid_Nodes = error20(1:2:41,3);
T6.Percent_Error_80_Grid_Nodes = error30(1:4:81,3);
T6.Percent_Error_160_Grid_Nodes = error40(1:8:161,3);
T6.Error_Of_20_Over_Error_Of_40 = error10(1:21,3) ./ error20(1:2:41,3);
T6.Error_Of_20_Over_Error_Of_80 = error10(1:21,3) ./ error30(1:4:81,3);
T6.Error_Of_20_Over_Error_Of_160 = error10(1:21,3) ./ error40(1:8:161,3);
writetable(T6, 'Grid Point Error Analysis.xlsx','Sheet',2,'Range','A2');

T7 = table;
T7.Grid_Node = error10(1:21,1);
T7.Percent_Error_20_Grid_Nodes_10_Iterations = error10(1:21,3);
T7.Percent_Error_20_Grid_Nodes_20_Iterations = error11(1:21,3);
T7.Percent_Error_40_Grid_Nodes_10_Iterations = error12(1:2:41,3);
T7.Error_Of_10_Iterations_Over_Error_Of_20_Iterations = error10(1:21,3) ./ error11(1:21,3);
T7.Error_Of_20_Grid_Nodes_Over_Error_Of_40_Grid_Nodes = error10(1:21,3) ./ error12(1:2:41,3);
writetable(T7, 'Grid Point Error Analysis.xlsx','Sheet',3,'Range','A2');

T8 = table;
T8.Grid_Node = error20(1:41,1);
T8.Percent_Error_40_Grid_Nodes_20_Iterations = error20(1:41,3);
T8.Percent_Error_40_Grid_Nodes_40_Iterations = error21(1:41,3);
T8.Percent_Error_80_Grid_Nodes_20_Iterations = error22(1:2:81,3);
T8.Error_Of_20_Iterations_Over_Error_Of_40_Iterations = error20(1:41,3) ./ error21(1:41,3);
T8.Error_Of_40_Grid_Nodes_Over_Error_Of_80_Grid_Nodes = error20(1:41,3) ./ error22(1:2:81,3);
writetable(T8, 'Grid Point Error Analysis.xlsx','Sheet',4,'Range','A2');

T9 = table;
T9.Grid_Node = error30(1:81,1);
T9.Percent_Error_80_Grid_Nodes_40_Iterations = error30(1:81,3);
T9.Percent_Error_80_Grid_Nodes_80_Iterations = error31(1:81,3);
T9.Percent_Error_160_Grid_Nodes_40_Iterations = error32(1:2:161,3);
T9.Error_Of_40_Iterations_Over_Error_Of_80_Iterations = error30(1:81,3) ./ error31(1:81,3);
T9.Error_Of_80_Grid_Nodes_Over_Error_Of_160_Grid_Nodes = error30(1:81,3) ./ error32(1:2:161,3);
writetable(T9, 'Grid Point Error Analysis.xlsx','Sheet',5,'Range','A2');

T10 = table;
T10.Grid_Node = error40(1:161,1);
T10.Percent_Error_160_Grid_Nodes_80_Iterations = error40(1:161,3);
T10.Percent_Error_160_Grid_Nodes_160_Iterations = error41(1:161,3);
T10.Percent_Error_320_Grid_Nodes_80_Iterations = error42(1:2:321,3);
T10.Error_Of_80_Iterations_Over_Error_Of_160_Iterations = error40(1:161,3) ./ error41(1:161,3);
T10.Error_Of_160_Grid_Nodes_Over_Error_Of_320_Grid_Nodes = error40(1:161,3) ./ error42(1:2:321,3);
writetable(T10, 'Grid Point Error Analysis.xlsx','Sheet',6,'Range','A2');