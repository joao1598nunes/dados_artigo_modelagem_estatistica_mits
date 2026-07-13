

%% BOXPLOT DO FATOR DE POTÊNCIA PARA OS MITs:

% OBS: Este arquivo lê as planilhas referentes ao fator de potência por carregamento para cada um dos motores

%% Motor A:

fp_motores = 'Dados_simulacoes_motores.xlsx';


% fator de potência do motor A:

fp1ma= xlsread(fp_motores, 'Analise_Medias', 'V9:V58');
fp075ma = xlsread(fp_motores, 'Analise_Medias', 'W9:W58');
fp05ma = xlsread(fp_motores, 'Analise_Medias', 'X9:X58');

%% Motor 2:



% fator de potência do motor B:

fp1mb= xlsread(fp_motores, 'Analise_Medias', 'AS9:AS58');
fp075mb = xlsread(fp_motores, 'Analise_Medias', 'AT9:AT58');
fp05mb = xlsread(fp_motores, 'Analise_Medias', 'AU9:AU58');

%% Motor 3:



% fator de potência do motor C:

fp1mc= xlsread(fp_motores, 'Analise_Medias', 'BP9:BP58');
fp075mc = xlsread(fp_motores, 'Analise_Medias', 'BQ9:BQ58');
fp05mc = xlsread(fp_motores, 'Analise_Medias', 'BR9:BR58');

%% Motor 4:



% fator de potência do motor D:

fp1md= xlsread(fp_motores, 'Analise_Medias', 'CL9:CL58');
fp075md = xlsread(fp_motores, 'Analise_Medias', 'CM9:CM58');
fp05md = xlsread(fp_motores, 'Analise_Medias', 'CN9:CN58');

%% Motor 5:



% fator de potência do motor E:

fp1me= xlsread(fp_motores, 'Analise_Medias', 'DI9:DI58');
fp075me = xlsread(fp_motores, 'Analise_Medias', 'DJ9:DJ58');
fp05me = xlsread(fp_motores, 'Analise_Medias', 'DK9:DK58');


%% 1. ORGANIZAÇÃO DE DADOS DO BOXPLOT
% Ordem das colunas: [M1_100, M1_75, M1_50, M2_100, M2_75, M2_50, ...]

data_matrix = [fp1ma, fp075ma, fp05ma, ...
               fp1mb, fp075mb, fp05mb, ...
               fp1mc, fp075mc, fp05mc, ...
               fp1md, fp075md, fp05md, ...
               fp1me, fp075me, fp05me];


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
ylabel('Erros do Fator de Potência (p.p)', 'FontSize', 30, 'FontWeight', 'bold');
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

print(gcf, 'Fator_de_Potência_400DPI.png', '-dpng', '-r400', '-opengl');

disp('Imagem salva com sucesso para a pasta "boxplot"!');






