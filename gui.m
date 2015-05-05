%{
gui.m
By Alexander Mazur, 20516281
For the CITS4402 2015 project
    This code displays a GUI which allows a user to view SIFT-based image
    matching.

    The code specifies the textual, image and button elements, and provides
    controls for user interaction.
%}
function gui(objects, scenes)
    % Initialise GUI
    f        = figure( ...
                'Visible',  'off', ...
                'Position', [0, 0, 800, 500] ...
               );
           
    % Initialise button elements       
    hbtn1    = uicontrol( ...
                'Style',    'pushbutton', ...
                'String',   'Nothing!', ...
                'Position', [20, 400, 120, 30], ...
                'Callback', {@load_button_Callback} ...
               );

    % Initialise popup menu element
    hpop1     = uicontrol( ...
                'Style',    'popup', ...
                'String',   {objects.name}, ...
                'Position', [20, 200, 120, 30], ...
                'Callback', {@obj_popup_Callback} ...
               );
    % Initialise popup menu element
    hpop2     = uicontrol( ...
                'Style',    'popup', ...
                'String',   scenes, ...
                'Position', [20, 300, 120, 30], ...
                'Callback', {@scene_popup_Callback} ...
               ); 
           
    % Initialise text elements
    htxt1    = uicontrol( ...
                'Style',    'text', ...
                'String',   'SIFT Project', ...
                'FontWeight', 'bold', ...
                'FontSize',   11, ...
                'Position', [20, 450, 100, 18] ...
               );
    htxt2    = uicontrol( ...
                'Style',    'text', ...
                'String',   'Select scene:', ...
                'FontSize',   11, ...
                'Position', [20, 350, 100, 18] ...
               );
    htxt3    = uicontrol( ...
                'Style',    'text', ...
                'String',   'Select object:', ...
                'FontSize',   11, ...
                'Position', [20, 250, 100, 18] ...
               );

     % Initialise image elements
	ha1       = axes( ...
                'Units',    'pixels', ...
                'Position', [200,20,560,460], ...
                'Tag',      'ha1' ...
               );
    axis off;
     
    % Initialize the UI.
    % Change units to normalized so components resize automatically.
    f.Units        = 'normalized';
    ha1.Units      = 'normalized';
    hpop1.Units    = 'normalized';
    hpop2.Units    = 'normalized';
    hbtn1.Units    = 'normalized';
    htxt1.Units    = 'normalized';
    htxt2.Units    = 'normalized';
    htxt3.Units    = 'normalized';
 
    % Assign a name to appear in the window title.
    f.Name = 'CITS4402 Project';

    % Move the window to the center of the screen.
    movegui(f,'center')

    % Share GUI elements with callbacks
    tmp = {objects.name};
    cur_obj  = tmp(1);
    cur_scn  = scenes(1);
    guidata(f, struct( ...
        'ha1',     ha1, ...
        'cur_obj', cur_obj, ...
        'cur_scn', cur_scn ...
    ));
    
    % Make the UI visible.
    f.Visible = 'on';
    
    function load_button_Callback(source, eventdata) 
    % Load new image in ha1 and im1
        data = guidata(source);
 
        %[filename, pathname] = uigetfile({'*'},'File Selector');
        %im1 = imread(strcat(pathname ,filename));
        
        guidata(source, data);
    end

    function obj_popup_Callback(source, eventdata)
    % Apply colour segmentation to im1 with the specified thresholds and 
    % store the result in im2, then display in ha2
        data = guidata(source);

        cur_obj = source.String{source.Value};
        scene(cur_obj, cur_scn, objects, data);
        
        guidata(source, data);
    end

    function scene_popup_Callback(source, eventdata)
    % Apply colour segmentation to im1 with the specified thresholds and 
    % store the result in im2, then display in ha2
        data = guidata(source);
        
        cur_scn = source.String{source.Value};
        scene(cur_obj, cur_scn, objects, data);
        
        guidata(source, data);
    end

end