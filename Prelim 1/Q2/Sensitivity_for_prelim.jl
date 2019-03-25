#Sensitivity Coefficent Generation



#estimated sensitivity coefficent using central difference method
#sensitivity coefficent
# S_i_j = (P_j / x_i) * { (x_i_high - x_i_low) / 2 * (P_j - P_original)

#sensitivity is a function of time, so three windows of values are called
#Phase 1       = no inducer                   (30 minute to 50 minute window)
#Phase 2 Early = early inducer addition       (210 to 240 minute window)
#Phase 3 Late  = late effects                 (390 to 410 minute window)





# Include the parameters in the workspace to run

include("parameters_for_number_2_prelim.jl")

# include the change matrix to allow for the interation over different parameter changes
# The first row of the change matrix is the base state (no perturbations)

include("Change_matrix.jl")

# intitialize the Variation_matrix
Variation_matrix = zeros(422,3,37)

# perform the Discrete Solver method over differnct parameter conditions (37 different "systems")
for iii = 1:37

    global InD = iii
    # grab the solver file
    include("PS_2_modification_for_prelim.jl")
    # store the protein levels in the matrix as columns (rows are time steps)
    Variation_matrix[:,1,InD] = P1_values
    Variation_matrix[:,2,InD] = P2_values
    Variation_matrix[:,3,InD] = P3_values
end

#generate time windows

# 30 to 50 mintute time window for phase 1
Phase_1_time_start = 30   #minute
Phase_1_time_end   = 50   #minute

# 30 to 50 mintute time window for phase 2 early
Phase_2e_time_start = 210   #minute
Phase_2e_time_end   = 240   #minute

# 30 to 50 mintute time window for phase 2 late
Phase_2l_time_start = 390   #minute
Phase_2l_time_end   = 410   #minute


#sensitivity coefficent generation for 20 minute time windows

#intitialize the sensitivity coefficent arrays
# the letters and numbers after the S_ in the values (i.e P_1_r_1) follow notation as below

# r_1 means row one of the array (ie state 1 or protein 1)
# r_2 means row two of the array (ie state 2 or protein 2), etc for r_3
# P_1 means for Phase 1 (the no inducer time window)
# P_2e is for early inducer addtion and P_2l is for late inducer addition

S_P_1_r_1 = zeros(1,18,20)
S_P_1_r_2 = zeros(1,18,20)
S_P_1_r_3 = zeros(1,18,20)
S_P_2e_r_1 = zeros(1,18,20)
S_P_2e_r_2 = zeros(1,18,20)
S_P_2e_r_3 = zeros(1,18,20)
S_P_2l_r_1 = zeros(1,18,20)
S_P_2l_r_2 = zeros(1,18,20)
S_P_2l_r_3 = zeros(1,18,20)



#index value to allow for a loop, due to the way the parameter changes were stored
# it went
# Original x, Low x, High x, Low y, high y ......
# Where x,y,... were the parameters,
# so the i_in is needed to grab orginal values without grabbing a modified one
i_in = [1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18]

# Get the sensitivites for Phase 1, at the 20 minute time window
for t = 1:20

    for rl = 1:2:35
    S_P_1_r_1[1,i_in[rl],t] = ((Parameter_original[rl] )/ Variation_matrix[t + 30,1,1] ) * ( Variation_matrix[t+7,1,(rl+2)] - Variation_matrix[t+7,1,(rl+1)] ) / ( 2*(Steps_size[rl]) )
    S_P_1_r_2[1,i_in[rl],t] = ((Parameter_original[rl])/Variation_matrix[t+30,2,1] ) * (Variation_matrix[t+7,2,(rl+2)] - Variation_matrix[t+7,2,(rl+1)])/(2*(Steps_size[rl]))
    S_P_1_r_3[1,i_in[rl],t] = ((Parameter_original[rl])/Variation_matrix[t+30,3,1] ) * (Variation_matrix[t+7,3,(rl+2)] - Variation_matrix[t+7,3,(rl+1)])/(2*(Steps_size[rl]))

    end

