%Lattice Mapping 1
    for mcnt = 1:N
        Datay(mcnt,1) = S(mcnt);
        Datay(mcnt,2) = D(mcnt);
        Datay(mcnt,3) = R(mcnt);
    end
    Datax = 1:1:100;
    bar(Datax,Datay);
    legend('Susceptible Drinkers', 'Current Drinkers', 'Former Drinkers');
    xlabel('Lattice Sites');
    ylabel('# of Drinkers');
   
    pause
%End of Lattice Mapping

%Lattice Mapping 2
    if mod(gencnt,10) == 0 
        for mcnt = 1:N
            Datay(mcnt,1) = S(mcnt);
            Datay(mcnt,2) = D(mcnt);
            Datay(mcnt,3) = R(mcnt);
        end
        Datax = 1:1:100;
        bar(Datax,Datay);
        legend('Susceptible Drinkers', 'Current Drinkers', 'Former Drinkers');
        xlabel('Lattice Sites');
        ylabel('# of Drinkers');
        
        gencnt
        
        pause
    end
%End of Lattice Mapping