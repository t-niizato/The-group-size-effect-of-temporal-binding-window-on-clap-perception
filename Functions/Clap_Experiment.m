function Clap_Experiment(number)
% 最初の10秒で刺激の提示
% 次の10秒でEnterを1押すと刺激を記録
% スタートきっかけは被験者とする
Screen('Preference', 'SkipSyncTests', 1);
% ---------------------------------------------------------------------------%
ListenChar(2); % キー入力がmatlabをジャマしないように。
InitializePsychSound(1);
AssertOpenGL; % OpenGLが使えるかどうかのチェック。
KbName('UnifyKeyNames'); % OSで共通のキー配置にする。
% あらかじめ読み込んでおく必要がある関数たち
GetSecs;
WaitSecs(0.1);
% data set
generate_clap;
interval = [0.16, 0.14, 0.12, 0.10, 0.08, 0.06, 0.04, 0.02];
m = 20; n = size(interval, 2);
trial = Shuffle(reshape(repmat(1:n, m, 1), n*m, 1));
select_interval = interval(trial(1));
Ord = Shuffle(1:47);

% 背景色
bgColor = [0 0 0];
% ---------------------------------------------------------------------------%
Total_number = 2; % 全試行数
%----------------------------------------------------------------------------%
try
    % 全体のループ
    Data = zeros(10,70);
    sample_number = 0;
    screenNumber = max(Screen('Screens'));
   [windowPtr, windowRect] = Screen('OpenWindow', screenNumber, bgColor);

     % ESCキー以外を押すと、押されたキーの情報をコマンドウィンドウに表示します。
    escapeKey = KbName('ESCAPE');
    while KbCheck; end % いずれのキーも押されていないことをチェック。
      
      % 被験者の時間測定------------------------------------------
       
    fprintf("測定開始：Enterを押してください.\n");
          
         count = 0;
         KbWait(-1);
         [ keyIsDown, ~, keyCode ] = KbCheck;
         time = GetSecs;
      
        if keyIsDown
            sound(y,Fs);
            while KbCheck; end
            while(1)
                [ keyIsDown,  seconds, ~ ] = KbCheck;
                if keyIsDown
                    Data(count+1, sample_number+1) = seconds - time;
                    count = count + 1;
                    while KbCheck; end
                end
              
              if count == 10
                  break;
              end
            end
        end
      
      
            
      sample_number = sample_number + 1;
      
      if sample_number == Total_number
          break;
      end
        
    
    
  csvwrite('Time_Data_Experiment_1.csv',Data);
  
   %終了処理
  Screen('CloseAll'); 
  ShowCursor;
  ListenChar(0);
    
  catch % 正常に終了した場合は、catch以下は実行されません。
  Screen('CloseAll');
  ShowCursor;
  ListenChar(0);
  psychrethrow(psychlasterror);
end


end