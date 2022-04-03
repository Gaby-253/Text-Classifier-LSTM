function Dataset = readDataSet2(path)
%readDataSet You have to change the path here if you want to add the
%dataset, path where the press note are put.

disp ('Reading data, Please wait ...');

%%%%% Path of the topics press notes
addpath(path(1));
addpath(path(2));
addpath(path(3));
addpath(path(4));
addpath(path(5));
%%%%%

count = 0 ;
for a=1:5
    
if a==1
        topicsint = 'business';
    elseif a==2
        topicsint = 'sport';
    elseif a==3
        topicsint = 'entertainment';
    elseif a==4
        topicsint = 'tech';
    elseif a==5
        topicsint = 'politics';
    end
            
    str = "Data_Train\" + topicsint + "\*.txt";
    dinfo = dir(str);
    
    for K = 1 : length(dinfo)
        count= count+1;
        
        thisfilename = dinfo(K).name;  %just the name
        
        fid = fopen(thisfilename);
       
        str = extractFileText(thisfilename);
        
        %data = split(str,newline);
        data(count) = str;
        Category(count) = string(topicsint);
        fclose(fid);
    end
    Dataset = table(data',Category','VariableNames',{'DataPress','Category'});


end
disp ('Reading complete ! ');
end

