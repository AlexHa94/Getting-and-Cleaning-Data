The site where data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Dataset for project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

run_analysis.R performs the following steps (can be complemented with comments from script):
	1. Reads in features.txt, subsetting "mean" and "std" and storing the subsequent data in meansStdFeatures
	2. Reads in X_train.txt and X_test.txt, and appends one on to the other, creating allX
	3. The data in the second column in meansStdFeatures is transposed onto the column names in allX
	4. Reads in subject_train.txt and subject_test.txt and appends one to the other, creating allSubject
	5. Reads in Y_test.txt and Y_train.txt and appends one to the other, creating allY
	6. Combines allX, allY, and allSubject. This results in combinedData
	7. The first and second column in combinedData is renamed to "Subject" and "Y" respectively
	8. Reads in activity_labels.txt and assigns it to activities
	9. Assigns the values in "Y", which range from 1-6, to their respective activities
	10. Aggregates columns 3 - 81 and averages them according to unique rows
	11. End result is dataset called "tidy"