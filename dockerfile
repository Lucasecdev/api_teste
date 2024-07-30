# Usando a imagem base do Python
FROM python:3.9

# Definindo o diretório de trabalho
WORKDIR /app

# Copiando o arquivo de requisitos e instalando dependências
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Copiando o restante dos arquivos da aplicação
COPY . .

# Expõe a porta que o aplicativo usa
EXPOSE 8000

# Comando para rodar a API
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
