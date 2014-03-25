function [magnet_center, well_position] = magnetic_field_configuration(magnet_diameter, mid_y,well_space ,mid_x)

%script to get magnetic field of an 4x5 magnet array
magnet_x = zeros(4,5); %open matrix for x coordinate of magents
magnet_y = zeros(4,5); %open matrix for y coordinate of magents
%define x coordinate of magnet center at starting position
magnet_x(:,1) = 2*magnet_diameter;
magnet_x(:,2) = 3*magnet_diameter;
magnet_x(:,3) = 4*magnet_diameter;
magnet_x(:,4) = 5*magnet_diameter;
magnet_x(:,5) = 6*magnet_diameter;
%define y coordinate of magnet center at starting position
magnet_y(1,:) = 2*magnet_diameter;
magnet_y(2,:) = 3*magnet_diameter;
magnet_y(3,:) = 4*magnet_diameter;
magnet_y(4,:) = 5*magnet_diameter;

% matrix of magnet starting coodination
magnet_center(:,:,1) = magnet_y;
magnet_center(:,:,2) = magnet_x;
clear magnet_y magnet_x;

%set up 24-well plate center coordinates
plate_x = zeros(4,6); %open matrix represents x coordinate of the well center
plate_y = zeros(4,6); %open matrix represents y coordinate of the well center
%define y coordinate of well center
plate_y(1,:) = mid_y + well_space + well_space/2; %(cm)
plate_y(2,:) = mid_y + well_space/2; %(cm)
plate_y(3,:) = mid_y - well_space - well_space/2; %(cm)
plate_y(4,:) = mid_y - well_space/2; %(cm)

%define x coordinate of well center
plate_x(:,6) = mid_x + 2 * well_space + well_space/2; %(cm)
plate_x(:,5) = mid_x + well_space + well_space/2; %(cm)
plate_x(:,4) = mid_x + well_space/2; %(cm)
plate_x(:,3) = mid_x - well_space/2;
plate_x(:,2) = mid_x - well_space - well_space/2;
plate_x(:,1) = mid_x - 2 * well_space - well_space/2; 

% matrix of well center coodination
well_position(:,:,1) = round(plate_y);
well_position(:,:,2) = round(plate_x);
clear plate_x plate_y well_space;