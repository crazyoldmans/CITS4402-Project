%{
scene.m
Authors:
    Alexander Mazur, 20516281
    Dominic Cockman, 20927611

For the CITS4402 2015 project.
    This function looks calls the MATLAB functions provided in the SIFT
    demo in order to find if an object exists in a scene.

    The function tests a variety of inputted images against a scene, and
    returns the image that has the greatest match.

    Parts of this function were extracted and modified from match.m,
    provided in the SIFT demo.
%}
function scene(obj, scn, objects, data)

    addpath('sift');
    
    %[image, descrips, locs] = sift('img/scenes/scene.pgm');
    %showkeys(image, locs);

    tmp_obj  = objects( strcmp({objects.name}, obj) );
    tmp_nums = cell(1, length(tmp_obj.images));
    
    scn_str = strcat('img/scenes/', scn);

    if (length(tmp_obj.images) > 0)
        for i=1:length(tmp_obj.images)
            data.txt4.String = ['Processing ', num2str(i), '/', num2str(length(tmp_obj.images))];
            drawnow
            obj_str = strcat('img/objects/', obj, '/', tmp_obj.images(i));
            tmp_nums{i} = match_mod(char(obj_str), char(scn_str));
        end
     
        [m,i] = max(cell2mat(tmp_nums));
        obj_str = strcat('img/objects/', obj, '/', tmp_obj.images(i));
        [num, des1, des2, loc1, loc2, match] = match_mod(char(obj_str), char(scn_str));
        
        % Draw both images with lines connecting matched keypoints
        im1 = imread(char(obj_str));
        im2 = imread(char(scn_str));
        im3 = appendimages(im1,im2);

        axes(data.ha1);
        
        colormap('gray');
        imagesc(im3);
        hold on;
        cols1 = size(im1,2);
        for i = 1: size(des1,1)
          if (match(i) > 0)
            line([loc1(i,2) loc2(match(i),2)+cols1], ...
                 [loc1(i,1) loc2(match(i),1)], 'Color', 'c');
          end
        end
        hold off;
        axis off;

        data.txt4.String = ['Found ', num2str(num), ' matches.'];
        
    end

end
