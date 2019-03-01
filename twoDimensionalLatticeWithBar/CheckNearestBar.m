function Bar = CheckNearestBar(mcnt,BarStore,max)
    n = length(BarStore);
    low = max;
    
    for loop = 1:n
        temp = abs(mcnt - BarStore(loop));
        
        if low > temp
            low = temp;
            Bar = BarStore(loop);
        end
    end
end