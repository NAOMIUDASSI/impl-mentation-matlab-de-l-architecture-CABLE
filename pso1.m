function out=pso1(problem, params)

%% Problem definition
CostFunction = problem.CostFunction;

%CostFunction = @(x) minimizeError(x);

nVar=problem.nVar; 

varSize = [1 nVar];

varMin = problem.varMin;
varMax = problem.varMax;


%% Parameters of PSO

MaxIt = params.MaxIt;
nPop=params.nPop;
w=params.w;
wmax=params.wmax;       % inertia weight
wmin=params.wmin;
c1=params.c1;
c2=params.c2;

ShowIterInfo = params.ShowIterInfo;

%% Initialization

empty_particle.Position = [];
empty_particle.Velocity = [];
empty_particle.Cost = [];
empty_particle.Best.Position = [];
empty_particle.Best.Cost = [];

particle = repmat(empty_particle, nPop, 1);

GlobalBest.Cost = inf;

for i=1:nPop
  
    particle(i).Position = unifrnd(varMin, varMax, varSize);
    particle(i).Position
    particle(i).Velocity = zeros(varSize);
    
    particle(i).Cost = CostFunction(particle(i).Position);
    
    particle(i).Best.Position=particle(i).Position;
    particle(i).Best.Cost=particle(i).Cost;
    
    
    if particle(i).Best.Cost < GlobalBest.Cost
        GlobalBest = particle(i).Best;
    end
    
end
    
    BestCosts = zeros(MaxIt, 1);
    
    %% Main Loop of PSO
    for it=1:MaxIt
        
        for i=1:nPop
  
            particle(i).Velocity = w*particle(i).Velocity + c1*rand(varSize).*(particle(i).Best.Position - particle(i).Position)
                + c2*rand(varSize).*(GlobalBest.Position - particle(i).Position);
                
            particle(i).Position = particle(i).Position + particle(i).Velocity;
            
            particle(i).Cost = CostFunction(particle(i).Position)
            
            
            if (particle(i).Cost < particle(i).Best.Cost)
                
            particle(i).Best.position = particle (i).Position;
            particle(i).Best.Cost = particle(i).Cost;
        
            if particle(i).Best.Cost < GlobalBest.Cost
                GlobalBest = particle(i).Best;
            
            
            end
            end
            
        end
        
            BestCosts(it) = GlobalBest.Cost;
            
            if ShowIterInfo 
            disp(['Iteration ' num2str(it) ': Best Cost =' num2str(BestCosts(it)) ]);
            end
            
            w=wmax-(wmax-wmin)*it/MaxIt;
    end

     
   out.pop = particle;
   out.BestSol = GlobalBest;
   out.BestCosts = BestCosts;
    
    
%% Results