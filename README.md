The data included in this dataset were derived from data collected from smartphone accelerometers and gyroscopes. It was gathered by:
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

The original data set, and more complete information about data collection and other details can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.


The script run_analysis transforms the original data set into a smaller data set including only mean and standard deviation variables. 
This script :
	- downloads and unzips the complete data set
	- combines the train and test sets to create a complete set of all collected observations
	- eliminates all variables that are not mean or standard devation values for measurements (mean frequencies and angular means were not considered to be means of measurements, so were also excluded)
	- updates activity names for greater readibility
	- updates variable names for greater readibility
		+ CamelCase was used instead of all lower case to increase clarity and readability of the lengthy variable names
	- creates a separate data set including mean values for each variable and each combination of subject and activity
	- writes this smaller data set into a text file for later use

To run this script, the package reshape2 is required. If the original data set is downloaded, unzipped, and located in the working directory users can skip download and unzip steps as noted in the comments in the script.