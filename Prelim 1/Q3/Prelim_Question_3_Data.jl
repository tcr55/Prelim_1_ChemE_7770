# stoichiometric_matrix for part a

#See suplemental PDF for a diagram and additional written out reaction schemes
#For part a, S is a Stoiciometric matrix of 17 x 15 dimention.

#rows are metabolites (17 metabolites) and columns are reactions
#           Metabolites
# 1   G
# 2   G*
# 3   RNAP
# 4   NTP
# 5   mRNA
# 6   P
# 7   NMP
# 8   Rib
# 9   Rib*
# 10  AAtRNA
# 11  GTP
# 12  GDP
# 13  tRNA
# 14  AA
# 15  ATP
# 16  AMP
# 17  Protein


#balances for      d[x]/dt = [S]*[r]     are as follows
# dG/dt       = v2 - v1
# dG*/dt      = v1 - v2
# dRNAP/dt    = v2 - v1
# dNTP/dt     = b2 - v2
# dmRNA/dt    = v5 + v2 - v3 - v4
# dP/dt       = 2 v2 + 2 v5 + 2 v6 - b9
# dNMP/dt     = v3 - b4
# dRib/dt     = v5 - v4
# dRib*/dt    = v4 - v5
# dAAtRNA/dt  = v6 - v5
# dGTP/dt     = b7 - 2 v5
# dGDP/dt     = 2 v5 - b8
# dtRNA/dt    = v5 - v6
# dAA/dt      = b1 - v6
# dATP/dt     = b5 - v6
# dAMP/dt     = v6 - b6
# dProtein/dt = v5 - b3




#stoichiometric_matrix
#      v1  v2  v3  v4  v5  v6  b1  b2  b3  b4  b5  b6  b7  b8  b9
S = [ -1   1   0   0   0   0   0   0   0   0   0   0   0   0   0    ;
       1  -1   0   0   0   0   0   0   0   0   0   0   0   0   0    ;
      -1   1   0   0   0   0   0   0   0   0   0   0   0   0   0    ;
       0  -1   0   0   0   0   0   1   0   0   0   0   0   0   0    ;
       0   1  -1  -1   1   0   0   0   0   0   0   0   0   0   0    ;
       0   2   0   0   2   2   0   0   0   0   0   0   0   0  -1    ;
       0   0   1   0   0   0   0   0   0  -1   0   0   0   0   0    ;
       0   0   0  -1   1   0   0   0   0   0   0   0   0   0   0    ;
       0   0   0   1  -1   0   0   0   0   0   0   0   0   0   0    ;
       0   0   0   0  -1   1   0   0   0   0   0   0   0   0   0    ;
       0   0   0   0  -2   0   0   0   0   0   0   0   1   0   0    ;
       0   0   0   0   2   0   0   0   0   0   0   0   0  -1   0    ;
       0   0   0   0   1  -1   0   0   0   0   0   0   0   0   0    ;
       0   0   0   0   0  -1   1   0   0   0   0   0   0   0   0    ;
       0   0   0   0   0  -1   0   0   0   0   1   0   0   0   0    ;
       0   0   0   0   0   1   0   0   0   0   0  -1   0   0   0    ;
       0   0   0   0   1   0   0   0  -1   0   0   0   0   0   0   ];


#Convert the matrix to float64
S = convert(Array{Float64}, S);


#generate the default_bounds_array for the fluxes,
# note fluxes b9,b10,b11,b12,b13 are allowed to be reversible for exchange of those metabolites

default_bounds_array = [
                         0.0       0.0     # v1         mmol/gDW-hr
                         0.0       0.0     # v2         mmol/gDW-hr
                         0.0       0.0     # v3         mmol/gDW-hr
                         0.0       0.0     # v4         mmol/gDW-hr
                         0.0       0.0     # v5         mmol/gDW-hr
                         0.0       0.0     # v6         mmol/gDW-hr
                   -100000.0  100000.0     # b1         mmol/gDW-hr
                   -100000.0  100000.0     # b2         mmol/gDW-hr
                   -100000.0  100000.0     # b3         mmol/gDW-hr
                   -100000.0  100000.0     # b4         mmol/gDW-hr
                   -100000.0  100000.0     # b5         mmol/gDW-hr
                   -100000.0  100000.0     # b6         mmol/gDW-hr
                   -100000.0  100000.0     # b7         mmol/gDW-hr
                   -100000.0  100000.0     # b8         mmol/gDW-hr
                   -100000.0  100000.0     # b9         mmol/gDW-hr
                                  ];


