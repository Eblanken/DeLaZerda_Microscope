% Erick Blankenberg
% DeLaZarda Research
% 5/2/2018

clear all;
close all;

%% Settings

% Graphmode is supported on 1, 3, 6, 7, 8
% 1). Plots all stages
% 2). Plots source->backscatter survival, source->illumination survival, emission->emission survival
% 3). Plots properties of mirror
% 4). Plots properties of dye % TODO
% 5). Plots light source passing through all optical elements % TODO

graphMode = 5;

% Source
% 1). Broadband (Thorlabs MBB1L3)
% 2). Red (Thorlabs M625L3)
% 3). Orange (Thorlabs M617L3)
% 4). Red Laser (Wasatch Source)

sourceSetting = 4;

% Excitation Filter
% 1). Thorlabs 650 Short (Thorlabs FES0650)
% 2). Thorlabs 600 Short (Thorlabs FES0600)
% 3). Edmund 625 Short (Edmund 64-604)
% 4). Edmund 650 Short (Edmund 47-290)

excitationSetting = 1;

% Mirror
% 1). Thorlabs 650 Dichroic (Thorlabs DMLP650)
% 2). Thorlabs 50/50 (Thorlabs BSW29R)

mirrorSetting = 1;

% Target Dye
% 1). Alexa680

dyeSetting = 1;

% Emission Filter
% 1). Thorlabs Premium 650 Longpass (Thorlabs FELH0650)
% 2). Thorlabs Premium 700 Longpass (Thorlabs FELH0700)
% 3). Thorlabs Premium 800 Longpass (Thorlabs FELH0800)
% 4). Edmund Longpass 675 (Edmund ED64629)

emissionSetting = 2;

%% Product Data

% TODO WFA2001, Camera sensitivity, Objective, new Filters, strange NAN at
% beginning of source data

% Testing values
range = 400:1:970;

% Alexa 680 (Dye)
Alexa680_File = csvread('Alexa Fluor 680.csv', 1, 0);
Alexa680_Title = 'Alexa680';
% Normalized excitation response 
Alexa680_NExcitation = interp1(Alexa680_File(:,1), Alexa680_File(:,2), range)./100;
Alexa680_NEmission = interp1(Alexa680_File(:,1), Alexa680_File(:,3), range)./100;

% FELH0650 (Premium Longpass 650nm) (2600nm-200nm, increments of 1 nm)
FELH0650_File = 'FELH0650_Transmission.xlsx';
FELH0650_Title = 'Thorlabs FELH0650 P. Long Pass (650nm)';
% Percentage passed
FELH0650_Percentage = interp1(xlsread(FELH0650_File,'C2:C2402'), xlsread(FELH0650_File,'D2:D2402'), range)./100;

% FELH0800 (Premium Longpass 800nm) (2600nm-200nm, increments of 1 nm)
FELH0700_File = 'FELH0700_Transmission.xlsx';
FELH0700_Title = 'Thorlabs FELH0700 P. Long Pass (700nm)';
% Percentage passed
FELH0700_Percentage = interp1(xlsread(FELH0700_File,'C2:C2402'), xlsread(FELH0700_File,'D2:D2402'), range)./100;


% FELH0700 (Premium Longpass 700nm) (2600nm-200nm, increments of 1 nm)
FELH0800_File = 'FELH0800_Transmission.xlsx';
FELH0800_Title = 'Thorlabs FELH0800 P. Long Pass (800nm)';
% Percentage passed
FELH0800_Percentage = interp1(xlsread(FELH0800_File,'C2:C2402'), xlsread(FELH0800_File,'D2:D2402'), range)./100;

% Edmund 64-629 (Longpass 700) (200-2000nm, increments of 1 nm)
ED64629_File = 'curv_47620.xlsx';
ED64629_Title = 'Edmund 64-629 Long Pass (700nm)';
% Percentage passed
ED64629_Percentage = interp1(xlsread(ED64629_File,'A2:A1802'), xlsread(ED64629_File,'B2:B1802'), range)./100;

