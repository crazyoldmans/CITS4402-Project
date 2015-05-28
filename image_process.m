function image_process(filepath)
    i = imread(filepath);
    grey = rgb2gray(i);
    %uncomment for very large images
    resized = imresize(grey, 0.5);
    %resized = grey;
    fnames = strsplit(filepath, '.');
    fnames = strcat(fnames{1}, '.pgm');
    imwrite(resized, ['compressed_' fnames]);
end