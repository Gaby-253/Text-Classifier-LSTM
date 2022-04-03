function [data,filename] = readnew()
%readDataSet You have to change the path here if you want to add the
%dataset, path where the press note are put.

    addpath("Data_To_Classify");
    
    str = "Data_To_Classify\*.txt";
    
    dinfo = dir(str);
    
    for K = 1 : length(dinfo)
        
        thisfilename = dinfo(K).name;  %just the name
        filename(K,1) = string(thisfilename);
        fid = fopen(thisfilename);
        str = extractFileText(thisfilename);
        data(K) = str;
        fclose(fid);
    end

end