% Edmund 64-621 (Longpass 675) (200-2000nm, increments of 1 nm)
ED64621_File = 'curv_64629.xlsx';
ED64621_Title = 'Edmund 64-621 Long Pass (675nm)';
% Percentage passed
ED64621_Percentage = interp1(xlsread(ED64621_File,'A2:A1802'), xlsread(ED64621_File,'B2:B1802'), range)./100;

% FES0650 (Shortpass 650nm) (2600nm-200nm increments of 1 nm)
FES0650_File = 'FES0650.xlsx';
FES0650_Title = 'Thorlabs FES0650 Short Pass (650 nm)';
% Percentage passed
FES0650_Percentage = interp1(xlsread(FES0650_File,'C2:C2402'), xlsread(FES0650_File,'D2:D2402'), range)./100;

% FES0600 (Shortpass 600nm) (2600nm-200nm increments of 1 nm)
FES0600_File = 'FES0600.xlsx';
FES0600_Title = 'Thorlabs FES0600 Short Pass (600 nm)';
% Percentage passed
FES0600_Percentage = interp1(xlsread(FES0600_File,'C2:C2402'), xlsread(FES0600_File,'D2:D2402'), range)./100;

% Edmund 64-604 (Shortpass 625nm)
ED64604_File = 'curv_64604.xlsx';
ED64604_Title = 'Edmund 64-604 Short Pass (625nm)';
% Percentage passed
ED64604_Percentage = interp1(xlsread(ED64604_File,'A2:A1802'), xlsread(ED64604_File,'B2:B1802'), range)./100;

% Edmund 47-290 (Shortpass 650nm)
ED47290_File = 'curv_47815.xlsx';
ED47290_Title = 'Edmund 47-290 Short Pass (650nm)';
% Percentage passed
ED47290_Percentage = interp1(xlsread(ED47290_File,'A2:A1802'), xlsread(ED47290_File,'B2:B1802'), range)./100;

% DMLP650 (Dichoic Mirror) (2500-250nm increments of 1 nm)
DMLP650_File = 'DMLP650.xlsx';
DMLP650_Title = 'Thorlabs DMLP650 Dichroic Mirror (650 nm)';
% Transmission percentage unpolarized
DMLP650_TPercentage = interp1(xlsread(DMLP650_File,'C3:C2253'), xlsread(DMLP650_File,'D3:D2253'), range)./100;
% Reflectance percentage unpolarized
DMLP650_RPercentage = interp1(xlsread(DMLP650_File,'C3:C2253'), xlsread(DMLP650_File,'E3:E2253'), range)./100;
% Transmission percentage polarized P
DMLP650_TPercentageP = interp1(xlsread(DMLP650_File,'C3:C2253'), xlsread(DMLP650_File,'F3:F2253'), range)./100;
% Reflectance percentage polarized P
DMLP650_RPercentageP = interp1(xlsread(DMLP650_File,'C3:C2253'), xlsread(DMLP650_File,'G3:G2253'), range)./100;
% Transmission percentage polarized S
DMLP650_TPercentageS = interp1(xlsread(DMLP650_File,'C3:C2253'), xlsread(DMLP650_File,'H3:H2253'), range)./100;
% Reflectance percentage polarized S
DMLP650_RPercentageS = interp1(xlsread(DMLP650_File,'C3:C2253'), xlsread(DMLP650_File,'I3:I2253'), range)./100;


