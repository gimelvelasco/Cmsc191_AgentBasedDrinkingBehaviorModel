for runs=1:3
tic

N = 100; %NxM number of lattice in the 2D space
M = 100;
Generations = 1000; %number of generations
p = .5; %probability of movement
pb = .8; %probabality of staying in the bar
pd = .3; %probability of drinkers to stop drinking
pr = .3; %probability of former drinkers to drink again

S = zeros(N,M); %Susceptible
D = zeros(N,M); %Current Drinkers
R = zeros(N,M); %Former Drinkers
B = zeros(N,M); %Placement of Bar

%Storage of variables for per generation comparison
Sgen = zeros(Generations,1);
Dgen = zeros(Generations,1);
Rgen = zeros(Generations,1);
Bgen = zeros(Generations,1);
ADBgen = zeros(1);

%Mapping Variable
%Datay = zeros(N,3);

%Initialization of Susceptible Drinkers
for rowcnt = 1:N
    for colcnt = 1:M
        S(rowcnt,colcnt) = 1;
    end
end
%Initialization of Current Drinker in the middle of the 2D lattice
initD = 100; %additional drinkers
D(floor(N/2),floor(M/2)) = 1;
for iD=1:initD-1
    D(randi([1,N]),randi([1,N])) = 1;
end

%Initialization of the Bar
NumberOfBars = 1; %limited to 1 only
for iBar=1:NumberOfBars
    %rowBar = randi([1,N]);
    %colBar = randi([1,N]);
    rowBar = 50;
    colBar = 50;
    B(rowBar,colBar) = B(rowBar,colBar) + 1;
    fprintf('A Bar is situated in (%d,%d)\n', rowBar, colBar);
end

