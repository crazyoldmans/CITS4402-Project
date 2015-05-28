%{
cits4402_project.m
Authors:
    Alexander Mazur, 20516281
    Dominic Cockman, 20927611

For the CITS4402 2015 project.
    This code displays a GUI which allows a user to view SIFT-based image
    matching.

    The user can specify scene images for the program to use. Objects will
    be automatically pulled from the local directory in the following path
    structure:
        img/objects/OBJECT_NAME/FRONT.jpg
        img/objects/OBJECT_NAME/OTHER_NAME.jpg
        img/objects/OBJECT_NAME/ETC.jpg

    Scenes will be extracted from:
        img/scenes/SCENE_NAME.jpg

    For further information, see README.md
%}
function project
    warning('off','all');
    [objects, scenes] = init;
    
    gui(objects, scenes);

end