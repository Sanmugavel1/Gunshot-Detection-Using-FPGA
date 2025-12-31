%% ==================== Setup ====================
fs = 16000;           % Sampling frequency
duration = 1;         % seconds
t = linspace(0, duration, fs*duration);

% Create folder to save results
outputFolder = 'Gunshot_Simulation_Results';
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

%% ==================== STEP 0: Simulated gunshot ====================
gunshot = sin(2*pi*3000*t) .* exp(-10*t);
noise = 0.05*randn(size(t));
signal_raw = gunshot + noise;

% Save raw audio
audiowrite(fullfile(outputFolder,'step0_raw_signal.wav'), signal_raw, fs);

%% ==================== STEP 1: Microphone Array ====================
mic_positions = [ 0.0, 0.05, 0.025, -0.025, -0.05, -0.025, 0.025; 
                  0.0, 0.0, 0.043, 0.043, 0.0, -0.043, -0.043 ]; % 2x7

figure; hold on; grid on; axis equal;
scatter(mic_positions(1,:), mic_positions(2,:), 'r', 'filled');
for i = 1:size(mic_positions,2)
    text(mic_positions(1,i)+0.002, mic_positions(2,i)+0.002, ['Mic', num2str(i)]);
end
title('Step 1: 6-Microphone Hexagonal Array');
xlabel('X position (m)'); ylabel('Y position (m)');
saveas(gcf, fullfile(outputFolder,'step1_microphone_array.png'));

%% ==================== STEP 2: Bandpass Filter ====================
bpFilt = designfilt('bandpassiir','FilterOrder',6, ...
         'HalfPowerFrequency1',2000,'HalfPowerFrequency2',4000, ...
         'SampleRate',fs);
filtered = filtfilt(bpFilt, signal_raw);

figure;
subplot(2,1,1); plot(t, signal_raw); title('Raw Gunshot Signal + Noise');
subplot(2,1,2); plot(t, filtered); title('Step 2: Bandpass Filtered Signal (2–4 kHz)');
xlabel('Time (s)');
saveas(gcf, fullfile(outputFolder,'step2_filtered_signal.png'));

%% ==================== STEP 3: Spectrogram + MFCC ====================
% Spectrogram
figure;
spectrogram(filtered,256,128,256,fs,'yaxis');
title('Step 3: Spectrogram');
saveas(gcf, fullfile(outputFolder,'step3_spectrogram.png'));

% MFCC (Audio Toolbox required)
coeffs = mfcc(filtered, fs, 'NumCoeffs', 13);
figure;
imagesc(coeffs'); axis xy;
xlabel('Frame'); ylabel('MFCC Coefficient');
title('Step 3: MFCC Features');
colorbar;
saveas(gcf, fullfile(outputFolder,'step3_mfcc.png'));

%% ==================== STEP 4: Classification ====================
energy = sum(filtered.^2);
if energy > 5
    label = 'Gunshot';
else
    label = 'Not Gunshot';
end
disp(['Step 4: Classification Result → ', label]);

%% ==================== STEP 5: Simple DOA via Cross-Correlation ====================
% Simplified TDOA for demonstration (center mic vs others)
centerMic = filtered; % center mic
numMics = size(mic_positions,2);
angles_est = zeros(1,numMics);

for i = 1:numMics
    if i == 1
        angles_est(i) = 0;
        continue;
    end
    [xc, lags] = xcorr(centerMic, filtered, fs*0.01, 'coeff');
    [~, idx] = max(xc);
    tdoa = lags(idx)/fs;
    % Estimate angle (simplified)
    dx = mic_positions(1,i) - mic_positions(1,1);
    dy = mic_positions(2,i) - mic_positions(2,1);
    angle = atan2d(dy, dx); 
    angles_est(i) = angle;
end
estimated_DOA = mean(angles_est);
disp(['Step 5: Estimated DOA ≈ ', num2str(estimated_DOA), '°']);

% Plot DOA
figure;
polarplot(deg2rad(angles_est), ones(size(angles_est)), 'r*');
title(['Step 5: Estimated DOA ≈ ', num2str(estimated_DOA), '°']);
saveas(gcf, fullfile(outputFolder,'step5_doa.png'));

%% ==================== STEP 6: Final Dashboard ====================
figure;
subplot(2,2,1); plot(t, signal_raw); title('Raw Signal');
subplot(2,2,2); plot(t, filtered); title('Filtered Signal');
subplot(2,2,3); imagesc(coeffs'); axis xy; title('MFCCs'); colorbar;
subplot(2,2,4); polarplot(deg2rad(angles_est), ones(size(angles_est)), 'r*');
title(['DOA ≈ ', num2str(estimated_DOA), '°']);
sgtitle(['Step 6: Final Results → ', label]);
saveas(gcf, fullfile(outputFolder,'step6_dashboard.png'));

disp(['All results saved in folder: ',outputFolder]);