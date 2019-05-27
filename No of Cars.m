function count =  NCars(v, th)


for i = 1:v.Duration*v.FrameRate
    F(:,:,i) = rgb2gray(read(v,i));
end
count = 0;
RightLanePrevious =0;
MiddleLanePrevious =0;
LeftLanePrevious = 0;
        for i = 2:v.Duration*v.FrameRate
        I = rgb2gray(read(v,i));
        Ip = rgb2gray(read(v,i-1));
        d2 = imabsdiff(I,Ip) > th;
        R=ismember(1, d2(98:102, 118:122));
        L=ismember(1, d2(98:102, 23:27));
        M=ismember(1, d2(98:102, 68:72));
        if(R ==0 && RightLanePrevious==1)
            count = count+1;
        end
        if(M ==0 && MiddleLanePrevious==1)
            count = count+1;
        end
        if(L ==0 && LeftLanePrevious==1)
            count = count+1;
        end
        RightLanePrevious = R;
        MiddleLanePrevious=M;
        LeftLanePrevious = L;
        imshow([double(I)/255 double(d2)])
        end
end