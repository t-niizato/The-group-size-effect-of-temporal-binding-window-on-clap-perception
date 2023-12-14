function ovalkey
ListenChar(2); % キー入力がmatlabをジャマしないように。
InitializePsychSound(1);
AssertOpenGL; % OpenGLが使えるかどうかのチェック。
KbName('UnifyKeyNames'); % OSで共通のキー配置にする。
% プログラムが動かない場合はmyKeyCheckを使ってみてください。
%myKeyCheck;
% あらかじめ読み込んでおく必要がある関数たち
GetSecs;
WaitSecs(0.1);
rand('state', sum(100*clock));
% 背景色
bgColor = [128 128 128];
% 円の色
ovalColor = [255 0 0];
% 円の半径
radius = 20;

 [y,Fs] = audioread('bell.mp3');
try
  % 必要に応じてカーソルを消してください
  %HideCursor;
  
  screenNumber = max(Screen('Screens'));
  % ウィンドウでの呈示（デバッグ用）
  %Screen('Preference', 'SkipSyncTests', 1);
  %[windowPtr, windowRect] = Screen('OpenWindow', screenNumber, bgColor, [100, 200, 700, 600]);
  % フルスクリーンでの呈示
  [windowPtr, windowRect] = Screen('OpenWindow', screenNumber, bgColor);
    
  % 画面の中央の座標
  [centerX centerY] = RectCenter(windowRect);
     
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % 円の描画
  Screen('FillOval', windowPtr, ovalColor, [centerX - radius, centerY - radius, centerX + radius, centerY + radius]);
  Screen('Flip', windowPtr); % 画面に呈示
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % ESCキーを押すまでは円を呈示したまま
  % ESCキー以外を押すと、押されたキーの情報をコマンドウィンドウに表示します。
  escapeKey = KbName('ESCAPE');
  while KbCheck; end % いずれのキーも押されていないことをチェック。
  
  while 1
      [ keyIsDown, ~, keyCode ] = KbCheck;
      
       if keyCode(escapeKey)
          break; % while 文を抜けます。
       end;
      
      if keyIsDown
            sound(y,Fs);
          % キー情報はコマンドウィンドウに表示されます。
          while KbCheck; end;
          fprintf('キー情報： %i %s \n', find(keyCode), KbName(keyCode));
            


  
          % いずれのキーも押されていないことをチェック。
          
          
      end;
  
  end
  
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