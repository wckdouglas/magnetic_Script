function [B_field] = magnetic_field_get_point(magnet_center,magnet_radius,B_0,res)


x_center = magnet_center(:,:,2);
y_center = magnet_center(:,:,1);

B_field = zeros(140*res,160*res);
[y_dim x_dim] = size(B_field);

for y = 1:y_dim,
	for x = 1:x_dim,
        for i = 1:4,
            for j = 1:5,
                center_x = x_center(i,j);
                center_y = y_center(i,j);
                if (x - center_x)^2 + (y - center_y)^2 <= magnet_radius^2,
                    B_field(y,x) = B_0(i,j);
%                    B_field(y,x)=B_0;
                end
            end
        end
    end
end

%non magnet surface
count=0;
for dist = 1:(8*res),        
    for y = ((8*res)+1):(y_dim-(8*res)-1),
        for x = ((8*res)+1):(x_dim-(8*res)-1),
            if B_field(y,x) == 0,
            %if ismember(B_field(y,x),B_0)==0,
                for i = x-dist:x+dist,
                    for j = y-dist:y+dist,
                        if find(B_0==B_field(j,i)),
                            B = B_field(j,i);
                            B_field(y,x) = (B_field(y,x) + B/(1+dist/10/res)^2)/2;
                            count = count + 1;
                            if rem(count,10000) ==0, 
                                text = ['analyzed ',int2str(count),' points'];
                                disp(text)
                            end
                        end
                    end               
                end
            end
        end
    end
end
