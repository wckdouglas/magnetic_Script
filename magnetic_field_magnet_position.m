function [B_field_stack]= magnetic_field_magnet_position(cycle,B_field,radius)

[y_dim x_dim] = size(B_field);
B_field_stack = zeros(y_dim,x_dim,length(cycle));
count = 1;

for degree = cycle,
    delta_y = round(radius * sin(degree));
    delta_x = round(radius * cos(degree));
    for i = 1:x_dim,
        for j = 1: y_dim,
            if B_field(j,i) ~= 0,
                %text = [num2str(j), ' ', num2str(i)];
                %disp(text)
                B_field_stack(j+delta_y,i+delta_x,count) = B_field(j,i);
            end
        end
    end
    text = ['Done analyzing frame = ',num2str(count)];
    disp(text)
    count = count+1;
end
                
    