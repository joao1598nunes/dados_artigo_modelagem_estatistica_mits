

%% DADOS DE KURTOSE, DENSIDADE DE PROBABILIDADES, MÉDIAS E DESVIOS-PADRÃO PARA CADA MIT (POR CARREGAMENTO E GRANDEZA)

clear all
close all
clc 
%%

% Nome do arquivo Excel
arquivo = 'Dados_simulacoes_motores.xlsx';

% Lê a coluna Correspondente a análise estatística da respectiva grandeza para determinado carregamento para cada motor
% Ex: se deseja calcular a média, desvio-padrão, erro-padrão e densidade de
% probabilidades para potência de entrada (Pel)a 100% do carregamento do
% MIT A, usa-se as colunas G9:G58
dados = xlsread(arquivo, 'Analise_Medias', 'G9:G58'); %Pel 100% Motor A 


% --- ESTATÍSTICAS ---
maior = max(dados)
menor = min(dados)
media = mean(dados)
desvio = std(dados)
erro_padrao = desvio / sqrt(length(dados))
k = kurtosis(dados)

fprintf('Média: %.4e\n', media);
fprintf('Desvio Padrão: %.4e\n', desvio);

%% --- CONFIGURAÇÃO DO GRÁFICO ---
edges = linspace(menor, maior, 40);

% Criação da Figura
figure('Position', [100 50 1000 800], 'Color', 'w');
hold on;

% 1. Histograma (PDF)
histogram(dados, 'BinEdges', edges, ...
              'Normalization', 'pdf', ...  
              'FaceColor', [0.85 0.33 0.10], ... 
              'EdgeColor', 'black', ...
              'LineWidth', 1.2, ...
              'DisplayName', 'Densidade Medida');
          
% 2. Curva Gaussiana
x_curve = linspace(menor, maior, 1000); 
f = (1 / (desvio * sqrt(2 * pi))) * exp(-0.5 * ((x_curve - media) / desvio).^2);
plot(x_curve, f, 'b-', 'LineWidth', 2.0, 'DisplayName', 'Curva Normal Teórica');

% 3. Linha da Média
yl = ylim; 
line([media media], yl, 'Color', 'g', 'LineStyle', '--', 'LineWidth', 2, 'DisplayName', 'Média');

%% ESTÉTICA E FONTES

% Título Principal
%title('Densidade de Probabilidade - Is (50%)', ...
    %  'FontWeight', 'bold', 'FontSize', 25, 'FontName', 'Times New Roman');

% Título dos Eixos (FontSize 25)
ylabel('Densidade de Probabilidade', ...
      'FontWeight', 'bold', 'FontSize', 25, 'FontName', 'Times New Roman');
xlabel('Intervalo de Erros Absolutos (%)', ...
      'FontWeight', 'bold', 'FontSize', 25, 'FontName', 'Times New Roman');

grid on;
legend('show', 'Location', 'NorthEast', 'FontSize', 14);
xlim([menor maior]);

% Estética dos Números do Grid (FontSize 15)
ax = gca;
ax.FontWeight = 'bold';
ax.LineWidth = 1.2;
ax.FontSize = 15;
ax.FontName = 'Times New Roman';

hold off;

% --- SALVAR (400 DPI) ---
nome_arquivo = 'curtose_menor_M3_q075.eps';
set(gcf, 'PaperPositionMode', 'auto');
print(gcf, nome_arquivo, '-depsc', '-painters');

fprintf('Gráfico salvo: %s\n', nome_arquivo);



