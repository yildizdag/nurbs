function nurbs1Dplot(Nurbs1D,control_net,sampling)
%---------------------------------
% Plots 2-D NURBS Patches
%---------------------------------
figure;
for kk = 1:Nurbs1D.numpatch
    %Sampling:
    N1 = Nurbs1D.knots.U{kk}(end);
    uu = linspace(Nurbs1D.knots.U{kk}(Nurbs1D.order{kk}(1)),N1,sampling);
    %Storing:
    X0 = zeros(1,length(uu));
    Y0 = zeros(1,length(uu));
    Z0 = zeros(1,length(uu));
    for r = 1:sampling
        iu = findspan(Nurbs1D.number{kk}(1),Nurbs1D.order{kk}(1)-1,uu(r),Nurbs1D.knots.U{kk});
        dNu = dersbasisfuns(iu,uu(r),Nurbs1D.order{kk}(1)-1,0,Nurbs1D.knots.U{kk});
        CP = Nurbs1D.cPoints{kk}(:,iu-Nurbs1D.order{kk}(1)+1:iu);
        [~,dC] = derRat1DBasisFuns(dNu,Nurbs1D.order{kk}(1),CP,0);
        X0(r) = dC(1,1); Y0(r) = dC(2,1); Z0(r) = dC(3,1);
    end
    %
    hold on
    plot3(X0,Y0,Z0,'k','LineWidth',3);
    hold off
end
% Plot Control Net:
if control_net == 1
    hold on
    for kk = 1:Nurbs1D.numpatch
        plot3(Nurbs1D.cPoints{kk}(1,:),Nurbs1D.cPoints{kk}(2,:),Nurbs1D.cPoints{kk}(3,:),'b--*','LineWidth',3);
    end
    hold off
end
axis equal
axis off