clear all;

load("DataSagittale.mat");
load("DataTransverse.mat");

% reshape tensors
DataTempsT = reshape(Image_DataT, 64*54, 20);
DataTempsS = reshape(Image_DataS, 64*54, 20);

% create gifs (just of fun)
h = figure;
axis tight manual
for n=1:2
    if n== 1
        filename = 'Transverse.gif';
        Data     = Image_DataT;
    else
        filename = 'Sagittale.gif';
        Data     = Image_DataS;
    end
    
    for i=1:20
        image(rehab(Data(:, :, i)));
        drawnow;
        frame = getframe(h); 
        im = frame2im(frame); 
        [imind,cm] = rgb2ind(im,256);

        if i == 1 
            imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
        else
            imwrite(imind,cm,filename,'gif','WriteMode','append'); 
        end
    end
end

% classification 
sigma = 5;
k     = 2;

idT = classification_spectrale(DataTempsT, k, sigma);
idS = classification_spectrale(DataTempsS, k, sigma);

idT = reshape(idT, 64, 54);
idS = reshape(idS, 64, 54);

figure()
image(idT * 127.5)

figure()
image(idS * 127.5)
