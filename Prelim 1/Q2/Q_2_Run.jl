#Run.jl

#primary run file, will run all of the parts at once and display the key results

# the InD this is to fix a issue with how my code was written
global InD = 1

#include the files that run the problem, must be run in this order
include("parameters_for_number_2_prelim.jl")
include("Change_matrix.jl")
include("PS_2_modification_for_prelim.jl")
include("Sensitivity_for_prelim.jl")
include("Sorting_Run.jl")





# The Generated plot is for part A, and plots the Protein Levels as a function of time
# Inducer was added at the 120 minute mark (60 minutes after an assumed steady state)

#Plot for part A
plot(t_Final_end,Variation_matrix[:,1,1],"red",linewidth=2, linestyle="--")
plot(t_Final_end,Variation_matrix[:,2,1],"green",linewidth=2, linestyle="--")
plot(t_Final_end,Variation_matrix[:,3,1],"blue",linewidth=2, linestyle="--")



# Restatment of the Readme for Problem 2



# The Generated plot is for part A, and plots the Protein Levels as a function of time
# Inducer was added at the 120 minute mark (60 minutes after an assumed steady state)





# Part 2 asks for the sensitivity coefficents for each parameter as a fucntion
#  of time for three time phases
# these are stored as

# Sensitivity_Matrix_Phase_1        (before inducer addtion)
#        for the sensitivity of states (rows i) (proteins) to
#        the parameters (columns j) (parameter/given values)

# Sensitivity_Matrix_Phase_2e       (early inducer addtion)
#        for the sensitivity of states (rows i) (proteins) to
#        the parameters (columns j) (parameter/given values)

# Sensitivity_Matrix_Phase_2l       (late indcer addtion)
#        for the sensitivity of states (rows i) (proteins) to
#        the parameters (columns j) (parameter/given values)

# These were taken to have a 20 minute window, so they will then be a 3x18x20 array
# each Z axis slice of the array is a time point slice with the sensitivites at that slice

# To view them, type the full name into the command line, note they will be
# shortened to fit into the display









# Part 3 takes the sensitivity matrix and turns it into a time averaged form following
#      the Trapezoidal rule for integration
#
# The files Sensitivity_for_prelim and Sorting_Run are required here
# The Time matrixes are named as follows

#       Time_Averaged_Sensitivity_Matrix_Phase_1
#       Time_Averaged_Sensitivity_Matrix_Phase_2e
#       Time_Averaged_Sensitivity_Matrix_Phase_2l

# These are then run through SVD in the Sensitivity_for_prelim file
# Resulting U,V,S matrixes are generated, wherein we are told to take the first column absolute value
# The U values are then fed to a Dictionary file called Importance
#       note this is done in succession so Importance will only contain the last Phases assingments
# The values are rank ordered, with the strings indicating which species are which
#
#

# The resulting Ranked Matrixes for the U column absoluted and ordered are as follows

# Ranked_Importnace_Phase_1        (no inducer addtion species importance)

# Ranked_Importnace_Phase_2e       (early inducer species importance)

# Ranked_Importnace_Phase_2l       (Late inducer species importance)
