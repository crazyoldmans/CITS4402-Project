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
        objects(1).desc        % SIFT - The keypoint descriptors for this image
        objects(1).loc         % SIFT - The keypoint locators for this image
        {objects.name}         % An array of the names of all objects

    A second array containing all the detected scene images is also given:
        scenes(1).name
        scenes(1).desc
        scenes(1).loc
%}
function [objects, scenes] = init

    % Progress bar!
    h = waitbar(0,'Pre-calculating training data from objects and scenes. Please wait...');
    steps = 1000;
    waitbar(0 / steps)

    addpath('sift');

    objects_dir = dir('img/objects');

    % Error if no objects found
    if length(objects_dir) <= 2
        error('Found no objects inside img/objects. Place object image files inside img/objects/OBJECT_NAME/IMAGE_NAME.jpg.')
    end
    
    object_names = cell(1, length(objects_dir)-2);
    image_names  = cell(1, length(objects_dir)-2);
    objects_desc = cell(1, length(objects_dir)-2);
    objects_loc  = cell(1, length(objects_dir)-2);
    
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
            
             % Now run SIFT on the objects to get the keypoint data
            tmp_locs  = cell(1, length(images));
            tmp_descs = cell(1, length(images));
            for j=1:length(images)
                obj_str = strcat('img/objects/', objects_dir(i).name, '/', images(j));
                [tmp_descs{j}, tmp_locs{j}] = sift(char(obj_str));
            end
            objects_desc{i-2} = tmp_descs;
            objects_loc{i-2}  = tmp_locs;
        end
        
        step = 500 * (i-3) / (length(objects_dir)-3);
        waitbar( step / steps)
    end
    
    objects = struct('name', object_names, 'images', image_names, ...
        'desc', objects_desc, 'loc', objects_loc);
    
    % Now find all the scenes
    scenes_dir = dir('img/scenes');
    
    % Error if no scenes found
    if length(scenes_dir) <= 2
        error('Found no scenes inside img/scenes. Place scene image files inside img/scenes/SCENE_NAME.jpg.')
    end
    
    scene_names = cell(1, length(scenes_dir)-2);
    scenes_desc = cell(1, length(scenes_dir)-2);
    scenes_loc  = cell(1, length(scenes_dir)-2);
    
    for i=3:length(scenes_dir)
        scene_names{i-2} = scenes_dir(i).name;
        
        % Run SIFT on the scene
        scn_str = strcat('img/scenes/', scenes_dir(i).name);
        [scenes_desc{i-2}, scenes_loc{i-2}] = sift(char(scn_str));
        
        step = 500 + 500 * (i-3) / (length(objects_dir)-3);
        waitbar( step / steps)
    end
    
    scenes = struct('name', scene_names, 'desc', scenes_desc, 'loc', scenes_loc);
    
    % Finish progress bar
    close(h) 
end
