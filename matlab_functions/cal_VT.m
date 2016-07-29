function [a_lum,b_lum,b_c1,b_c2]=cal_VT(jnd_level)
% function to show VTs for a given JND level on Monitor Asus PA-328Q, for
% VT5 or larger, extrapolations from VT1-VT4 are done.
% Feng Liu, 3/15/2016
% Input: jnd_level is the JND level, i.e., VT index
% Output: a_lum and b_lum are a and b coefficients to calculate VTs for a
% given JND level. VT=a*sig2+b
% Output: b_c1 and b_c2 are the VTs for Cb and Cr, respectively.
% All the output coefficients and VTs are 16 dimentional, arranged by [LL5,
% HL5, LH5, HH5, HL4, LH4, HH4, HL3, LH3, HH3, HL2, LH2, HH2, HL1, LH1,
% HH1].

% look-up table of "b" for VT1-VT4
b1_lum=[0.382691320230401 0.382691320230401 0.415293420481180 0.447540530128035 0.447540530128035 0.505890470144748 0.608465602455002 0.608465602455002 0.702137687918609 0.871573939998642 0.871573939998642 1.77078039768350 3.72283610670291 3.72283610670291 9.47287633995948];
b1_lum_ll5=0.685592700761521;
b1_c1=[0.706067754652443 0.607701590312628 0.607701590312628 0.607510535848851 0.998011299607568 0.998011299607568 3.78068062969872 2.94951873588676 2.94951873588676 17.9106643098601 130.993897131432 130.993897131432 130.994577667857 130.993617273076 130.993617273076 130.992153438877];
b1_c2=[0.669813632739133 0.604517322739880 0.604517322739880 0.767490934370264 0.946400521775300 0.946400521775300 1.16636527698937 1.20292230006847 1.20292230006847 1.61979256634760 2.09309373154831 2.09309373154831 130.997233627744 130.986488505754 130.986488505754 130.996934103572];
b2_lum=[0.434084655468548 0.434084655468548 0.465304797535008 0.511750034414467 0.511750034414467 0.581305539151728 0.659755487103723 0.659755487103723 0.809491439975062 1.15104803552979 1.15104803552979 2.24989296860497 4.87646885047829 4.87646885047829 14.5774535018941];
b2_lum_ll5=0.742033237759156;
b2_c1=[0.784265893007400 0.736937695178067 0.736937695178067 0.919137710588956 1.69686104200778 1.69686104200778 10.5182654000033 3.76734662426825 3.76734662426825 134.996947307751 152.993516130552 152.993516130552 152.997530884212 152.995237751513 152.995237751513 152.996482122665];
b2_c2=[0.805759555823776 0.744440760700397 0.744440760700397 1.01986962415208 1.12209855682695 1.12209855682695 1.51569057777514 1.48372631921818 1.48372631921818 2.30200745554014 2.96072780817329 2.96072780817329 152.997304749796 152.995149617803 152.995149617803 152.997458558437];
b3_lum=[0.484341099986328 0.484341099986328 0.494147223178906 0.551603027384164 0.551603027384164 0.636957952654720 0.721475383961316 0.721475383961316 0.881402986606295 1.29943208839722 1.29943208839722 2.58130969501846 6.05940698449506 6.05940698449506 21.5414998901205];
b3_lum_ll5=0.762992801427690;
b3_c1=[1.07832910653056 0.856522433805792 0.856522433805792 1.27271477663976 2.19690472634955 2.19690472634955 152.996839855327 5.12853035241829 5.12853035241829 152.995325414146 152.995780802669 152.995780802669 152.997959460260 152.998797195216 152.998797195216 152.997959460260];
b3_c2=[1.00872822650578 0.854771240647879 0.854771240647879 1.23195394950874 1.25534262453520 1.25534262453520 1.83189078555938 1.69349682433062 1.69349682433062 3.85286999390618 4.67774385488046 4.67774385488046 152.998797195216 152.997305806641 152.997305806641 152.998217237609];
b4_lum=[0.505435228069161 0.505435228069161 0.541146219833016 0.587742313187429 0.587742313187429 0.687676072096987 0.789845112882299 0.789845112882299 0.957923039632841 1.55684815856524 1.55684815856524 2.93624716922495 7.33552529213651 7.33552529213651 28.1249366542854];
b4_lum_ll5=0.793823216031755;
b4_c1=[1.43002627051325 1.03788185931584 1.03788185931584 1.75698728080976 2.70532009328825 2.70532009328825 152.997959460260 8.52406722911980 8.52406722911980 152.998439137414 152.997658652403 152.997658652403 152.998797195216 152.998217237609 152.998217237609 152.997305806641];
b4_c2=[1.08258440295412 0.985140683118398 0.985140683118398 1.46352201491993 1.47979520544745 1.47979520544745 2.00031419770869 2.03877053533035 2.03877053533035 8.29421171419673 7.03683390523834 7.03683390523834 152.997959460260 152.998630903525 152.998630903525 152.997305806641];
b5_lum=[0.551771218714230 0.551771218714230 0.576232092347723 0.628048534812246 0.628048534812246 0.734772989042317 0.842091735638497 0.842091735638497 1.02958317266458 1.73078788261667 1.73078788261667 3.29038844919062 7.97417315137227 7.97417315137227 35.8329834468014];
b5_lum_ll5=0.819757330508854;
b5_c1=[1.61919342101566 1.21828925391952 1.21828925391952 2.29323109245853 3.29433221046579 3.29433221046579 152.998630903525 17.4417514369166 17.4417514369166 152.998217237609 152.998439137414 152.998439137414 152.998630903525 152.998439137414 152.998439137414 152.998941826944];
b5_c2=[1.23729656249215 1.12105204952981 1.12105204952981 1.64034512342955 1.71442276517571 1.71442276517571 2.22583969362199 2.26943241494878 2.26943241494878 152.993830150836 9.78526908605870 9.78526908605870 152.997959460260 152.997658652403 152.997658652403 152.998941826944];
b6_lum=[0.589124061157761 0.589124061157761 0.615837717834706 0.664657289772031 0.664657289772031 0.799488246434283 0.877321522613872 0.877321522613872 1.09598000665499 1.92261227682623 1.92261227682623 3.67376612110808 8.73991763078593 8.73991763078593 41.2716787379908];
b6_lum_ll5=0.856928961087898;
b6_c1=[1.84815774066071 1.38716698493363 1.38716698493363 2.65362522906756 3.70486975907107 3.70486975907107 152.997305806641 152.994126727367 152.994126727367 152.996394722211 152.998217237609 152.998217237609 152.998797195216 152.997658652403 152.997658652403 152.998439137414];
b6_c2=[1.39029248707526 1.23757848172025 1.23757848172025 1.81224059922087 1.91162667552829 1.91162667552829 2.57629089798738 2.58761265159553 2.58761265159553 152.998139623523 152.990585711418 152.990585711418 152.998439137414 152.997658652403 152.997658652403 152.997959460260];

