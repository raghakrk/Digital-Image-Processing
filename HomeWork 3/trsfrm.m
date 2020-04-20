function Io= trsfrm(Is,vertex1)
    flag=0;
    [P,Q]=size(Is);
    for p=1:P
        for q=1:Q
                if Is(p,q)~=255
                    if flag==0
                       p1=p;q1=q;
                       rmin=p;
                       cmin=q;
                       rmax=p;cmax=q;
                       flag=1;
                    else
                        if (p>rmin && q<cmin) 
                            cmin=q;
                            q3=cmin;p3=p;
                            rmax=p;
                        elseif(p>rmin && q>cmax)
                            cmax=q;
                            p4=p;q4=cmax;                        
                        elseif(p>rmax)
                            rmax=p;
                            p2=rmax;q2=q;
                        end                              
                    end
                end          
        end
    end

    clear cmax cmin flag rmax rmin
%     vertex1=3;
    if vertex1==3
        pd=[p3 p2 p4 p1];
        qd=[q3 q2 q4 q1];
    elseif vertex1==2
        pd=[p2 p4 p1 p3];
        qd=[q2 q4 q1 q3];
    elseif vertex1==1
        pd=[p1 p3 p2 p4];
        qd=[q1 q3 q2 q4];
    elseif vertex1==4
        pd=[p4 p1 p3 p2];
        qd=[q4 q1 q3 q2];   
    end
%     figure;imshow(uint8(Is));
%     hold on;
%     scatter(qd,pd);text(qd,pd,{'i1','i2','i3','i4'});hold off;

    ud=qd-0.5;vd=P-pd+0.5;
    uc=(ud(1)+ud(3))/2;vc=(vd(1)+vd(3))/2;
    rn=(vd(3)-vd(2));
    rd=(ud(3)-ud(2));
    if rd>=0
        theta=-1*atan(rn/rd);
    else
        theta=-1*atan(rn/rd) - pi;
    end
    wd=(sqrt((vd(1)-vd(4))^2+(ud(1)-ud(4))^2));
    ht=(sqrt((vd(1)-vd(2))^2+(ud(1)-ud(2))^2));
    iht=168;iwd=168;
    %%168
    sx=iwd/wd;
    sy=iht/ht;

    R=[cos(theta) -1*sin(theta) 0;sin(theta) cos(theta) 0;0 0 1];
    txi=0.5- uc;
    tyi=0.5- vc;
    txo=80;
    tyo=80;
    Ti=[1 0 txi;0 1 tyi;0 0 1];
    To=[1 0 txo;0 1 tyo;0 0 1];
    S=[sx 0 0;0 sy 0;0 0 1];

    J=160; K=160;
    for j=1:J
        for k=1:K
            x=k-0.5;y=J-j+0.5;
            A=inv(Ti)*inv(R)*inv(S)*inv(To)*[x;y;1];
            u=A(1);v=A(2); 
            q=u+0.5+1;
            p=P+0.5-v+1;
            dq=q-floor(q);dp=p-floor(p);
            qc=ceil(q);qf=floor(q);
            pc=ceil(p);pf=floor(p);
            Io(j,k)=(1-dq)*(1-dp)*Is(pf,qf)+dq*(1-dp)*Is(pc,qf)+(1-dq)*dp*Is(pf,qc)+dq*dp*Is(pc,qc); 
%             Io(j,k)=Is(round(p),round(q));
        end
    end
%     figure;
%     imshow(uint8(Io));
end