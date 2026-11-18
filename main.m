clc;
clear;
%Constant Pressure in kPa
P = 500;

%Temperature Values in C
T = [250 275 300 325];

%Enthalpy values in kj/kg
H = [2960 3015 3070 3125];

%Temperature to find by interpolation
TQuery = 285;
