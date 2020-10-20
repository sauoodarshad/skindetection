imgRead = imread('low-contrast.jpg');

img = rgb2hsv(imgRead);
hsv1 = img(:, :, 1);	
hsv2 = img(:, :, 2);
hsv3 = img(:, :, 3);

figure;histogram(img);
[counts,binLocations] = imhist(hsv3);

valLeft = sum(counts(1:85)) ;
valMiddle =sum(counts(86:171));
valRight = sum(counts(171:255));

if valLeft>valMiddle
    if valLeft>valRight
        disp('LeftSke')
        disp('overdark')
        I2=im2double(hsv3);
        m=mean2(I2); 
        hsv3a=1./(1+(m./(I2+eps)).^4);  
        hsvNew = cat(3, hsv1, hsv2, hsv3a);
        rgbNew = hsv2rgb(hsvNew);
        imshow(imgRead), figure, imshow(rgbNew)

        YCbCr = rgb2ycbcr(imgRead);

        Y=YCbCr( :,:,1);
        Cb=YCbCr( :,:,2);
        Cr=YCbCr( :,:,3);
        skinplace = (Cb>93) & (Cb<136) & (Cr>138) & (Cr<175);

        se=strel('disk',15);
        imgFilled=imfill(skinplace,'holes');
        imgOpen = imopen(imgFilled, se);
        figure, imshow(skinplace);


    end
end

if valRight>valMiddle
    if valRight>valLeft
        
        disp('RightSke')
        disp('OverBright')
        hsv3a = imadjust(hsv3);
        hsvNew = cat(3, hsv1, hsv2, hsv3a);
        rgbNew = hsv2rgb(hsvNew);
        imshow(imgRead), figure, imshow(rgbNew)
        
        YCbCr = rgb2ycbcr(imgRead);

        Y=YCbCr( :,:,1);
        Cb=YCbCr( :,:,2);
        Cr=YCbCr( :,:,3);
        skinplace = (Cb>93) & (Cb<136) & (Cr>138) & (Cr<175);

        se=strel('disk',15);
        imgFilled=imfill(skinplace,'holes');
        imgOpen = imopen(imgFilled, se);
        figure, imshow(skinplace);


    end
end

if valMiddle>valLeft
    if valMiddle>valRight
        disp('MiddleSke')
        disp('LowContrast')
        hsv3a = imadjust(hsv3);
        hsvNew = cat(3, hsv1, hsv2, hsv3a);
        rgbNew = hsv2rgb(hsvNew);
        imshow(imgRead), figure, imshow(rgbNew)
        YCbCr = rgb2ycbcr(imgRead);

        Y=YCbCr( :,:,1);
        Cb=YCbCr( :,:,2);
        Cr=YCbCr( :,:,3);
        skinplace = (Cb>93) & (Cb<136) & (Cr>138) & (Cr<175);

        se=strel('disk',15);
        imgFilled=imfill(skinplace,'holes');
        imgOpen = imopen(imgFilled, se);
        figure, imshow(skinplace);


    end
end





