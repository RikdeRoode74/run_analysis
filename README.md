#CleanPhoneData

CleanPhoneData is a R-script which downloads and tidies a dataset containing measurements of subjects using a a mobile device.

The original dataset can be found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
And it's description can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The script (CleanPhoneData.R) can be found on github at the following address: https://github.com/RikdeRoode74/run_analysis

# working
First the dataset is downloaded and unzipped in a working directory
The dataset is seperated in several related files, only some of which are useful for our purposes.
The script reads those files, combines and aggregates them to a single dataset which is written back as a simple CSV-file in the working directory named: tidyPhoneData.csv.

Details of the working of the script can be found in comments in the script itself (in combination with the code)
A description of the resulting file can be found in the CodeBook.md file