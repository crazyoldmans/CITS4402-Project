function acc = accuracy( detected_obj, scn  )

    tmp = strsplit(scn{1},'-');
    
    b = strcmp({'flat','white','shelf'}, tmp(1))
       
    if any(b(:))    
        'hey'
    end
        
    acc=1;

end
