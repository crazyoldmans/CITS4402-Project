%{
init.m
Authors:
    Alexander Mazur, 20516281
    Dominic Cockman, 20927611

For the CITS4402 2015 project.
    This function looks through the 'img' folder and detects what images
    are available for sift detection. It ouputs a data structure containing
    all objects and their corresponding image file names.

    To use the object data structure:
        objects = init
        length(objects)        % Number of objects found
        objects(1)             % Name and image file names for the first object
        objects(1).name        % The name of the first object
        objects(1).images      % An array of image file names for the first object
        {objects.name}         % An array of the names of all objects

    A second array containing all the detected scene images is also given.
%}
function [objects, scenes] = init
    objects_dir = dir('img/objects');

    % Error if no objects found
    if length(objects_dir) <= 2
        error('Found no objects inside img/objects. Place object image files inside img/objects/OBJECT_NAME/IMAGE_NAME.jpg.')
    end
    
    object_names = cell(1, length(objects_dir)-2);
    image_names = cell(1, length(objects_dir)-2);
    
    % Scan each folder in the img/objects directory
    for i=3:length(objects_dir)
        object_names{i-2} = objects_dir(i).name;

        img_dir = dir( strcat('img/objects/', objects_dir(i).name) );

        % If the object has images, add them to the data structure
        if length(img_dir) > 2
            images = cell(1, length(img_dir)-2);
            
            for j=3:length(img_dir)
                images{j-2} = img_dir(j).name;
            end
            
            image_names{i-2} = images;
        end
    end
    
    objects = struct('name', object_names, 'images', image_names);
    
    % Now find all the scenes
    scenes_dir = dir('img/scenes');
    
    % Error if no scenes found
    if length(scenes_dir) <= 2
        error('Found no scenes inside img/scenes. Place scene image files inside img/scenes/SCENE_NAME.jpg.')
    end
    
    scenes = cell(1, length(scenes_dir)-2);
    for i=3:length(scenes_dir)
        scenes{i-2} = scenes_dir(i).name;
    end
    
end
