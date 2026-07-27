function [TTT, XXX] = plotorbits(N,m,X,Y,Z,vx,vy,vz,dimension)
global G m

record=0; % record video


if record==1
    vid = VideoWriter('orbits_rk4_3D.mp4','MPEG-4');
    open(vid);
end

%% constants

G=2.95912208286 * 10^4; % gravitational constant
max_iter_to_plot=100000; % how many points to trim the trajectory plot to
dt=0.02;% timestep

%% Initial conditions



r=[X Y Z]; %Position vector of all masses

inits=[X Y Z vx vy vz]; % initial conditions for each mass -- all in 1 column, 6 rows for ode solvers

%%%%%%% end initial conditions %%%%%%%%%%%


%% COM (barycentre)
COM=sum(r(1:N,1:3).*m(1:N),1)/sum(m); % location of barycentre

%% setup plotting
myplot=figure('Position',[100 100 850 850]);hold on; % figure window
COM_plot=plot3(COM(:,1),COM(:,2),COM(:,3),'*'); hold on;
axis([-10 10 -10 10 -10 10]*1);
% axis auto
xlabel('X');ylabel('Y');zlabel('Z');
daspect([1 1 1]); 
view(dimension); % Dimension of projection

% plots for each orbit of each mass
for i=1:N
   body_traj(i)=plot3(X(i), Y(i),Z(i),'-'); hold on       % orbit line
   body(i)=plot3(X(i), Y(i), Z(i),'o', 'MarkerSize',8);    % mass marker
end

t=0; % abs time
TITLE=title(['N=' num2str(N) ';  Gravitational N-body Simulation']);
whitebg('black');

time=text(2.5,3.5,['t = ' num2str(t)]);
grid on;
drawnow   

maxtime=dt*100; % time span for one ode45 call

time_span=0:dt:maxtime;
options = odeset('reltol',1e-7); % tolerance for ode solver

n=0; % iteration count
%%
while isgraphics(myplot) % infinite DKD leapfrog time loop (while plot open)
    if t>1000
        break
    end
    x_history=[];
    [TTT,XXX] = ode45(@nbody,time_span,inits, options);
    steps=length(TTT);
    x_history=XXX(:,:);

% get new coordinates from solution    
    i=1:N;
    XX(:,i)=x_history(:,i);
    YY(:,i)=x_history(:,i+N);
    ZZ(:,i)=x_history(:,i+2*N);
    
    VX(:,i)= x_history(:,i+3*N);
    VY(:,i)= x_history(:,i+4*N);
    VZ(:,i)= x_history(:,i+5*N);
    
    n=n+1; % number of total ode runs performed
    t=t+dt;

    % redrawind all plots
    for ii=1:N
            body_traj(ii).XData=[body_traj(ii).XData XX(:,ii)'];
            body_traj(ii).YData=[body_traj(ii).YData YY(:,ii)']; %    
            body_traj(ii).ZData=[body_traj(ii).ZData ZZ(:,ii)']; % update plots    
            set(body(ii), 'XData',XX(end,ii),'YData',YY(end,ii),'ZData',ZZ(end,ii)); % update mass' markers
            
        if n*steps>=max_iter_to_plot % trimming the trajectory line to max_iter_to_plot
            body_traj(ii).XData=body_traj(ii).XData(end-max_iter_to_plot+1:end);
            body_traj(ii).YData=body_traj(ii).YData(end-max_iter_to_plot+1:end);
            body_traj(ii).ZData=body_traj(ii).ZData(end-max_iter_to_plot+1:end);
        end
    end  %%%%%%%%%%%%%%%%% loop ii   ends

      
    r=[XX(end,:)' YY(end,:)' ZZ(end,:)'];
    COM=sum(r(i,1:3).*m(i),1)/sum(m); % new location of barycentre
    set(COM_plot,'XData', COM(end,1),'YData', COM(end,2),'ZData', COM(end,3)); 
    
    inits=XXX(end,:)'; % use current state as initial conditions for next portion of orbit
    
    t=t+maxtime-dt;  
    time.String=['t = ' num2str(round(t,3))];
    drawnow
    
    if record==1
        A=getframe(myplot);
        writeVideo(vid,A);
    end

end % while time loop ends
%%
if record==1 
    close(vid); % close video file
end 

end %end of function