function decision = decide_lin_noise(left_train, right_train,...
    gamma, kappa, noise_sd, y0)
% returns decision, -1,0 or 1, using the linear model with Gaussian
% multiplicative noise applied to clicks
% ARGS:
%   left_train   col vector left click times
%   right_train  col vector of right click times
%   gamma        N-by-1 vector of discounting parameter values to use
%   kappa        log(high click rate/low click rate)
%   noise_sd     Gaussian noise applied to click heights
%   y0           initial condition of decision process (scalar)
% RETURNS:
%   decision    N-by-1 vector of decisions
% NOTES:
%   Called by: fill_lin_dec()
%   rng('shuffle') must be called before the function
num_disc=length(gamma);
    noise_left_train = normrnd(kappa, noise_sd, [num_disc,...
        length(left_train)]);
    noise_right_train = normrnd(kappa, noise_sd, [num_disc,...
        length(right_train)]);
    % for the following, I got inspired by this post:
    % https://stackoverflow.com/a/2301078
    gamma=gamma';
    yp=sum(noise_right_train.*exp(right_train*gamma)',2);
    ym=sum(noise_left_train.*exp(left_train*gamma)',2);
    decision=sign(y0+(yp-ym));
end
