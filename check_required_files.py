import os
import sys

#List of required files
required_files= ['README.md', '.gitignore'] 

#Track the missing files
missing_files=[]

#Check each required file
for filename in required_files:
    if not os.path.isfile (filename):
        missing_files.append(filename)

#Print missing and exit with code 1.
if missing_files:
    print("Missing required file:") 
    for filename in missing_files:
        print("- " + filename)

    #Exit with code 1 to show there was a problem.
    sys.exit(1)
else:
    #If not files are missing, print success.
    print("All required files are present!")

    #Exit with code 0 to show success.
    sys.exit(0)




