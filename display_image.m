%{
display_image.m
By Alexander Mazur, 20516281
For the CITS4402 2015 project
    This function takes in two images and their corresponding SIFT keypoint
    data, and then displays them to the GUI. It also overlays blue lines to
    connect the matching keypoints, and an edge-detection based overlay of
    the detected image.
%}
function display_image(im1, im2, des1, loc1, loc2, match, data)
    % Calculate the affine transformations necessary to move the outline
    %of the object of concern over on to the scene image

    x = 0;
    f = 0;
    
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
    for p = j+1: size(des1,1)
        if(match(j) > 0)
            f = p;
            break
        end
    end
    
    %if there are sufficient key point matches, begin calculating the 
    %required transformations for the outline
    if x ~= 0 && f~=0 && z ~= size(des1,1) && x ~= size(des1,1) && f ~= size(des1,1)
        
        BW = im2bw(im1);
        outline = bwperim(BW);
        rowshift = round((loc2(match(z),1) - loc1(z,1)));
        colshift = round(((loc2(match(z),2)+size(im1,2))-loc1(z,2)));
        scalefactorx = (loc1(x,1) - loc1(z,1))/(loc2(match(x),1)-loc2(match(z),1));
        scalefactory = (loc1(x,2) - loc1(z,2))/(loc2(match(x),2)-loc2(match(z),2));
        newx = abs(1/scalefactory*size(outline,1)-0.25);
        newy = abs(1/scalefactorx*size(outline,2)-0.25);
        if 1/scalefactory*size(outline,1)-0.25 < 0
            outline = flipud(outline);
        end
        if 1/scalefactorx*size(outline,2)-0.25 < 0
            outline = fliplr(outline);
        end
        outline = imresize(outline, [newx NaN]);
        rowshift = round((loc2(match(z),1) - loc1(z,1))) + size(im1,1) - size(outline,1);
        colshift = round(((loc2(match(z),2)+size(im1,2))-loc1(z,2))) + size(im1,2) - size(outline,2);

        out2 = padarray(outline,[abs(size(im1,1) - size(im2,1)) size(im2,2)], 'post');

        outline(:,2) = outline(:,2) + colshift;
        outline(:,1) = outline(:,1) + rowshift;

    %append the two target images
        im3 = appendimages(im1,im2);

        axes(data.ha1);

        colormap('gray');
        imagesc(im3);

        hold on;
        count = 1;
        xlist = [];
        ylist = [];
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
    else
        im3 = appendimages(im1,im2);
        imagesc(im3);
        axis off;
    end
end