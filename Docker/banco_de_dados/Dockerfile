# use a imagem oficial do MySQL como imagem base 
FROM mysql:latest 
# defina variáveis de ambiente para a senha do rrot do MySQL 
ENV MYSQL_ROOT_PASSWORD=urubu100 
# copie os scripts SQL de inicialização para um diretório temporário no container 
COPY ./oberon/Oberon-Banco-De-Dados/01_dbStructure.sql /docker-entrypoint-initdb.d/
COPY ./oberon/Oberon-Banco-De-Dados/02_triggersAuditoria.sql /docker-entrypoint-initdb.d/
COPY ./oberon/Oberon-Banco-De-Dados/03_InsertMock.sql /docker-entrypoint-initdb.d/
COPY ./oberon/Oberon-Banco-De-Dados/04_userConfig.sql /docker-entrypoint-initdb.d/
# exponha a porta padrão do MySQL 
EXPOSE 3306 