for gencnt=1:Generations
    
    %Movement of SDR
    for rowcnt=1:N
        for colcnt=1:M
            %Movement of S
            Scell = S(rowcnt,colcnt);
            for scnt=1:Scell
                switch(colcnt)
                    case 1 %left most of the 2D lattice (right only)
                        switch(rowcnt)
                            case 1 %top most of the 2D lattice (down only)
                                if rand() > (1-p)
                                    pdir = rand();
                                    %pdir = .5;
                                    if  pdir > (2/3) %move E
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt,colcnt+1) = S(rowcnt,colcnt+1) + 1;
                                    elseif pdir > (1/3) %move SE
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt+1,colcnt+1) = S(rowcnt+1,colcnt+1) + 1;
                                    else %move S
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt+1,colcnt) = S(rowcnt+1,colcnt) + 1;
                                    end
                                end
                            case N %bottom most of the 2D lattice (up only)
                                if rand() > (1-p)
                                    pdir = rand();
                                    if  pdir > (2/3) %move E
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt,colcnt+1) = S(rowcnt,colcnt+1) + 1;
                                    elseif pdir > (1/3) %move NE
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt-1,colcnt+1) = S(rowcnt-1,colcnt+1) + 1;
                                    else %move N
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt-1,colcnt) = S(rowcnt-1,colcnt) + 1;
                                    end
                                end
                            otherwise %middle of the 2D lattice (up and down)
                                if rand() > (1-p)
                                    pdir = rand();
                                    if  pdir > (4/5) %move N
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt-1,colcnt) = S(rowcnt-1,colcnt) + 1;
                                    elseif pdir > (3/5) %move NE
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt-1,colcnt+1) = S(rowcnt-1,colcnt+1) + 1;
                                    elseif pdir > (2/5) %move E
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt,colcnt+1) = S(rowcnt,colcnt+1) + 1;
                                    elseif pdir > (1/5) %move SE
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt+1,colcnt+1) = S(rowcnt+1,colcnt+1) + 1;
                                    else %move S
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt+1,colcnt) = S(rowcnt+1,colcnt) + 1;
                                    end
                                end
                        end
                    case M %right most of the 2D lattice (left only)
                        switch(rowcnt)
                            case 1 %top most of the 2D lattice (down only)
                                if rand() > (1-p)
                                    pdir = rand();
                                    if  pdir > (2/3) %move W
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt,colcnt-1) = S(rowcnt,colcnt-1) + 1;
                                    elseif pdir > (1/3) %move SW
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt+1,colcnt-1) = S(rowcnt+1,colcnt-1) + 1;
                                    else %move S
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt+1,colcnt) = S(rowcnt+1,colcnt) + 1;
                                    end
                                end
                            case N %bottom most of the 2D lattice (up only)
                                if rand() > (1-p)
                                    pdir = rand();
                                    if  pdir > (2/3) %move W
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt,colcnt-1) = S(rowcnt,colcnt-1) + 1;
                                    elseif pdir > (1/3) %move NW
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt-1,colcnt-1) = S(rowcnt-1,colcnt-1) + 1;
                                    else %move N
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt-1,colcnt) = S(rowcnt-1,colcnt) + 1;
                                    end
                                end
                            otherwise %middle of the 2D lattice (up and down)
                                if rand() > (1-p)
                                    pdir = rand();
                                    if  pdir > (4/5) %move N
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt-1,colcnt) = S(rowcnt-1,colcnt) + 1;
                                    elseif pdir > (3/5) %move NW
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt-1,colcnt-1) = S(rowcnt-1,colcnt-1) + 1;
                                    elseif pdir > (2/5) %move W
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt,colcnt-1) = S(rowcnt,colcnt-1) + 1;
                                    elseif pdir > (1/5) %move SW
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt+1,colcnt-1) = S(rowcnt+1,colcnt-1) + 1;
                                    else %move S
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt+1,colcnt) = S(rowcnt+1,colcnt) + 1;
                                    end
                                end
                        end
                    otherwise %middle of the 2D lattice (left and right)
                        switch(rowcnt)
                            case 1 %top most of the 2D lattice (down only)
                                if rand() > (1-p)
                                    pdir = rand();
                                    if  pdir > (4/5) %move W
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt,colcnt-1) = S(rowcnt,colcnt-1) + 1;
                                    elseif pdir > (3/5) %move SW
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt+1,colcnt-1) = S(rowcnt+1,colcnt-1) + 1;
                                    elseif pdir > (2/5) %move S
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt+1,colcnt) = S(rowcnt+1,colcnt) + 1;
                                    elseif pdir > (1/5) %move SE
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt+1,colcnt+1) = S(rowcnt+1,colcnt+1) + 1;
                                    else %move E
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt,colcnt+1) = S(rowcnt,colcnt+1) + 1;
                                    end
                                end
                            case N %bottom most of the 2D lattice (up only)
                                if rand() > (1-p)
                                    pdir = rand();
                                    if  pdir > (4/5) %move W
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt,colcnt-1) = S(rowcnt,colcnt-1) + 1;
                                    elseif pdir > (3/5) %move NW
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt-1,colcnt-1) = S(rowcnt-1,colcnt-1) + 1;
                                    elseif pdir > (2/5) %move N
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt-1,colcnt) = S(rowcnt-1,colcnt) + 1;
                                    elseif pdir > (1/5) %move NE
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt-1,colcnt+1) = S(rowcnt-1,colcnt+1) + 1;
                                    else %move E
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt,colcnt+1) = S(rowcnt,colcnt+1) + 1;
                                    end
                                end
                            otherwise %middle of the 2D lattice (up and down)
                                if rand() > (1-p)
                                    pdir = rand();
                                    if  pdir > (7/8) %move N
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt-1,colcnt) = S(rowcnt-1,colcnt) + 1;
                                    elseif pdir > (6/8) %move NE
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt-1,colcnt+1) = S(rowcnt-1,colcnt+1) + 1;
                                    elseif pdir > (5/8) %move E
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt,colcnt+1) = S(rowcnt,colcnt+1) + 1;
                                    elseif pdir > (4/8) %move SE
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt+1,colcnt+1) = S(rowcnt+1,colcnt+1) + 1;
                                    elseif pdir > (3/8) %move S
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt+1,colcnt) = S(rowcnt+1,colcnt) + 1;
                                    elseif pdir > (2/8) %move SW
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt+1,colcnt-1) = S(rowcnt+1,colcnt-1) + 1;
                                    elseif pdir > (1/8) %move W
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt,colcnt-1) = S(rowcnt,colcnt-1) + 1;
                                    else %move NW
                                        S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                                        S(rowcnt-1,colcnt-1) = S(rowcnt-1,colcnt-1) + 1;
                                    end
                                end
                        end
                end
            end

            %Movement of D - the ONLY agent that can be affected by the bar
            Dcell = D(rowcnt,colcnt);
            for dcnt=1:Dcell
                if gencnt < 2 %They wont be affected by the bar at the first iteration. In the succeeding iterations, they will be affected by the bar
                    switch(colcnt)
                        case 1 %left most of the 2D lattice (right only)
                            switch(rowcnt)
                                case 1 %top most of the 2D lattice (down only)
                                    if rand() > (1-p)
                                        pdir = rand();
                                        %pdir = .5;
                                        if  pdir > (2/3) %move E
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt,colcnt+1) = D(rowcnt,colcnt+1) + 1;
                                        elseif pdir > (1/3) %move SE
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt+1,colcnt+1) = D(rowcnt+1,colcnt+1) + 1;
                                        else %move S
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt+1,colcnt) = D(rowcnt+1,colcnt) + 1;
                                        end
                                    end
                                case N %bottom most of the 2D lattice (up only)
                                    if rand() > (1-p)
                                        pdir = rand();
                                        if  pdir > (2/3) %move E
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt,colcnt+1) = D(rowcnt,colcnt+1) + 1;
                                        elseif pdir > (1/3) %move NE
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt-1,colcnt+1) = D(rowcnt-1,colcnt+1) + 1;
                                        else %move N
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt-1,colcnt) = D(rowcnt-1,colcnt) + 1;
                                        end
                                    end
                                otherwise %middle of the 2D lattice (up and down)
                                    if rand() > (1-p)
                                        pdir = rand();
                                        if  pdir > (4/5) %move N
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt-1,colcnt) = D(rowcnt-1,colcnt) + 1;
                                        elseif pdir > (3/5) %move NE
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt-1,colcnt+1) = D(rowcnt-1,colcnt+1) + 1;
                                        elseif pdir > (2/5) %move E
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt,colcnt+1) = D(rowcnt,colcnt+1) + 1;
                                        elseif pdir > (1/5) %move SE
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt+1,colcnt+1) = D(rowcnt+1,colcnt+1) + 1;
                                        else %move S
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt+1,colcnt) = D(rowcnt+1,colcnt) + 1;
                                        end
                                    end
                            end
                        case M %right most of the 2D lattice (left only)
                            switch(rowcnt)
                                case 1 %top most of the 2D lattice (down only)
                                    if rand() > (1-p)
                                        pdir = rand();
                                        if  pdir > (2/3) %move W
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt,colcnt-1) = D(rowcnt,colcnt-1) + 1;
                                        elseif pdir > (1/3) %move SW
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt+1,colcnt-1) = D(rowcnt+1,colcnt-1) + 1;
                                        else %move S
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt+1,colcnt) = D(rowcnt+1,colcnt) + 1;
                                        end
                                    end
                                case N %bottom most of the 2D lattice (up only)
                                    if rand() > (1-p)
                                        pdir = rand();
                                        if  pdir > (2/3) %move W
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt,colcnt-1) = D(rowcnt,colcnt-1) + 1;
                                        elseif pdir > (1/3) %move NW
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt-1,colcnt-1) = D(rowcnt-1,colcnt-1) + 1;
                                        else %move N
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt-1,colcnt) = D(rowcnt-1,colcnt) + 1;
                                        end
                                    end
                                otherwise %middle of the 2D lattice (up and down)
                                    if rand() > (1-p)
                                        pdir = rand();
                                        if  pdir > (4/5) %move N
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt-1,colcnt) = D(rowcnt-1,colcnt) + 1;
                                        elseif pdir > (3/5) %move NW
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt-1,colcnt-1) = D(rowcnt-1,colcnt-1) + 1;
                                        elseif pdir > (2/5) %move W
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt,colcnt-1) = D(rowcnt,colcnt-1) + 1;
                                        elseif pdir > (1/5) %move SW
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt+1,colcnt-1) = D(rowcnt+1,colcnt-1) + 1;
                                        else %move S
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt+1,colcnt) = D(rowcnt+1,colcnt) + 1;
                                        end
                                    end
                            end
                        otherwise %middle of the 2D lattice (left and right)
                            switch(rowcnt)
                                case 1 %top most of the 2D lattice (down only)
                                    if rand() > (1-p)
                                        pdir = rand();
                                        if  pdir > (4/5) %move W
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt,colcnt-1) = D(rowcnt,colcnt-1) + 1;
                                        elseif pdir > (3/5) %move SW
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt+1,colcnt-1) = D(rowcnt+1,colcnt-1) + 1;
                                        elseif pdir > (2/5) %move S
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt+1,colcnt) = D(rowcnt+1,colcnt) + 1;
                                        elseif pdir > (1/5) %move SE
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt+1,colcnt+1) = D(rowcnt+1,colcnt+1) + 1;
                                        else %move E
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt,colcnt+1) = D(rowcnt,colcnt+1) + 1;
                                        end
                                    end
                                case N %bottom most of the 2D lattice (up only)
                                    if rand() > (1-p)
                                        pdir = rand();
                                        if  pdir > (4/5) %move W
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt,colcnt-1) = D(rowcnt,colcnt-1) + 1;
                                        elseif pdir > (3/5) %move NW
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt-1,colcnt-1) = D(rowcnt-1,colcnt-1) + 1;
                                        elseif pdir > (2/5) %move N
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt-1,colcnt) = D(rowcnt-1,colcnt) + 1;
                                        elseif pdir > (1/5) %move NE
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt-1,colcnt+1) = D(rowcnt-1,colcnt+1) + 1;
                                        else %move E
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt,colcnt+1) = D(rowcnt,colcnt+1) + 1;
                                        end
                                    end
                                otherwise %middle of the 2D lattice (up and down)
                                    if rand() > (1-p)
                                        pdir = rand();
                                        if  pdir > (7/8) %move N
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt-1,colcnt) = D(rowcnt-1,colcnt) + 1;
                                        elseif pdir > (6/8) %move NE
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt-1,colcnt+1) = D(rowcnt-1,colcnt+1) + 1;
                                        elseif pdir > (5/8) %move E
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt,colcnt+1) = D(rowcnt,colcnt+1) + 1;
                                        elseif pdir > (4/8) %move SE
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt+1,colcnt+1) = D(rowcnt+1,colcnt+1) + 1;
                                        elseif pdir > (3/8) %move S
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt+1,colcnt) = D(rowcnt+1,colcnt) + 1;
                                        elseif pdir > (2/8) %move SW
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt+1,colcnt-1) = D(rowcnt+1,colcnt-1) + 1;
                                        elseif pdir > (1/8) %move W
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt,colcnt-1) = D(rowcnt,colcnt-1) + 1;
                                        else %move NW
                                            D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                            D(rowcnt-1,colcnt-1) = D(rowcnt-1,colcnt-1) + 1;
                                        end
                                    end
                            end
                    end
                else %mainly, dito ung block na para sa bar %HEY OVER HERE
                    if B(rowcnt,colcnt) > 0 %if there is a bar situated in the area
                        switch(colcnt)
                            case 1 %left most of the 2D lattice (right only)
                                switch(rowcnt)
                                    case 1 %top most of the 2D lattice (down only)
                                        if rand() > pb
                                            pdir = rand();
                                            %pdir = .5;
                                            if  pdir > (2/3) %move E
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt,colcnt+1) = D(rowcnt,colcnt+1) + 1;
                                            elseif pdir > (1/3) %move SE
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt+1) = D(rowcnt+1,colcnt+1) + 1;
                                            else %move S
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt) = D(rowcnt+1,colcnt) + 1;
                                            end
                                        end
                                    case N %bottom most of the 2D lattice (up only)
                                        if rand() > pb
                                            pdir = rand();
                                            if  pdir > (2/3) %move E
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt,colcnt+1) = D(rowcnt,colcnt+1) + 1;
                                            elseif pdir > (1/3) %move NE
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt+1) = D(rowcnt-1,colcnt+1) + 1;
                                            else %move N
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt) = D(rowcnt-1,colcnt) + 1;
                                            end
                                        end
                                    otherwise %middle of the 2D lattice (up and down)
                                        if rand() > pb
                                            pdir = rand();
                                            if  pdir > (4/5) %move N
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt) = D(rowcnt-1,colcnt) + 1;
                                            elseif pdir > (3/5) %move NE
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt+1) = D(rowcnt-1,colcnt+1) + 1;
                                            elseif pdir > (2/5) %move E
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt,colcnt+1) = D(rowcnt,colcnt+1) + 1;
                                            elseif pdir > (1/5) %move SE
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt+1) = D(rowcnt+1,colcnt+1) + 1;
                                            else %move S
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt) = D(rowcnt+1,colcnt) + 1;
                                            end
                                        end
                                end
                            case M %right most of the 2D lattice (left only)
                                switch(rowcnt)
                                    case 1 %top most of the 2D lattice (down only)
                                        if rand() > pb
                                            pdir = rand();
                                            if  pdir > (2/3) %move W
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt,colcnt-1) = D(rowcnt,colcnt-1) + 1;
                                            elseif pdir > (1/3) %move SW
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt-1) = D(rowcnt+1,colcnt-1) + 1;
                                            else %move S
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt) = D(rowcnt+1,colcnt) + 1;
                                            end
                                        end
                                    case N %bottom most of the 2D lattice (up only)
                                        if rand() > pb
                                            pdir = rand();
                                            if  pdir > (2/3) %move W
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt,colcnt-1) = D(rowcnt,colcnt-1) + 1;
                                            elseif pdir > (1/3) %move NW
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt-1) = D(rowcnt-1,colcnt-1) + 1;
                                            else %move N
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt) = D(rowcnt-1,colcnt) + 1;
                                            end
                                        end
                                    otherwise %middle of the 2D lattice (up and down)
                                        if rand() > pb
                                            pdir = rand();
                                            if  pdir > (4/5) %move N
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt) = D(rowcnt-1,colcnt) + 1;
                                            elseif pdir > (3/5) %move NW
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt-1) = D(rowcnt-1,colcnt-1) + 1;
                                            elseif pdir > (2/5) %move W
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt,colcnt-1) = D(rowcnt,colcnt-1) + 1;
                                            elseif pdir > (1/5) %move SW
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt-1) = D(rowcnt+1,colcnt-1) + 1;
                                            else %move S
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt) = D(rowcnt+1,colcnt) + 1;
                                            end
                                        end
                                end
                            otherwise %middle of the 2D lattice (left and right)
                                switch(rowcnt)
                                    case 1 %top most of the 2D lattice (down only)
                                        if rand() > pb
                                            pdir = rand();
                                            if  pdir > (4/5) %move W
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt,colcnt-1) = D(rowcnt,colcnt-1) + 1;
                                            elseif pdir > (3/5) %move SW
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt-1) = D(rowcnt+1,colcnt-1) + 1;
                                            elseif pdir > (2/5) %move S
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt) = D(rowcnt+1,colcnt) + 1;
                                            elseif pdir > (1/5) %move SE
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt+1) = D(rowcnt+1,colcnt+1) + 1;
                                            else %move E
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt,colcnt+1) = D(rowcnt,colcnt+1) + 1;
                                            end
                                        end
                                    case N %bottom most of the 2D lattice (up only)
                                        if rand() > pb
                                            pdir = rand();
                                            if  pdir > (4/5) %move W
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt,colcnt-1) = D(rowcnt,colcnt-1) + 1;
                                            elseif pdir > (3/5) %move NW
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt-1) = D(rowcnt-1,colcnt-1) + 1;
                                            elseif pdir > (2/5) %move N
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt) = D(rowcnt-1,colcnt) + 1;
                                            elseif pdir > (1/5) %move NE
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt+1) = D(rowcnt-1,colcnt+1) + 1;
                                            else %move E
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt,colcnt+1) = D(rowcnt,colcnt+1) + 1;
                                            end
                                        end
                                    otherwise %middle of the 2D lattice (up and down)
                                        if rand() > pb
                                            pdir = rand();
                                            if  pdir > (7/8) %move N
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt) = D(rowcnt-1,colcnt) + 1;
                                            elseif pdir > (6/8) %move NE
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt+1) = D(rowcnt-1,colcnt+1) + 1;
                                            elseif pdir > (5/8) %move E
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt,colcnt+1) = D(rowcnt,colcnt+1) + 1;
                                            elseif pdir > (4/8) %move SE
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt+1) = D(rowcnt+1,colcnt+1) + 1;
                                            elseif pdir > (3/8) %move S
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt) = D(rowcnt+1,colcnt) + 1;
                                            elseif pdir > (2/8) %move SW
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt-1) = D(rowcnt+1,colcnt-1) + 1;
                                            elseif pdir > (1/8) %move W
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt,colcnt-1) = D(rowcnt,colcnt-1) + 1;
                                            else %move NW
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt-1) = D(rowcnt-1,colcnt-1) + 1;
                                            end
                                        end
                                end
                        end
                    else
                        switch(colcnt)
                            case 1 %left most of the 2D lattice (right only)
                                switch(rowcnt)
                                    case 1 %top most of the 2D lattice (down only)
                                        if rand() > (1-p)
                                            pdir = rand();
                                            %pdir = .5;
                                            if  pdir > (2/3) %move E
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt,colcnt+1) = D(rowcnt,colcnt+1) + 1;
                                            elseif pdir > (1/3) %move SE
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt+1) = D(rowcnt+1,colcnt+1) + 1;
                                            else %move S
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt) = D(rowcnt+1,colcnt) + 1;
                                            end
                                        end
                                    case N %bottom most of the 2D lattice (up only)
                                        if rand() > (1-p)
                                            pdir = rand();
                                            if  pdir > (2/3) %move E
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt,colcnt+1) = D(rowcnt,colcnt+1) + 1;
                                            elseif pdir > (1/3) %move NE
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt+1) = D(rowcnt-1,colcnt+1) + 1;
                                            else %move N
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt) = D(rowcnt-1,colcnt) + 1;
                                            end
                                        end
                                    otherwise %middle of the 2D lattice (up and down)
                                        if rand() > (1-p)
                                            pdir = rand();
                                            if  pdir > (4/5) %move N
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt) = D(rowcnt-1,colcnt) + 1;
                                            elseif pdir > (3/5) %move NE
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt+1) = D(rowcnt-1,colcnt+1) + 1;
                                            elseif pdir > (2/5) %move E
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt,colcnt+1) = D(rowcnt,colcnt+1) + 1;
                                            elseif pdir > (1/5) %move SE
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt+1) = D(rowcnt+1,colcnt+1) + 1;
                                            else %move S
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt) = D(rowcnt+1,colcnt) + 1;
                                            end
                                        end
                                end
                            case M %right most of the 2D lattice (left only)
                                switch(rowcnt)
                                    case 1 %top most of the 2D lattice (down only)
                                        if rand() > (1-p)
                                            pdir = rand();
                                            if  pdir > (2/3) %move W
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt,colcnt-1) = D(rowcnt,colcnt-1) + 1;
                                            elseif pdir > (1/3) %move SW
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt-1) = D(rowcnt+1,colcnt-1) + 1;
                                            else %move S
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt) = D(rowcnt+1,colcnt) + 1;
                                            end
                                        end
                                    case N %bottom most of the 2D lattice (up only)
                                        if rand() > (1-p)
                                            pdir = rand();
                                            if  pdir > (2/3) %move W
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt,colcnt-1) = D(rowcnt,colcnt-1) + 1;
                                            elseif pdir > (1/3) %move NW
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt-1) = D(rowcnt-1,colcnt-1) + 1;
                                            else %move N
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt) = D(rowcnt-1,colcnt) + 1;
                                            end
                                        end
                                    otherwise %middle of the 2D lattice (up and down)
                                        if rand() > (1-p)
                                            pdir = rand();
                                            if  pdir > (4/5) %move N
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt) = D(rowcnt-1,colcnt) + 1;
                                            elseif pdir > (3/5) %move NW
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt-1) = D(rowcnt-1,colcnt-1) + 1;
                                            elseif pdir > (2/5) %move W
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt,colcnt-1) = D(rowcnt,colcnt-1) + 1;
                                            elseif pdir > (1/5) %move SW
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt-1) = D(rowcnt+1,colcnt-1) + 1;
                                            else %move S
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt) = D(rowcnt+1,colcnt) + 1;
                                            end
                                        end
                                end
                            otherwise %middle of the 2D lattice (left and right)
                                switch(rowcnt)
                                    case 1 %top most of the 2D lattice (down only)
                                        if rand() > (1-p)
                                            pdir = rand();
                                            if  pdir > (4/5) %move W
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt,colcnt-1) = D(rowcnt,colcnt-1) + 1;
                                            elseif pdir > (3/5) %move SW
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt-1) = D(rowcnt+1,colcnt-1) + 1;
                                            elseif pdir > (2/5) %move S
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt) = D(rowcnt+1,colcnt) + 1;
                                            elseif pdir > (1/5) %move SE
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt+1,colcnt+1) = D(rowcnt+1,colcnt+1) + 1;
                                            else %move E
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt,colcnt+1) = D(rowcnt,colcnt+1) + 1;
                                            end
                                        end
                                    case N %bottom most of the 2D lattice (up only)
                                        if rand() > (1-p)
                                            pdir = rand();
                                            if  pdir > (4/5) %move W
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt,colcnt-1) = D(rowcnt,colcnt-1) + 1;
                                            elseif pdir > (3/5) %move NW
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt-1) = D(rowcnt-1,colcnt-1) + 1;
                                            elseif pdir > (2/5) %move N
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt) = D(rowcnt-1,colcnt) + 1;
                                            elseif pdir > (1/5) %move NE
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt-1,colcnt+1) = D(rowcnt-1,colcnt+1) + 1;
                                            else %move E
                                                D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                D(rowcnt,colcnt+1) = D(rowcnt,colcnt+1) + 1;
                                            end
                                        end
                                    otherwise %middle of the 2D lattice (up and down)
                                        if rand() > (1-p)
                                            if rand() > (1-pb) %movement is based on attraction <3
                                                if (colcnt-colBar) < 0 %if agent is in west of bar
                                                    if (rowcnt-rowBar) > 0 %if agent is in south of bar
                                                        %move NE
                                                        D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                        D(rowcnt-1,colcnt+1) = D(rowcnt-1,colcnt+1) + 1;
                                                    elseif (rowcnt-rowBar) < 0%if agent is in north of bar
                                                        %move SE
                                                        D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                        D(rowcnt+1,colcnt+1) = D(rowcnt+1,colcnt+1) + 1;
                                                    else %otherwise (same row)
                                                        %move E
                                                        D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                        D(rowcnt,colcnt+1) = D(rowcnt,colcnt+1) + 1;
                                                    end
                                                elseif (colcnt-colBar) > 0 %if agent is in east of bar
                                                    if (rowcnt-rowBar) > 0 %if agent is in south of bar
                                                        %move NW
                                                        D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                        D(rowcnt-1,colcnt-1) = D(rowcnt-1,colcnt-1) + 1;
                                                    elseif (rowcnt-rowBar) < 0%if agent is in north of bar
                                                        %move SW
                                                        D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                        D(rowcnt+1,colcnt-1) = D(rowcnt+1,colcnt-1) + 1;
                                                    else %otherwise (same row)
                                                        %move W
                                                        D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                        D(rowcnt,colcnt-1) = D(rowcnt,colcnt-1) + 1;
                                                    end
                                                else %otherwise (inline)
                                                    if (rowcnt-rowBar) > 0 %if agent is in south of bar
                                                        %move N
                                                        D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                        D(rowcnt-1,colcnt) = D(rowcnt-1,colcnt) + 1;
                                                    else %otherwise (agent is in north of bar)
                                                        %move S
                                                        D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                        D(rowcnt+1,colcnt) = D(rowcnt+1,colcnt) + 1;
                                                    end
                                                end
                                            else %else move normally
                                                pdir = rand();
                                                if  pdir > (7/8) %move N
                                                    D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                    D(rowcnt-1,colcnt) = D(rowcnt-1,colcnt) + 1;
                                                elseif pdir > (6/8) %move NE
                                                    D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                    D(rowcnt-1,colcnt+1) = D(rowcnt-1,colcnt+1) + 1;
                                                elseif pdir > (5/8) %move E
                                                    D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                    D(rowcnt,colcnt+1) = D(rowcnt,colcnt+1) + 1;
                                                elseif pdir > (4/8) %move SE
                                                    D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                    D(rowcnt+1,colcnt+1) = D(rowcnt+1,colcnt+1) + 1;
                                                elseif pdir > (3/8) %move S
                                                    D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                    D(rowcnt+1,colcnt) = D(rowcnt+1,colcnt) + 1;
                                                elseif pdir > (2/8) %move SW
                                                    D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                    D(rowcnt+1,colcnt-1) = D(rowcnt+1,colcnt-1) + 1;
                                                elseif pdir > (1/8) %move W
                                                    D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                    D(rowcnt,colcnt-1) = D(rowcnt,colcnt-1) + 1;
                                                else %move NW
                                                    D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                                                    D(rowcnt-1,colcnt-1) = D(rowcnt-1,colcnt-1) + 1;
                                                end 
                                            end
                                        end
                                end
                        end
                    end
                end
            end

            %Movement of R
            Rcell = R(rowcnt,colcnt);
            for rcnt=1:Rcell
                switch(colcnt)
                    case 1 %left most of the 2D lattice (right only)
                        switch(rowcnt)
                            case 1 %top most of the 2D lattice (down only)
                                if rand() > (1-p)
                                    pdir = rand();
                                    %pdir = .5;
                                    if  pdir > (2/3) %move E
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt,colcnt+1) = R(rowcnt,colcnt+1) + 1;
                                    elseif pdir > (1/3) %move SE
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt+1,colcnt+1) = R(rowcnt+1,colcnt+1) + 1;
                                    else %move S
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt+1,colcnt) = R(rowcnt+1,colcnt) + 1;
                                    end
                                end
                            case N %bottom most of the 2D lattice (up only)
                                if rand() > (1-p)
                                    pdir = rand();
                                    if  pdir > (2/3) %move E
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt,colcnt+1) = R(rowcnt,colcnt+1) + 1;
                                    elseif pdir > (1/3) %move NE
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt-1,colcnt+1) = R(rowcnt-1,colcnt+1) + 1;
                                    else %move N
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt-1,colcnt) = R(rowcnt-1,colcnt) + 1;
                                    end
                                end
                            otherwise %middle of the 2D lattice (up and down)
                                if rand() > (1-p)
                                    pdir = rand();
                                    if  pdir > (4/5) %move N
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt-1,colcnt) = R(rowcnt-1,colcnt) + 1;
                                    elseif pdir > (3/5) %move NE
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt-1,colcnt+1) = R(rowcnt-1,colcnt+1) + 1;
                                    elseif pdir > (2/5) %move E
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt,colcnt+1) = R(rowcnt,colcnt+1) + 1;
                                    elseif pdir > (1/5) %move SE
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt+1,colcnt+1) = R(rowcnt+1,colcnt+1) + 1;
                                    else %move S
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt+1,colcnt) = R(rowcnt+1,colcnt) + 1;
                                    end
                                end
                        end
                    case M %right most of the 2D lattice (left only)
                        switch(rowcnt)
                            case 1 %top most of the 2D lattice (down only)
                                if rand() > (1-p)
                                    pdir = rand();
                                    if  pdir > (2/3) %move W
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt,colcnt-1) = R(rowcnt,colcnt-1) + 1;
                                    elseif pdir > (1/3) %move SW
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt+1,colcnt-1) = R(rowcnt+1,colcnt-1) + 1;
                                    else %move S
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt+1,colcnt) = R(rowcnt+1,colcnt) + 1;
                                    end
                                end
                            case N %bottom most of the 2D lattice (up only)
                                if rand() > (1-p)
                                    pdir = rand();
                                    if  pdir > (2/3) %move W
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt,colcnt-1) = R(rowcnt,colcnt-1) + 1;
                                    elseif pdir > (1/3) %move NW
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt-1,colcnt-1) = R(rowcnt-1,colcnt-1) + 1;
                                    else %move N
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt-1,colcnt) = R(rowcnt-1,colcnt) + 1;
                                    end
                                end
                            otherwise %middle of the 2D lattice (up and down)
                                if rand() > (1-p)
                                    pdir = rand();
                                    if  pdir > (4/5) %move N
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt-1,colcnt) = R(rowcnt-1,colcnt) + 1;
                                    elseif pdir > (3/5) %move NW
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt-1,colcnt-1) = R(rowcnt-1,colcnt-1) + 1;
                                    elseif pdir > (2/5) %move W
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt,colcnt-1) = R(rowcnt,colcnt-1) + 1;
                                    elseif pdir > (1/5) %move SW
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt+1,colcnt-1) = R(rowcnt+1,colcnt-1) + 1;
                                    else %move S
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt+1,colcnt) = R(rowcnt+1,colcnt) + 1;
                                    end
                                end
                        end
                    otherwise %middle of the 2D lattice (left and right)
                        switch(rowcnt)
                            case 1 %top most of the 2D lattice (down only)
                                if rand() > (1-p)
                                    pdir = rand();
                                    if  pdir > (4/5) %move W
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt,colcnt-1) = R(rowcnt,colcnt-1) + 1;
                                    elseif pdir > (3/5) %move SW
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt+1,colcnt-1) = R(rowcnt+1,colcnt-1) + 1;
                                    elseif pdir > (2/5) %move S
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt+1,colcnt) = R(rowcnt+1,colcnt) + 1;
                                    elseif pdir > (1/5) %move SE
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt+1,colcnt+1) = R(rowcnt+1,colcnt+1) + 1;
                                    else %move E
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt,colcnt+1) = R(rowcnt,colcnt+1) + 1;
                                    end
                                end
                            case N %bottom most of the 2D lattice (up only)
                                if rand() > (1-p)
                                    pdir = rand();
                                    if  pdir > (4/5) %move W
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt,colcnt-1) = R(rowcnt,colcnt-1) + 1;
                                    elseif pdir > (3/5) %move NW
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt-1,colcnt-1) = R(rowcnt-1,colcnt-1) + 1;
                                    elseif pdir > (2/5) %move N
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt-1,colcnt) = R(rowcnt-1,colcnt) + 1;
                                    elseif pdir > (1/5) %move NE
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt-1,colcnt+1) = R(rowcnt-1,colcnt+1) + 1;
                                    else %move E
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt,colcnt+1) = R(rowcnt,colcnt+1) + 1;
                                    end
                                end
                            otherwise %middle of the 2D lattice (up and down)
                                if rand() > (1-p)
                                    pdir = rand();
                                    if  pdir > (7/8) %move N
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt-1,colcnt) = R(rowcnt-1,colcnt) + 1;
                                    elseif pdir > (6/8) %move NE
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt-1,colcnt+1) = R(rowcnt-1,colcnt+1) + 1;
                                    elseif pdir > (5/8) %move E
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt,colcnt+1) = R(rowcnt,colcnt+1) + 1;
                                    elseif pdir > (4/8) %move SE
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt+1,colcnt+1) = R(rowcnt+1,colcnt+1) + 1;
                                    elseif pdir > (3/8) %move S
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt+1,colcnt) = R(rowcnt+1,colcnt) + 1;
                                    elseif pdir > (2/8) %move SW
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt+1,colcnt-1) = R(rowcnt+1,colcnt-1) + 1;
                                    elseif pdir > (1/8) %move W
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt,colcnt-1) = R(rowcnt,colcnt-1) + 1;
                                    else %move NW
                                        R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                                        R(rowcnt-1,colcnt-1) = R(rowcnt-1,colcnt-1) + 1;
                                    end
                                end
                        end
                end
            end
        end
    end

    %Interaction of SDR
        %S to D
        for rowcnt = 1:N
            for colcnt = 1:M
                T = S(rowcnt,colcnt) + D(rowcnt,colcnt) + R(rowcnt,colcnt);
                sprob = D(rowcnt,colcnt)/T;
                if sprob > rand() && S(rowcnt,colcnt) > 0
                    S(rowcnt,colcnt) = S(rowcnt,colcnt) - 1;
                    D(rowcnt,colcnt) = D(rowcnt,colcnt) + 1;
                end
            end
        end
        %D to R
        for rowcnt = 1:N
            for colcnt = 1:M
                T = S(rowcnt,colcnt) + D(rowcnt,colcnt) + R(rowcnt,colcnt);
                dprob = (R(rowcnt,colcnt)/T) + pd;
                if dprob > rand() && D(rowcnt,colcnt) > 0
                    D(rowcnt,colcnt) = D(rowcnt,colcnt) - 1;
                    R(rowcnt,colcnt) = R(rowcnt,colcnt) + 1;
                end
            end
        end
        %R to D
        for rowcnt = 1:N
            for colcnt = 1:M
                T = S(rowcnt,colcnt) + D(rowcnt,colcnt) + R(rowcnt,colcnt);
                rprob = (D(rowcnt,colcnt)/T) + pr;
                if rprob > rand() && R(rowcnt,colcnt) > 0
                    R(rowcnt,colcnt) = R(rowcnt,colcnt) - 1;
                    D(rowcnt,colcnt) = D(rowcnt,colcnt) + 1;
                end
            end
        end

    %Generation Evaluation
    T = sum(sum(S)) + sum(sum(D)) + sum(sum(R));
    Sgen(gencnt) = sum(sum(S))/T;
    Dgen(gencnt) = sum(sum(D))/T;
    Rgen(gencnt) = sum(sum(R))/T;

    ADBgen(gencnt) = D(rowBar,colBar);
end

gen = 1:1:Generations;

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


figure
plot(gen,ADBgen);
legend('# Drinkers in the Bar');
xlabel('# of Iterations');
ylabel('# Drinkers in the Bar');

toc
end