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
%}
function scene(obj, scn, objects, data)

    addpath('sift');

    %[image, descrips, locs] = sift('img/scenes/scene.pgm');
    %showkeys(image, locs);

    tmp_obj = objects( strcmp({objects.name}, obj) );

    %if (length(tmp_obj.images) > 0)
    %    for i=1:length(tmp_obj.images)
    %        obj_str = strcat('img/objects/', obj, '/', tmp_obj.images(i)); 
            obj_str = strcat('img/objects/', obj, '/', tmp_obj.images{1});
            scn_str = strcat('img/scenes/', scn{1});
            
            num = match(obj_str, scn_str, data)
            
    %    end
    %end

end
