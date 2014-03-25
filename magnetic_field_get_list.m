function [force_well average_force wells] = magnetic_field_get_list(well_position, well_radius, B_field_stack,permeability,density,susceptibility,bead_diameter,water_susceptibility,bead_number,res)


[x_dim y_dim z_dim] = size(B_field_stack);
B_field_well = zeros(x_dim ,y_dim, z_dim);
force_well = zeros(x_dim ,y_dim, z_dim);
wells = ones(x_dim ,y_dim);
x_list=[];
y_list=[];
xlist = cell(24,1);
ylist = cell(24,1);
average_force = cell(24,1);
bead_vol = (bead_diameter /2)^3 * pi * 4/3; %surface area (m^2)

% get points coordinates in the wells
count = 1;
for i = 1:4,
    for j = 1:6,
        well_center_x = well_position(i,j,2);
        well_center_y = well_position(i,j,1);
        for y = 1:140*res,
            for x = 1:160*res,
                if (x - well_center_x)^2 + (y - well_center_y)^2 < well_radius^2,
                    x_list(end+1) = x;
                    y_list(end+1) = y;
                    xlist{count}(end+1) = x;
                    ylist{count}(end+1) = y;
                    wells(y,x) = 0;
                end
            end
        end
        count = count + 1;
	end
end

%get force at eeach points varying with time
for z = 2:z_dim,
    for list_len = 1:length(x_list),
        x = x_list(list_len);
        y = y_list(list_len);
        force_well(y,x,z) = bead_number * bead_vol * (susceptibility - water_susceptibility) / (2*permeability) * (B_field_stack(y,x,z) - B_field_stack(y,x,z-1))^2;
    end
end

%average force in a well
for well_number = 1:count-1,
    for z = 2:z_dim,
        force_point =[];
        for point_number = 1:length(xlist{well_number}),
            x = xlist{well_number}(point_number);
            y = ylist{well_number}(point_number);
            force_point(end+1) = bead_number * bead_vol * (susceptibility - water_susceptibility) / (2*permeability) * (B_field_stack(y,x,z) - B_field_stack(y,x,z-1))^2; % Shevkoplyas et al 
        end
        average_force{well_number}(end+1) = mean(force_point); 
    end
end
        
