% insert images
im1 = imread('lytro-09-A.jpg');
im2 = imread('lytro-09-B.jpg');
im_black_1 = rgb2gray(im1);
im_black_2 = rgb2gray(im2);
[rows_1, columns_1] = size(im_black_1);
[rows_2, columns_2] = size(im_black_2);

[A1L1,H1L1,V1L1,D1L1] = swt2(im_black_1,1,'sym2');
[A2L1,H2L1,V2L1,D2L1] = swt2(im_black_2,1,'sym2');

% fusion start
AfL1 = 0.5*(A1L1+A2L1);
D = (abs(H1L1)-abs(H2L1))>=0;
HfL1 = D.*H1L1 + (~D).*H2L1;
D = (abs(V1L1)-abs(V2L1))>=0;
VfL1 = D.*V1L1 + (~D).*V2L1;
D = (abs(D1L1)-abs(D2L1))>=0;
DfL1 = D.*D1L1 + (~D).*D2L1;

% fused image
imf = iswt2(AfL1,HfL1,VfL1,DfL1,'sym2');
figure(1);
imshow(im_black_1,[]); title("1st input Image")
figure(2);
imshow(A1L1,[]);
title('Approxiamate component of figure 1');
figure(3);
imshow(H1L1,[]);
title('Horizontal component of figure 1');
figure(4);
imshow(V1L1,[]);
title('Vertical component of figure 1');
figure(5);
imshow(D1L1,[]);
title('Diagnol component of figure 1');
figure(6);
imshow(im_black_2,[]); title("2nd input Image")
figure(7);
imshow(A2L1,[]);
title('Approxiamate component of figure 2');
figure(8);
imshow(H2L1,[]);
title('Horizontal component of figure 2');
figure(9);
imshow(V2L1,[]);
title('Vertical component of figure 2');
figure(10);
imshow(D2L1,[]);
title('Diagnol component of figure 2');
figure(11); 
imshow(imf,[]);
title("Fused Image");
figure(12);
imshow(AfL1,[]);
title('Approxiamate component of fused image');
figure(13);
imshow(HfL1,[]);
title('Horizontal component of fused image');
figure(14);
imshow(VfL1,[]);
title('Vertical component of fused image');
figure(15);
imshow(DfL1,[]);
title('Diagnol component of fused image');
%Error image one
squaredErrorImage_1 = (double(im_black_1) - double(imf)) .^ 2;
figure(16);
imshow(squaredErrorImage_1, []);
title('Squared Error Image for image 1 and fused image');
% Sum the Squared Image and divide by the number of elements
mse_1 = sum(sum(squaredErrorImage_1)) / (rows_1 * columns_1)
PSNR_1 = 10 * log10( 256^2 / mse_1)
CR1=corr2(im_black_1,imf)
%Error image two
squaredErrorImage_2 = (double(im_black_2) - double(imf)) .^ 2;
figure(17);
imshow(squaredErrorImage_2, []);
title('Squared Error Image for image 2 and fused image');
% Sum the Squared Image and divide by the number of elements
mse_2 = sum(sum(squaredErrorImage_2)) / (rows_2 * columns_2)
PSNR_2 = 10 * log10( 256^2 / mse_2)
CR2=corr2(im_black_2,imf)
