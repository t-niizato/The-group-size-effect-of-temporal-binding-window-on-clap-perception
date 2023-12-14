for i= 1:count
while 1
    [ keyIsDown, seconds, keyCode ] = KbCheck;
    if keyIsDown
        if find(keyCode) == 40
            sound(C_mix{si, pattern_numbers(si), i}./max(C_mix{si, pattern_numbers(si), i}), Fs);
            %play(player(i))
            break;                      
        end
        
        if keyCode(escapeKey)
            break; % while 文を抜けます。
        end
        
        % いずれのキーも押されていないことをチェック。
        while KbCheck; end
    end
end

while KbCheck; end % いずれのキーも押されていないことをチェック。
end