clearvars;
% data set
generate_clap_2;

% 初期設定
interval = [0.16, 0.14, 0.12, 0.10, 0.08, 0.06, 0.04, 0.02];
m = 20; n = size(interval, 2);
A = reshape(repmat(1:n, m, 1), n*m, 1);
trial = A(randperm(size(A, 1)));
% 練習用初期設定
m = 3; n = size(interval, 2);
A = reshape(repmat(1:n, m, 1), n*m, 1);
trial_practice= A(randperm(size(A, 1)));

% 記録用
record = zeros(8, 1);

numbers = [2, 3, 4, 5, 7, 10, 20];
count = 3;

% check sound
[Sy,SFs] = audioread("sound_check.mp3");
[Sy2,SFs2] = audioread("abort.mp3");

%% 実験設定を入力
number = 5;
% 音の生成
clap_sound_patters;
pattern_numbers = ones(1, length(interval));
%%
KbName('UnifyKeyNames'); % OSで共通のキー配置にする。
ListenChar(2); % キー入力がmatlabをジャマしないように。

escapeKey = KbName('ESCAPE');
while KbCheck; end % いずれのキーも押されていないことをチェック。


for time = 1:20
    si = trial_practice(time);
    sound(Sy, SFs)    
    
    active_clap;
    
    pattern_numbers(si) = pattern_numbers(si) + 1;
    fprintf('拍手の音は揃ってた(right_shift) 揃ってなかった(left_shift?) \n')

     while 1
         [ keyIsDown, seconds, keyCode ] = KbCheck;
         if keyIsDown
             if keyCode(escapeKey)
                 break; % while 文を抜けます。
             end
             
             if find(keyCode) == 229
                 break; 
             elseif find(keyCode) == 225
                 break; 
             end

             % いずれのキーも押されていないことをチェック。
             while KbCheck; end
             
         end
     end
    pause(0.4)
end
ListenChar(0); % キー操作制限解除


%% 本番開始
KbName('UnifyKeyNames'); % OSで共通のキー配置にする。
ListenChar(2); % キー入力がmatlabをジャマしないように。

escapeKey = KbName('ESCAPE');
while KbCheck; end % いずれのキーも押さ　れていないことをチェック。

for time = 1:160

    si = trial(time);
    sound(Sy, SFs)
    active_clap;
    
    pattern_numbers(si) = pattern_numbers(si) + 1;
    fprintf('拍手の音は揃ってた(right_shift) 揃ってなかった(left_shift?) \n')

     while 1
         [ keyIsDown, seconds, keyCode ] = KbCheck;
         if keyIsDown
             if keyCode(escapeKey)
                 break; % while 文を抜けます。
             end
             
             if find(keyCode) == 229
                 record(trial(time)) = record(trial(time)) +  1;
                 break; 
             elseif find(keyCode) == 225
                 break; 
             end

             % いずれのキーも押されていないことをチェック。
             while KbCheck; end
             
         end
     end
     pause(0.4)
end

pause(0.5)

[y,Fs] = audioread('Bell.mp3');
sound(y, Fs)

ListenChar(0); % キー操作制限解除
writematrix(record, "N=" + num2str(number) + "_active_clap_data.csv");
