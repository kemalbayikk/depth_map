I1 = imread('i_left.png');
I2 = imread('i_right.png');
I1 = padarray(I1,[1 1]);
I2 = padarray(I2,[1 1]);
I1 = double(I1);
I2 = double(I2);
[x,y,z] = size(I1);
i = 2;
min = 100000;
min_z = 100000.0;
max_z = 0.0;
ssd_x = 0;
ssd_y = 0;
temp = 0;
x_subs = 0;
for i = 2:y-2
    for j = 2:x-1
        imageOne = I1(j-1:j+1,i-1:i+1,:);
        min = 100000;
            for q = 2:x-1   
                imageTwo = I2(q-1:q+1,i-1:i+1,:);
                temp = 0;
                for l = 1:3
                    for m = 1:3
                        for z = 1:3
                            ssd = (imageTwo(l,m,z)-imageOne(l,m,z)) * (imageTwo(l,m,z)-imageOne(l,m,z));
                            temp  = temp + ssd;
                        end
                    end
                 end
                if temp < min
                    min = temp;
                    ssd_first_x = j;
                    ssd_second_x = q;
                end
            end
        x_subs = ssd_first_x - ssd_second_x;
        if x_subs == 0
           x_subs = 1; 
        end
        
        Z = (5*3) / (abs(x_subs));
        if Z < min_z
            min_z = Z;
        end
        if Z > max_z
            max_z = Z;
        end
        Output(j,i) = Z;
    end
end
figure,imshow(Output);