% BSW29R (50/50 Mirror)
BSW29R_File = 'BSWxx_Data.xlsx';
BSW29R_Title = 'Thorlabs BSW29R 50/50 Mirror';
% Transmission percentage unpolarized
BSW29R_TPercentage = interp1(xlsread(BSW29R_File,'Transmission', 'C3:C2203'), xlsread(BSW29R_File, 'Transmission', 'F3:F2203'), range)./100;
% Reflectance percentage unpolarized
BSW29R_RPercentage = interp1(xlsread(BSW29R_File,'Reflectance', 'C3:C2203'), xlsread(BSW29R_File, 'Reflectance', 'F3:F2203'), range)./100;
% Transmission percentage polarized-P
BSW29R_TPercentageP = interp1(xlsread(BSW29R_File,'Transmission', 'C3:C2203'), xlsread(BSW29R_File, 'Transmission', 'D3:D2203'), range)./100;
% Reflectance percentage polarized-P
BSW29R_RPercentageP = interp1(xlsread(BSW29R_File,'Reflectance', 'C3:C2203'), xlsread(BSW29R_File, 'Reflectance', 'D3:D2203'), range)./100;
% Transmission percentage polarized-S
BSW29R_TPercentageS = interp1(xlsread(BSW29R_File,'Transmission', 'C3:C2203'), xlsread(BSW29R_File, 'Transmission', 'E3:E2203'), range)./100;
% Reflectance percentage polarized-S
BSW29R_RPercentageS = interp1(xlsread(BSW29R_File,'Reflectance', 'C3:C2203'), xlsread(BSW29R_File, 'Reflectance', 'E3:E2203'), range)./100;

% M625L3 (Red LED 625 nm nom.) (320 - 745.5496 incr. 0.1212)
M625L3_File = 'M625L3_data.xlsx';
M625L3_Title = 'Thorlabs M625L3 Red Source (625 nm)';
% Normalized intensity
M625L3_NIntensity = interp1(xlsread(M625L3_File,'C3:C3649'), xlsread(M625L3_File,'D3:D3649'), range);

% M617L3 (Orange LED 617 nm nom.) (320 - 745.5496 incr. 0.1212)
M617L3_File = 'M617L3_data.xlsx';
M617L3_Title = 'Thorlabs M617L3 Orange Source (617 nm)';
% Normalized intensity
M617L3_NIntensity = interp1(xlsread(M617L3_File,'C3:C3649'), xlsread(M617L3_File,'D3:D3649'), range);

% MBB1L3 (Broadband LED) (197.196 - 1022.814 incr. 0.2432)
MBB1L3_File = 'MBB1L3_data.xlsx';
MBB1L3_Title = 'Thorlabs MBB1L3 Broadband Source';
% Normalized intensity
MBB1L3_NIntensity = interp1(xlsread(MBB1L3_File,'C3:C3649'), xlsread(MBB1L3_File,'D3:D3649'), range);

