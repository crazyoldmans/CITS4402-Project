% num = match(image1, image2)
%
% This function reads two images, finds their SIFT features, and
%   displays lines connecting the matched keypoints.  A match is accepted
%   only if its distance is less than distRatio times the distance to the
%   second closest match.
% It returns the number of matches displayed.
%
% Example: match('scene.pgm','book.pgm');
%
% MODIFIED FOR CITS4402 PROJECT

function num = match(image1, image2, data)

% Find SIFT keypoints for each image
[im1, des1, loc1] = sift(image1);
[im2, des2, loc2] = sift(image2);

% For efficiency in Matlab, it is cheaper to compute dot products between
%  unit vectors rather than Euclidean distances.  Note that the ratio of 
%  angles (acos of dot products of unit vectors) is a close approximation
%  to the ratio of Euclidean distances for small angles.
%
% distRatio: Only keep matches in which the ratio of vector angles from the
%   nearest to second nearest neighbor is less than distRatio.
distRatio = 0.6;   

% For each descriptor in the first image, select its match to second image.
des2t = des2';                          % Precompute matrix transpose
for i = 1 : size(des1,1)
   dotprods = des1(i,:) * des2t;        % Computes vector of dot products
   [vals,indx] = sort(acos(dotprods));  % Take inverse cosine and sort results

   % Check if nearest neighbor has angle less than distRatio times 2nd.
   if (vals(1) < distRatio * vals(2))
      match(i) = indx(1);
   else
      match(i) = 0;
   end
end

% Create a new image showing the two images side by side.

for i = 1: size(des1,1)
  if (match(i) > 0)
    z = i;
    break
     
  end
end
for j = z+1: size(des1,1)
    if(match(j) > 0)
        x = j;
        break
    end
end

BW = im2bw(im1);
outline = bwperim(BW);
rowshift = round((loc2(match(z),1) - loc1(z,1)))
colshift = round(((loc2(match(z),2)+size(im1,2))-loc1(z,2)))
scalefactorx = (loc1(x,1) - loc1(z,1))/(loc2(match(x),1)-loc2(match(z),1));
scalefactory = (loc1(x,2) - loc1(z,2))/(loc2(match(x),2)-loc2(match(z),2));
newx = 1/scalefactory*size(outline,1)-0.25;
newy = 1/scalefactorx*size(outline,2)-0.25;
outline = imresize(outline, [newx NaN]);
rowshift = round((loc2(match(z),1) - loc1(z,1))) + size(im1,1) - size(outline,1)
colshift = round(((loc2(match(z),2)+size(im1,2))-loc1(z,2))) + size(im1,2) - size(outline,2)
%paddingc = (size(im1,2) + size(im2,2)) - size(outline,2)
%paddingr = (size(im1,1) + size(im2,1)) - size(outline,1)
out2 = padarray(outline,[abs(size(im1,1) - size(im2,1)) size(im2,2)], 'post');


    
outline(:,2) = outline(:,2) + colshift;
outline(:,1) = outline(:,1) + rowshift;
%T = maketform('affine', [1 0 0; 0 1 0; rowshift colshift 1]);
%im4 = imtransform(outline, T, 'XData',[1 size(outline,2)], 'YData',[1 size(outline,1)]);

im3 = appendimages(im1,im2);
%im3(out2) = 255;



% Show a figure with lines joining the accepted matches.
%axes(data.ha1);
%figure('Position', [100 100 size(im3,2) size(im3,1)]);
colormap('gray');
imagesc(im3);

hold on;
cols1 = size(im1,2);
count = 1;
for x = 2:size(out2,1)-2
    for y  = 2:size(out2,2)-2
        if out2(x,y) == 1
            %im3(x + rowshift,y + colshift) = 255;
            ylist(count) = x + rowshift;
            xlist(count) = y + colshift;
            count = count + 1;
        end
    end
end

scatter(xlist, ylist, 5, 'green', 'filled')

for i = 1: size(des1,1)
  if (match(i) > 0)
    line([loc1(i,2) loc2(match(i),2)+cols1], ...
         [loc1(i,1) loc2(match(i),1)], 'Color', 'c');
     
  end
end
hold off;
num = sum(match > 0);
fprintf('Found %d matches.\n', num);




