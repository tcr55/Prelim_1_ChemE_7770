# Question 2
------------------------
# Included Files 
1) Change_matrix.jl
2) Figure_for_compare.PNG
3) parameters_for_number_2_prelim.jl
4) PS_2_modification_for_prelim.jl
5) Q_2_Prelim_7770.PDF
6) Q_2_Run.jl
7) Sensitivity_for_prelim.jl
8) Sorting_Run.jl
9) Figure_1_supplemental_Q2.PNG
-----------------------
# Specific Instructions
- Code for question 2 to produce the figure and generate the sensitivity values (too many to provide easily) should all run from the main Q_2_Run.jl file 
- Make sure all the other files are in the same folder or location so the when the Q_2_Run.jl calls for them that it can get them 
- If it has issues with that run each file separately starting with the parameters_for_number_2_prelim and then Change_matrix.
# Operation plan
- All specific operation should be explained in the comments in the specific code to explain what each section does.
- An overview of the opertaion of this code is to open the Q_2_Run.jl file and click run, all of the values and parameters are stored in the parameters_for_number_2_prelim.jl which the Q_2_Run file pulls into it. then it pulls the Change matrix file which is a matrix that is 18x37. Its purpose is to give 37 different "states" to get the sensitivity where each set of three "state" (example row 2 and 3) will be the low and high value of a parameter. the PS_2 modification file runs the solver code for the DISCRETE method of linear algebra. Comments in the file explain how to incorporate the derivations and written equations into the code. this runs and will generate a large amount of Protien levels as a fucntion of time at different parameter "states". Sensitivity_for_Prelim and Sorting_Run will then take all of the generated values and use central differnce to get the sensitivity values and trapezoidal rule to get the integral over the time windows for the time averaged sensitivity array. this then gets converted into a UVS set from the Singular value decomposition. U is parsed for just the abs value of the first column and the rows are assigned to a string, fed to a dictionary file, and sorted by value to get the rank of the species on the sensitvity and control.
-----------------------
# Issues
- Should not have any issues, ocassionaly I had an undefined error for a value I_int, this was set as a global value in the run file to fix it and is an issue with how I wrote the code, If it occurs run a line in the Run file with the missing value that wasnt defined set to 1 (has to do with my loop) HOWEVER this should be fixed 
-----------------------
# Summary 
# NOTE: all the explination below is explined in detail in the Written response file Q_2_Prelim_7770.PDF

I) Question 2 invloves three parts. 
  - part a is a simulation with a generated plot (Provided as Figure_1_supplemental_Q2.PNG) of the protein levels as a function of time.
  - part b asks for the computation of the scaled sensitivity coefficents for three time windows. These are embedded in the code however they are given a name and the Run file will tell which value to typo or look in the workspace to find,
    - this has to due with each phase having a sensitivity coefficent array or 3 X 18 X 20 which is too large to show outside of code.
  - part c asks to compute the Time averaged sensitivy array to use in a singular value decomposition to get a U array of the species to rank for importance across the three phases
  
II) The Phases
  - The phases are broken into three parts,
    1) Phase 1 is no inducer for 120 minutes
    2) Phase 2 is the early indcuer additon at around 210 to 240 minutes
    3) Phase 3 is late inducer addtion and is from 390 to 410 minutes
    
# Key Results and Answer Summary
I) the plot is provided and shows an increase in the protein levels after inducer is added, with clear repression of P3 from P2.
II) the sensitivity coefficients were genrated using the code, where the partial derivative was approximated using the central differnce formula. 
  - This involved computing the species (protein) values multiple times to have a high and low value to perform the central difference calcualtion with. step sizes for the parameter changes were also computed and put for the denominator in the central differnce formula.

III) part C asks for an explination of the rankings and shifts in rankings of the species importance array gained from the U matrix.
  - The summary is that P2 has the higest importance in early time before the inducer is added. P1 and P3 have low importance in the ranking and contribute very little to the control at no inducer level. Once the inducer is added however the P1 and P2 contributions rise and the P2 contribution declines. this holds for both early and late inducer times. The uderstanding I have of this is that the shifts in ranking is occuring when the system is going from one controled and levels primarily gained from repression control and background leackage. Since P2 is the repressor in this system, most of the control would therefore fall on it when inducer is absent. once inducer was added P1 and P3 take over as the system is now moved into an inducer driven control, and P2 controls less than it did. however it still controls enough to keep P3 below P2 levels which hypothetically if the inducer was removed the P2 control should kick back in like it was in phase 1.
