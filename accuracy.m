%finds the accuracy of the algorithm as a percentage of correct objects 
%found over the number of objects in the scene

function acc = accuracy( detected_obj, scn)

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
