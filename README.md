magnetic_Script
===============

This is the scripts I created to model the magnetic force applied to the cells for the work:

Laura R. Geuss, Douglas C. Wu, Divya Ramamoorthy, Corinne D Alford, Laura J. Suggs (2014). Effect of Magnetically Mediated Strain on Mouse Embryonic Stem Cell Differentiation into Cardiomyocytes (In preparation)

All parameters are stored in the main script: magnetic_field.m, as followed:

res = 1; %resolution of the graphs 1mm = how many points
num_cycles = input('How many cylces do you want to model?')
frame = 0.05; %different between each image by how many time (radian)
cycle = 0:frame:2*pi*num_cycles; 
well_radius = round(15*res/2); %(mm)
radius = 20*res; %mm
directory_name = ['../figure/']; %figure directory
magnet_radius = 10*res;%mm          
 %%%-------------------------------------------------------------------------------
%B_0 = [0.212 -0.206 0.22 -0.21 0.196;         %%%                 |
%          -0.202 0.212 -0.194 0.196 -0.19;    %%%                 |                    <<<<<<<<<<<--------------------------- alternate magnets
%         0.193 -0.188 0.205 -0.189 0.2;       %%%                 |
%         -0.215 0.215 -0.205 0.217 -0.207];   %%%                 |
%%%---------------------------------------------------------------------------------    

%%%-------------------------------------------------------------------------------
 B_0 = [0.212 0.206 0.22 0.21 0.196;       %%%                 |
         0.202 0.212 0.194 0.196 0.19;     %%%                 |           <<<<<<<<<<<--------------------------- sam direction magnets
         0.193 0.188 0.205 0.189 0.2;      %%%                 |
         0.215 0.215 0.205 0.217 0.207];   %%%                 |
 %%%-------------------------------------------------------------------------------
magnet_diameter = 20*res;
mid_y = 70*res;
mid_x = 80*res;
well_space = 19*res; %19.3mm
permeability = pi*4e-7; % water permeability (m kg s-2 A-2)
density = 1.05; % from manufacturer
susceptibility = 11.3;% %M = X*H manufacturer
bead_diameter = 1.2e-6; % diameter of micro bead (m)
water_susceptibility = -9.05e-6;
bead_number =  (572.0290 +  491.0976 + 496 + 502 )/4; % number of beads in EB
rotating_speed = 42; %rotational speed, (rpm)
w = rotating_speed * 2* pi /60;



