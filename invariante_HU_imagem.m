%Cálculo dos 7 parâmetros invariantes de uma imagem.
clc; clear;
cd '/home/junior/Imagens/base_treino';
nome = ["abacaxi1.jpeg";  "banana1.jpeg"; 
        "abacaxi2.jpeg";  "banana2.jpeg";
        "abacaxi3.jpeg";  "banana3.jpeg";
        "abacaxi4.jpeg";  "banana4.jpeg";
        "abacaxi5.jpeg";  "banana5.jpeg"; 
        "abacaxi6.jpeg";  "banana6.jpeg"; 
        "abacaxi7.jpeg";  "banana7.jpeg"; 
        "abacaxi8.jpeg";  "banana8.jpeg"; 
        "abacaxi9.jpeg";  "banana9.jpeg";
        "abacaxi10.jpeg"; "banana10.jpeg" ;
        "abacaxi11.jpeg"; "banana11.jpeg" ;
        "abacaxi12.jpeg"; "banana12.jpeg"; 
        "abacaxi13.jpeg"; "banana13.jpeg" ; 
        "abacaxi14.jpeg"; "banana14.jpeg"; 
        "abacaxi15.jpeg"; "banana15.jpeg" ; 
        "abacaxi16.jpeg"; "banana16.jpeg" ; 
        "abacaxi17.jpeg"; "banana17.jpeg" ; 
        "abacaxi18.jpeg"; "banana18.jpeg";
        "abacaxi19.jpeg"; "banana19.jpeg"; 
        "abacaxi20.jpeg"; "banana20.jpeg"; 
        "abacaxi21.jpeg"; "banana21.jpeg" ; 
        "abacaxi22.jpeg"; "banana22.jpeg"; 
        "abacaxi23.jpeg"; "banana23.jpeg" ; 
        "abacaxi24.jpeg"; "banana24.jpeg"; 
        "abacaxi25.jpeg"; "banana25.jpeg";];

nome = sort(nome);    
k = 1;
l = 1;
conta = 0;
lista_total = [];
for k = 1:length(nome(:,1))
   %for l = 1:length(nome(1,:))
%nome = input('Nome do arquivo na pasta: ');
imagem = imread(char(nome(k,l)));
%imagem = imread(char(nome(25,1)));
imagemPB = rgb2gray(imagem);
imagemPB = im2double(imagemPB);
tamanho = size(imagemPB); % Dimensão da imagem (x,y).
x = tamanho(1); y = tamanho(2);

i = 1; j = 1;
soma = 0;
m00 = 0;
while (i < x)
    while (j < y)
        soma = soma + imagemPB(i,j); %ESSA MERDA TEM QUE SER VARIÁVEL FLOAT!!! DO CONTRÁRIO, VAI ATÉ 255!!!! 
        j = j + 1;
    end
    j = 1;
    i = i + 1;
end

m00 = soma;

%Cálculo do centróide:
%coordenadas x e y do centróide: 

i = 1; j = 1;
somaX = 0;
somaY = 0;
while (i < x)
    while (j < y)
        somaX = somaX + (imagemPB(i,j)*i); %ESSA MERDA TEM QUE SER VARIÁVEL FLOAT!!! DO CONTRÁRIO, VAI ATÉ 255!!!! 
        somaY = somaY + (imagemPB(i,j)*j);
        j = j + 1;
    end
    j = 1;
    i = i + 1;
end
x_centroide = somaX/m00;
y_centroide = somaY/m00;

%Cálculo dos momentos centrais normalizados:
i = 1; j = 1;
somaEta20 = 0;
somaEta02 = 0;
somaEta11 = 0;
somaEta30 = 0;
somaEta12 = 0;
somaEta21 = 0;
somaEta03 = 0;
somaY = 0;

while (i < x)
    while (j < y)
        somaEta20 = somaEta20 + (imagemPB(i,j)*((i-x_centroide).^2)); 
        somaEta02 = somaEta02 + (imagemPB(i,j)*((j-y_centroide).^2));
        somaEta11 = somaEta11 + (imagemPB(i,j))*((j-y_centroide).*(i-x_centroide));
        somaEta30 = somaEta30 + (imagemPB(i,j))*(((i-x_centroide).^3));
        somaEta12 = somaEta12 + (imagemPB(i,j))*(((j-y_centroide).^2).*(i-x_centroide));
        somaEta21 = somaEta21 + (imagemPB(i,j))*(((j-y_centroide)).*((i-x_centroide).^2));
        somaEta03 = somaEta03 + (imagemPB(i,j))*(((j-y_centroide).^3).*((i-x_centroide)));
        j = j + 1;
    end
    j = 1;
    i = i + 1;
end
eta20 = somaEta20/(m00^2);
eta02 = somaEta02/(m00^2);
eta11 = somaEta11/(m00^2);
eta30 = somaEta30/(m00^(5/2));
eta12 = somaEta12/(m00^(5/2));
eta21 = somaEta21/(m00^(5/2));
eta03 = somaEta03/(m00^(5/2));

%Cálculo dos 7 momentos invariantes: 

phi1 = eta20 + eta02; 
phi2 = (eta20 -eta02)^2 + 4*(eta11^2);
phi3 = (eta30-(3*eta12))^2 + ((3*eta21)-eta03)^2;
phi4 = (eta30 + eta12)^2 + ((3*eta21) + eta03)^2;
phi5 = (eta30 - (3*eta12))*(eta30 + eta12)*((eta30 +eta12)^2 - 3*(eta21 + eta03)^2) + ((3*eta21)-eta03)*(eta21 + eta03)*(3*(eta30+eta12)^2 - (eta21 + eta03)^2); 
phi6 = (eta20 - eta02)*((eta30 +eta12)^2 - (eta21 + eta03)^2) + 4*eta11*(eta30 + eta12)*(eta21 + eta03); 
phi7 = ((3*eta21) - eta30)*(eta30+eta12)*((eta30 +eta12)^2 - 3*(eta21 + eta03)^2) + ((3*eta12) - eta30)*(eta21 + eta03)*((3*(eta30 + eta12)^2) - (eta21 + eta03)^2);

momentos_invariantes = [phi1 phi2 phi3 phi4 phi5 phi6 phi7];
lista_total(k,l,1:7) = momentos_invariantes
conta = conta+1;
sprintf('\nConta: %d',conta)
   %end
l = 1;
end
coordX = lista_total(:,1);
coordY = lista_total(:,2);
indice = [1:conta];
plot3(coordX,coordY,indice);
title('Valores de phi1 e phi2: ');
xlabel('phi1');
ylabel('phi2');
zlabel('indice');