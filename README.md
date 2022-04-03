# Text-Classifier-LSTM
This is a text classifier that works well for long text or article. It's a supervised learning with LSTM network, because you have to explain your topics before launching it. 

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////										******								     ///////	
///////							  *README for Classifer Algorithm using LSTM Network *				             ///////
///////							    **Gabriel Gattaux - Erasmus Master 1 - June 2021**					     ///////
///////										******								     ///////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

I) Description of the folders/files
II) How to run/compile


I) Description of the folders/files

	ClassifierLSTM <--- Main Folder
	|       | 
	|	Classified <--- Folder where the files in Data_to_Classified Folder will be write
	|    		|____________________________________________________________________________________________________________
	|		.DatatoCl_CL.txt <--- This file will be created accordingly to the data to classified and the network trained
	|		_____________________________________________________________________________________________________________
	|_______	
	|	|
	|	Data_To_Classify <--- Put here the file in .txt that you want to classify
	|		|____________________________________________________________________________________________________________
	|		.frompoliticodotcom.txt <--- example of file inside the folder to classify, there will be no file when first using
	|		...
	|		...
	|		_____________________________________________________________________________________________________________
	|_______	
	|	|
	|	Data_Train <--- Put here the categorical folder of the files for the Training and Validation
	|		|____________________________________________________________________________________________________________
	|		business <--- categorical folder
	|			|
	|			.b_000.txt <- file
	|			...
	|		sport ...
	|		...
	|		_____________________________________________________________________________________________________________
	|
	|_______	
	|	|
	|	.Plot <--- Folder of the plots I used for the report
	|_______
	|	|
	|	.Main_Driver.m <--- The MAIN DRIVER to RUN, it takes two arguments, QFigure and Trainingprogress
	|_______
	|	|
	|	.preprocessText.m <--- The file which preprocess the data come out from ReadDataSet2.m
	|_______
	|	|
	|	.ReadDataSet2.m <--- Reading the Data from the Data_Train folder
	|_______
	|	|
	|	.readNewReport.m <--- Reading the Data from the Data_To_Classify folder
	|_______
	|	|
	|	.README.txt <--- ThisREADME	
	|_______
	|	|	
	|	.AI_ClassifierLSTM_5.pdf <--- concise report

II) How to run/compile

NECESSARY ADD-ONS : 

	To Run my Driver, you will need 3 ADD-ONS from Mathworks. 
		- Text Analytics Toolbox
		- Deep Learning Toolbox
		- Statistics and Machine Learning Toolbox

To install Add-Ons on matlab you can go to Add-Ons icon on the Home tab of the Toolstrip, Manage Add-Ons and enter in the search bar the Toolbox above. 
Once you have installed all this powerful toolboxs, you can RUN my Main_Driver

	a)WINDOWS

RUN the Driver ".Main_Driver(QFigure,Trainingprogres).m"
The argument pair are QFigure = 1 if you want to show the histogramm, and Trainingprogres = 1 if you want to show the Training Progress plot (which is useful)
In all cases the command prompt will show you some steps computed by the Training Progress. 

	b)LINUX

If you are in the Folder ClassifierLSTM and you don't want to see the Figure and the Training progress plot : 
 ~ matlab -nodisplay -r "Main_Driver 0 0"

	If you want the output log into a log file (useless, the program do the same by his own) : 
	 ~ matlab -nodisplay -r "Main_Driver 0 0"  -logfile output.txt

If you are in the Folder ClassifierLSTM and you want to see the Figure and the Training progress plot : 
 ~ matlab -nodisplay -r "Main_Driver 1 1"

Extra : If you want to change the path for the Data_Train and Data to classify, change the path in the Main_Driver line 19 to 25.

**********************************************************END**********************************************************************
I hope this README.txt will save you some time
