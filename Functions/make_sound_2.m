function [output] = make_sound_2(y, count)
%  能動的に拍手をさせるときの音プログラム
%  count数を拍手数として複数の分離した拍手音を生成
    peaks = zeros(1, count);
    C = cell(count, 1);
    
    % 拍手音が出現したテイルポイントを取得
    tag = 1;
    for i = 1 : count
        peaks(1, i) = find(abs(y(tag:end, 1)) > 0.1, 1);
        if i > 1
            peaks(1, i) = peaks(1, i) + tag;
        end
        tag = peaks(1, i) + 22050;
    end
    
    
    for i = 1:count
        C{i} = y((peaks(1, i)-100):(peaks(1, i) + 22050), :);
    end
    
    output = C;

end

