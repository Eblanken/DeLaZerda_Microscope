%
% File: Main_Manual.m
% -------------------
% Author: Erick Blankenberg
% Date 8/1/2018
% 
% Description:
%   This program acts as an interface for the new flouroscopy microscope.
%   This version requires the user to use the manual stage while acquiring
%   a composite image.
%

close all;
clear all;

% ---------------------------------- Settings -----------------------------



% -------------------------------- The Program ----------------------------

% -> Sets up GUI and Camera
figure(1);
hold on;
tilingButton = uicontrol('String', 'Save to Tiled Image');
saveTiledButton = uicontrol('String', 'Save Tiled Image 
saveButton = uicontrol('String', 'Save to Disk');
clearButton = uicontrol();
hold off;

% -> Streams the latest images from the camera, allows the user to take an
%    image to save, append to the current panorama, etc.
exitProgram = false;
cameraManager = Manager_Camera(0);
imageObject = imshow(zeros(cameraManager.getHeight, cameraManager.getWidth), []);
while(~exitProgram) % Main loop just shows camera footage
    figure(1);
    hold on;
    refresh(1);
    set(imageObject, 'CData', cameraManager.acquireImage(1));
    drawnow;
    hold off;
end

% --------------------------------- Functions -----------------------------
