%{
scene_all.m
Authors:
    Alexander Mazur, 20516281
    Dominic Cockman, 20927611

For the CITS4402 2015 project.
    This function looks calls the MATLAB functions provided in the SIFT
    demo in order to find if an object exists in a scene.

    The function tests every single object in the database against the
    given scene, and then updates the GUI with a list of matched objects
    and an accuracy rating.
%}
function detected_obj = scene_all(scn, objects, scenes, thrs, data)

    tmp_scn  = scenes( strcmp({scenes.name}, scn) );

    addpath('sift');
    
    detected_obj = {};
    
    if (length({objects.name}) > 0)
        % Compare each image associated with each object with the scene
        for j=1:length({objects.name})
            if (length(objects(j).images) > 0)
                for i=1:length(objects(j).images)
                    data.txt4.String = ['Processing ', num2str(j), '/', ...
                        num2str(length({objects.name}))];
                    drawnow
                    
                    num = match_mod(objects(j).desc{i}, tmp_scn.desc);

                    if (num > thrs)
                        detected_obj{end+1} = objects(j).name;
                        break
                    end
            	end
            end
        end
    	acc = accuracy(detected_obj, scn);
        data.txt4.String = ['Found ', num2str(length(detected_obj)), ' matching objects. Accuracy: ', num2str(acc), '%'];
    end
end
