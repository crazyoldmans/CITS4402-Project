%{
scene_all.m
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
function detected_obj = scene_all(scn, objects, data)

    addpath('sift');
    scn_str = strcat('img/scenes/', scn);
    
    detected_obj = {};
    
    if (length({objects.name}) > 0)
        for j=1:length({objects.name})
            if (length(objects(j).images) > 0)
                for i=1:length(objects(j).images)
                    data.txt4.String = ['Processing ', num2str(i), '/', num2str(length(objects(j).images)), ...
                        ' of ', num2str(j), '/', num2str(length({objects.name}))];
                    drawnow
                    
                    obj_str = strcat('img/objects/', objects(j).name, '/', objects(j).images(i));
                    num = match_mod(char(obj_str), char(scn_str));

                    if (num > 0)
                        detected_obj{end+1} = objects(j).name;
                        break
                    end
                end
            end
        end
        
    data.txt4.String = ['Found ', length(detected_obj), ' matching objects.'];
    
end
