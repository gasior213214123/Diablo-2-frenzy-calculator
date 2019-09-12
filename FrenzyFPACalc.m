% Frenzy IAS calculator adjusted to Path of Diablo Mod
% TitanSeal's equations and MajinKaisa script

% Put the weapon with the fastest (lowest number) base weapon speed
% modifier (wsb)in the wsb1 slot.
% If both wsb's are the same, then put the one with the most on weapon
% increased attack speed (wias) in the wsb1 slot.
clear all

wsb1 = input('wsb1 right (glove) hand base weapon speed modifier: ');
wsb2 = input('wsb2 left (boot) hand base weapon speed modifier: ');
wias11 = input('wias11 right (glove) hand on weapon ias: ');
wias22 = input('wias22 left (boot) hand on weapon ias: ');
frenzy=input('frenzy skill level: ');
fanat=input('fanatacism skill level: ');

%input to matrix conversions
wias1=ones(33,1)*[wias11 wias22 wias22 wias11];
wias2=ones(33,1)*[wias22 wias11 wias11 wias22];
x=(0:5:160)'*ones(1,4);

%equipped as specified above, right primary
wsmRPF1=(wsb1 + wsb2)/2 + wsb1 - wsb2;
wsmRPF2=(wsb1 + wsb2)/2;

%equipped as specified, left primary
wsmLPS1=wsb2 + wsb1 - (wsb2 + wsb1)/2;
wsmLPS2=2*wsb1 - (wsb2 + wsb1)/2;

%switched, right primary
wsmRPS1=(wsb2 + wsb1)/2 + wsb2 - wsb1;
wsmRPS2=(wsb2 + wsb1)/2;

%switched, left primary
wsmLPF1=wsb1 + wsb2 - (wsb1 + wsb2)/2;
wsmLPF2=2*wsb2 - (wsb1 + wsb2)/2;

%all wsm matrix
wsm1=ones(33,1)*[wsmRPF1 wsmLPS1 wsmRPS1 wsmLPF1];
wsm2=ones(33,1)*[wsmRPF2 wsmLPS2 wsmRPS2 wsmLPF2];


if frenzy <= 0
    siasf=0;
else
    frenzymod=[9 13 15 18 20 21 22 23 24 25 26 26 27 28 28 29 29 29 29 30 30 30 31 31 31 31 32 32 32 32 32 32 32 32 32 33 33 33 33 33 33 33 33 33 34 34 34 34 34 34];
    siasf=frenzymod(frenzy);
end
if fanat <= 0
    siasn=0;
else
    fanatmod=[14 18 20 23 25 26 27 28 29 30 31 31 32 33 33 34 34 34 34 35 35 36 36 36 36 37 37 37 37 37 37 37 37 37 38 38 38 38 38 38 38 38 38];
    siasn=fanatmod(fanat);
end
sias=siasf + siasn;

%enhance ias
eias1 = floor(120*(x + wias1)./(120*ones(33,4) + x - wias1));
eias2 = floor(120*(x + wias2)./(120*ones(33,4) + x - wias2));

%accelleration
acc11 = (70 + sias)*ones(33,4) + eias1 - wsm1;
acc22 = (70 + sias)*ones(33,4) + eias2 - wsm2;

for h=1:33;
    for i=1:4;
        if acc11(h,i)>=175
            acc1(h,i)=175;
        elseif acc11(h,i)<=15
            acc1(h,i)=15;
        else
            acc1(h,i)=acc11(h,i);
        end
        if acc22(h,i)>=175
            acc2(h,i)=175;
        elseif acc22(h,i)<=15
            acc2(h,i)=15;
        else
            acc2(h,i)=acc22(h,i);
        end
    end
end

%frame rate
fpa1 = ceil(256*9./floor(256*acc1/100)) - 1;
fpa2 = ceil((256*17 - fpa1.*floor(256*acc1/100))./floor(256*acc2/100));
fpa=(fpa1 + fpa2);


disp(['first weapon base speed = ',num2str(wsb1),' '])
disp(['first weapon ias = ',num2str(wias11),' '])
disp(' ')
disp(['second weapon base speed = ',num2str(wsb2),' '])
disp(['second weapon ias = ',num2str(wias22),' '])
disp(' ')
disp(['frenzy skill level = ',num2str(frenzy),' '])
FPA=[(0:5:160)' fpa]