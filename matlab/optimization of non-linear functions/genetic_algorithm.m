clear
clc

n=2;
xmin=-20;
xmax=20;
step=(xmax-xmin)/100; % ���
x=xmin:step:xmax;
N=100; % �������� ���������
a1=randi([0 2^15],1,N); % ��������� 1 - ������� 1x100 �� ��������� ����� ����� � ��������� �� 0 �� 2^15
a2=randi([0 2^15],1,N); % ��������� 2 - ������� 1x100 �� ��������� ����� ����� � ��������� �� 0 �� 2^15
if(n==3)
    a3=randi([0 2^15],1,N); % ��������� 3 - ������� 1x100 �� ��������� ����� ����� � ��������� �� 0 �� 2^15
end
brCount=0;
a=20;
b=0.2;
c=2*pi;

for j=1:length(x)
    for i=1:length(x)
        if(n==2)
            Fp(i)=-a*exp(-b*sqrt((1/n)*sum(x(j)^2+x(i)^2)))-exp((1/n)*sum(cos(c*x(j))+cos(c*x(i))))+a+exp(1);
        elseif(n==3)
            Fp(i)=-a*exp(-b*sqrt((1/n)*sum(x(j)^2+x(i)^2+x(i)^2)))-exp((1/n)*sum(cos(c*x(j))+cos(c*x(i))+cos(c*x(i))))+a+exp(1);
        end
    end
    Fp_surf(j,:)=Fp;
end
[x,y]=meshgrid(x);
surf(x,y,Fp_surf);
hold on;
for it=1:2000
    x1=0;
    x2=0;
    if(n==3)
        x3=0;
    end
    count=0;
    for i=1:length(a1)
        x1(i)=-1+a1(i)*(2)/(2^15);
        x2(i)=-1+a2(i)*(2)/(2^15);
        if(n==3)
            x3(i)=-1+a3(i)*(2)/(2^15);  
        end
    end
	% ������-������� ������������ ���� �������� � ������������ �������
    for i=1:length(x1)
        if(n==2)
            F(i)=-a*exp(-b*sqrt((1/n)*sum(x1(i)^2+x2(i)^2)))-exp((1/n)*sum(cos(c*x1(i))+cos(c*x2(i))))+a+exp(1);
        elseif(n==3)
            F(i)=-a*exp(-b*sqrt((1/n)*sum(x1(i)^2+x2(i)^2+x3(i)^2)))-exp((1/n)*sum(cos(c*x1(i))+cos(c*x2(i))+cos(c*x3(i))))+a+exp(1);
        end
        if(F(i)>0.1) % ������ ������ � ���������
            count=0;
        else
            count=count+1;
        end
    end
    % ��������  ���������  ����������
    % ����������  ������� ���������� 5 ��� ��� ���������� ���������� 2000 ��������� 
    if(count==length(F)) % ���� ��� ��������� �������� ��� ��������
        brCount=brCount+1;
    else
        brCount=0;
    end
    if(brCount==5 || it==2000)
        if(n==2)
            plot3(x1,x2,F,'*')
        elseif(n==3)
            plot3((x1+x2)/2,(x2+x3)/2,F,'*')
        end
        fprintf('���������� ������� ������� %f\n', min(F));
        fprintf('����� ��������� (���������) ����� %i\n', it);
        break;
    end
	% �������� �����������
    F1=F-max(F); % ��������� ���������� � ������������� ��������� ��� ����������� "�����������"
    Mf=round(F1/mean(mean(F1))); % ���������� �� ������ �����
    k=1;
    for i=1:length(a1)
        for j=1:Mf(i) 
            a12(k)=a1(i); % �������� ����� ��������� ��������
            a22(k)=a2(i);
            if(n==3)
                a32(k)=a3(i);
            end
            k=k+1;
        end
    end
	% ������������� ����� ��������� ��������
    a1=a12;
    a2=a22;
    if(n==3)
        a3=a32;
    end
	% ������� ����������� ������������� ����� ��������
    b1=dec2bin(a1,15);
    b2=dec2bin(a2,15);
    if(n==3)
        b3=dec2bin(a3,15);
    end
	% �������� �������������
    j=0;
    for i=1:2:length(b1)-1
        p=randi([0,1]);
        if (p==1)
            k=randi([1,15]); % ����������� ����
            j=b1(i,k:15);
            b1(i,k:15)=b1(i+1,k:15);
            b1(i+1,k:15)=j;
            j=b2(i,k:15);
            b2(i,k:15)=b2(i+1,k:15);
            b2(i+1,k:15)=j;
            if(n==3)
                j=b3(i,k:15);
                b3(i,k:15)=b3(i+1,k:15);
                b3(i+1,k:15)=j;
            end
        end
    end
	% �������� �������
    for i=1:1:length(b1)-1
        p2=randi([0,100]);
        if (p2==1)
            k=randi([1,15]); % ����������� ����
            if (b1(i,k)=='0')
                b1(i,k)='1';
            else
                b1(i,k)='0';
            end
            if (b2(i,k)=='0')
                b2(i,k)='1';
            else
                b2(i,k)='0';
            end
            if(n==3)
                if (b3(i,k)=='0')
                    b3(i,k)='1';
                else
                    b3(i,k)='0';
                end
            end
        end
    end
	% ������� ��������� ������������� ����� � ����������
    a1=bin2dec(b1);
    a2=bin2dec(b2);
    if(n==3)
        a3=bin2dec(b3);
    end
end