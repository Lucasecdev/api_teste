# Usando a imagem base do Python
FROM python:3.9

# Instalar o Trivy
RUN apt-get update && apt-get install -y wget
RUN wget https://github.com/aquasecurity/trivy/releases/download/v0.43.1/trivy_0.43.1_Linux-64bit.deb
RUN dpkg -i trivy_0.43.1_Linux-64bit.deb

# Definindo o diretório de trabalho
WORKDIR /app

# Copiando o arquivo de requisitos e instalando dependências
COPY requirements.txt .

# Atualizando o setuptools para uma versão segura
RUN pip install --no-cache-dir setuptools==65.5.1
RUN pip install --no-cache-dir -r requirements.txt

# Copiando o restante dos arquivos da aplicação
COPY . .

# Expõe a porta que o aplicativo usa
EXPOSE 8000

# Rodar o Trivy para escanear a imagem em busca de vulnerabilidades
RUN trivy filesystem --severity HIGH,CRITICAL /

# Comando para rodar a API
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
