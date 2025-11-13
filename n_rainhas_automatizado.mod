# n_rainhas_automatizado.mod
# Problema das nrainha Rainhas
# execução com arquivo dat:
# glpsol --math n_rainhas_automatizado.mod --data n_rainhas_dados.dat -o resultado.txt
# glpsol --math n_rainhas_automatizado.mod --data n_rainhas_dados.dat --presol --cuts -o resultado.txt
# execução sem arquivo dat: echo "param nrainha := 4; end;" | glpsol --math n_rainhas_automatizado.mod -o resultado_4.txt


# declarar um parâmetro constante
param nrainha;

# definição de um conjunto
set LINHAS := 1..nrainha; # LINHAS = {1, 2, 3, 4, 5, 6, 7, 8}
set COLUNAS := 1..nrainha; # COLUNAS = {1, 2, 3, 4, 5, 6, 7, 8}

/* VARIÁVEIS DE DECISÃO */
var x{i in LINHAS, j in COLUNAS} binary;

/* FUNÇÃO OBJETIVO */
maximize Total_Rainhas: sum{i in LINHAS, j in COLUNAS} x[i,j];

/* RESTRIÇÕES */

/* Exatamente n rainhas no total */
subject to Total_Rainhas_Exatas: 
    sum{i in LINHAS, j in COLUNAS} x[i,j] = nrainha;

/* UMA rainha por LINHA */
subject to Uma_Por_Linha {i in LINHAS}:
    sum{j in COLUNAS} x[i,j] = 1;

/* UMA rainha por COLUNA */
subject to Uma_Por_Coluna {j in COLUNAS}:
    sum{i in LINHAS} x[i,j] = 1;

/* DIAGONAIS PRINCIPAIS (\) */
/* Para cada diagonal principal: i - j = constante */
subject to Diagonais_Principais {k in (1-nrainha)..(nrainha-1)}:
    sum{i in LINHAS, j in COLUNAS: i - j = k} x[i,j] <= 1;

/* DIAGONAIS SECUNDÁRIAS (/) */
/* Para cada diagonal secundária: i + j = constante */
subject to Diagonais_Secundarias {k in 2..(2*nrainha)}:
    sum{i in LINHAS, j in COLUNAS: i + j = k} x[i,j] <= 1;

end;