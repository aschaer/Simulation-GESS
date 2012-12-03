% 'Gaussian Distribution' function
function p = Prova_Gauss(t)
    % Define the Parameters of the Gaussian dirstribution
    mu = 1000;
    sigma = 1700;        
    A = 2/3700;
    % Values obtained by "trying"
    
    % MATLAB's DEFINITION
    % p = A*(normpdf(t,mu,sigma)+1);
    
    % People Vector as a function of time
    p=t.*A.*exp(-(t-mu).^2/(2*sigma^2));

