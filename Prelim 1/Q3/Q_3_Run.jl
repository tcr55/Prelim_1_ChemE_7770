# Run_Q_3




# This run file runs the entire question 3
# Note : the code takes a long time for some reason (minute or two or something)
#

global I_val = 1

include("calculate_optimal_flux_distribution.jl")
include("Prelim_Question_3_Data.jl")
include("Solver_For_Run_Prelim.jl")




# Part a is the stoichiometric_matrix, this was generated and is on the Writen File
# as a snipp of the code, looking into Prelim_Question_3_Data will also show the
# stoichiometric_matrix

#part b  is maximizing the translation rate and plotting the Protein level vs the inducer level
# this will automatically display
# if it is closed, a backup is also in the Written part of question 3 below the stoichiometric_matrix


# Part c seeks to see which bounds the flux is most sensitive to
# The discussion of the values is done in the written file
# to see the change, two matrixes Percent_change and Percent_change2
# were made to look at the rate at high inducer (flat line on top of plot)
# and the middle inducer region (curved portion)

# the bounds are labled here for understanding
# Percent_change
#     Rows                  Columns = percent change from original
# b1 = AA source
# b2 = NTP source
# b3 = Protein sink
# b4 = NMP sink
# b5 = ATP source
# b6 = AMP sink
# b7 = GTP source
# b8 = GDP sink
# b9 = P sink

# a high percent change means it is very sensitive,
# a low percent change means the change did not change it much and
# therefore it is not very sensitve

# based on my code, b2, b4, and b9 had the largest impact on the
# tranlation rate in both late and early inducer levels

# b1,3,6,5 was more important than b8,7 in early unducer
# but b8,7 were more important in late incuder

# based on the corresponding regions these sources and sinks play into
# the translation was limited primarily by the transcription metabolites (b2,4,9)
# the Rna charging motif (b8,7) had moderate effect at high inducer but lower effect at low inducer
# the Translation motif (b1,3,6,5) was the least useful at high inducer, but more important at low inducer

# however overall the transcription motif metabolites caused the greatest effect,

# I.E im concluding that the production rate of protein
# was more sensitive to transcription motif effects before the GDP GTP cycle charging motif or translation motif
# essentially saying deficiency in transcription metabolite feed cripples the system
