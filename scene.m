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
function scene(obj, scn, objects, scenes, data)
    data.txt4.String = 'Processing ';
    drawnow

    addpath('sift');
    
    tmp_obj  = objects( strcmp({objects.name}, obj) );
    tmp_scn  = scenes( strcmp({scenes.name}, scn) );
    tmp_nums = cell(1, length(tmp_obj.images));
    
    scn_str = strcat('img/scenes/', tmp_scn.name);

    if (~isempty(tmp_obj.images))
        for i=1:length(tmp_obj.images)
            tmp_nums{i} = match_mod(tmp_obj.desc{i}, tmp_scn.desc);
        end
     
        [~,i] = max(cell2mat(tmp_nums));
        obj_str = strcat('img/objects/', obj, '/', tmp_obj.images(i));
        [num, match] = match_mod(tmp_obj.desc{i}, tmp_scn.desc);
        
        % Draw both images with lines connecting matched keypoints
        im1 = imread(char(obj_str));
        im2 = imread(char(scn_str));
        im3 = appendimages(im1,im2);

        des1 = tmp_obj.desc{i};
        loc1 = tmp_obj.loc{i};
        loc2 = tmp_scn.loc;
        
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
