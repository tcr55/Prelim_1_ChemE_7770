#Thomas Roberts Hw 2/18/2019

using LinearAlgebra
using PyPlot
pygui(true)
#Part 3
#this section takes up the most code,






#inital Inducer concentration
I = 0; #nM

#set the time step, is put into seconds for consistent units
time_step_d = 60 ;#seconds
#final time = 7200 seconds (120 minutes)
#7200/60 = 120 points/steps
#so v goes from 1 to 120 each point is 60 seconds or 1 min

#intial concentrations
xg = [   0.0;        # m1
         0.0;        # m2
         0.0;        # m3
         0.0;        # p3
         0.0;        # p2
         0.0 ];      # p3
x_long_length = 121  #steps (120 minutes to run without inducer (steady state plus 60 mins))

#concentration matrix for the Phase 1
x = zeros(6,x_long_length)

#this loop runs through the equations to generate a matrix of x and steps
#(time) for the time before inducer is added (0 to 60 minutes plus 60 minutes after Steady state)
for v = 1:120 #steps


# Kinetic constant calcualtions based on given transcription gene lengths
K_E_P_1 = transcription_elongation_rate / L_x[1,C_M[InD,2]]
K_E_P_2 = transcription_elongation_rate / L_x[2,C_M[InD,8]]
K_E_P_3 = transcription_elongation_rate / L_x[3,C_M[InD,14]]

#format into a matrix
K_E_P = [K_E_P_1 K_E_P_2 K_E_P_3]  ; #sec^-1

# get a time constant matrix from the K values
Tau_x_p = [(K_E_P[1]/(1/characteristic_initiation_time_transcription) ) (K_E_P[2]/(1/characteristic_initiation_time_transcription) ) (K_E_P[3]/(1/characteristic_initiation_time_transcription) )] ; #dimentionless

#repeat for the Translation constants
K_E_L_1 = transcription_elongation_rate / L_t[1,C_M[InD,3]]
K_E_L_2 = transcription_elongation_rate / L_t[2,C_M[InD,9]]
K_E_L_3 = transcription_elongation_rate / L_t[3,C_M[InD,15]]

K_E_L = [K_E_L_1 K_E_L_2 K_E_L_3]; #sec^-1
Tau_l_q = [(K_E_L[1]/(1/characteristic_initiation_time_translation) ) (K_E_L[2]/(1/characteristic_initiation_time_translation) ) (K_E_L[3]/(1/characteristic_initiation_time_translation) )] ;

#R calcualtion

#generate constants for TX
R_x_p_1 = K_E_P[1] .* ( ( R_x_t .* Gp[1,C_M[InD,1]] ) ./ ((Tau_x_p[1]) .* K_x + Tau_x_p[1] .* Gp[1,C_M[InD,1]] + Gp[1,C_M[InD,1]]) ) ;
R_x_p_2 = K_E_P[2] .* ( ( R_x_t .* Gp[2,C_M[InD,7]] ) ./ ((Tau_x_p[2]) .* K_x + Tau_x_p[2] .* Gp[2,C_M[InD,7]] + Gp[2,C_M[InD,7]]) ) ;
R_x_p_3 = K_E_P[3] .* ( ( R_x_t .* Gp[3,C_M[InD,13]] ) ./ ((Tau_x_p[3]) .* K_x + Tau_x_p[3] .* Gp[3,C_M[InD,13]] + Gp[3,C_M[InD,13]]) ) ;


#U calculation
F = ((I)^n_I_1) / ((K_I_1)^n_I_1 + (I)^n_I_1) ;
F12 = ((x[4,v])^n_1_2) / ((K_1_2)^n_1_2 + (x[4,v])^n_1_2) ;
F13 = ((x[4,v])^n_1_3) / ((K_1_3)^n_1_3 + (x[4,v])^n_1_3) ;
F23 = ((x[5,v])^n_2_3) / ((K_2_3)^n_2_3 + (x[5,v])^n_2_3) ;

