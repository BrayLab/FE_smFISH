%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
myGene = 'Npas4'
myGeneModel = 'Npas4(2S,500)'

Exp = cat(2,'DataMerged_',myGene,'.xlsx');% Experimental data file
% Exp = 'DataMerged_Npas4.xlsx'
NtZ = 0;                                    % If 1, substitute NaN to zero.
ExI = 0;                                    % If 1, extract experiment information.
N = '2S';                                   % Model ('2S' or '3S').
maxM = 300;                                 % Maximum mRNA number to consider.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% (1.1) Import data:
    [i,t] = xlsfinfo(Exp);
    for i = 1:length(t)
        X = DATA_X(Exp,t{i},NtZ,ExI);
        
        % (1.2) Convert to matrix:
        x.(t{i}) = DATA_Xm(X.data,N,maxM);
    end
    clear i t X

% (1.3) Save file:
    save(cat(2,'myData_',myGene,'(',N,',',num2str(maxM),').mat'),...
        'x','N','maxM')
    clear x

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Model (N) and maximum mRNA number to consider (maxM):
%load(cat(2,'myData_',myGene,'.mat'),'N','maxM');
load(cat(2,'myData_',myGene,'(',N,',',num2str(maxM),').mat'),...
        'x','N','maxM')
% Kinetic parameters:
Par.kON = NaN;      % Promoter activation rate (OFF->ON)
Par.kOFF = 0.0616;	% Promoter deactivation rate (ON->OFF)
Par.kONs = NaN;     % Promoter "super" activation rate (ON->ONs)
Par.kOFFs = NaN;	% Promoter "super" deactivation rate (ONs->ON)
Par.mu0 = 0.0266;	% mRNA synthesis rate of promoter in OFF state
Par.mu = 5.0851;	% mRNA synthesis rate of promoter in ON state
Par.muS = NaN;   	% mRNA synthesis rate of promoter in ONs state
Par.d = 0.0462;     % mRNA degradation rate
% Kinetic parameters sensitive to stimulus:
ParS.kON = [0.0051,0.1373]; % [Basal,Stimulus]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% (2.1) Model structure:
    STRUCT_TransM(N,maxM);
    
% (2.2) Calculate transition matrices:
    pS = fieldnames(ParS);
    % Basal conditions:
    for i1 = 1:length(pS)
        Par.(pS{i1}) = ParS.(pS{i1})(1);
    end
    A.b = DATA_TransM(N,maxM,Par);
    % Stimulus conditions:
    for i1 = 1:length(pS)
        Par.(pS{i1}) = ParS.(pS{i1})(2);
    end
    A.s = DATA_TransM(N,maxM,Par);
    clear pS i1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Model (N):
load(cat(2,'myData_',myGeneModel,'.mat'),'N');
% Time points:
load(cat(2,'myData_',myGeneModel,'.mat'),'x');
myT = fieldnames(x);
clear x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% (3.1) Calculate probability distributions vectors:
    P.t00 = DATA_Pss(A.b);
    for t = 2:length(myT)
        tt = regexp(myT{t},'\.*\d*','match');
        P.(myT{t}) = DATA_Pxt(A.s,P.t00,str2double(tt{1}));
        % Calculate FSP algorithm estimation error:
        eps.(myT{t}) = 1-sum(P.(myT{t}));
        if(eps.(myT{t})>0.001)
            cat(2,'CAUTION: Large FSP algorithm estimation error (',...
                num2str(eps.(myT{t})),')')
        end
    end
    clear t tt
    
% (3.2) Transform probability distributions vectors to matrices:
    for t = 1:length(myT)
        M.(myT{t}) = DATA_P2M(N,P.(myT{t}));
    end
    clear t