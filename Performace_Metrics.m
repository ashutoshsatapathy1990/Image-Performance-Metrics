%......................................................................
%                      PERFORMANCE METICES                            |
%.....................................................................|
% ENTROPY | PEAK SIGNAL TO NOISE RATIO (PSNR) | SIGNAL TO NOISE RATIO |
% MEAN ABSOLUTE ERROR (MAE) | MEAN SQUARE ERROR (MSE)| CORRELATION    |
% ROOT MEAN SQUARE ERROR (RMSE) | STRUCTURAL SIMILARITY INDEX (SSIM)  |
%       STANDARD DEVIATION (SD) | PERCENTAGE FIT ERROR (PFE)          |
%.....................................................................|

%%%%%%%%%%%%%%%%%%% START OF THE PROGRAM %%%%%%%%%%%%%%%%%%%%%%%%%
% // Free all allocated spaces from The System Memory 
clear;
% // Read the Distorted and Enhanced Images from he Given Paths
Ori_Img = imread('input/Original.bmp');
Enc_Img = imread('input/Restored.bmp');

% // Extract [R, G, B] Channels of The Distorted & Enhanced Images
Ori_ImgR = Ori_Img(:, :, 1);
Ori_ImgG = Ori_Img(:, :, 2);
Ori_ImgB = Ori_Img(:, :, 3);
Enc_ImgR = Enc_Img(:, :, 1);
Enc_ImgG = Enc_Img(:, :, 2);
Enc_ImgB = Enc_Img(:, :, 3);

%%%%%%%%%%%%%%%%%%%%%%%%% ENTROPY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% // Compute Entropy of The Enhanced Image.
Enpy = entropy(Enc_Img);
%%%%%%%%%%%%%%%%%%%%%%%%%%%% END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%% PSNR & SNR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% // Measure PSNR & SNR of Restored Image w.r.t Original Image 
[peaksnr, snr] = psnr(Enc_Img, Ori_Img);
%%%%%%%%%%%%%%%%%%%%%%%%%%% END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%% SSIM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% // SSIM values and SSIM Maps for Restored Image w.r.t Original Image
[ssiVal, ssiMap] = ssim(Enc_Img, Ori_Img);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%% MAE, MSE & RMSE %%%%%%%%%%%%%%%%%%%%%%%
% // Size of The Input Image
N = size(Ori_Img);

% // Converts Intensity Values to Double Precision
Ori_ImgR = double(Ori_ImgR);
Ori_ImgG = double(Ori_ImgG);
Ori_ImgB = double(Ori_ImgB);
Enc_ImgR = double(Enc_ImgR);
Enc_ImgG = double(Enc_ImgG);
Enc_ImgB = double(Enc_ImgB);

% // Calculate Mean Absolute Error of Each Channel [R, G, B] 
maeR = sum(abs(Enc_ImgR(:) - Ori_ImgR(:)))/(N(1) * N(2));
maeG = sum(abs(Enc_ImgG(:) - Ori_ImgG(:)))/(N(1) * N(2));
maeB = sum(abs(Enc_ImgB(:) - Ori_ImgB(:)))/(N(1) * N(2));

% // Calculate Mean Square Error of Each Channel [R, G, B] 
mseR = sum((Enc_ImgR(:) - Ori_ImgR(:)).^2)/(N(1) * N(2));
mseG = sum((Enc_ImgG(:) - Ori_ImgG(:)).^2)/(N(1) * N(2));
mseB = sum((Enc_ImgB(:) - Ori_ImgB(:)).^2)/(N(1) * N(2));

% // Compute Final  MAE  and MSE By Taking Average of All Three.
mae = (maeR + maeG + maeB)/3;
mse = (mseR + mseG + mseB)/3 ;

% // Root Mean Squre Error by Taking Squre Root of MSE 
rmse = sqrt(mse);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%% STANDARD DEVIATION %%%%%%%%%%%%%%%%%%%%%%%
% // Evaluate Mean Values of [R, G, B] Frames for SD Computation
meanR = mean2(Enc_ImgR);
meanG = mean2(Enc_ImgG);
meanB = mean2(Enc_ImgB);

% // Calculate Variance of Each Channel [R, G, B] 
varR = sum((Enc_ImgR(:) - meanR).^2)/(N(1) * N(2));
varG = sum((Enc_ImgG(:) - meanG).^2)/(N(1) * N(2));
varB = sum((Enc_ImgB(:) - meanB).^2)/(N(1) * N(2));
 
% // Compute Standard Deviation By Taking Square Root of Variance.
sdR = sqrt(varR); 
sdG = sqrt(varG);
sdB = sqrt(varB);
sd = (sdR+sdG+sdB)/3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%% FIT ERROR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% // Calculate Individual PFE of Each Channel w.r.t. Distorted Image
pfeR = norm(Ori_ImgR - Enc_ImgR)/norm(Ori_ImgR);
pfeG = norm(Ori_ImgG - Enc_ImgG)/norm(Ori_ImgG);
pfeB = norm(Ori_ImgB - Enc_ImgB)/norm(Ori_ImgB);

% // Average PFE of Three Channels are Normalized between [0-100] 
pfe = (pfeR + pfeG +pfeB)*100/3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%% CORRELATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% // Find Correlation Betn Channels of Enhanced and Distorted Images
corR = corr2(Enc_ImgR, Ori_ImgR);
corG = corr2(Enc_ImgG, Ori_ImgG);
corB = corr2(Enc_ImgB, Ori_ImgB);

% // Correlation By Taking Avg. of Three Correlation Values
cor = (corR + corG + corB)/3;
%%%%%%%%%%%%%%%%%%%%%%%%%%% END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% END OF THE PROGRAM %%%%%%%%%%%%%%%%%%%%%%%%%%%
