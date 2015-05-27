%{
match_mod.m
Authors:
    Alexander Mazur, 20516281
    Dominic Cockman, 20927611

For the CITS4402 2015 project.
    This function takes a pair of SIFT descriptors and returns both the
    number of matches and matches themselves.

    This function is sourced heavily from the match.m file accompanying the
    SIFT demo.
%}
function [ num, match ] = match_mod( des1, des2 )
    distRatio = 0.6;
    
	des2t = des2';
    match = zeros(1, size(des1,1));
	for i = 1 : size(des1,1)
        dotprods = des1(i,:) * des2t;
        [vals,indx] = sort(acos(dotprods));

        if (vals(1) < distRatio * vals(2))
            match(i) = indx(1);
        else
            match(i) = 0;
        end
	end

	num = sum(match > 0);
end