#F = ((protein or inducer)^n) / (K^n + (protein or inducer)^n)
U1 = (W_1[C_M[InD,6]] + W_2 * F) / (1 + W_1[C_M[InD,6]] + W_2 * F );
U2 = (W_r2[C_M[InD,12]] + W_12 * F12 ) / (1 + W_r2[C_M[InD,12]] + W_12 * F12);
U3 = (W_r3[C_M[InD,18]] + W_13 * F13 - W_23 * F23) / (1 + W_r3[C_M[InD,18]] + W_13 * F13 - W_23 * F23 );

#dillution values
DeltaM = [ (K_x_i_d[1,C_M[InD,4]] + Mu ) (K_x_i_d[2,C_M[InD,10]] + Mu ) (K_x_i_d[3,C_M[InD,16]] + Mu ) ]

DeltaP = [ (K_l_i_d[1,C_M[InD,5]] + Mu ) (K_l_i_d[2,C_M[InD,11]] + Mu ) (K_l_i_d[3,C_M[InD,17]] + Mu ) ]

#TX matrix setup
TX = [0 0 0 ];
TX = convert(Array{Float64},TX)
TX[1] = R_x_p_1 * U1;
TX[2] = R_x_p_2 * U2;
TX[3] = R_x_p_3 * U3;

#protein balance

#R values for TL that depend on mrna concentrations
R_L_p_1 = K_E_L[1] .* ( ( R_l_t .* x[1,v] ) ./ ((Tau_l_q[1]) .* K_l + Tau_l_q[1] .* x[1,v] + x[1,v]) ) ;
R_L_p_2 = K_E_L[2] .* ( ( R_l_t .* x[2,v] ) ./ ((Tau_l_q[2]) .* K_l + Tau_l_q[2] .* x[2,v] + x[2,v]) ) ;
R_L_p_3 = K_E_L[3] .* ( ( R_l_t .* x[3,v] ) ./ ((Tau_l_q[3]) .* K_l + Tau_l_q[3] .* x[3,v] + x[3,v]) ) ;

#set up TL vector
TL = [0 0 0];
TL = convert(Array{Float64},TL)
TL[1] = R_L_p_1  ;
TL[2] = R_L_p_2 ;
TL[3] = R_L_p_3 ;


#Discretation for linear algebra

#dillution vector
A = [ -DeltaM[1]  0         0         0      0        0
         0   -DeltaM[2]     0         0      0        0
         0        0     -DeltaM[3]    0      0        0
         0        0         0    -DeltaP[1]  0        0
         0        0         0         0   -DeltaP[2]  0
         0        0         0         0      0   -DeltaP[3] ];
#Stoiciometric matrix
S = [ 1 0 0 0 0 0
      0 1 0 0 0 0
      0 0 1 0 0 0
      0 0 0 1 0 0
      0 0 0 0 1 0
      0 0 0 0 0 1 ];

#rate matrix
r = [ TX[1]
      TX[2]
      TX[3]
      TL[1]
      TL[2]
      TL[3] ];
#A_hat calculation
A_hat = exp(A.*time_step_d);

#S_hat Calculation

eye = [1 0 0 0 0 0
       0 1 0 0 0 0
       0 0 1 0 0 0
       0 0 0 1 0 0
       0 0 0 0 1 0
       0 0 0 0 0 1 ]
S_hat = inv(A).*(A_hat - eye).*S ;
#final calculation of x at the next time step, stores in the next column of
#the x matrix
x[:,v+1] = A_hat*x[:,v] + S_hat * r ;





end

#next this process is repeated but for time from the additional 60 min to 300 min
# I.E this section is with the addition of the inducer into the system at t = 120 min

End_length = 301

I = 10; #uM
xnew = zeros(6, End_length)
#xnew = [    x[1,end];        # m1
#            x[2,end];        # m2
#            x[3,end];        # m3
#            x[4,end];        # p3
#            x[5,end];        # p2
#            x[6,end] ];      # p3

xnew[1,1] = x[1,end];
xnew[2,1] = x[2,end];
xnew[3,1] = x[3,end];
xnew[4,1] = x[4,end];
xnew[5,1] = x[5,end];
xnew[6,1] = x[6,end];

