function J = deconv_reg(varargin)

[I, PSF, NP, LR] = parse_inputs(varargin{:});

otf = psf2otf(PSF,size(I));
lap = [0 -1 0;-1 4 -1;0 -1 0];
LAP = psf2otf(lap,size(I));

fftnI = fftn(I);
R2 = abs(LAP).^2;
clear REGOP;
H2 = abs(otf).^2;

if (numel(LR)==1) || isequal(diff(LR),0)% gma is given
  gma = LR(1);
else % prepare coefficients for the optimization function (to speed it up)
  R4G2 = (R2.*abs(fftnI)).^2;
  H4 = H2.^2;
  R4 = R2.^2;
  H2R22 = 2*H2.*R2;
  ScaledNP = NP*numel(I);
  gma = fminbnd(@ResOffset,LR(1),LR(2),[],R4G2,H4,R4,H2R22,ScaledNP);
  clear H4 R4 H2R22 R4G2;
end

Denom = H2 + gma*R2;
clear R2 H2;
Nomin = conj(otf).*fftnI;
clear fftnI otf;
Denom = max(Denom, sqrt(eps));

J = real(ifftn(Nomin./Denom));
clear Denom Nomin;


function [I, PSF, NP, LR] = parse_inputs(varargin)
I = varargin{1};
PSF = varargin{2};
NP = varargin{3};
LR = varargin{4};


function f = ResOffset(gma,R4G2,H4,R4,H2R22,ScaledNP)
% Compute the power of the deconvolution residuals
% using Parseval's theorem and its difference with noise power
Residuals = R4G2./(H4 + gma*H2R22 + gma^2*R4 + sqrt(eps));
f = abs(gma^2*sum(Residuals(:)) - ScaledNP);
