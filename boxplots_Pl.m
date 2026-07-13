

%% BOXPLOT DAS PERDAS PARA OS MITs:

% OBS: Este arquivo lê as planilhas referentes a Perdas (Pl) por carregamento para cada um dos motores

%% Motor A:

Pl_motores = 'Dados_simulacoes_motores.xlsx';


% perdas do motor A:

pl1ma= xlsread(Pl_motores, 'Analise_Medias', 'P9:P58');
pl075ma = xlsread(Pl_motores, 'Analise_Medias', 'Q9:Q58');
pl05ma = xlsread(Pl_motores, 'Analise_Medias', 'R9:R58');

%% Motor B:



% perdas do motor B:

pl1mb= xlsread(Pl_motores, 'Analise_Medias', 'AM9:AM58');
pl075mb = xlsread(Pl_motores, 'Analise_Medias', 'AN9:AN58');
pl05mb = xlsread(Pl_motores, 'Analise_Medias', 'AO9:AO58');

%% Motor 3:



% perdas do motor C:

pl1mc= xlsread(Pl_motores, 'Analise_Medias', 'BJ9:BJ58');
pl075mc = xlsread(Pl_motores, 'Analise_Medias', 'BK9:BK58');
pl05mc = xlsread(Pl_motores, 'Analise_Medias', 'BL9:BL58');

%% Motor 4:



% perdas do motor D:

pl1md= xlsread(Pl_motores, 'Analise_Medias', 'CF9:CF58');
pl075md = xlsread(Pl_motores, 'Analise_Medias', 'CG9:CG58');
pl05md = xlsread(Pl_motores, 'Analise_Medias', 'CH9:CH58');

%% Motor 5:



% perdas do motor E:

pl1me= xlsread(Pl_motores, 'Analise_Medias', 'DC9:DC58');
pl075me = xlsread(Pl_motores, 'Analise_Medias', 'DD9:DD58');
pl05me = xlsread(Pl_motores, 'Analise_Medias', 'DE9:DE58');


%% 1. ORGANIZAÇÃO DE DADOS DO BOXPLOT
% Ordem das colunas: [M1_100, M1_75, M1_50, M2_100, M2_75, M2_50, ...]

data_matrix = [pl1ma, pl075ma, pl05ma, ...
               pl1mb, pl075mb, pl05mb, ...
               pl1mc, pl075mc, pl05mc, ...
               pl1md, pl075md, pl05md, ...
               pl1me, pl075me, pl05me];


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
ylabel('Erros das Perdas (%)', 'FontSize', 30, 'FontWeight', 'bold');
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

print(gcf, 'Is_400DPI.png', '-dpng', '-r400', '-opengl');

disp('Imagem salva com sucesso para a pasta "boxplot"!');






