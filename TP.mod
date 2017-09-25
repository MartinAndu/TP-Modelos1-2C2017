#Conjuntos:
#Las ciudades del viajante
set CIUDADES;

#Parámetros (o constantes):
param TARIFA;

# Distancia de j a k, con j distinto de k
param DISTANCIA{j in CIUDADES, k in CIUDADES : j<>k};

#Variables:
#Yij, bivalente que vale 1 si va desde la ciudad i hasta la j (i != j)
var Y{i in CIUDADES, j in CIUDADES: i<>j} >= 0, binary;

#Ui orden de secuencia en que la ciudad i es visitada (excluyendo el punto de partida que
#en este caso lo tomamos como A). Declarada entera sólo a efectos de mostrar la
#declaración.
var U{i in CIUDADES: i<>'A'} >=0, integer;

#Funcional:
# La tarifa es de 7[$/km]. Nota: no se agrego la tarifa como param porque tiraba error
minimize z: sum{i in CIUDADES, j in CIUDADES : i<>j} 7*DISTANCIA[i,j]*Y[i,j];

#Llego desde un solo lugar hasta la ciudad j
s.t. llegoJ{j in CIUDADES}: sum{i in CIUDADES: i<>j} Y[i,j] = 1;

#Voy hacia un sólo lugar desde i
s.t. voyI{i in CIUDADES}: sum{j in CIUDADES: i<>j} Y[i,j] = 1;

#Secuencia para evitar subtours
s.t. orden{i in CIUDADES, j in CIUDADES: i<>j and i<>'A' and j<>'A'}: U[i] - U[j] + card(CIUDADES)*Y[i,j] <= card(CIUDADES) - 1;

solve;