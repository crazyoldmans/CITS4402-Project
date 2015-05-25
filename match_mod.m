function [ num, des1, des2, loc1, loc2, match ] = match_mod( image1, image2 )
%MATCH_MOD Summary of this function goes here
%   Detailed explanation goes here
	
    distRatio = 0.6;

    [des1, loc1] = sift(image1);
	[des2, loc2] = sift(image2);

	des2t = des2';
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

