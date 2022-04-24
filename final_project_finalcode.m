clc; clear;
 
healthy = imread('healthy.jpg');
bw_healthy = rgb2gray(healthy);

patient = imread('epilep1.jpg');
bw_patient = rgb2gray(patient);



%hello, I am a bob.

%change from 0-255 to 0-1 scale
bw_patient = im2double(bw_patient);

%create a copy, keep the original
epiNew = bw_patient;

%apply noise to simulate noisy image. Preliminary
sigma = 0.01;
epiNew = randn(size(epiNew))*sigma + epiNew;
imshow(epiNew);

%apply noise filter
h2 = fspecial('gaussian', 8, 1);
epiNew = imfilter(epiNew, h2);
imshow(epiNew, []);

%dynamic thresholding depending on the set pixel number. Threshold
%continuously decreases until at least 'n' number of pixels can be seen
%through the threshold.
n = 10;
threshold = 1;
while threshold >0
    epiNew1 = epiNew;
    thresholdhigh = threshold;
    epiNew1(epiNew1<thresholdhigh) = 0;
    epiNew1(epiNew1>thresholdhigh) = 255;
    if length(epiNew1(epiNew1>threshold))>n
        break
    else
        threshold = threshold - 0.0001;
    end
end

%best determined threshold values displayed
display(threshold);

%apply threshold, values arbitrary
thresholdhigh = threshold;
thresholdlow = threshold;
epiNew(epiNew<thresholdlow) = 0;
epiNew(epiNew>thresholdhigh) = 255;

%clean up the border areas
epiNew = imclearborder(epiNew, 4);
imshow(epiNew);

%image overlay
imshow(labeloverlay(rgb2gray(patient), epiNew));
%save current figure
saveas(gcf,'epilepD.jpg');

%mean center of mass (assumed circular) is [centx,centy]
[r, c] = find(epiNew > 0.99);
rowcolCoordinates = [mean(r), mean(c)];
centx = mean(c);
centy = mean(r);

%print display statements 
if threshold>0.55
    disp('epilepsy highly probable')
elseif threshold>0.40
    disp('epilepsy probable')
else
    disp('epilepsy improbable')
end



[row col color] = size(bw_patient);
x = col/2;
y = row/2;
imshow(bw_patient);
%centx = x / 2;
%centy = y / 2; %moves the circle around
r = 20;
hold on;
theta = 0 : (2 * pi / 10000) : (2 * pi); %change variable names
pline_x = r * cos(theta) + centx;
pline_y = r * sin(theta) + centy; %same here
plot(pline_x, pline_y, 'r-', 'LineWidth', 3);
hold off;
%%adjust where circle goes

%save current figure as 'filename.jpg' to recall at subplot
saveas(gcf,'epilepC.jpg');
imshow('epilepC.jpg')



subplot(1,2,1)
imshow(bw_healthy)
title('Healthy Brain')

subplot(1,2,2)
imshow('epilepC.jpg')
title('Epileptic Brain')

