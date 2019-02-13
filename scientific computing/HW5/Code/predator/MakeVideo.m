function[] = MakeVideo(T,X,Y)
%A simple code to generate videos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Part I - save the frames



nt=length(T);
color = ['k*','r+','bs','go','mh'];
figure
grid off
for it = 1:nt
    
    
    plot(X(1,it),Y(1,it),'k*')
    hold on
    plot(X(2,it),Y(2,it),'r+')
    hold on
    plot(X(3,it),Y(3,it),'bs')
    hold on
    plot(X(4,it),Y(4,it),'go')
    hold on
    plot(X(5,it),Y(5,it),'mh')
    hold on
    
    %end
    hold off
    axis([-30 10 -20 20])
    axis off
    drawnow
    
    print(['frame' num2str(it,'%5.5i')],'-djpeg90')
    
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
