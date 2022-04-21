​​%Authors: Brian, Hannah, Leah, & Julia
%Date: April 20, 2022
%BME3053c
 
clc; clear;
 
healthy = imread('healthy.jpg');
bw_healthy = rgb2gray(healthy);
imshow(bw_healthy)

epileptic = imread('epileptic.png');
bw_epileptic = rgb2gray(epileptic);
%imshow(bw_epileptic)
%%NOTES
%%process for white area; needs to filter for level of brightness but also likely for size (healthy also has some smaller bright sections)

%%filter through pixels with a threshold value??

%%take coordinates of bright spot detected and input to fit circle code (find middle of white area??)

%hello, I am a bob. Ignore this line but don’t get rid of it.
bw_epileptic = im2double(bw_epileptic);

%apply noise. Preliminary
epiNew = bw_epileptic;
sigma = 0.01;
epiNew = randn(size(epiNew))*sigma + epiNew;
imshow(epiNew);

%apply noise filter
h2 = fspecial('gaussian', 8, 1);
epiNew = imfilter(epiNew, h2);
imshow(epiNew, []);

%apply threshold, values arbitrary
thresholdhigh = 0.6;
thresholdlow = 0.6;

epiNew(epiNew<thresholdlow) = 0;
epiNew(epiNew>thresholdhigh) = 255;

imshow(epiNew);

%image overlay
imshow(labeloverlay(rgb2gray(imread('epilep.jpg')), epiNew));

%need to quantify and classify the dot size. also need circle moved (?)


%%THIS IS A WORK IN PROGRESS
[row col color] = size(bw_healthy);
x = col/2;
y = row/2;
imshow(bw_healthy);
centx = x / 2;
centy = y / 2; %moves the circle around
r = 60;
hold on;
theta = 0 : (2 * pi / 10000) : (2 * pi);
pline_x = r * cos(theta) + centx;
pline_y = r * sin(theta) + centy; %same here
plot(pline_x, pline_y, 'r-', 'LineWidth', 3);
hold off;

subplot(1,2,1)
imshow(bw_healthy)
title('Healthy Brain')

subplot(1,2,2)
imshow(bw_epileptic)
title('Epileptic Brain')
