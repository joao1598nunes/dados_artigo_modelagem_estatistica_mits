

%% BOXPLOT DA CORRENTE DO ESTATOR PARA OS MITs:

% OBS: Este arquivo lê as planilhas referentes a corrente do estator (Is) por carregamento para cada um dos motores

%% Motor A:

Is_motores = 'Dados_simulacoes_motores.xlsx';


% corrente no estator do motor A:

is1ma= xlsread(Is_motores, 'Analise_Medias', 'M9:M58');
is075ma = xlsread(Is_motores, 'Analise_Medias', 'N9:N58');
is05ma = xlsread(Is_motores, 'Analise_Medias', 'O9:O58');

%% Motor B:



% corrente no estator do motor B:

is1mb= xlsread(Is_motores, 'Analise_Medias', 'AJ9:AJ58');
is075mb = xlsread(Is_motores, 'Analise_Medias', 'AK9:AK58');
is05mb = xlsread(Is_motores, 'Analise_Medias', 'AL9:AL58');

%% Motor 3:



% corrente no estator do motor C:

is1mc= xlsread(Is_motores, 'Analise_Medias', 'BG9:BG58');
is075mc = xlsread(Is_motores, 'Analise_Medias', 'BH9:BH58');
is05mc = xlsread(Is_motores, 'Analise_Medias', 'BI9:BI58');

%% Motor 4:



% corrente no estator do motor D:

is1md= xlsread(Is_motores, 'Analise_Medias', 'CC9:CC58');
is075md = xlsread(Is_motores, 'Analise_Medias', 'CD9:CD58');
is05md = xlsread(Is_motores, 'Analise_Medias', 'CE9:CE58');

%% Motor 5:



% corrente no estator do motor E:

is1me= xlsread(Is_motores, 'Analise_Medias', 'CZ9:CZ58');
is075me = xlsread(Is_motores, 'Analise_Medias', 'DA9:DA58');
is05me = xlsread(Is_motores, 'Analise_Medias', 'DB9:DB58');


%% 1. ORGANIZAÇÃO DE DADOS DO BOXPLOT
% Ordem das colunas: [M1_100, M1_75, M1_50, M2_100, M2_75, M2_50, ...]

data_matrix = [is1ma, is075ma, is05ma, ...
               is1mb, is075mb, is05mb, ...
               is1mc, is075mc, is05mc, ...
               is1md, is075md, is05md, ...
               is1me, is075me, is05me];


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
ylabel('Erros da Corrente no Estator (%)', 'FontSize', 30, 'FontWeight', 'bold');
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






