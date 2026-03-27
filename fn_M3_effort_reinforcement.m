% Effort Reinforcement model (M3)
function result = fn_M3_effort_reinforcement(data)

% set up
ch = [data.choice]; % choices
fb = [data.outcome]; % reward outcomes
bl = [data.block]; % block number
tr = [data.trial]; % trial number
pk = [data.effort]; % peak amplitude
result.bl               = bl;
result.ch               = ch;
result.fb               = fb;
result.tr               = tr;
result.pk               = pk;
result.options          = optimset('Display','off','MaxIter',1000,'TolFun',1e-5,'TolX',1e-5,...
    'DiffMaxChange',1e-2,'DiffMinChange',1e-4,'MaxFunEvals',1000,'LargeScale','off'); warning off;

result.inx        = [0         1        0      0];
result.lb         = [-5        0        -2     -5];
result.ub         = [5         20       2      5];
result.blabel     = {'gamma', 'beta',  'k',   'phi_e'};

params = fmincon(@mod,result.inx,[],[],[],[],result.lb,result.ub,[],result.options,result);

result.params               = params;
[LL, p_ch, lr]              = mod(params,result);
result.p_ch                 = p_ch;
result.lr                   = lr;
result.LL                   = LL;

function [LL, p_ch, lr] =  mod(x, data)

gamma          = x(1); % gamma signal gain
beta           = x(2); % beta temperature
k              = x(3); % effort discounting
phi_e          = x(4); % learning rate asymmetry (effort)

%% preliminary
LL = 0;
eff = [0.05, 0.44];
p_ch = [];
if length(unique(data.bl))==2
    for i = 1:2 % find new blocks
        newBlock(i,:) = find(data.bl==i,1,'first');
    end
else
    newBlock = 1;
end

%% learning model

for i = 1:length(data.ch) % for each trial
    
    % initialise values at start of each new block
    if ismember(i,newBlock)
        v = [0.5 0.5];
    end
    
    % choice
    c = data.ch(i,:); % chosen stimulus on current trial
    n = 3-c; % non-chosen stimulus on current trial
    v_c(i,:) = v(c)-k*eff(c); % chosen stimulus value discounted by effort
    v_n(i,:) = v(n)-k*eff(n); % non-chosen stimulus value discounted by effort
    v_ch(i,:) = beta*(v_c(i,:)-v_n(i,:)); % value difference scaled by beta
    p_ch(i,:) = 1./(1+exp(-v_ch(i,:))); % softmax probability
    LL = LL + log(p_ch(i,:)); % add to log likelihood
    
    % learning
    asym = phi_e*data.pk(i,:); % learning rate asymmetry scaled by effort
    pe(i,:) = data.fb(i,:)-v(c); % prediction error
    if data.fb(i,:) == 0 
        lr(i,:) = 1/(1+exp(-(gamma-asym))); % negative learning rate
    elseif data.fb(i,:) == 1
        lr(i,:) = 1/(1+exp(-(gamma+asym))); % positive learning rate
    end
    v(c) = v(c) + lr(i,:)*pe(i,:); % update value of chosen stimulus
end

LL = -LL; % minimise negative log likelihood
