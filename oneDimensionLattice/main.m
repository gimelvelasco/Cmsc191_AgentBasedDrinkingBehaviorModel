%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Code by:
%VELASCO, Gimel David F.
%2012-58922
%Cmsc 191
%Agent Based Modeling of Drinking Behaviour
%Project
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%Initialization Section%%%%%%%%%%%
num_sites = 100;	%number of sites in 1-D lattice
num_days = 2000;	%max iterations
p = 0.1;			%agent motion	(0,0.5]
rho = 1;			%natural tendency of former drinkers to resume drinking
gam = 0.5;			%natural tendency of current drinkers to stop drinking

lattice = zeros(3);
for addrs=1:num_sites
	lattice(addrs,:) = [1 0 0]; %[s(i), d(i), r(i)]	%one susceptible drinker in every location
end
lattice(num_sites/2,:) = [0 1 0]; 			%only one drinker in the middle of the lattice

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

allS = zeros(1);
allD = zeros(1);
allR = zeros(1);
allT = zeros(1);
iteration = zeros(1);
%%%%%%Actual Event Simulation%%%%%%
day = 1;

while(day <= num_days)
	[allS(day),allD(day),allR(day),allT(day)] = getAllSDR(lattice,num_sites);	%stores the number of S, D and R in each day
	iteration(day) = day;
	%%%Pseudocode%%%
	%update number of s d and r per lattice
	%update agent motion of the whole day
	%%%%%%%%%%%%%%%%
	for addrs=1:num_sites
		%%%Pseudocode%%%
		%update per person in a lattice
			%test every S if it becomesDrinkerFirst
			%test every D if it becomesFormerDrinker
			%test every R if it becomesDrinkerAgain			%note that all tests must happen simultaneously
		%update lattice for next day 						%note that the records for all days/iterations will not be stored in lattice alone
		%%%%%%%%%%%%%%%%
		%fprintf('s(%d) = %d\td(%d) = %d\tr(%d) = %d\t\n',addrs,lattice(addrs,1),addrs,lattice(addrs,2),addrs,lattice(addrs,3));
		s = lattice(addrs,1);	% 1 - S | 2 - D | 3 - R
		d = lattice(addrs,2);
		r = lattice(addrs,3);
		for person_index=1:lattice(addrs,1)
			%fprintf('s');
			if rand(1) < becomesDrinkerFirst(addrs,lattice(addrs,2),totalPopulation(lattice,addrs))
				s = s - 1;
				d = d + 1;
			end
		end
		for person_index=1:lattice(addrs,2)
			%fprintf('d');
			if rand(1) < becomesFormerDrinker(addrs,lattice(addrs,3),totalPopulation(lattice,addrs),gam)
				d = d - 1;
				r = r + 1;
			end
		end
		for person_index=1:lattice(addrs,3)
			%fprintf('r');
			if rand(1) < becomesDrinkerAgain(addrs,lattice(addrs,2),totalPopulation(lattice,addrs),rho)
				r = r - 1;
				d = d + 1;
			end
		end
		lattice(addrs,:) = [s d r];
		%fprintf('\n');
	end

	for addrs=1:num_sites
		%%%Pseudocode%%%
		%test every S,D and R in every lattice if it movesOut
		%%%%%%%%%%%%%%%%
		latticeTemp = lattice;
		if addrs == 1
			for person_index=1:lattice(addrs,1)
				if rand(1) < movesOut(p)
					latticeTemp(addrs,1) = latticeTemp(addrs,1) - 1;
					latticeTemp(addrs+1,1) = latticeTemp(addrs+1,1) + 1;
				end
			end
			for person_index=1:lattice(addrs,2)
				if rand(1) < movesOut(p)
					latticeTemp(addrs,2) = latticeTemp(addrs,2) - 1;
					latticeTemp(addrs+1,2) = latticeTemp(addrs+1,2) + 1;
				end
			end
			for person_index=1:lattice(addrs,3)
				if rand(1) < movesOut(p)
					latticeTemp(addrs,3) = latticeTemp(addrs,3) - 1;
					latticeTemp(addrs+1,3) = latticeTemp(addrs+1,3) + 1;
				end
			end
		elseif addrs == num_sites
			for person_index=1:lattice(addrs,1)
				if rand(1) < movesOut(p)
					latticeTemp(addrs,1) = latticeTemp(addrs,1) - 1;
					latticeTemp(addrs-1,1) = latticeTemp(addrs-1,1) + 1;
				end
			end
			for person_index=1:lattice(addrs,2)
				if rand(1) < movesOut(p)
					latticeTemp(addrs,2) = latticeTemp(addrs,2) - 1;
					latticeTemp(addrs-1,2) = latticeTemp(addrs-1,2) + 1;
				end
			end
			for person_index=1:lattice(addrs,3)
				if rand(1) < movesOut(p)
					latticeTemp(addrs,3) = latticeTemp(addrs,3) - 1;
					latticeTemp(addrs-1,3) = latticeTemp(addrs-1,3) + 1;
				end
			end
		else
			for person_index=1:lattice(addrs,1)
				if rand(1) < movesOut(p)
					latticeTemp(addrs,1) = latticeTemp(addrs,1) - 1;
					if rand(1) < 0.5 	%move left
						latticeTemp(addrs-1,1) = latticeTemp(addrs-1,1) + 1;
					else 				%move right
						latticeTemp(addrs+1,1) = latticeTemp(addrs+1,1) + 1;
					end
				end
			end
			for person_index=1:lattice(addrs,2)
				if rand(1) < movesOut(p)
					latticeTemp(addrs,2) = latticeTemp(addrs,2) - 1;
					if rand(1) < 0.5 	%move left
						latticeTemp(addrs-1,2) = latticeTemp(addrs-1,2) + 1;
					else 				%move right
						latticeTemp(addrs+1,2) = latticeTemp(addrs+1,2) + 1;
					end
				end
			end
			for person_index=1:lattice(addrs,3)
				if rand(1) < movesOut(p)
					latticeTemp(addrs,3) = latticeTemp(addrs,3) - 1;
					if rand(1) < 0.5 	%move left
						latticeTemp(addrs-1,3) = latticeTemp(addrs-1,3) + 1;
					else 				%move right
						latticeTemp(addrs+1,3) = latticeTemp(addrs+1,3) + 1;
					end
				end
			end
		end
		lattice = latticeTemp;
	end
	
	day = day + 1;
end

[allS(day),allD(day),allR(day),allT(day)] = getAllSDR(lattice,num_sites);	%stores the number of S, D and R in each day
iteration(day) = day;

figure
plot(iteration,allS)
hold on
plot(iteration,allD)
hold on
plot(iteration,allR)
hold on
plot(iteration,allT)
hold on
legend('Susceptible','Drinkers','Recovered','TotalSDR')
xlabel('Iteration')
ylabel('SDR')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%