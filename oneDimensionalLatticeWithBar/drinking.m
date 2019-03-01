tic

N = 100; %number of lattices
Generations = 1000; %number of generations
p = .5; %probability of movement
pd = .3; %probability of drinkers to stop drinking
pr = .3; %probability of former drinkers to drink again

S = zeros(1,N); %Susceptible
D = zeros(1,N); %Current Drinkers
R = zeros(1,N); %Former Drinkers

%Storage of variables for per generation comparison
Sgen = zeros(Generations,1);
Dgen = zeros(Generations,1);
Rgen = zeros(Generations,1);

%Mapping Variable
Datay = zeros(N,3);

%Initialization of Susceptible Drinkers
for cnt = 1:N
    S(cnt) = 1;
end

%Initialization of Current Drinker in the middle of the lattice
D(floor(N/2)) = 1;

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
        
        %Movement of D
        Dcell = D(mcnt);
        for lcnt = 1:Dcell
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
                    otherwise %if at any site, 50-50 chance of going left or right
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

toc