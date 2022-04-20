clc; clear;
 
healthy = imread('healthy.jpg');
bw_healthy = rgb2gray(healthy);

epileptic = imread();
bw_epileptic = rgb2gray(epileptic)

[row col color] = size(bw_healthy);
x = col/2;
y = row/2;
imshow(bw_healthy);
centx = x / 2;
centy = y / 2; %moves the circle around
r = 60;
hold on;
theta = 0 : (2 * pi / 10000) : (2 * pi); %change variable names
pline_x = r * cos(theta) + centx;
pline_y = r * sin(theta) + centy; %same here
plot(pline_x, pline_y, 'r-', 'LineWidth', 3);
hold off;

%%adjust where circle goes

subplot(1,2,1)
imshow(bw_healthy)
title('Healthy Brain')

subplot(1,2,2)
imshow(bw_epileptic)
title('Epileptic Brain')
