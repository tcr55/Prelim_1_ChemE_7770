#test for test_for_working

#Change_matrix

# This matrix is used to define which values I want to change when,
# Each row corresponds to a "system" which is to say the set of parameters used
# Each column corresponds to the parameter (18 parameters)

# for example C_M[1,2] is inside "system" 1
#                      parameter 2 is kept at state 1 (or given)

# If the value is a 2, this corresponds to a decrease in the given parameter
# If the value is a 3, the parameter is increased 
# Specific values that it chooses are in the parameters_for_number_2_prelim file
C_M = [ 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
        2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
        3 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
        1 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
        1 3 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
        1 1 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
        1 1 3 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
        1 1 1 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1
        1 1 1 3 1 1 1 1 1 1 1 1 1 1 1 1 1 1
        1 1 1 1 2 1 1 1 1 1 1 1 1 1 1 1 1 1
        1 1 1 1 3 1 1 1 1 1 1 1 1 1 1 1 1 1
        1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 1 1 1
        1 1 1 1 1 3 1 1 1 1 1 1 1 1 1 1 1 1
        1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 1 1
        1 1 1 1 1 1 3 1 1 1 1 1 1 1 1 1 1 1
        1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 1
        1 1 1 1 1 1 1 3 1 1 1 1 1 1 1 1 1 1
        1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1
        1 1 1 1 1 1 1 1 3 1 1 1 1 1 1 1 1 1
        1 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1
        1 1 1 1 1 1 1 1 1 3 1 1 1 1 1 1 1 1
        1 1 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1
        1 1 1 1 1 1 1 1 1 1 3 1 1 1 1 1 1 1
        1 1 1 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1
        1 1 1 1 1 1 1 1 1 1 1 3 1 1 1 1 1 1
        1 1 1 1 1 1 1 1 1 1 1 1 2 1 1 1 1 1
        1 1 1 1 1 1 1 1 1 1 1 1 3 1 1 1 1 1
        1 1 1 1 1 1 1 1 1 1 1 1 1 2 1 1 1 1
        1 1 1 1 1 1 1 1 1 1 1 1 1 3 1 1 1 1
        1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 1 1 1
        1 1 1 1 1 1 1 1 1 1 1 1 1 1 3 1 1 1
        1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 1 1
        1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 3 1 1
        1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 1
        1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 3 1
        1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2
        1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 3 ];
