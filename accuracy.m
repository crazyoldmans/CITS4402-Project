%{
accuracy.m
By Alexander Mazur, 20516281
For the CITS4402 2015 project
    This function takes in a list of detected objects, a properly formatted
    scene string, and a total number of available objects, and outputs the
    accuracy of the detection as a number between 0 and 100.

    Scenes filenames must be formatted as follows for this function to be
    effective:
        prefix-object1_object2_..._objectn.pgm

    Where object1, object2, ... are the names of each object inside the
    scene. A prefix must be attached, and the dash '-' and underscore '_'
    characters cannot be used elsewhere in the filename.
%}
function acc = accuracy(detected_obj, scn, number_obj)
    if ~isempty(strfind(scn, 'nothing'))
        acc = 100;
    elseif ~isempty(strfind(scn, 'everything'))
        acc = 100 * length(detected_obj) / number_obj;
    else
        hyph = strsplit(scn, '-');
        if length(hyph) >1
            pgm = strsplit(hyph{2}, '.');
            tmp = strsplit(pgm{1},'_');
            count = 0;
            for i = 1:length(detected_obj)
                for j = 1:length(tmp)
                    if strcmp(tmp{j},detected_obj{i})
                        count  = count+1;
                    end
                end
            end
            acc = 100 * count/length(tmp);
        else
            acc = 0;
        end
    end
end
