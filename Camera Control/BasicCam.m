% This is the base script for communicating with the thorcam through matlab

%% Setup
clear all;
close all;

% Add NET Assembly
NET.addAssembly('C:\Program files\Thorlabs\Scientific Imaging\DCx Camera Support\Develop\DotNet\uc480DotNet.dll');
% Creates camera handle
cam = uc480.Camera;

%% The Program

% Opens the camera
cam.Init(0); % Argument is ID of camera
cam.Display.Mode.Set(uc480.Defines.DisplayMode.DiB); % Sets display mode
cam.PixelFormat.Set(uc480.Defines.ColorMode.RGBA8Packed); % Sets color mode
cam.Trigger.Set(uc480.Defines.TriggerMode.Software); % Set trigger mode to software

% Display a photograph
% Takes a snapshot
[~, MemId] = cam.Memory.Allocate(true); % Allocates memory for image
[~, Width, Height, Bits, ~] = cam.Memory.Inquire(MemId); % Obtains image data
cam.Acquisition.Freeze(uc480.Defines.DeviceParameter.Wait); % Takes snapshot
[~, tmp] = cam.Memory.CopyToArray(MemId); % Copies to memory
% Reshapes data
Data = reshape(uint8(tmp), [Bits/8, Width, Height]);
Data = Data(1:3, 1:Width, 1:Height);
Data = permute(Data, [3, 2, 1]);
himg = imshow(Data);

% Closes the camera
cam.Exit;

%% Functions

% This function takes a single photograph assuming the camera is configured
function Data = takePhoto(ThorCam)
% Takes a snapshot
[~, MemId] = ThorCam.Memory.Allocate(true); % Allocates memory for image
[~, Width, Height, Bits, ~] = ThorCam.Memory.Inquire(MemId); % Obtains image data
ThorCam.Acquisition.Freeze(uc480.Defines.DeviceParameter.Wait); % Takes snapshot
[~, tmp] = ThorCam.Memory.CopyToArray(MemId); % Copies to memory
% Reshapes data
Data = eshape(uint8(tmp), [Bits/8, Width, Height]);
Data = Data(1:3, 1:Width, 1:Height);
Data = permute(Data, [3, 2, 1]);
end