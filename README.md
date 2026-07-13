# dados_artigo_modelagem_estatistica_mits

1. O passo inicial consiste na obtenção dos erros médios percentuais (%) e em pontos percentuais (p.p) para cada um dos motores. Os arquivos 'solver_Motor_A.xlsl', 'solver_Motor_B.xlsl', 'solver_Motor_C.xlsl', 'solver_Motor_D.xlsl' e 'solver_Motor_E.xlsl' calculam, respectivamente, os erros para cada um dos motores do trabalho. Cada um dos arquivos citados obtêm uma simulação por vez;
2. O passo seguinte consistiu em simular 50 vezes os arquivos 'solver_Motor_A.xlsl', 'solver_Motor_B.xlsl', 'solver_Motor_C.xlsl', 'solver_Motor_D.xlsl' e 'solver_Motor_E.xlsl' para enfim obter valores de 50 erros para cada uma das grandezas dos MITs analisados;
3. As amostras dos 50 erros por grandeza e carregamento para cada um dos MIT foram organizados no arquivo 'Dados_simulacoes_motores.xlsx' para simplificar a análise estatística das amostras;
4. O arquivo 'kurtose_medias_desvio.m' apresenta os gráficos de densidades de probabilidades das amostras de erros, além do arcabouço matemático que calcula as médias, desvios-padrão, erros-padrão e coeficientes de curtose para cada grandeza, por carregamento e motor. Ex: se deseja calcular a média, desvio-padrão, erro-padrão e densidade de probabilidades para potência de entrada (Pel) a 100% do carregamento do MIT A, usa-se as colunas G9:G58. Os dados foram calculados manualmente, como é apresentado no código;
5. Por fim, os arquivos 'boxplots_Fp.m', 'boxplots_Is.m', 'boxplots_Pel.m', 'boxplots_Pl.m', 'boxplots_Q.m' e 'boxplots_Ren.m' obtêm os gráficos de boxplot dos erros, respectivamente, para o fator de potência, corrente no estator, potência de entrada, perdas, potência reativa e rendimento. Ambos são calculados para cada um dos três carregamentos (100%, 75% e 50%) por MIT



1. The initial step consists of obtaining the mean percentage errors (%) and percentage point errors (p.p.) for each of the motors. The files 'solver_Motor_A.xlsl', 'solver_Motor_B.xlsl', 'solver_Motor_C.xlsl', 'solver_Motor_D.xlsl', and 'solver_Motor_E.xlsl' calculate the errors for each of the respective motors in this study. Each of the aforementioned files performs one simulation at a time;

2. The next step consisted of running 50 simulations of the files 'solver_Motor_A.xlsl', 'solver_Motor_B.xlsl', 'solver_Motor_C.xlsl', 'solver_Motor_D.xlsl', and 'solver_Motor_E.xlsl' to ultimately obtain 50 error values for each of the variables of the analyzed IMs (Induction Motors);

3. The samples of the 50 errors per variable and load level for each IM were organized in the file 'Dados_simulacoes_motores.xlsx' to simplify the statistical analysis of the samples;

4. The file 'kurtose_medias_desvio.m' presents the probability density plots of the error samples, along with the mathematical framework that calculates the means, standard deviations, standard errors, and kurtosis coefficients for each variable, per load level and motor. E.g., if one wishes to calculate the mean, standard deviation, standard error, and probability density for the input power (Pel) at 100% load of IM A, columns G9:G58 are used. The data were calculated manually, as shown in the code;

5. Finally, the files 'boxplots_Fp.m', 'boxplots_Is.m', 'boxplots_Pel.m', 'boxplots_Pl.m', 'boxplots_Q.m', and 'boxplots_Ren.m' generate the boxplots of the errors for the power factor, stator current, input power, losses, reactive power, and efficiency, respectively. These are calculated for each of the three load levels (100%, 75%, and 50%) per IM.
