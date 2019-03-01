tic

N = 100; %number of lattices
Generations = 1000; %number of generations
p = .5; %probability of movement
pd = .3; %probability of drinkers to stop drinking
pr = .3; %probability of former drinkers to drink again

pb = .8; %probabality of attraction to bar (self-implemented)

S = zeros(1,N); %Susceptible
D = zeros(1,N); %Current Drinkers
R = zeros(1,N); %Former Drinkers
B = zeros(1,N); %Placement of Bar

%Storage of variables for per generation comparison
Sgen = zeros(Generations,1);
Dgen = zeros(Generations,1);
Rgen = zeros(Generations,1);
Bgen = zeros(Generations,1);

NumberOfBars = 5;

%Mapping Variable
Datay = zeros(N,3);

%Initialization of Susceptible Drinkers
for cnt = 1:N
    S(cnt) = 1;
end

%Initialization of Current Drinker in the middle of the lattice
D(floor(N/2)) = 1;

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

for iBar=1:NumberOfBars
    rowBar = randi([1,N]);
    B(rowBar) = B(rowBar) + 1;
    fprintf('A Bar is situated in %d\n', rowBar);
end

for gencnt = 1:Generations

    
    %Movement of Persons
    for mcnt = 1:N
        %Movement of S
        Scell = S(mcnt);
        for lcnt = 1:Scell
            switch(mcnt)
                case 1 %left most site can only move right
                    if rand() > (1-p)
                        S(mcnt) = S(mcnt) - 1;
                        S(mcnt+1) = S(mcnt+1) + 1;
                    end
                case N %right most site can only move left
                    if rand() > (1-p)
                        S(mcnt) = S(mcnt) - 1;
                        S(mcnt-1) = S(mcnt-1) + 1;
                    end
                otherwise %if at any site, 50-50 chance of going left or right
                    if rand() > (1-p)
                        if rand() > .5
                            S(mcnt) = S(mcnt) - 1;
                            S(mcnt+1) = S(mcnt+1) + 1;
                        else
                            S(mcnt) = S(mcnt) - 1;
                            S(mcnt-1) = S(mcnt-1) + 1;
                        end
                    end
            end
        end
        
        %Movement of D, only current drinkers are affected by the bar
        Dcell = D(mcnt);
        for lcnt = 1:Dcell
            if gencnt < 2
                switch(mcnt)
                    case 1 %left most site can only move right
                        if rand() > (1-p)
                            D(mcnt) = D(mcnt) - 1;
                            D(mcnt+1) = D(mcnt+1) + 1;
                        end
                    case N %right most site can only move left
                        if rand() > (1-p)
                            D(mcnt) = D(mcnt) - 1;
                            D(mcnt-1) = D(mcnt-1) + 1;
                        end
                    otherwise %if at any site and not within proximity of bar, 50-50 chance of going left or right
                        if rand() > (1-p)
                            if rand() > .5
                                D(mcnt) = D(mcnt) - 1;
                                D(mcnt+1) = D(mcnt+1) + 1;
                            else
                                D(mcnt) = D(mcnt) - 1;
                                D(mcnt-1) = D(mcnt-1) + 1;
                            end
                        end
                end
            else
                    switch(mcnt)%if current drinker is within proximity of a bar, it is more likely to move closer towards the bar.
                        case 1 %left most site can only move right
                            if B(mcnt) > 0 %if drinker is at the bar, it is less likely to move
                                if rand() > pb
                                    D(mcnt) = D(mcnt) - 1;
                                    D(mcnt+1) = D(mcnt+1) + 1;
                                end
                            else
                                if rand() > (1-p) %movement based on probability if not in bar
                                    D(mcnt) = D(mcnt) - 1;
                                    D(mcnt+1) = D(mcnt+1) + 1;
                                end
                            end
                        case N %right most site can only move left
                            if B(mcnt) > 0 %if drinker is at the bar, it is less likely to move
                                if rand() > pb
                                    D(mcnt) = D(mcnt) - 1;
                                    D(mcnt-1) = D(mcnt-1) + 1;
                                end
                            else
                                if rand() > (1-p) %movement based on probability if not in bar
                                    D(mcnt) = D(mcnt) - 1;
                                    D(mcnt-1) = D(mcnt-1) + 1;
                                end
                            end
                        otherwise
                            if B(mcnt) > 0 %if drinker is at the bar, it is less likely to move
                                if rand() > pb
                                    if rand() > .5 %50-50 chance of moving left or right from the bar
                                        D(mcnt) = D(mcnt) - 1;
                                        D(mcnt+1) = D(mcnt+1) + 1;
                                    else
                                        D(mcnt) = D(mcnt) - 1;
                                        D(mcnt-1) = D(mcnt-1) + 1;
                                    end
                                end
                            else
                                if rand() > (1-p) %movement based on probability if not in bar
                                    if rand() > (1-pb) %movement towards the bar is greatly favored if within proximity of it
                                        if (mcnt-rowBar) < 0
                                            D(mcnt) = D(mcnt) - 1;
                                            D(mcnt+1) = D(mcnt+1) + 1;
                                        elseif (mcnt-rowBar) >= 0
                                            D(mcnt) = D(mcnt) - 1;
                                            D(mcnt-1) = D(mcnt-1) + 1;
                                        end
                                    else
                                        if (mcnt-rowBar) < 0
                                            D(mcnt) = D(mcnt) - 1;
                                            D(mcnt-1) = D(mcnt-1) + 1;
                                        elseif (mcnt-rowBar) >= 0
                                            D(mcnt) = D(mcnt) - 1;
                                            D(mcnt+1) = D(mcnt+1) + 1;
                                        end
                                    end
                                end
                            end
                    end
            end
        end
        
        %Movement of R
        Rcell = R(mcnt);
        for lcnt = 1:Rcell
            switch(mcnt)
                case 1 %left most site can only move right
                    if rand() > (1-p)
                        R(mcnt) = R(mcnt) - 1;
                        R(mcnt+1) = R(mcnt+1) + 1;
                    end
                case N %right most site can only move left
                    if rand() > (1-p)
                        R(mcnt) = R(mcnt) - 1;
                        R(mcnt-1) = R(mcnt-1) + 1;
                    end
                otherwise %if at any site, 50-50 chance of going left or right
                    if rand() > (1-p)
                        if rand() > .5
                            R(mcnt) = R(mcnt) - 1;
                            R(mcnt+1) = R(mcnt+1) + 1;
                        else
                            R(mcnt) = R(mcnt) - 1;
                            R(mcnt-1) = R(mcnt-1) + 1;
                        end
                    end
            end
        end
    end
    
    %Conversion of Status
    %Susceptible to Drinking
    for scnt = 1:N
        T = S(scnt) + D(scnt) + R(scnt);
        sprob = D(scnt)/T;
        if sprob > rand() && S(scnt) > 0
            S(scnt) = S(scnt) - 1;
            D(scnt) = D(scnt) + 1;
        end
    end
    
    %Drinking to Former
    for dcnt = 1:N
        T = S(dcnt) + D(dcnt) + R(dcnt);
        dprob = (R(dcnt)/T) + pd;
        if dprob > rand() && D(dcnt) > 0
            D(dcnt) = D(dcnt) - 1;
            R(dcnt) = R(dcnt) + 1;
        end
    end
    
    %Former to Drinking
    for rcnt = 1:N
        T = S(rcnt) + D(rcnt) + R(rcnt);
        rprob = (D(rcnt)/T) + pr;
        if rprob > rand() && R(rcnt) > 0
            R(rcnt) = R(rcnt) - 1;
            D(rcnt) = D(rcnt) + 1;
        end
    end
    
    %Generation Values
    T = sum(S) + sum(D) + sum(R);
    gen = 1:1:Generations;
    Sgen(gencnt) = sum(S)/T;
    Dgen(gencnt) = sum(D)/T;
    Rgen(gencnt) = sum(R)/T;
    Bgen(gencnt) = D(rowBar);
    
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
end

figure
subplot(2,1,1);
plot(gen,Sgen);
legend('Susceptible Drinkers');
xlabel('# of Iterations');
ylabel('Susceptible Drinkers');

subplot(2,1,2);
plot(gen,Dgen);
hold on
plot(gen,Rgen);
legend('Current Drinkers','Former Drinkers');
xlabel('# of Iterations');
ylabel('Drinkers');

toc