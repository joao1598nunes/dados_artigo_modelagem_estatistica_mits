

%% BOXPLOT DO RENDIMENTO PARA OS MITs:

% OBS: Este arquivo lê as planilhas referentes ao rendimento por carregamento para cada um dos motores

%% Motor A:

ren_motores = 'Dados_simulacoes_motores.xlsx';


% fator de potência do motor A:

ren1ma= xlsread(ren_motores, 'Analise_Medias', 'S9:S58');
ren075ma = xlsread(ren_motores, 'Analise_Medias', 'T9:T58');
ren05ma = xlsread(ren_motores, 'Analise_Medias', 'U9:U58');

%% Motor B:



% fator de potência do motor B:

ren1mb= xlsread(ren_motores, 'Analise_Medias', 'AP9:AP58');
ren075mb = xlsread(ren_motores, 'Analise_Medias', 'AQ9:AQ58');
ren05mb = xlsread(ren_motores, 'Analise_Medias', 'AR9:AR58');

%% Motor C:



% fator de potência do motor C:

ren1mc= xlsread(ren_motores, 'Analise_Medias', 'BM9:BM58');
ren075mc = xlsread(ren_motores, 'Analise_Medias', 'BN9:BN58');
ren05mc = xlsread(ren_motores, 'Analise_Medias', 'BO9:BO58');

%% Motor D:



% fator de potência do motor D:

ren1md= xlsread(ren_motores, 'Analise_Medias', 'CI9:CI58');
ren075md = xlsread(ren_motores, 'Analise_Medias', 'CJ9:CJ58');
ren05md = xlsread(ren_motores, 'Analise_Medias', 'CK9:CK58');

%% Motor E:



% fator de potência do motor E:

ren1me= xlsread(ren_motores, 'Analise_Medias', 'DF9:DF58');
ren075me = xlsread(ren_motores, 'Analise_Medias', 'DG9:DG58');
ren05me = xlsread(ren_motores, 'Analise_Medias', 'DH9:DH58');


%% 1. ORGANIZAÇÃO DE DADOS DO BOXPLOT
% Ordem das colunas: [M1_100, M1_75, M1_50, M2_100, M2_75, M2_50, ...]

data_matrix = [ren1ma, ren075ma, ren05ma, ...
               ren1mb, ren075mb, ren05mb, ...
               ren1mc, ren075mc, ren05mc, ...
               ren1md, ren075md, ren05md, ...
               ren1me, ren075me, ren05me];


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
ylabel('Erros do Rendimento (p.p)', 'FontSize', 30, 'FontWeight', 'bold');
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

print(gcf, 'Ren_400DPI.png', '-dpng', '-r400', '-opengl');

disp('Imagem salva com sucesso para a pasta "boxplot"!');