#Now do computation for the inducer Added
#but with an adjusted step size

for vnew = 1:300 #steps




    K_E_P_1 = transcription_elongation_rate / L_x[1,C_M[InD,2]]
    K_E_P_2 = transcription_elongation_rate / L_x[2,C_M[InD,8]]
    K_E_P_3 = transcription_elongation_rate / L_x[3,C_M[InD,14]]

    K_E_P = [K_E_P_1 K_E_P_2 K_E_P_3]  ; #sec^-1

    Tau_x_p = [(K_E_P[1]/(1/characteristic_initiation_time_transcription) ) (K_E_P[2]/(1/characteristic_initiation_time_transcription) ) (K_E_P[3]/(1/characteristic_initiation_time_transcription) )] ; #dimentionless

    K_E_L_1 = transcription_elongation_rate / L_t[1,C_M[InD,3]]
    K_E_L_2 = transcription_elongation_rate / L_t[2,C_M[InD,9]]
    K_E_L_3 = transcription_elongation_rate / L_t[3,C_M[InD,15]]

    K_E_L = [K_E_L_1 K_E_L_2 K_E_L_3]; #sec^-1
    Tau_l_q = [(K_E_L[1]/(1/characteristic_initiation_time_translation) ) (K_E_L[2]/(1/characteristic_initiation_time_translation) ) (K_E_L[3]/(1/characteristic_initiation_time_translation) )] ;
    #R calcualtion

    #generate constants for TX
    R_x_p_1 = K_E_P[1] .* ( ( R_x_t .* Gp[1,C_M[InD,1]] ) ./ ((Tau_x_p[1]) .* K_x + Tau_x_p[1] .* Gp[1,C_M[InD,1]] + Gp[1,C_M[InD,1]]) ) ;
    R_x_p_2 = K_E_P[2] .* ( ( R_x_t .* Gp[2,C_M[InD,7]] ) ./ ((Tau_x_p[2]) .* K_x + Tau_x_p[2] .* Gp[2,C_M[InD,7]] + Gp[2,C_M[InD,7]]) ) ;
    R_x_p_3 = K_E_P[3] .* ( ( R_x_t .* Gp[3,C_M[InD,13]] ) ./ ((Tau_x_p[3]) .* K_x + Tau_x_p[3] .* Gp[3,C_M[InD,13]] + Gp[3,C_M[InD,13]]) ) ;





    #U calculation
    F = ((I)^n_I_1) / ((K_I_1)^n_I_1 + (I)^n_I_1) ;
    F12 = ((xnew[4,vnew])^n_1_2) / ((K_1_2)^n_1_2 + (xnew[4,vnew])^n_1_2) ;
    F13 = ((xnew[4,vnew])^n_1_3) / ((K_1_3)^n_1_3 + (xnew[4,vnew])^n_1_3) ;
    F23 = ((xnew[5,vnew])^n_2_3) / ((K_2_3)^n_2_3 + (xnew[5,vnew])^n_2_3) ;
    #F = ((protein/inducer)^n) / (K^n + (protein/inducer)^n)
    U1 = (W_1[C_M[InD,6]] + W_2 * F) / (1 + W_1[C_M[InD,6]] + W_2 * F );
    U2 = (W_r2[C_M[InD,12]] + W_12 * F12 ) / (1 + W_r2[C_M[InD,12]] + W_12 * F12  );
    U3 = (W_r3[C_M[InD,18]] + W_13 * F13 - W_23 * F23) / (1 + W_r3[C_M[InD,18]] + W_13 * F13 - W_23 * F23 );

    #dillution values
    DeltaM = [ (K_x_i_d[1,C_M[InD,4]] + Mu ) (K_x_i_d[2,C_M[InD,10]] + Mu ) (K_x_i_d[3,C_M[InD,16]] + Mu ) ]

    DeltaP = [ (K_l_i_d[1,C_M[InD,5]] + Mu ) (K_l_i_d[2,C_M[InD,11]] + Mu ) (K_l_i_d[3,C_M[InD,17]] + Mu ) ]


    #TX matrix setup
    TX = [0 0 0 ];
    TX = convert(Array{Float64},TX)
    TX[1] = R_x_p_1 * U1;
    TX[2] = R_x_p_2 * U2;
    TX[3] = R_x_p_3 * U3;

    #protein balance

    #R values for TL that depend on mrna concentrations
    R_L_p_1 = K_E_L[1] .* ( ( R_l_t .* xnew[1,vnew] ) ./ ((Tau_l_q[1]) .* K_l + Tau_l_q[1] .* xnew[1,vnew] + xnew[1,vnew]) ) ;
    R_L_p_2 = K_E_L[2] .* ( ( R_l_t .* xnew[2,vnew] ) ./ ((Tau_l_q[2]) .* K_l + Tau_l_q[2] .* xnew[2,vnew] + xnew[2,vnew]) ) ;
    R_L_p_3 = K_E_L[3] .* ( ( R_l_t .* xnew[3,vnew] ) ./ ((Tau_l_q[3]) .* K_l + Tau_l_q[3] .* xnew[3,vnew] + xnew[3,vnew]) ) ;

    #set up TL vector
    TL = [0 0 0];
    TL = convert(Array{Float64},TL)
    TL[1] = R_L_p_1  ;
    TL[2] = R_L_p_2 ;
    TL[3] = R_L_p_3 ;


    #Discretation for linear algebra

    #dillution vector
    A = [ -DeltaM[1]      0         0         0      0     0
             0     -DeltaM[2]       0         0      0     0
             0         0     -DeltaM[3]       0      0     0
             0         0         0      -DeltaP[1]   0     0
             0         0         0         0   -DeltaP[2]  0
             0         0         0         0      0   -DeltaP[3] ];
    #Stoiciometric matrix
    S = [ 1 0 0 0 0 0
          0 1 0 0 0 0
          0 0 1 0 0 0
          0 0 0 1 0 0
          0 0 0 0 1 0
          0 0 0 0 0 1 ];

    #rate matrix
    r = [ TX[1]
          TX[2]
          TX[3]
          TL[1]
          TL[2]
          TL[3] ];
    #A_hat calculation
    A_hat = exp(A.*time_step_d);
    #S_hat Calculation

    eye = [1 0 0 0 0 0
           0 1 0 0 0 0
           0 0 1 0 0 0
           0 0 0 1 0 0
           0 0 0 0 1 0
           0 0 0 0 0 1 ]
    S_hat = inv(A).*(A_hat - eye).*S ;
    #final calculation of x at the next time step, stores in the next column of
    #the x matrix
    xnew[:,vnew+1] = A_hat*xnew[:,vnew] + S_hat * r ;







