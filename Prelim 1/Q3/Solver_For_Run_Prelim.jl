#Solver run file for Question 3
# this file solves for the maximized objective values using the optimal flux distribution
# code from the Varner lab
# this code will return 3 things
# first it will return the plot for part a
# Second it will solve for a change in the maximized value for a change in bounds at two inducer points
# third it will turn this abstract coefficent of change into a percent change for ease of use and comprehension



#using the FBA solver from the Varner lab from github
include("calculate_optimal_flux_distribution.jl");

#plot
using PyPlot
pygui(true)



# set up the intial matrix to hold the rates
Maximized_tranlastion_rate = zeros(10000,1);

# give the range of inducer
I_min = 0.0001
I_max = 10

# turn the range values into an array with step size
I = I_min:0.001:I_max ;
I = collect(I);

# take the step size and create the for loop to calculate the maximized value at each inducer value
for j in 1:10000

    global I_val = I[j];

    #grabbing the data and stoichiometric_matrix generated in HW_3_Data
    include("Prelim_Question_3_Data.jl");

    # set objective to maximize translation rate v5
    objective_coefficient_array[5] = 1.0;

    stoichiometric_matrix = S;
    #perform the calculation using the GLPK solver
    (objective_value, calculated_flux_array, dual_value_array, uptake_array, exit_flag, status_flag) = calculate_optimal_flux_distribution(stoichiometric_matrix, default_bounds_array, species_bounds_array, objective_coefficient_array; min_flag = false);
    #redefince objective value to identify its purpose
    Maximized_tranlastion_rate[j] = objective_value;

end



#Generate the semilog plot of the incucer vs protein level


semilogx(I,Maximized_tranlastion_rate )

# axis - and y axis labeling

xlabel("Inducer concentration (mM)", fontsize=16)
ylabel("Protein level (nmol/gDW)", fontsize=16)


# the following code seeks to see how a change in the bounds causes
# a change in the protein level (shadow price)
#If shadow price was understood correcly, one step of the bounds should have some change in the protein level
# making the same change to all of the bounds, and seeing the impact on the protein level
# will tell which bounds (and thus exhagnge of metabolites) the protien production level is most sensitive to

#intialize a change coefficent array
#this will store integer values corresponding to the change in protein production flux

change_coefficient = zeros(9,1);

Percent_change = zeros(9,1);
#run over all of the exchange boundarys (b values )
for l in 7:15


    global I_val = I[5000];

    global step_done = l  ;

    #grabbing the data and stoichiometric_matrix generated in HW_3_Data
    include("Prelim_Question_3_Data.jl");

    # make the change to the default bounds array, here i set the exchange to a very low value
    # higher values showed no change, so units may have been messed up somewhere given the
    # original bounds were 1000000 and to see change i had to go down to less than 1.
    # hopefully this means the sensitivity is maintained however the specific values may be off.

    default_bounds_array[step_done,2]  =   0.13
    default_bounds_array[step_done,1]  =  -0.13


    # set objective to maximize translation rate v5
    objective_coefficient_array[5] = 1.0;

    #grab the stoichiometric_matrix
    stoichiometric_matrix = S;

    #perform the FBA again on the new bounds system
    (objective_value, calculated_flux_array, dual_value_array, uptake_array, exit_flag, status_flag) = calculate_optimal_flux_distribution(stoichiometric_matrix, default_bounds_array, species_bounds_array, objective_coefficient_array; min_flag = false);

    #redefince objective value to identify its purpose
    Maximized_tranlastion_rate_new = objective_value;

    # Calculate the change coefficent (the change in the rate due to the bounds change )
    # the 5000 is to grab a value around the middle of the inducer range (an intemediate value)
    # changing the 5000 value to a new value can see how the rate changes at lower or higher inducer levels
    Inducer_point = 5000

    change_coefficient[(l-6)] =   Maximized_tranlastion_rate[Inducer_point] - Maximized_tranlastion_rate_new  ;

    # percent change is reformating the above value into a percent to easily see the difference (0.5 is abstract while 40% redution is intuitive )

    Percent_change[(l-6)] = ( ( Maximized_tranlastion_rate[Inducer_point] - Maximized_tranlastion_rate_new) / Maximized_tranlastion_rate[Inducer_point] ) *100;

    # reset the bound modification with the original values
    default_bounds_array[step_done,2]  =   100000.0
    default_bounds_array[step_done,1]  =  -100000.0
    #now repeat the loop for the next bounds

end



#the muted out code here is a replication of the above, but with the inducer point changed to near the end about 9400

change_coefficient2 = zeros(9,1);

Percent_change2 = zeros(9,1);
#run over all of the exchange boundarys (b values )
for l in 7:15


    global I_val = I[5000];

    global step_done = l  ;

    #grabbing the data and stoichiometric_matrix generated in HW_3_Data
    include("Prelim_Question_3_Data.jl");

    # make the change to the default bounds array, here i set the exchange to a very low value
    # higher values showed no change, so units may have been messed up somewhere given the
    # original bounds were 1000000 and to see change i had to go down to less than 1.
    # hopefully this means the sensitivity is maintained however the specific values may be off.

    default_bounds_array[step_done,2]  =   0.13
    default_bounds_array[step_done,1]  =  -0.13


    # set objective to maximize translation rate v5
    objective_coefficient_array[5] = 1.0;

    #grab the stoichiometric_matrix
    stoichiometric_matrix = S;

    #perform the FBA again on the new bounds system
    (objective_value, calculated_flux_array, dual_value_array, uptake_array, exit_flag, status_flag) = calculate_optimal_flux_distribution(stoichiometric_matrix, default_bounds_array, species_bounds_array, objective_coefficient_array; min_flag = false);

    #redefince objective value to identify its purpose
    Maximized_tranlastion_rate_new2 = objective_value;

    # Calculate the change coefficent (the change in the rate due to the bounds change )
    # the 5000 is to grab a value around the middle of the inducer range (an intemediate value)
    # changing the 5000 value to a new value can see how the rate changes at lower or higher inducer levels
    Inducer_point2 = 8

    change_coefficient2[(l-6)] =   Maximized_tranlastion_rate[Inducer_point2] - Maximized_tranlastion_rate_new2  ;

    # percent change is reformating the above value into a percent to easily see the difference (0.5 is abstract while 40% redution is intuitive )

    Percent_change2[(l-6)] = ( ( Maximized_tranlastion_rate[Inducer_point2] - Maximized_tranlastion_rate_new2) / Maximized_tranlastion_rate[Inducer_point2] ) *100;

    # reset the bound modification with the original values
    default_bounds_array[step_done,2]  =   100000.0
    default_bounds_array[step_done,1]  =  -100000.0
    #now repeat the loop for the next bounds

end
