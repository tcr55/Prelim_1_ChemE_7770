





W_1 = [0.000001 0.0000001 0.00001] ;     #unitless background of 1
W_2 = 100  ;  #unitless   Inducer on 1
W_12 = 10 ;   #unitless
W_13 = 5 ;   #unitless
W_32 = 0 ;   #unitless
W_23 = 50  ;   #unitless
W_r2 =[0.000001 0.0000001 0.00001] ;   #unitless
W_r3 =[0.000001 0.0000001 0.00001] ;    #unitless

characteristic_initiation_time_transcription = 42 #seconds
characteristic_initiation_time_translation = 15 #seconds

K_I_1 = 0.30  # mM
K_1_2 = 1000.0   #nMol/gDW
K_1_3 = 1000.0   #nMol/gDW
K_2_3 = 10000.0   #nMol/gDW
#binding orders
n_I_1 = 1.5
n_1_2 = 1.5
n_1_3 = 1.5
n_2_3 = 10

# Parameters
 # copies / avgagadros number = moles per cell
 # moles/cell  /  Cell Weight = moles / cell weight g
 # mol/g * .3  = mol/gDW
 # value * 10^9 = nMol/gDw
 avagad = 6.02e23
 Weight_cell = 2.8e-13

Gp_given = [200.0 100.0 300.0]
Gp_calc = (((Gp_given / (avagad)) / (Weight_cell)) * 0.3)* 1e9; #nmol/gdw


#store gene copies into a parameter matrix
              #p1  p2  p3
Gp = [Gp_calc[1] Gp_calc[2] Gp_calc[3]
      Gp_calc[1] Gp_calc[2] Gp_calc[3]
      Gp_calc[1] Gp_calc[2] Gp_calc[3]]

R_x_t = (((1150.0 / (avagad)) / (Weight_cell)) * 0.3)* 1e9; #nmol/gdwl
R_l_t = (((45000.0 / (avagad)) / (Weight_cell)) * 0.3)* 1e9; #nmol/gdw

#gene lengths
Char_L_x = 1000.0 #nt
Char_L_t = 333.0 #aa
#gene length matrix
L_x = [1200.0 1000.0 1400.0
       2400.0 2200.0 2600.0
        600.0  400.0  800.0] #nt

#peptide lengths
#key assumption here is that the peptides have distict values separate
# from the gene length. Ie L_t = 1/3 * L_x , but this is not being
#put in as an equation to allow for perturbatinos to be made to each length
#indipendenly, otherwise changes in gene length could affect l_t also
L_t = [1200/3 1000/3 1400/3
       2400/3 2200/3 2600/3
        600/3  400/3  800/3 ]

#RNAP elongation rate
transcription_elongation_rate = 60.0 #nt/s

translation_elongation_rate = 16.5  #aa/s

#cell_doubling_time
Mu = 40.0 #min

Mu = (log(2)/40.0) *(1/60); #sec^-1

#mrna half life
mRNA_half_life_in_hr = [2.1/60  1.1/60  3.1/60
                        2.1/60  1.1/60  3.1/60
                        2.1/60  1.1/60  3.1/60   ]
#degredation constant of mrna
K_x_i_d = [(log(2.0)/(mRNA_half_life_in_hr[1,1]*60.0)) (log(2.0)/(mRNA_half_life_in_hr[1,2]*60.0)) (log(2.0)/(mRNA_half_life_in_hr[1,3]*60.0))
           (log(2.0)/(mRNA_half_life_in_hr[2,1]*60.0)) (log(2.0)/(mRNA_half_life_in_hr[2,2]*60.0)) (log(2.0)/(mRNA_half_life_in_hr[2,3]*60.0))
           (log(2.0)/(mRNA_half_life_in_hr[3,1]*60.0)) (log(2.0)/(mRNA_half_life_in_hr[3,2]*60.0)) (log(2.0)/(mRNA_half_life_in_hr[3,3]*60.0))  ] *(1.0/60.0) ; #sec^-1


#protein half life
protein_half_life_in_hr = [24.0  10.0  100.0
                           24.0  10.0  100.0
                           24.0  10.0  100.0  ]
