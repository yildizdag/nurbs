function nurbs2Dplot(Nurbs2D,control_net,sampling)
%---------------------------------------------------------------
% Plots 2-D NURBS Patches
%---------------------------------------------------------------
figure;
for kk = 1:Nurbs2D.numpatch
    %Sampling:
    N1 = Nurbs2D.knots.U{kk}(end);
    N2 = Nurbs2D.knots.V{kk}(end);
    uu = linspace(Nurbs2D.knots.U{kk}(Nurbs2D.order{kk}(1)),N1,sampling);
    vv = linspace(Nurbs2D.knots.V{kk}(Nurbs2D.order{kk}(2)),N2,sampling);
    %Storing:
    X0 = zeros(length(vv),length(uu));
    Y0 = zeros(length(vv),length(uu));
    Z0 = zeros(length(vv),length(uu));
    for j = 1:sampling
        for r = 1:sampling
            iu = findspan(Nurbs2D.number{kk}(1),Nurbs2D.order{kk}(1)-1,uu(r),Nurbs2D.knots.U{kk});
            iv = findspan(Nurbs2D.number{kk}(2),Nurbs2D.order{kk}(2)-1,vv(j),Nurbs2D.knots.V{kk});
            dNu = dersbasisfuns(iu,uu(r),Nurbs2D.order{kk}(1)-1,0,Nurbs2D.knots.U{kk});
            dNv = dersbasisfuns(iv,vv(j),Nurbs2D.order{kk}(2)-1,0,Nurbs2D.knots.V{kk});
            CP = Nurbs2D.cPoints{kk}(:,iu-Nurbs2D.order{kk}(1)+1:iu, iv-Nurbs2D.order{kk}(2)+1:iv);
            [~,dS] = derRat2DBasisFuns(dNu,dNv,Nurbs2D.order{kk}(1),Nurbs2D.order{kk}(2),CP,0,0);
            X0(j,r) = dS(1,1); Y0(j,r) = dS(2,1); Z0(j,r) = dS(3,1);
        end
    end
    hold on
    surf(X0,Y0,Z0,'EdgeLighting','none','FaceColor','[.8,1,.8]','EdgeColor','none','LineStyle','-');
    hold off
end
if control_net == 1
    hold on
    for kk = 1:Nurbs2D.numpatch
        xParametric = Nurbs2D.knots.U{kk}(Nurbs2D.order{kk}(1):end-Nurbs2D.order{kk}(1)+1);
        yParametric = Nurbs2D.knots.V{kk}(Nurbs2D.order{kk}(2):end-Nurbs2D.order{kk}(2)+1);
        N1 = Nurbs2D.knots.U{kk}(end);
        N2 = Nurbs2D.knots.V{kk}(end);
        uu = linspace(Nurbs2D.knots.U{kk}(Nurbs2D.order{kk}(1)),N1,sampling);
        vv = linspace(Nurbs2D.knots.V{kk}(Nurbs2D.order{kk}(2)),N2,sampling);
        for ii=1:length(yParametric)
            X=zeros(1,sampling); Y=zeros(1,sampling); Z=zeros(1,sampling);
            for jj=1:sampling
                iu = findspan(Nurbs2D.number{kk}(1),Nurbs2D.order{kk}(1)-1,uu(jj),Nurbs2D.knots.U{kk});
                iv = findspan(Nurbs2D.number{kk}(2),Nurbs2D.order{kk}(2)-1,yParametric(ii),Nurbs2D.knots.V{kk});
                dNu = dersbasisfuns(iu,uu(jj),Nurbs2D.order{kk}(1)-1,0,Nurbs2D.knots.U{kk});
                dNv = dersbasisfuns(iv,yParametric(ii),Nurbs2D.order{kk}(2)-1,0,Nurbs2D.knots.V{kk});
                CP = Nurbs2D.cPoints{kk}(:,iu-Nurbs2D.order{kk}(1)+1:iu, iv-Nurbs2D.order{kk}(2)+1:iv);
                [~,dS] = derRat2DBasisFuns(dNu,dNv,Nurbs2D.order{kk}(1),Nurbs2D.order{kk}(2),CP,0,0);
                X(jj) = dS(1,1); Y(jj) = dS(2,1); Z(jj) = dS(3,1);
            end
            plot3(X,Y,Z,'k','LineWidth',2);
        end
        for ii=1:length(xParametric)
            X=zeros(1,sampling); Y=zeros(1,sampling); Z=zeros(1,sampling);
            for jj=1:sampling
                iu = findspan(Nurbs2D.number{kk}(1),Nurbs2D.order{kk}(1)-1,xParametric(ii),Nurbs2D.knots.U{kk});
                iv = findspan(Nurbs2D.number{kk}(2),Nurbs2D.order{kk}(2)-1,vv(jj),Nurbs2D.knots.V{kk});
                dNu = dersbasisfuns(iu,xParametric(ii),Nurbs2D.order{kk}(1)-1,0,Nurbs2D.knots.U{kk});
                dNv = dersbasisfuns(iv,vv(jj),Nurbs2D.order{kk}(2)-1,0,Nurbs2D.knots.V{kk});
                CP = Nurbs2D.cPoints{kk}(:,iu-Nurbs2D.order{kk}(1)+1:iu, iv-Nurbs2D.order{kk}(2)+1:iv);
                [~,dS] = derRat2DBasisFuns(dNu,dNv,Nurbs2D.order{kk}(1),Nurbs2D.order{kk}(2),CP,0,0);
                X(jj) = dS(1,1); Y(jj) = dS(2,1); Z(jj) = dS(3,1);
            end
            plot3(X,Y,Z,'k','LineWidth',2);
        end
    end
end
% Control Points:
for kk = 1:Nurbs2D.numpatch
    for i = 1:Nurbs2D.number{kk}(2)
        X = reshape(Nurbs2D.cPoints{kk}(1,:,i),1,Nurbs2D.number{kk}(1));
        Y = reshape(Nurbs2D.cPoints{kk}(2,:,i),1,Nurbs2D.number{kk}(1));
        Z = reshape(Nurbs2D.cPoints{kk}(3,:,i),1,Nurbs2D.number{kk}(1));
        plot3(X,Y,Z,'--o','LineWidth',2,'Color','b','MarkerSize',12,'MarkerFaceColor','r')
    end
end
for kk = 1:Nurbs2D.numpatch
    for i = 1:Nurbs2D.number{kk}(1)
        X = reshape(Nurbs2D.cPoints{kk}(1,i,:),1,Nurbs2D.number{kk}(2));
        Y = reshape(Nurbs2D.cPoints{kk}(2,i,:),1,Nurbs2D.number{kk}(2));
        Z = reshape(Nurbs2D.cPoints{kk}(3,i,:),1,Nurbs2D.number{kk}(2));
        plot3(X,Y,Z,'--o','LineWidth',2,'Color','b','MarkerSize',12,'MarkerFaceColor','r')
    end
end
for kk = 1:Nurbs2D.numpatch
    X = reshape(Nurbs2D.cPoints{kk}(1,:,:),1,Nurbs2D.nnp{kk});
    Y = reshape(Nurbs2D.cPoints{kk}(2,:,:),1,Nurbs2D.nnp{kk});
    Z = reshape(Nurbs2D.cPoints{kk}(3,:,:),1,Nurbs2D.nnp{kk});
    scatter3(X,Y,Z,80,'b','filled')
end
hold off
axis equal
axis off