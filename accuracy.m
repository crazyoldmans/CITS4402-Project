function acc = accuracy( detected_obj, scn)

    hyph = strsplit(scn, '-');
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
      
    acc=count/length(tmp);

end