% Wasatch Laser Source
WasatchSource_File = 'WasatchProfile.mat';
WasatchSource_Title = 'Wasatch Laser Source';
WasatchSource_Workspace = load('WasatchProfile');
% NormalizedIntensity
WasatchSource_NIntensity = interp1(WasatchSource_Workspace.lambda.values, WasatchSource_Workspace.apod', range)./max(WasatchSource_Workspace.apod);


%% Loads data

% Source Data
sourceTitle = '';
sourceProfile = [];
switch sourceSetting
    case 1
        sourceProfile = MBB1L3_NIntensity;
        sourceTitle = MBB1L3_Title;
    case 2
        sourceProfile = M625L3_NIntensity;
        sourceTitle = M625L3_Title;
    case 3
        sourceProfile = M617L3_NIntensity;
        sourceTitle = M617L3_Title;
    case 4
        sourceProfile = WasatchSource_NIntensity;
        sourceTitle = WasatchSource_Title;
    otherwise
    error('Invalid source selected');
end
sourceProfile = fillmissing(sourceProfile,'constant',0);

% Excitation Data
excitationTitle = '';
excitationProfile = [];
switch excitationSetting
    case 1
        excitationTitle = FES0650_Title;
        excitationProfile = FES0650_Percentage;
    case 2
        excitationTitle = FES0600_Title;
        excitationProfile = FES0600_Percentage;
    case 3
        excitationTitle = ED64604_Title;
        excitationProfile = ED64604_Percentage;
    case 4
        excitationTitle = ED47290_Title;
        excitationProfile = ED47290_Percentage;
    otherwise
    error('Invalid excitation filter selected');
end
excitationProfile = fillmissing(excitationProfile,'constant',0);

% Mirror Data
mirrorTitle = [];
mirrorTProfile = [];
mirrorRProfile = [];
mirrorTProfileP = [];
mirrorRProfileP = [];
mirrorTProfileS = [];
mirrorRProfileS = [];
switch mirrorSetting
    case 1
        mirrorTitle = DMLP650_Title;
        mirrorTProfile = DMLP650_TPercentage;
        mirrorRProfile = DMLP650_RPercentage;
        mirrorTProfileP = DMLP650_TPercentageP;
        mirrorRProfileP = DMLP650_RPercentageP;
        mirrorTProfileS = DMLP650_TPercentageS;
        mirrorRProfileS = DMLP650_RPercentageS;
    case 2
        mirrorTitle = BSW29R_Title;
        mirrorTProfile = BSW29R_TPercentage;
        mirrorRProfile = BSW29R_RPercentage;
        mirrorTProfileP = BSW29R_TPercentageP;
        mirrorRProfileP = BSW29R_RPercentageP;
        mirrorTProfileS = BSW29R_TPercentageS;
        mirrorRProfileS = BSW29R_RPercentageS;
    otherwise
    error('Invalid mirror selected');
end
mirrorTProfile = fillmissing(mirrorTProfile,'constant',0);
mirrorRProfile = fillmissing(mirrorRProfile,'constant',0);
mirrorTProfileP = fillmissing(mirrorTProfileP,'constant',0);
mirrorRProfileP = fillmissing(mirrorRProfileP,'constant',0);
mirrorTProfileS = fillmissing(mirrorTProfileS,'constant',0);
mirrorRProfileS = fillmissing(mirrorRProfileS,'constant',0);

% Dye Data
dyeTitle = [];
dyeExcitationProfile = [];
dyeEmissionProfile = [];
switch dyeSetting
    case 1
        dyeTitle = Alexa680_Title;
        dyeExcitationProfile = Alexa680_NExcitation;
        dyeEmissionProfile = Alexa680_NEmission;
    otherwise
    error('Invalid dye selected');
end
dyeExcitationProfile = fillmissing(dyeExcitationProfile,'constant',0);
dyeEmissionProfile = fillmissing(dyeEmissionProfile,'constant',0);

% Emission Data
emissionTitle = ''; 
emissionProfile = 0;
switch emissionSetting
    case 1
        emissionTitle = FELH0650_Title; 
        emissionProfile = FELH0650_Percentage;
    case 2
        emissionTitle = FELH0700_Title; 
        emissionProfile = FELH0700_Percentage;
    case 3
        emissionTitle = FELH0800_Title;
        emissionProfile = FELH0800_Percentage;
    case 4
        emissionTitle = ED64629_Title; 
        emissionProfile = ED64629_Percentage;
    otherwise
    error('Invalid emission filter selected');
end
emissionProfile = fillmissing(emissionProfile,'constant',0);


%% Broadband Transmission with Dichoric
data = sourceProfile; % Starts with source
switch graphMode
    case 1
        % -> Originates from the source
        figure;
        hold on;
        plot(range, sourceProfile, 'DisplayName', sourceTitle, 'color', 'black');
        title('Original Source Intensity');
        xlabel('Wavelength (nm)');
        ylabel('Intensity (norm orig.)');
        legend('show', 'location', 'northwest');
        grid on;
        hold off;
        % -> Passes through excitation filter
        figure;
        hold on;
        plot(range, excitationProfile, 'DisplayName', excitationTitle, 'color', 'black');
        plot(range, data,'DisplayName','Inbound Profile', 'color', [0.9290, 0.6940, 0.1250]);
        data = data.*excitationProfile;
        plot(range, data, 'DisplayName', 'Outbound Profile', 'color', [0.8500, 0.3250, 0.0980]);
        title('Intensity after Shortpass');
        xlabel('Wavelength (nm)');
        ylabel('Intensity (norm orig.)');
        legend('show', 'location', 'northwest');
        grid on;
        hold off;
        % -> Reflects from mirror towards sample
        figure;
        hold on;
        plot(range, mirrorRProfile, 'DisplayName', sprintf('Reflection Profile for %s', mirrorTitle), 'color', 'black');
        plot(range, data,'DisplayName','Inbound Profile', 'color', [0.9290, 0.6940, 0.1250]);
        IProfile = data.*mirrorRProfile;
        plot(range, data, 'DisplayName', 'Outbound Profile', 'color', [0.8500, 0.3250, 0.0980]);
        title('Intensity after Initial Reflection');
        xlabel('Wavelength (nm)');
        ylabel('Intensity (norm orig.)');
        legend('show', 'location', 'northwest');
        grid on;
        hold off;
        % -> Hits Dye
        figure;
        hold on;
        plot(range, dyeExcitationProfile, 'DisplayName', sprintf('Excitation profile for %s', dyeTitle), 'color', 'black');
        plot(range, dyeEmissionProfile, 'DisplayName', sprintf('Emission profile for %s', dyeTitle), 'color', [0.4940, 0.1840, 0.5560]);
        plot(range, data, 'DisplayName', 'Inbound Profile', 'color', [0.9290, 0.6940, 0.1250]);
        % (Note: I modelled as just normalized response along whole wavelength)
        dataBackscatter = data; % Backscatter is unaffected
        data = data.*dyeExcitationProfile; % Response to excitation
        data = (sum(data)./ sum(dyeExcitationProfile)).*dyeEmissionProfile; % Normalized emission profile
        plot(range, data, 'DisplayName', 'Emission from Dye', 'color', [0.8500, 0.3250, 0.0980]);
        title('Response from Dye and Backscatter');
        xlabel('Wavelength (nm)');
        ylabel('Intensity (norm orig.)');
        legend('show', 'location', 'northwest');
        grid on;
        hold off;
        % -> Passes back through the Dichoric
        dataInboundSum = sum(data); % Used for looking at loss
        dataBackscatterInboundSum = sum(dataBackscatter);
        figure;
        hold on;
        plot(range, mirrorTProfile, 'DisplayName', sprintf('Transmission Profile for %s', mirrorTitle), 'color', 'black');
        plot(range, data, 'DisplayName', 'Inbound Fluorescant Profile', 'color', [0.9290, 0.6940, 0.1250]);
        plot(range, dataBackscatter, 'DisplayName', 'Inbound Backscatter Profile', 'color', [0.4660, 0.6740, 0.1880]);
        data = data.*emissionProfile;
        dataBackscatter = dataBackscatter.*mirrorTProfile;
        plot(range, data, 'DisplayName', 'Outbound Fluorescant Profile', 'color', [0.8500, 0.3250, 0.0980]);
        plot(range, dataBackscatter, 'DisplayName', 'Outbound Backscatter Profile', 'color', [0, 0.4470, 0.7410]);
        title('Intensity after Transmitted Through Mirror');
        xlabel('Wavelength (nm)');
        ylabel('Intensity (norm orig.)');
        legend('show', 'location', 'northwest');
        grid on;
        hold off;
        % -> Passes Through Long Pass and States Percentage of Back and Fluor Int.
        figure;
        hold on;
        plot(range, emissionProfile, 'DisplayName', emissionTitle, 'color', 'black');
        plot(range, data, 'DisplayName', 'Inbound Fluorescant Profile', 'color', [0.9290, 0.6940, 0.1250]);
        plot(range, dataBackscatter, 'DisplayName', 'Inbound Backscatter Profile', 'color', [0.4660, 0.6740, 0.1880]);
        data = data.*FELH0650_Percentage;
        dataBackscatter = dataBackscatter.*FELH0650_Percentage;
        dataResultSum = sum(data);
        dataBackscatterResultSum = sum(dataBackscatter);
        plot(range, data, 'DisplayName', 'Outbound Fluorescant Profile', 'color', [0.8500, 0.3250, 0.0980]);
        plot(range, dataBackscatter, 'DisplayName', 'Outbound Backscatter Profile', 'color', [0, 0.4470, 0.7410]);
        str_fluor = sprintf('Percentage of Dye through Mirror and Long Pass: %4.2f%%', (dataResultSum / dataInboundSum) * 100);
        str_backscatter = sprintf('Percentage of Backscatter through Mirror and Long Pass: %4.2f%%', (dataBackscatterResultSum / dataBackscatterInboundSum) * 100);
        annotation('textbox',[0.15, 0.6, 0.1, 0.1], 'String',str_fluor);
        annotation('textbox',[0.15, 0.5, 0.1, 0.1], 'String',str_backscatter);
        title('Intensity after Long Pass');
        xlabel('Wavelength (nm)');
        ylabel('Intensity (norm orig.)');
        legend('show', 'location', 'northwest');
        grid on;
        hold off;
        
    case 2 % Plots light survival
        % -> Plots backscatter
        figure;
        semilogy(range, sourceProfile, 'DisplayName', sourceTitle, 'color', [0.9290, 0.6940, 0.1250]);
        hold on;
        dataBackscatter = data.*excitationProfile.*mirrorRProfile.*mirrorTProfile.*emissionProfile;
        semilogy(range, dataBackscatter, 'DisplayName', 'Backscatter Recieved at Camera', 'color', [0.4660, 0.6740, 0.1880]);
        title('Source to Backscatter for Broadband w/ Dichoric');
        [maxVal, maxIndex] = max(dataBackscatter);
        str_backscatter = sprintf('Maximum Backscatter Survival is: %4.2f%% at: %4.2f nm', maxVal * 100, range(maxIndex));
        annotation('textbox',[0.15, 0.6, 0.1, 0.1], 'String',str_backscatter);
        xlabel('Wavelength (nm)');
        ylabel('Intensity (norm orig.)');
        legend('show', 'location', 'northwest');
        grid on;
        hold off;
        % -> Plots light hitting target
        figure;
        plot(range, sourceProfile, 'DisplayName', sourceTitle, 'color', [0.9290, 0.6940, 0.1250]);
        hold on;
        dataIllumination = data.*excitationProfile.*mirrorRProfile;
        plot(range, dataIllumination, 'DisplayName', 'Illumination Recieved at Camera', 'color', [0.4660, 0.6740, 0.1880]);
        plot(range, dyeExcitationProfile, 'DisplayName', sprintf('Excitation profile for %s', dyeTitle), 'color', 'black');
        title('Source to Dye Illumination');
        [maxVal, maxIndex] = max(dataIllumination);
        str_illumination = sprintf('Maximum Ilumination Survival is: %4.2f%% at: %4.2f nm', maxVal * 100, range(maxIndex));
        annotation('textbox',[0.15, 0.6, 0.1, 0.1], 'String',str_illumination);
        str_illuminationArea = sprintf('Illumination Total is: %4.2f%%', (sum(dataIllumination) / sum(data)) * 100);
        annotation('textbox',[0.15, 0.7, 0.1, 0.1], 'String',str_illuminationArea);
        xlabel('Wavelength (nm)');
        ylabel('Intensity (norm orig.)');
        legend('show', 'location', 'northwest');
        grid on;
        hold off;
        % -> Plots ideal emission and reception
        figure
        hold on;
        plot(range, dyeEmissionProfile, 'DisplayName', sprintf('Emission profile for %s', dyeTitle), 'color', [0.4940, 0.1840, 0.5560]);
        dataPassed = dyeEmissionProfile.*mirrorTProfile.*emissionProfile;
        plot(range, dataPassed, 'DisplayName', 'Dye Emission Recieved at Camera', 'color', [0.4660, 0.6740, 0.1880]);
        title('Dye Emission and Subsequent Filtration');
        str_fluor = sprintf('Percentage of dye emission through Mirror and Long Pass: %4.2f%%', (sum(dataPassed) / sum(dyeEmissionProfile)) * 100);
        annotation('textbox',[0.15, 0.6, 0.1, 0.1], 'String',str_fluor);
        grid on;
        xlabel('Wavelength (nm)');
        ylabel('Intensity (norm orig.)');
        legend('show', 'location', 'northwest');
        hold off;
    
    case 3
        hold on;
        plot(range, mirrorRProfile, 'DisplayName', sprintf('Unpolarized Reflection Profile for %s', mirrorTitle));
        plot(range, mirrorTProfile, 'DisplayName', sprintf('Unpolarized Transmission Profile for %s', mirrorTitle));
        plot(range, mirrorRProfileP, 'DisplayName', sprintf('Polarized-P Reflection Profile for %s', mirrorTitle));
        plot(range, mirrorTProfileP, 'DisplayName', sprintf('Polarized-P Transmission Profile for %s', mirrorTitle));
        plot(range, mirrorRProfileS, 'DisplayName', sprintf('Polarized-S Reflection Profile for %s', mirrorTitle));
        plot(range, mirrorTProfileS, 'DisplayName', sprintf('Polarized-S Transmission Profile for %s', mirrorTitle));
        grid on;
        xlabel('Wavelength (nm)');
        ylabel('Percentage');
        legend('show', 'location', 'northwest');
        hold off;
    
    case 4
        hold on;
        hold off;
        
    case 5 % Plots response of each optical element between source and dye TODO
        
        % -> None
        figure;
        hold on;
        sourceAfter = sourceProfile.*dyeExcitationProfile;
        title(sprintf('Source Without Component, Percentage is %%%.2f', 100 * sum(sourceAfter) / sum(dyeExcitationProfile)));
        plot(range, sourceProfile, 'DisplayName', sprintf('Profile for Source %s', sourceTitle));
        area(range, dyeExcitationProfile, 'DisplayName', sprintf('Dye Excitation Profile'), 'FaceAlpha', 0.25, 'FaceColor', [0.4660, 0.6740, 0.1880]);
        area(range, sourceAfter, 'DisplayName', sprintf('Absorbed Source'), 'FaceAlpha', 0.25, 'FaceColor', [0.9290, 0.6940, 0.1250]);
        xlabel('Wavelength (nm)');
        ylabel('Normalized Intensity');
        legend('show');
        hold off;
        
        %{
        % -> Excitation
        figure;
        hold on;
        sourceAfter = excitationProfile.*sourceProfile;
        title(sprintf('Source Through Excitation, Percentage is %%%f', 100 * sum(sourceAfter) / sum(sourceProfile)));
        plot(range, sourceProfile, 'DisplayName', sprintf('Profile for Source %s', sourceTitle));
        plot(range, excitationProfile, 'DisplayName', sprintf('Profile for Excitation %s', excitationTitle));
        plot(range, sourceAfter, 'DisplayName', sprintf('Source After Excitation'));
        xlabel('Wavelength (nm)');
        ylabel('Normalized Intensity');
        legend('show');
        hold off;
        %}
        
        % -> Emission
        figure;
        hold on;
        sourceAfter = emissionProfile.*sourceProfile.*dyeExcitationProfile;
        title(sprintf('Source Through Emission, Percentage is %%%.2f', 100 * sum(sourceAfter) / sum(dyeExcitationProfile)));
        plot(range, sourceProfile, 'DisplayName', sprintf('Profile for Source %s', sourceTitle));
        plot(range, emissionProfile, 'DisplayName', sprintf('Profile for Emission %s', emissionTitle));
        area(range, dyeExcitationProfile, 'DisplayName', sprintf('Dye Excitation Profile'), 'FaceAlpha', 0.25, 'FaceColor', [0.4660, 0.6740, 0.1880]);
        area(range, sourceAfter, 'DisplayName', sprintf('Absorbed Source'), 'FaceAlpha', 0.25, 'FaceColor', [0.9290, 0.6940, 0.1250]);
        xlabel('Wavelength (nm)');
        ylabel('Normalized Intensity');
        legend('show');
        hold off;
        
end