#bounds calculation for reactions v1, v2 v3 v4 v5 v6

#rate Constants for Bounds of v1 v2 v3 v4 v5 v6

Peptide_length = 308 #aa
Gene_length = 924 #nt
Gene_Concentration = .005 #uM
Volume = 15 #uL
RNAP_concentration = 0.15 #uM
Ribosome_concentration = 1.6 #uM
Transcription_Elongation_Rate_given = 60*3600 #nt/hr
Translation_Elongation_Rate_given = 16.5*3600 #aa/hr
translation_saturation_constant_given = 57 #uM
transcription_saturation_constant_given = 0.3 #uM
transcription_time_constant = 2.7
translation_time_constant = 0.8
mRNA_degradation_constant = 8.35 #hr^-1
protein_degradation_constant = 9.9*10^(-3) #hr^-1
Characteristic_gene_length = 1000 #nt
characteristic_protein_length_given = 330 #aa
#inducer concentration bounds
I_min = 0.0001 #mM
I_max = 10.0 #mM
W1 = 0.26
W2 = 300.0
K = 0.30 #mM
n = 1.5

#set up control stategy
FI = ((I_val)^n)/(K^n + (I_val)^n)
Transcription_control_function = (W1 + W2 * FI )/(1 + W1 + W2 * FI )
#Kinetic limit for tranlation
Translation_control_function = 1

#Calculation for Kcat for V2 and v5
V_2_K_cat = (Transcription_Elongation_Rate_given) / Characteristic_gene_length  #Hr^-1
V_5_K_cat = (Translation_Elongation_Rate_given) / characteristic_protein_length_given  #Hr^-1



#Calculation for the rate of transcription rx
rx = ( V_2_K_cat ) * RNAP_concentration * (Gene_Concentration / (transcription_time_constant*transcription_saturation_constant_given + (transcription_time_constant + 1)* Gene_Concentration)) ;

rx_hat = rx * Transcription_control_function ;

#using rate of transcription at seady state to get mRNA concentration
MRNA_concentration_SS = rx*Transcription_control_function / mRNA_degradation_constant ;

# Calculation for the rate of Translation rl
rL = ( V_5_K_cat) * Ribosome_concentration * (MRNA_concentration_SS/(translation_time_constant * translation_saturation_constant_given + (translation_time_constant + 1) * MRNA_concentration_SS))

rL_hat = rL * Translation_control_function ;

#Vmax calulations of the six reaction
V1_max = ( V_2_K_cat) * RNAP_concentration ;
V2_max = rx_hat    ;
V3_max = mRNA_degradation_constant * MRNA_concentration_SS  ;
V4_max = ( V_5_K_cat) * Ribosome_concentration
V5_max = rL_hat
V6_max = 100 * Ribosome_concentration

#put the new bounds for the reactions into the default bounds array
default_bounds_array[1,2] = V1_max ;
default_bounds_array[2,2] = V2_max ;
default_bounds_array[2,1] = V2_max ; #to make v5 equal to rx_hat
default_bounds_array[3,2] = V3_max ;
default_bounds_array[4,2] = V4_max ;
default_bounds_array[5,2] = V5_max ;
default_bounds_array[6,2] = V6_max ;

#species_bounds_array, left hand side of the equation d[x]/dt = [S]*[r], set to zero for this homework
species_bounds_array = [
                           0.0    0.0 ;
                           0.0    0.0 ;
                           0.0    0.0 ;
                           0.0    0.0 ;
                           0.0    0.0 ;
                           0.0    0.0 ;
                           0.0    0.0 ;
                           0.0    0.0 ;
                           0.0    0.0 ;
                           0.0    0.0 ;
                           0.0    0.0 ;
                           0.0    0.0 ;
                           0.0    0.0 ;
                           0.0    0.0 ;
                           0.0    0.0 ;
                           0.0    0.0 ;
                           0.0    0.0 ;
                                       ] ;

# array to set the objective value, will be given a value in the run file
objective_coefficient_array = [
                                0.0
                                0.0
                                0.0
                                0.0
                                0.0
                                0.0
                                0.0
                                0.0
                                0.0
                                0.0
                                0.0
                                0.0
                                0.0
                                0.0
                                0.0

                                    ];
