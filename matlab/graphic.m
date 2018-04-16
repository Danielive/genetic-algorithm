for i=1:1000
    Fp(i)=sin(xp(i))/(1+exp(-xp(i))); % ��������� �������� ��� ���������� �������
end
plot(xp,Fp) % ���������� �������
ylim([-2 2]); % ����������� ������ ������� �� ��� y
hold on;
for i=1:1000
    if (Fp(i) == max(Fp))
        index = i;
    end
end
plot(xp(index),max(Fp),'*') % ���������� ����� �� �������
fprintf('������� ������� %f\n', max(Fp));