function output = my_imfilter(image, filter)
% This function is intended to behave like the built in function imfilter()
% See 'help imfilter' or 'help conv2'. While terms like "filtering" and
% "convolution" might be used interchangeably, and they are indeed nearly
% the same thing, there is a difference:
% from 'help filter2'
%    2-D correlation is related to 2-D convolution by a 180 degree rotation
%    of the filter matrix.

% Your function should work for color images. Simply filter each color
% channel independently.

% Your function should work for filters of any width and height
% combination, as long as the width and height are odd (e.g. 1, 7, 9). This
% restriction makes it unambigious which pixel in the filter is the center
% pixel.

% Boundary handling can be tricky. The filter can't be centered on pixels
% at the image boundary without parts of the filter being out of bounds. If
% you look at 'help conv2' and 'help imfilter' you see that they have
% several options to deal with boundaries. You should simply recreate the
% default behavior of imfilter -- pad the input image with zeros, and
% return a filtered image which matches the input resolution. A better
% approach is to mirror the image content over the boundaries for padding.

% % Uncomment if you want to simply call imfilter so you can see the desired
% % behavior. When you write your actual solution, you can't use imfilter,
% % filter2, conv2, etc. Simply loop over all the pixels and do the actual
% % computation. It might be slow.
% output = imfilter(image, filter);


%%%%%%%%%%%%%%%%
% Your code here
%%%%%%%%%%%%%%%%
filter_size = size(filter);

% perform checks on input size
if (isequal(mod(filter_size,2), [1 1]))
    % input filter has odd integer dimensions, so continue with filtering
    image_size = size(image);
    pad_size = (filter_size - 1) / 2;
    % pad the input image as per filter size
    %padded_image = padarray(image, pad_size, 'symmetric');
    padded_image = my_padarray(image, pad_size, 'symmetric');
    
    % initialize output
    output = zeros(image_size);
    % perform convolution
    for i=1:image_size(1)
        for j=1:image_size(2)
            % looping through each pixel
            for k=1:filter_size(1)
                for l=1:filter_size(2)
                    for c=1:image_size(3)
                        output(i, j, c) = output(i, j, c) + padded_image(i+k-1, j+l-1, c) .* filter(k, l);
                    end
                end
            end
        end
    end
else
    % input filter has at least one even integer dimension, terminate filtering
    error('Input filter has invalid dimensions!');
end