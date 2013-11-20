dt = 0.5;

h = MakeHRF(dt,256);

x = square(0.2*(1:144));

y = conv(x,h,'full');

xhat = WienerDeconv(y,MakeHRF(dt,length(y)),1);

figure(1);
clf;
plot(dt*(1:length(h)),h);

figure(2);
clf;
hold on;
plot(dt*(1:length(x)),x,'r');
plot(dt*(1:length(y)),y,'g');
plot(dt*(1:length(xhat)),xhat,'b');

load example_voxel;

dt = 2.5;

y = example_voxel;

xhat = WienerDeconv(y,MakeHRF(dt,length(y)),1);

figure(3);
clf;
hold on;
plot(dt*(1:length(y)),y,'r');
plot(dt*(1:length(xhat)),xhat,'b');



