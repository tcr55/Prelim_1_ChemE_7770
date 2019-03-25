# Ranking

#impartance scaling


#Grab the first column of the U matrix, and only the magnitude

Importance_Phase_1 = U_phase_1[:,1]
Importance_Phase_1 = abs.(Importance_Phase_1)

#assign val names to specific species to give a string designation to
val_1 = Importance_Phase_1[1]
val_2 = Importance_Phase_1[2]
val_3 = Importance_Phase_1[3]


#assign the values to a string in a dictionary to allow for rank order observation
Importance = Dict("Species 1" => val_1,
                  "Species 2" => val_2,
                  "Species 3" => val_3, )

# Sort the Dictionary and store it as a new dictionary specific to that phase
Ranked_Importnace_Phase_1 = sort(collect(zip(values(Importance),keys(Importance))))

# Repeat for the second phase (phase 2 early)
# Syntax is identical, so refer to comments above for resons for the specific action

Importance_Phase_2e = U_phase_2e[:,1]
Importance_Phase_2e = abs.(Importance_Phase_2e)
val_1 = Importance_Phase_2e[1]
val_2 = Importance_Phase_2e[2]
val_3 = Importance_Phase_2e[3]


Importance = Dict("Species 1" => val_1,
                  "Species 2" => val_2,
                  "Species 3" => val_3, )

Ranked_Importnace_Phase_2e = sort(collect(zip(values(Importance),keys(Importance))))

# Repeat again for the last phase (Phase 2 late)
# Again refer to Phase 1 for comments on opertaion

Importance_Phase_2l = U_phase_2l[:,1]
Importance_Phase_2l = abs.(Importance_Phase_2l)
val_1 = Importance_Phase_2l[1]
val_2 = Importance_Phase_2l[2]
val_3 = Importance_Phase_2l[3]


Importance = Dict("Species 1" => val_1,
                  "Species 2" => val_2,
                  "Species 3" => val_3, )

Ranked_Importnace_Phase_2l = sort(collect(zip(values(Importance),keys(Importance))))
