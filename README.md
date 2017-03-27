# SenSE - Sensor Simulation Environment



Soluções têm sido propostas para gerenciar dispositivos IoT em ambientes complexos, principalmente em Cidades Inteligentes. Embora escalabilidade seja uma característica imprescindível nesses sistemas, não existe uma plataforma de testes adequada para testar e comprovar a eficiência e escalabilidade desses softwares e os cenários propostos e testados tendem a ser simples e pontuais. O SenSE é um gerador de dados sintéticos de sensores de código aberto, flexível e genérico, desenvolvido para simular ambientes complexos, como encontrados em Cidades Inteligentes.  A ferramenta é capaz de gerar uma grande quantidade de dados de sensores heterogêneos simultaneamente, sendo capaz de simular dezenas de milhares de sensores. 


Manual de Instalação

Itens necessários para execução do software:
- Java 7 ou superior
- Servidor Apache Tomcat 8

# Procedimento de Instalação

- A partir do war já gerado: Na pasta na qual encontra-se o Apache Tomcat, colocar o arquivo com extensão war dentro da pasta webapps e iniciar a execução do servidor. Para iniciar o servidor, o usuário deve ir na pasta de instalação do servidor Tomcat e procurar a pasta bin. Caso o usuário esteja usando uma distribuição Linux, deve executar o arquivo startup.sh da seguinte forma via linha de comando: sh startup.sh. Caso esteja usando Windows, executar o arquivo startup.bat via linha de comando ou interface gráfica do Windows.  Para acessar a aplicação, acesse o endereço http://ip_do_servidor/nome_do_war, na qual ip_do_servidor é o IP do servidor Tomcat junto com a porta aberta para receber as requisições e nome_do_war é o nome do arquivo com extensão war.

Exemplo, se o servidor estiver na máquina local e o nome do arquivo war for SenSE.war, basta acessar o endereço: http://localhost:8080/SenSE, sendo 8080 a porta na qual o servidor Tomcat foi configurada para ouvir as requisições.

O endereço localhost:8080/SenSE executará a interface gráfica do SenSE, por é possível executar o software. Além disso, há explicações e tutoriais.

