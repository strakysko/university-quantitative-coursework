function [F,DFDZ] = Schnakenberg(z,p,Dx,Dxx)

  % Rename parameters
  a  = p(1); 
  b  = p(2); 
  g  = p(3);

  % Ancillary variables and solution split
  nx = length(z)/2; iV = 1:nx; iW = nx+iV;
  v = z(iV); w = z(iW);

  % Function handles for reaction terms, and their derivatives
  f = @(v,w) -g*v + w.*v.^2; dfdv = @(v,w) -g +2*v.*w; dfdw = @(v,w)  v.^2;
  g = @(v,w)  a - w - w.*v.^2; dgdv = @(v,w)  -2*v.*w; dgdw = @(v,w) -1 -v.^2;

  % Right-hand side
  F = zeros(size(z));
  F(iV) =   Dxx*v + f(v,w);
  F(iW) = b*Dx*w + g(v,w);

  if nargout > 1
    DFDZ = spdiags([],[],2*nx,2*nx);
    DFDZ(iV,iV) =   Dxx + spdiags(dfdv(v,w),0,nx,nx);
    DFDZ(iV,iW) =         spdiags(dfdw(v,w),0,nx,nx);
    DFDZ(iW,iV) =         spdiags(dgdv(v,w),0,nx,nx);
    DFDZ(iW,iW) = b*Dx + spdiags(dgdw(v,w),0,nx,nx);
  end

end
