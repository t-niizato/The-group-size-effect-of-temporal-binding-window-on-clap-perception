int_n = length(interval);
pattern_number = 50;

C_mix = cell(int_n, pattern_number, count);

for i = 1 : int_n
    for j = 1 : pattern_number
        select_interval = interval(i);
        shift = round(Fs * select_interval);
        shift = round(shift/(number-1)) * (1:number-1);

        Ord = randperm(47);  

        for k = 1 : count 
            C_mix{i, j, k} =  C{Ord(1), k};
            for kk = 2 : number
                C_kari = C{Ord(kk), k};
                C_mix{i, j, k} = C_mix{i, j, k} + circshift(C_kari, shift(kk-1));
            end
        end
    end
end