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
function overlay(im1, im2, des1, loc1, loc2, match, data)
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
    
    axes(data.ha1);
    
    colormap('gray');
    imagesc(im3);

    hold on;
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
    
    % Draw lines between matching keypoints  
    cols1 = size(im1,2);
    for i = 1: size(des1,1)
        if (match(i) > 0)
            line([loc1(i,2) loc2(match(i),2)+cols1], ...
                [loc1(i,1) loc2(match(i),1)], 'Color', 'c');
        end
    end
    hold off;
    axis off;

end