% look-up table of "a" for VT1-VT4
a1_lum=[0.000585241344726125 0.000585241344726125 0.000477542584241842 0.000378687683207916 0.000378687683207916 0.000241220470218542 0.000638451962517004 0.000638451962517004 0.00112729395942739 0.00154526673246704 0.00154526673246704 0.00204177475486389 0.00433708864327796 0.00433708864327796 0.0393061899312421];
a2_lum=[0.000647934378866928 0.000647934378866928 0.000612144233536813 0.000430708357369612 0.000430708357369612 0.000309763961169524 0.000693302056409649 0.000693302056409649 0.00137845344030698 0.00140650574513955 0.00140650574513955 0.00225442284633459 0.00342580930062931 0.00342580930062931 0.0485185068317250];
a3_lum=[0.000571237839572667 0.000571237839572667 0.000703164795981749 0.000457256489435820 0.000457256489435820 0.000462373463966349 0.000803519191659962 0.000803519191659962 0.00155340778564751 0.00182048435664677 0.00182048435664677 0.00369915383946039 0.00173503443620607 0.00173503443620607 0.0300064681467924];
a4_lum=[0.000646972673003383 0.000646972673003383 0.000716917538387347 0.000513116364545300 0.000513116364545300 0.000517927739011784 0.000673875472882495 0.000673875472882495 0.00172432694037594 0.00156791755147101 0.00156791755147101 0.00434404534192463 0.000644830816917924 0.000644830816917924 0.0290727395748646];
a5_lum=[0.000641814272197087 0.000641814272197087 0.000848038123446818 0.000652347130410112 0.000652347130410112 0.000512495033555372 0.000667592314954124 0.000667592314954124 0.00191852727400392 0.00169021146054170 0.00169021146054170 0.00458360280415686 0.00213356857489579 0.00213356857489579 0.0109319976854877];
a6_lum=[0.000687858158138870 0.000687858158138870 0.000931523109552699 0.000717506198244873 0.000717506198244873 0.000444108423474345 0.000827352788946653 0.000827352788946653 0.00217738517604171 0.00179917876101125 0.00179917876101125 0.00474296889450931 0.00408175519391044 0.00408175519391044 0.0165513532085011];

