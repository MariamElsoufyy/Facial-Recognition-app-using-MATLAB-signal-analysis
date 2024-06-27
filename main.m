clc
clear
% Student 1 : Mariam Mohammed ELsoufy 1210115
% Student 2 : Mostafa Ahmed Abdelfattah 1210306
% Student 2 : Ahmed Ayman Wahdan

 

commonSize = [500, 500]; %to resize the images into one size
avgVectors = cell(1, 3); %to store the avg vector of each student
truedetectiontimes=[0,0,0];    %no. of the true detection times

studentnames={'Mariam','Mostafa','Ahmed'};
for student= 1:3
    studentTrainData = cell(1, 10); % Cell array to store images for each student
    
    for image = 1:10
        % Read the image
        img = imread(['D:\Coding\SignalsProject\photos\' num2str(student) '_image' num2str(image) '.jpg']);
         %please change the path into the path of the folder on your
         %computer before running
        img = imresize(img, commonSize); %resize the image
        studentTrainData{image}=img(:); %convert it into column vector
    end
    
    % Initialize the average vector
    avgVector = zeros(size(studentTrainData{1,student}));
    
    % Sum up all the vectors
    for image = 1:10
        avgVector = avgVector + double(studentTrainData{1,image});
    end
    
    % Calculate the average
    avgVector = uint8(avgVector / 10); % there are 10 images for each student
    
    % Store the average vector for the current student
    avgVectors{1,student} = avgVector;
    
end


testimages= cell(5,3);
%testimage cell array format
% s1 s2 s3
% s1 s2 s3
% s1 s2 s3
% s1 s2 s3
% s1 s2 s3

% reading test images
for student= 1:3
    for image = 11:15
        % Read the image
        img = imread(['D:\Coding\SignalsProject\photos\' num2str(student) '_image' num2str(image) '.jpg']);
        img = imresize(img, commonSize); %resize the image
        testimages{image-10,student}=img(:); %convert it into column vector
    end
end


finalresults =zeros(5,3);


for student= 1:3
    fprintf('\n Output for test %d \n',student)
    for image = 1:5
        distance=[]; %storing the distance between each avg vector for each student and the current image
        for student2= 1:3
            
            imagevector=double(testimages{image,student});
            avgvector=double(avgVectors{1,student2});
            normvector=imagevector-avgvector;
            distance(student2)=norm(normvector);
            
        end
        
        
        minimumdistance=min(distance);
        studentno=find(distance==minimumdistance);
        finalresults(image,student)=studentno;
        
        
        if (studentno==student)
            truedetectiontimes(student)=truedetectiontimes(student)+1;
        end
         fprintf('   {%s}    ',char(studentnames(studentno)))
    end
    
    
end


%calculating and print accuracy for each student and overall accuracy
accuracy =(truedetectiontimes(1)/5)*100;
fprintf('\n \n  Accuracy for Student 1 {Mariam}= %f %% \n',accuracy)
accuracy =(truedetectiontimes(2)/5)*100;
fprintf('\n \n Accuracy for Student 2 {Mostafa} = %f %% \n',accuracy)
accuracy =(truedetectiontimes(3)/5)*100;
fprintf('\n \n Accuracy for Student 3 {Ahmed} = %f %%\n ',accuracy)

accuracy =(sum(truedetectiontimes)/15)*100;
fprintf('\n \n over all Accuracy = %f %%',accuracy)