#degredation contstant of protein
K_l_i_d = [(log(2)/(protein_half_life_in_hr[1,1]*60)) (log(2)/(protein_half_life_in_hr[1,2]*60)) (log(2)/(protein_half_life_in_hr[1,3]*60))
           (log(2)/(protein_half_life_in_hr[2,1]*60)) (log(2)/(protein_half_life_in_hr[2,2]*60)) (log(2)/(protein_half_life_in_hr[2,3]*60))
           (log(2)/(protein_half_life_in_hr[3,1]*60)) (log(2)/(protein_half_life_in_hr[3,2]*60)) (log(2)/(protein_half_life_in_hr[3,3]*60))] *(1/60) ; #sec^-1

#saturation constants
K_x = 0.24 ; #nmol/gDw
K_l = 454.64  ; #nmol/gDw


Parameter_original = zeros(35)
Parameter_original[1] = Gp[1,1]
Parameter_original[3] = L_x[1,1]
Parameter_original[5] = L_t[1,1]
Parameter_original[7] = mRNA_half_life_in_hr[1,1]
Parameter_original[9] = protein_half_life_in_hr[1,1]
Parameter_original[11] = W_1[1]
Parameter_original[13] = Gp[2,1]
Parameter_original[15] = L_x[2,1]
Parameter_original[17] = L_t[2,1]
Parameter_original[19] = mRNA_half_life_in_hr[2,1]
Parameter_original[21] = protein_half_life_in_hr[2,1]
Parameter_original[23] = W_r2[1]
Parameter_original[25] = Gp[3,1]
Parameter_original[27] = L_x[3,1]
Parameter_original[29] = L_t[3,1]
Parameter_original[31] = mRNA_half_life_in_hr[3,1]
Parameter_original[33] = protein_half_life_in_hr[3,1]
Parameter_original[35] = W_r3[1]


#Steps size of paramter changes
Steps_size = zeros(35)
Steps_size[1] =  Gp[1,3] - Gp[1,2]
Steps_size[3] = L_x[1,3] - L_x[1,2]
Steps_size[5] = L_t[1,3] - L_t[1,2]
Steps_size[7] = mRNA_half_life_in_hr[1,3] - mRNA_half_life_in_hr[1,2]
Steps_size[9] = protein_half_life_in_hr[1,3] - protein_half_life_in_hr[1,2]
Steps_size[11] = W_1[3] - W_1[2]
Steps_size[13] = Gp[2,3] - Gp[2,2]
Steps_size[15] = L_x[2,3] - L_x[2,2]
Steps_size[17] = L_t[2,3] - L_t[2,2]
Steps_size[19] = mRNA_half_life_in_hr[2,3] - mRNA_half_life_in_hr[2,2]
Steps_size[21] = protein_half_life_in_hr[2,3] - protein_half_life_in_hr[2,2]
Steps_size[23] = W_r2[3] - W_r2[2]
Steps_size[25] =  Gp[3,3] - Gp[3,2]
Steps_size[27] = L_x[3,3] - L_x[3,2]
Steps_size[29] = L_t[3,3] - L_t[3,2]
Steps_size[31] = mRNA_half_life_in_hr[3,3] - mRNA_half_life_in_hr[3,2]
Steps_size[33] = protein_half_life_in_hr[3,3] - protein_half_life_in_hr[3,2]
Steps_size[35] = W_r3[3] - W_r3[2]

#note the 18 rows correspond to the following values
#  1 = Gp                        of P1
#  2 = gene_length_in_nt         of P1
#  3 = protein_length_in_aa      of P1
#  4 = mRNA_half_life_in_hr      of P1
#  5 = protein_half_life_in_hr   of P1
#  6 = W (background_expression) of P1
#  7 = Gp                        of P2
#  8 = gene_length_in_nt         of P2
#  9 = protein_length_in_aa      of P2
# 10 = mRNA_half_life_in_hr      of P2
# 11 = protein_half_life_in_hr   of P2
# 12 = W (background_expression) of P2
# 13 = Gp                        of P3
# 14 = gene_length_in_nt         of P3
# 15 = protein_length_in_aa      of P3
# 16 = mRNA_half_life_in_hr      of P3
# 17 = protein_half_life_in_hr   of P3
# 18 = W (background_expression) of P3
