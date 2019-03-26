# Question 2
------------------------
# Included Files 
1) Backup plot for convinience.PNG
2) Figure_1_Supplemental_Q3.PNG
3) calculate_optimal_flux_distribution.jl
4) Q_3_Prelim_7770.PDF
5) Q_3_Run.jl
6) Prelim_Question_3_data.jl
7) Solver_For_Run_Prelim.jl

-----------------------
# Specific Instructions
- Q_3_Run.jl is the primary run file that will run the entire question and generate the answers.
- make sure all the other files are in the same location as Q_3_Run.jl so it can call corectly
- Written derivation and plot answers are provided in the PDF and PNG files
-----------------------
# Issues
- Should not have any issues, ocassionaly I had an undefined error for a value InD, this was set as a global value in the run file to fix it and is an issue with how I wrote the code, If it occurs run a line in the Run file with the missing value that wasnt defined set to 1 (has to do with my loop) HOWEVER this should be fixed 
-----------------------
# Summary 
# NOTE: all the explination below is explined in detail in the Written response file Q_3_Prelim_7770.PDF
I) The first part of Question 3 asks for the creation of a stoiciometric matrix
  - This is labled as Figure_1_Supplemental_Q3.PNG in the provided files
  - The Stoiciometric matirx is also written in the code in the Prelim_Question_3_data.jl file 
  - Can lastly use the workspace in Atom or Julia to get it, it is labeld as S or as stoiciometric_matrix (S is easier)
II)The second part of question 3 part a asks for the formulation of expressions for the rates to be used as bounds in the bounds array. 
  - This is done in the Written file Q_3_Prelim_7770.PDF as there is a lot of math to write 
  - Note the question states that the R2 (or v2 in the code) will be equal to the r_x equation so I set both sides of the bounds equal to the value to force it to never deviate from that value. if this causes error with the GLPK solver that is the assumption that causes values to deviate from the actual.
III) The second part of Question 3 asks to maximize the translation rate v5 for a range of inducer additions.
  - This was done and a plot of the Protein level vs the inducer is given as "Backup plot for convinience.PNG" to see easily the result
  - NOTE: there are significantly fewer data points at the low inducer compared to the late inducer, I can correct for this, and did by doubling the step size, however this caused SUBSTANTIAL slow down of the code. For sake of brevity and the general trend it maintained i am running with the reduced step size and assuming the values i could get are sufficicent.
  - The graph shows the characteristic S shaped curve as expected.
  
IIII) the last part (part c) of question 3 asks about which exchange fluxes is the translation rate most sensitive to.
  - A longer form discussion of this is done in the Q_3_Prelim_7770.PDF file however the following is the key answer (barring the explination for a shadow price done in the PDF) 
  - The code was run twice to generate values at high inducer levels and at low inducer levels. what was found was that b2,b4,b9 were the most sensitive exhance fluxes, with the b1,3,6,5 and b7,8 fluxes swapping between being sensitive at high inducer vs at low inducer. 
  - The key draw therefore is that the exchange fluxes providing or removing metabolites nessesary for Transcription have the largest effect on the Translation rate. This means that the system is more sensitive towards the metabolites needed to produce mRNA over the metabolites needed to produce the protein( b1,3,5,6) or the ones to funnel GTP (b7,b8) .
  - This seems to be in line with how cell machenery works, where control structure is focused on the Transcription process (Ux = f(I,G,RNA,...)) and not the translation process (Ul = 1). So any changes to the system from that Transcription control is emulated by restricting the bounds. The resulting percent change of the protein level from baseline to restricted bounds was always significantly higher in the Transcription metabolite fluxes (b2,4,9). Thus based around the shadow price understanding, it cost significantly less to reduce the overall Translation rate or increase the rate by changing the Transcription metabolite fluxes (b2,4,9).

    