% extrapolation coefficients
abs_lum=[0.0401805006416194 0.0401805006416194 0.0395000676531396 0.0420176738633309 0.0420176738633309 0.0565459814446203 0.0559902307234187 0.0559902307234187 0.0773144812793430 0.207195065587617 0.207195065587617 0.371181500945324 1.01870396659253 1.01870396659253 6.55268681682981];
abs_lum_ll5=0.0320195426995727;
abs_c1=[0.244769419372823 0.157792602138269 0.157792602138269 0.423917889024922 0.538146319132293 0.538146319132293 0 0 0 0 0 0 0 0 0 0];
abs_c2=[0.142024613375260 0.126443117253160 0.126443117253160 0.209049796785618 0.195073027849242 0.195073027849242 0.267099967562283 0.275024107309338 0.275024107309338 0 0 0 0 0 0 0];
bbs_lum=[0.350609511692070 0.350609511692070 0.379743341749101 0.418161763094737 0.418161763094737 0.459770943197960 0.553859999910486 0.553859999910486 0.642152371097696 0.696867667432305 0.696867667432305 1.45126221349646 2.88592411958798 2.88592411958798 2.20250090293760];
bbs_lum_ll5=0.664786308480975;
bbs_c1=[0.387647063258456 0.421809195426971 0.421809195426971 0.100155159315009 0.549204404835310 0.549204404835310 256 256 256 256 256 256 256 256 256 256];
bbs_c2=[0.535326331118293 0.482032512690041 0.482032512690041 0.590896085517243 0.722192127409135 0.722192127409135 0.951215351805667 0.916742465332639 0.916742465332639 256 256 256 256 256 256 256];

as_lum=[0.000628897012845695 0.000628897012845695 0.000698768845414265 0.000511513899323421 0.000511513899323421 0.000399620383538999 0.000713901202847905 0.000713901202847905 0.00160955665713271 0.00163159268435200 0.00163159268435200 0.00342281059031193 0.00229145581666046 0.00229145581666046 0.0258881117885302];

if(jnd_level==1)
    b_lum=[b1_lum_ll5 b1_lum];
    b_c1=b1_c1;
    b_c2=b1_c2;
    a_lum=[0 a1_lum];
elseif(jnd_level==2)
    b_lum=[b2_lum_ll5 b2_lum];
    b_c1=b2_c1;
    b_c2=b2_c2;
    a_lum=[0 a2_lum];
elseif(jnd_level==3)
    b_lum=[b3_lum_ll5 b3_lum];
    b_c1=b3_c1;
    b_c2=b3_c2;
    a_lum=[0 a3_lum];
elseif(jnd_level==4)
    b_lum=[b4_lum_ll5 b4_lum];
    b_c1=b4_c1;
    b_c2=b4_c2;
    a_lum=[0 a4_lum];
elseif(jnd_level==5)
    b_lum=[b5_lum_ll5 b5_lum];
    b_c1=b5_c1;
    b_c2=b5_c2;
    a_lum=[0 a5_lum];
elseif(jnd_level==6)
    b_lum=[b6_lum_ll5 b6_lum];
    b_c1=b6_c1;
    b_c2=b6_c2;
    a_lum=[0 a6_lum];
else
    b_lum=[abs_lum_ll5*jnd_level+bbs_lum_ll5 abs_lum*jnd_level+bbs_lum];
    b_c1=(abs_c1*jnd_level+bbs_c1);
    b_c2=(abs_c2*jnd_level+bbs_c2);
    a_lum=[0 as_lum];
end

end