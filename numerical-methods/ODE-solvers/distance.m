function [dist]=distance(X)
% what is the form of X?
% this function calculates distance between two coordinates in a given vector X
L=length(X);
dist=zeros([1 L]);

j=1:L;
for k=1:L
  dist(j(k),j)=X(j(k))-X(j);
end
 
end