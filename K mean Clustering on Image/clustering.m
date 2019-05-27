function b = clustering(pic,k)

    s = size(pic);
    b = cat(3,pic,zeros(s(1),s(2)));
    kp = [randi([0 255],k,1),randi([0 255],k,1),randi([0 255],k,1)]
    for iterations = 1:10
        clear temp;        
        temp=cell(k,1);
        for i = 1:k
            clear h;
            h(:,:,1)= abs(double(b(:,:,1))-kp(i,1));
            h(:,:,2)= abs(double(b(:,:,2))-kp(i,2));
            h(:,:,3)= abs(double(b(:,:,3))-kp(i,3));        
            S1 = sum(power(h,2),3);
            temp{i} = S1;
        end
        
        for l = 1:s(1)
            for m = 1:s(2)
                maxIndex = -1;
                maxval=2147483647;
                for n = 1:k
                    if temp{n}(l,m) < maxval
                        maxval = temp{n}(l,m);
                        maxIndex = n;
                    end
                end
                b(l,m,4)=maxIndex;
            end        
        end
        for h = 1:k
            j = (b(:,:,4)==h);
            j = uint8(j);
            v = pic;
            v = v(:,:,:).*j;
            totalIndexes = sum(j(:));
            x = sum(v,[1 2]);
            if totalIndexes ~=0
                kp(h,1) = round(x(1)/totalIndexes);
                kp(h,2) = round(x(2)/totalIndexes);
                kp(h,3) = round(x(3)/totalIndexes);
            end
        end        
    end
    output=[];
    line = round(sqrt(k));
    g=[];
    x=[];
    for i=1:k
        j = (b(:,:,4)==i);
        j = uint8(j);
        v = pic;
        v = v(:,:,:).*j;
        x = [x v];
        output = cat(2,output,v);
        if(mod(i,line)== 0)
           g=[g ;x];
           x=[];
        end
    end
    rem = mod(k,line);
    x=  padarray(x,[0 s(2)*(line-rem)],255,'post');
    if rem~=0
    g=[g ;x];
    end
    imshow(g);
end