end


#end of the calualtions, now convert the step size back into time units to
#use for the plotting
stepp = 1:120;
stepp = collect(stepp)
stepp = convert(Array{Float64},stepp)
stepnew = 1:301;
stepnew = collect(stepnew)
stepnew = convert(Array{Float64},stepnew)
timem = stepp*(60)*(1/60);    # time steps in minutes
time_new_p = stepnew*(60)*(1/60); #time steps in minutes


#this chunk of code compresses the before inducer and after inducer matrix
#into a grand matrix for all concentration values and time values  (ie
#turning the four separate matrixes into two single matrixes that can be plotted (t_Final_end and x_Final))
jj = size(x,1);
h = size(x,2)
q = size(xnew,2);
x_Final = zeros(jj,h+q);
q = q + h ;
#x_Final[:,1:h] = x[:,:] ;
x = x
xnew = xnew
x_Final = [x  xnew]
h = h+1;
#x_Final[:,h:q] = xnew ;
x_Final = x_Final*((10^3)/0.39) ; #final X value vector in micromole/gram dry weight
h = size(stepp,1);
q = size(stepnew,1);
t_Final_end = 1:(h+q+1);
t_Final_end = t_Final_end * (60) *(1/60);   #final discrete range in minute steps
t_Final_end = collect(t_Final_end)

P1_values = x_Final[4,:]
P2_values = x_Final[5,:]
P3_values = x_Final[6,:]
