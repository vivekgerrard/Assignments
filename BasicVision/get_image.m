function [ image ] = get_image( vrhandle )
% GET_IMAGE Obtain an image from a virtual world handle
vrdrawnow;
pause(0.1); %% Necessary to allow drawing to finish
image = capture(vrhandle);

end

