clear all;
clc;
close all;

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

%get plate configurations
[magnet_center, well_position] = magnetic_field_configuration(magnet_diameter, mid_y,well_space ,mid_x);
text=['Finished configuration of plate'];
disp(text)
%loops
[B_field] = magnetic_field_get_point(magnet_center,magnet_radius,B_0,res);
text=['Finished configuration of magnetic field array'];
imshow(B_field)
disp(text)
[B_field_stack]= magnetic_field_magnet_position(cycle,B_field,radius);
text=['created magnetic field stack '];
disp(text)
[force_well average_force wells] = magnetic_field_get_list(well_position, well_radius, B_field_stack,permeability,density,susceptibility,bead_diameter,water_susceptibility,bead_number,res);
clear bead_number water_susceptibility rotating_speed density permeability susceptibility well_space mid_y mid_x magnet_diameter magnet_radius B_0 well_radius frame res;

% 
% 
% %Plot force for each well=============================================================================
maximum = [];
minimum = [];
force_well_graph = figure('Position', [100, 100, 1244,924]);
for i = 1:length(average_force),
    maximum(end+1) = max(average_force{i});
    minimum(end+1) = min(average_force{i});
end
maximum = max(maximum);
minimum = min(minimum);
    
for i = 1:24,
    subplot(4,6,i);
    plot(cycle(2:end)/w,average_force{i}*1e12);
    ylim([minimum*1e12 maximum*1e12]);
    ylabel('Force (pN)')
    xlabel('time (sec)')
end

name = [directory_name,'force_graph'];
print(force_well_graph,name,'-dtiff','-r400');



%plot well force change===============================================================================================
minimum = min(min(min(force_well*1e12 /2)));
maximum = max(max(max(force_well*1e12 /2)));
for j = 1:length(force_well(1,1,:)),
    close all;
    video = figure('Position', [100, 100, 600,600],'visible','off');
    a = flipud(force_well(:,:,j)*1e12);
    b = wells;
    imshow(a/2 + b/2);
    colormap(jet);
    colorbar();
    caxis([minimum maximum]);
    title(['Force (pN)']);
    xlabel(['24 well plate x-dimension']);
    ylabel(['24 well plate y-dimension']);
    video_name = [directory_name,'image_force_frame_',num2str(j)];
    print(video,video_name,'-dtiff','-r150');
    text = ['Saving well image number ', num2str(j)];
    disp(text)
end



%plot magnet
%movement-=========================================================================================
minimum = min(min(min(B_field_stack)));
maximum = max(max(max(B_field_stack)));
for j = 1:length(B_field_stack(1,1,:)),
    close all;
    video = figure('Position', [100, 100, 600,600],'visible','off');
    a = (B_field_stack(:,:,j));
    mesh(a);
    zlim([0 maximum+0.5]);
    colorbar();
    caxis([minimum maximum]);
    zlabel(['Magnetic Strength (Tesla)']);
    xlabel(['24 well plate x-dimension']);
    ylabel(['24 well plate y-dimension']);
    video_name = [directory_name,'image_3D_magnet_frame_',num2str(j)];
    print(video,video_name,'-dtiff','-r100');
    text = ['Saving magnet image number ', num2str(j)];
    disp(text)
end


% %2D===================================================================
minimum = min(min(min(B_field_stack)));
maximum = max(max(max(B_field_stack)));
for j = 1:length(B_field_stack(1,1,:)),
    close all;
    video = figure('Position', [100, 100, 600,600],'visible','off');
    a = flipud(B_field_stack(:,:,j));
    imshow(a);
    colormap(jet);
    colorbar();
    caxis([minimum maximum]);
    title('Magnet movement (Tesla)');
    xlabel(['x-dimension']);
    ylabel(['y-dimension']);
    video_name = [directory_name,'image_2D_magnet_frame_',num2str(j)];
    print(video,video_name,'-dtiff','-r100');
    text = ['Saving magnet image number ', num2str(j)];
    disp(text)
end

clear all;
