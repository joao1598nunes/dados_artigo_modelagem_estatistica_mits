

%% BOXPLOT DA POTÊNCIA REATIVA PARA OS MITs:

% OBS: Este arquivo lê as planilhas referentes a potência reativa (Q) por carregamento para cada um dos motores

%% Motor A:

Q_motores = 'Dados_simulacoes_motores.xlsx';


% potência reativa do motor A:

q1ma= xlsread(Q_motores, 'Analise_Medias', 'J9:J58');
q075ma = xlsread(Q_motores, 'Analise_Medias', 'K9:K58');
q05ma = xlsread(Q_motores, 'Analise_Medias', 'L9:L58');

%% Motor B:



% potência reativa do motor B:

q1mb= xlsread(Q_motores, 'Analise_Medias', 'AG9:AG58');
q075mb = xlsread(Q_motores, 'Analise_Medias', 'AH9:AH58');
q05mb = xlsread(Q_motores, 'Analise_Medias', 'AI9:AI58');

%% Motor 3:



% potência reativa do motor C:

q1mc= xlsread(Q_motores, 'Analise_Medias', 'BG9:BG58');
q075mc = xlsread(Q_motores, 'Analise_Medias', 'BH9:BH58');
q05mc = xlsread(Q_motores, 'Analise_Medias', 'BY9:BY58');

%% Motor 4:



% potência reativa do motor D:

q1md= xlsread(Q_motores, 'Analise_Medias', 'BZ9:BZ58');
q075md = xlsread(Q_motores, 'Analise_Medias', 'CA9:CA58');
q05md = xlsread(Q_motores, 'Analise_Medias', 'CB9:CB58');

%% Motor 5:



% potência reativa do motor E:

q1me= xlsread(Q_motores, 'Analise_Medias', 'CW9:CW58');
q075me = xlsread(Q_motores, 'Analise_Medias', 'CX9:CX58');
q05me = xlsread(Q_motores, 'Analise_Medias', 'CY9:CY58');


%% 1. ORGANIZAÇÃO DE DADOS DO BOXPLOT
% Ordem das colunas: [M1_100, M1_75, M1_50, M2_100, M2_75, M2_50, ...]

data_matrix = [q1ma, q075ma, q05ma, ...
               q1mb, q075mb, q05mb, ...
               q1mc, q075mc, q05mc, ...
               q1md, q075md, q05md, ...
               q1me, q075me, q05me];


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
ylabel('Erros da Potência Reativa (%)', 'FontSize', 30, 'FontWeight', 'bold');
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

print(gcf, 'Q_400DPI.png', '-dpng', '-r400', '-opengl');

disp('Imagem salva com sucesso para a pasta "boxplot"!');