end
# Get the sensitivites for Phase 2 early for a 20 miunte time window.
for t = 1:20
    for rl = 1:2:35

    S_P_2e_r_1[1,i_in[rl],t] = ((Parameter_original[rl])/Variation_matrix[t+210,1,1] ) * (Variation_matrix[t+210,1,(rl+2)] - Variation_matrix[t+210,1,(rl+1)])/(2*(Steps_size[rl]))
    S_P_2e_r_2[1,i_in[rl],t] = ((Parameter_original[rl])/Variation_matrix[t+210,2,1] ) * (Variation_matrix[t+210,2,(rl+2)] - Variation_matrix[t+210,2,(rl+1)])/(2*(Steps_size[rl]))
    S_P_2e_r_3[1,i_in[rl],t] = ((Parameter_original[rl])/Variation_matrix[t+210,3,1] ) * (Variation_matrix[t+210,3,(rl+2)] - Variation_matrix[t+210,3,(rl+1)])/(2*(Steps_size[rl]))

    end
end
# Get the sensitivites for Phase 2 late for a 20 miunte time window.
for t = 1:20
    for rl = 1:2:35

    S_P_2l_r_1[1,i_in[rl],t] = ((Parameter_original[rl])/Variation_matrix[t+390,1,1] ) * (Variation_matrix[t+390,1,(rl+2)] - Variation_matrix[t+390,1,(rl+1)])/(2*(Steps_size[rl]))
    S_P_2l_r_2[1,i_in[rl],t] = ((Parameter_original[rl])/Variation_matrix[t+390,2,1] ) * (Variation_matrix[t+390,2,(rl+2)] - Variation_matrix[t+390,2,(rl+1)])/(2*(Steps_size[rl]))
    S_P_2l_r_3[1,i_in[rl],t] = ((Parameter_original[rl])/Variation_matrix[t+390,3,1] ) * (Variation_matrix[t+390,3,(rl+2)] - Variation_matrix[t+390,3,(rl+1)])/(2*(Steps_size[rl]))

    end
end

#Phase 1 Sensitivity bloc
Sensitivity_Matrix_Phase_1  = [S_P_1_r_1; S_P_1_r_2; S_P_1_r_3]
#Phase 2 early sensitivity bloc
Sensitivity_Matrix_Phase_2e = [S_P_2e_r_1; S_P_2e_r_2; S_P_2e_r_3]
#Phase 2 late senstivity bloc
Sensitivity_Matrix_Phase_2l = [S_P_2l_r_1; S_P_2l_r_2; S_P_2l_r_3]

# So the sensitivity matrixes as a function of time are stored above,
# each bloc is a 3x18x20 array where each row is a protein (state)
#                                    Each column is the parameter change
#                                    Each z slice is a time point



# now to perfrom the SVD, must take the 20 minute time window and make a
# time averaged sensitivity matrix that will be 3x18x1

#Creation of the Time averaged seneitivity matrix for the three phases

a_i_j = 1  #placeholder in the equation N = 1/T int abs(a*s)  where s is Sensitivity_coefficeint_matrix
#trapezoidal estimation of time averaged matrix
T = t_Final_end ;
time_point_a = 1
time_point_b = 20
#generate the averaged matrixes for the three phases
Time_Averaged_Sensitivity_Matrix_Phase_1 = (1 / T[time_point_b+30] ) * (T[time_point_b+30] - T[time_point_a+30]) * ( Sensitivity_Matrix_Phase_1[:,:,1] + Sensitivity_Matrix_Phase_1[:,:,20]) / 2;
Time_Averaged_Sensitivity_Matrix_Phase_2e = (1 / T[time_point_b+210] ) * (T[time_point_b+210] - T[time_point_a+210]) * ( Sensitivity_Matrix_Phase_2e[:,:,1] + Sensitivity_Matrix_Phase_2e[:,:,20]) / 2;
Time_Averaged_Sensitivity_Matrix_Phase_2l = (1 / T[time_point_b+390] ) * (T[time_point_b+390] - T[time_point_a+390]) * ( Sensitivity_Matrix_Phase_2l[:,:,1] + Sensitivity_Matrix_Phase_2l[:,:,20]) / 2;


#Now to perform the SVD section

#get the SVD of each Phase
#stored as [y]_Phase_[x] where [x] is the phase  and [y] is either U,S,or V

U,s,v = svd(Time_Averaged_Sensitivity_Matrix_Phase_1)

U_phase_1 = U
s_Phase_1 = s
v_Phase_1 = v

U,s,v = svd(Time_Averaged_Sensitivity_Matrix_Phase_2e)
U_phase_2e = U
s_Phase_2e = s
v_Phase_2e = v

U,s,v = svd(Time_Averaged_Sensitivity_Matrix_Phase_2l)
U_phase_2l = U
s_Phase_2l = s
v_Phase_2l = v
