function mybacksub(v,B,th,alpha, se)


for i = 1:v.Duration*v.FrameRate
    F(:,:,i) = rgb2gray(read(v,i));
end

B_r(:,:,1)= F(:,:,1);
for i=2:v.Duration*v.Framerate
    B_r(:,:,i)=alpha*F(:,:,i-1)+(1-alpha)*B_r(:,:,i-1);
end

B_avg = double(mean(F(:,:,:),3))/255;
s = std(double(F),1,3);

    while true
        for i = 2:v.Duration*v.FrameRate
        I = rgb2gray(read(v,i));
        Ip = rgb2gray(read(v,i-1));
        pause(.1);
        d = imabsdiff(I,B) > th;
  
        d = double(d);
        d2 = imabsdiff(I,Ip) > th;
        d3 = imabsdiff(double(I)/255,(B_avg)) > th/255;
        d4 = imabsdiff(I,B_r(:,:,i))>th;
        d5 = imabsdiff(double(I)/255,(B_avg)) > 2*s;
        imshow([double(I)/255 d myholefill(d, se) d2 d3 d4 d5]);
        end
    end
end

function bwf = myholefill (bw, se)
    bwf = imerode(imdilate(bw, se), se);
end 