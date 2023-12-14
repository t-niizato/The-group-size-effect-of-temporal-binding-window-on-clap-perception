function ovalkey
ListenChar(2); % �L�[���͂�matlab���W���}���Ȃ��悤�ɁB
InitializePsychSound(1);
AssertOpenGL; % OpenGL���g���邩�ǂ����̃`�F�b�N�B
KbName('UnifyKeyNames'); % OS�ŋ��ʂ̃L�[�z�u�ɂ���B
% �v���O�����������Ȃ��ꍇ��myKeyCheck���g���Ă݂Ă��������B
%myKeyCheck;
% ���炩���ߓǂݍ���ł����K�v������֐�����
GetSecs;
WaitSecs(0.1);
rand('state', sum(100*clock));
% �w�i�F
bgColor = [128 128 128];
% �~�̐F
ovalColor = [255 0 0];
% �~�̔��a
radius = 20;

 [y,Fs] = audioread('bell.mp3');
try
  % �K�v�ɉ����ăJ�[�\���������Ă�������
  %HideCursor;
  
  screenNumber = max(Screen('Screens'));
  % �E�B���h�E�ł̒掦�i�f�o�b�O�p�j
  %Screen('Preference', 'SkipSyncTests', 1);
  %[windowPtr, windowRect] = Screen('OpenWindow', screenNumber, bgColor, [100, 200, 700, 600]);
  % �t���X�N���[���ł̒掦
  [windowPtr, windowRect] = Screen('OpenWindow', screenNumber, bgColor);
    
  % ��ʂ̒����̍��W
  [centerX centerY] = RectCenter(windowRect);
     
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % �~�̕`��
  Screen('FillOval', windowPtr, ovalColor, [centerX - radius, centerY - radius, centerX + radius, centerY + radius]);
  Screen('Flip', windowPtr); % ��ʂɒ掦
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % ESC�L�[�������܂ł͉~��掦�����܂�
  % ESC�L�[�ȊO�������ƁA�����ꂽ�L�[�̏����R�}���h�E�B���h�E�ɕ\�����܂��B
  escapeKey = KbName('ESCAPE');
  while KbCheck; end % ������̃L�[��������Ă��Ȃ����Ƃ��`�F�b�N�B
  
  while 1
      [ keyIsDown, ~, keyCode ] = KbCheck;
      
       if keyCode(escapeKey)
          break; % while ���𔲂��܂��B
       end;
      
      if keyIsDown
            sound(y,Fs);
          % �L�[���̓R�}���h�E�B���h�E�ɕ\������܂��B
          while KbCheck; end;
          fprintf('�L�[���F %i %s \n', find(keyCode), KbName(keyCode));
            


  
          % ������̃L�[��������Ă��Ȃ����Ƃ��`�F�b�N�B
          
          
      end;
  
  end
  
  %�I������
  Screen('CloseAll');
  ShowCursor;
  ListenChar(0);
  
catch % ����ɏI�������ꍇ�́Acatch�ȉ��͎��s����܂���B
  Screen('CloseAll');
  ShowCursor;
  ListenChar(0);
  psychrethrow(psychlasterror);
end