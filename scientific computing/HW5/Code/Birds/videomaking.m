function[] = videomaking(T,X,Y)
% X(1,1) is bird 1 first time step
% X(1,2) is bird 1 second time step
% X(2,1) is bird 2 first time step
% X(2,2) is bird 2 second time step
% ...
% same with Y

nt=length(T);
color = ['r*','go','bv','rd','bh'];
figure
grid off
for j = 1:nt
    %for i = 1:1
     plot(X(nt),Y(nt),color(1))
     %hold on
    %end
    
    axis([-2 2 -2 2])
    axis off
    drawnow
    
    print(['frame' num2str(j,'%5.5i')],'-djpeg90')
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Part II - create video
images    = cell(nt,1);
for i=1:nt
   
   image=['frame' num2str(i,'%5.5i') '.jpg'];
   images{i} = imread(image);
end

 % create the video writer with 1 fps
 writerObj = VideoWriter('myVideo.avi');
 writerObj.FrameRate = 5; %5 frames per second

 % set the seconds per image
 secsPerImage = ones(nt,1);

 % open the video writer
 open(writerObj);

 % write the frames to the video
 for u=1:length(images)
     % convert the image to a frame
     frame = im2frame(images{u});
     writeVideo(writerObj, frame);
 end

 % close the writer object
 close(writerObj);
