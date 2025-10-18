## ☁️ Automação de Implantação e Configuração AWS - Oberon

Este repositório contém um conjunto de *scripts* Shell e arquivos Dockerfile criados para automatizar a implantação completa da aplicação Oberon em um ambiente IaaS (Infraestrutura como Serviço), como uma instância EC2 na AWS.

O objetivo principal é garantir um *deploy* rápido, repetível e isolado através da conteinerização.

-----

### 🎯 Componentes e Objetivos

| Componente | Objetivo | Arquivo(s) de Referência |
| :--- | :--- | :--- |
| **Automação** | Orquestrar a instalação de dependências, clonagem de código e *deploy* dos containers. | `init.sh` |
| **Conteinerização** | Isolar o Banco de Dados (MySQL) e a Aplicação Web (Node.js) usando Docker. | `Docker/` |
| **Configuração** | Criar arquivos de ambiente (`.env`) com as credenciais necessárias para a aplicação. | `web-site/config_env.sh` |
| **Segurança Host** | Criar um usuário e grupo específicos no sistema operacional hospedeiro para segregação de permissões. | `user_config/user_group.sh` |

-----

### 📂 Estrutura de Diretórios Chave

| Caminho | Conteúdo Principal |
| :--- | :--- |
| `/` | Contém o *script* de entrada principal (`init.sh`). |
| `Docker/` | Contém os Dockerfiles para construção das imagens dos serviços. |
| `database/` | Scripts para clonagem do repositório de esquemas do banco de dados. |
| `web-site/` | Scripts para clonagem do repositório da aplicação web e configuração das variáveis de ambiente. |
| `docker_config/` | Scripts de orquestração do Docker, responsáveis por construir e executar os containers. |
| `user_config/` | Scripts para configuração inicial de usuário e grupo no sistema operacional. |

-----

### 🚀 Fluxo de Execução Principal

O processo de *deploy* é iniciado pelo script mestre `init.sh`.

```bash
./init.sh
```

A partir dele, são chamados os módulos que realizam as seguintes ações:

1.  **Configuração de Usuário:** Criação do usuário e grupo (`oberon`) no sistema operacional do host (`user_config/user_group.sh`).
2.  **Preparação de Repositórios:** Clonagem dos repositórios de código-fonte necessários (Database e Web-Site).
3.  **Configuração de Ambiente (.env):** Criação do arquivo de variáveis de ambiente (`.env`) para a Aplicação Web (`web-site/config_env.sh`), garantindo que ela se conecte corretamente ao banco de dados conteinerizado.
4.  **Orquestração Docker:** Executa o script principal de Docker (`docker_config/docker_config.sh`).
      * **Deploy do Banco de Dados:** Constrói e inicializa o container do MySQL 8.0 (`docker_config/config_docker_banco_de_dados.sh`).
      * **Deploy do Site:** Constrói e inicializa o container da Aplicação Web, baseada em Node.js 18 (`docker_config/config_docker_site.sh`).

-----

## 🚀 Como Usar o Oberon-Config-AWS

Para que o script funcione corretamente, é **obrigatório** que o **AWS Command Line Interface (AWS CLI)** esteja instalado e configurado em seu ambiente local com as credenciais (Access Keys) e permissões de IAM adequadas para a criação dos recursos na AWS.

### 🔒 Configuração de Acesso (Security Groups)
Para que o Oberon consiga se comunicar e operar corretamente com os recursos da AWS (como instâncias EC2, bancos de dados, etc.), é fundamental que as seguintes portas estejam habilitadas nas regras de entrada (Inbound Rules) dos seus Security Groups (SGs).

Você deve garantir que os Security Groups associados aos seus recursos permitam o tráfego de entrada (Inbound) nas portas e protocolos listados abaixo, a partir da origem que for necessária:

| Tipo de Tráfego | Protocolo | Porta | Descrição (Baseado na infraestrutura) |
| :--- | :--- | :--- | :--- |
| **HTTP** | TCP | **80** | Acesso web padrão (para um balanceador de carga ou servidor web, por exemplo). |
| **MySQL/Aurora** | TCP | **3306** | Conexão com o banco de dados MySQL ou Amazon Aurora. **Restrinja a origem!** |
| **SSH** | TCP | **22** | Acesso seguro ao shell do servidor (Linux/EC2). **Restrinja a origem!** |


### 🐳 Detalhes da Conteinerização (Docker)

#### **1. Dockerfile do Banco de Dados** (`Docker/banco_de_dados/Dockerfile`)

  * **Base:** `mysql:8.0`.
  * **Porta Exposta:** `3306`
  * **Função:** O Dockerfile apenas define a imagem base, confiando na execução do script do `docker_config/` para passar as variáveis de ambiente essenciais (como `MYSQL_ROOT_PASSWORD`, `MYSQL_DATABASE`, etc.) que o MySQL utiliza para a configuração inicial do container.

#### **2. Dockerfile da Aplicação Web** (`Docker/site/Dockerfile`)

  * **Base:** `node:18`.
  * **Porta Exposta:** `80`
  * **Função:** Configura o ambiente Node.js, realiza a instalação das dependências (`npm install`) e define o comando para iniciar o servidor web (`npm start`).