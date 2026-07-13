

%% BOXPLOT DA POTÊNCIA DE ENTRADA PARA OS MITs:

% OBS: Este arquivo lê as planilhas referentes a potência de entrada (Pel) por carregamento para cada um dos motores

%% Motor A:

pel_motores = 'Dados_simulacoes_motores.xlsx';


% potência de entrada do motor A:

pel1ma= xlsread(pel_motores, 'Analise_Medias', 'G9:G58');
pel075ma = xlsread(pel_motores, 'Analise_Medias', 'H9:H58');
pel05ma = xlsread(pel_motores, 'Analise_Medias', 'I9:I58');

%% Motor B:



% fator de potência do motor B:

pel1mb= xlsread(pel_motores, 'Analise_Medias', 'AD9:AD58');
pel075mb = xlsread(pel_motores, 'Analise_Medias', 'AE9:AE58');
pel05mb = xlsread(pel_motores, 'Analise_Medias', 'AF9:AF58');

%% Motor 3:



% fator de potência do motor C:

pel1mc= xlsread(pel_motores, 'Analise_Medias', 'BA9:BA58');
pel075mc = xlsread(pel_motores, 'Analise_Medias', 'BB9:BB58');
pel05mc = xlsread(pel_motores, 'Analise_Medias', 'BC9:BC58');

%% Motor 4:



% fator de potência do motor D:

pel1md= xlsread(pel_motores, 'Analise_Medias', 'BW9:BW58');
pel075md = xlsread(pel_motores, 'Analise_Medias', 'BX9:BX58');
pel05md = xlsread(pel_motores, 'Analise_Medias', 'BY9:BY58');

%% Motor 5:



% fator de potência do motor E:

pel1me= xlsread(pel_motores, 'Analise_Medias', 'CT9:CT58');
pel075me = xlsread(pel_motores, 'Analise_Medias', 'CU9:CU58');
pel05me = xlsread(pel_motores, 'Analise_Medias', 'CV9:CV58');


%% 1. ORGANIZAÇÃO DE DADOS DO BOXPLOT
% Ordem das colunas: [M1_100, M1_75, M1_50, M2_100, M2_75, M2_50, ...]

data_matrix = [pel1ma, pel075ma, pel05ma, ...
               pel1mb, pel075mb, pel05mb, ...
               pel1mc, pel075mc, pel05mc, ...
               pel1md, pel075md, pel05md, ...
               pel1me, pel075me, pel05me];


%% 2. DEFINIÇÃO DAS POSIÇÕES
% Agrupamento de 3 em três carregamentos por motor
positions = [1 2 3,  5 6 7,  9 10 11,  13 14 15,  17 18 19];

%% 3. GERAÇÃO DO BOXPLOT
figure('Color', 'w'); % Fundo branco
boxplot(data_matrix, 'Positions', positions, 'Widths', 0.6, 'Symbol', 'ro');

hold on;

%% 4. MÉDIA
means = mean(data_matrix);
plot(positions, means, 'bd', 'MarkerFaceColor', 'b', 'MarkerSize', 6);

%% 5. CONFIGURAÇÃO VISUAL
% Pinturas distintas das caixas por carregamento:

h = findobj(gca,'Tag','Box');

% Cores: Azul (100%), Laranja (75%)e Cinza (50%)
colors = [0.5 0.5 0.5;  % 50% (Cinza)
          0.85 0.33 0.1; % 75% (Laranja)
          0.0 0.45 0.74];% 100% (Azul)
          
% Laço de aplicação das cores
for j=1:length(h)
    % j: ciclagem entre as 3 cores
    color_idx = mod(j-1, 3) + 1;
    patch(get(h(j),'XData'), get(h(j),'YData'), colors(color_idx,:), 'FaceAlpha', 0.5);
end

%% 6. AJUSTES FINAIS DOS EIXOS
% Labels do Eixo X centralizados em cada grupo de motores
set(gca, 'XTick', [2, 6, 10, 14, 18]); 
set(gca, 'XTickLabel', {'Motor 1', 'Motor 2', 'Motor 3', 'Motor 4', 'Motor 5'});

% Labels dos eixos
ylabel('Erros da Potência de Entrada (%)', 'FontSize', 30, 'FontWeight', 'bold');
%xlabel('Motores de Indução', 'FontSize', 30, 'FontWeight', 'bold');
%title('Boxplot de Erros do Fator de Potência por Carregamento', 'FontSize', 20);

% Grid para facilitar a leitura
grid on;
set(gca, 'YGrid', 'on', 'XGrid', 'off','FontSize', 30); % Grid horizontal

% objetos invisíveis na legenda
h1 = plot(NaN,NaN,'s', 'MarkerFaceColor', colors(3,:), 'Color', 'k');
h2 = plot(NaN,NaN,'s', 'MarkerFaceColor', colors(2,:), 'Color', 'k');
h3 = plot(NaN,NaN,'s', 'MarkerFaceColor', colors(1,:), 'Color', 'k');
h_mean = plot(NaN,NaN,'bd', 'MarkerFaceColor', 'b'); 

legend([h1, h2, h3, h_mean], ...
       {'100% Carregamento', '75% Carregamento', '50% Carregamento', 'Média'}, ...
       'Location', 'Best');
   
set(findall(gcf,'-property','FontName'), 'FontName', 'Times New Roman');

hold off;



%% 7. EXPORTAÇÃO EM ALTA QUALIDADE


set(gcf, 'Units', 'inches', 'Position', [1 1 12 6]);


set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0 0 12 6]); % [x y largura altura]
set(gcf, 'PaperSize', [12 6]);         % Tamanho da folha

% 3. Salva o arquivo
% '-dpng': Formato PNG
% '-r400': Resolução de 400 DPI

print(gcf, 'Pel_400DPI.png', '-dpng', '-r400', '-opengl');

disp('Imagem salva com sucesso para a pasta "boxplot"!');






