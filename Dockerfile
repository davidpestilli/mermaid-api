# Usa uma imagem Node.js oficial
FROM node:18

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia os arquivos do projeto para o contêiner
COPY package.json package-lock.json ./
RUN npm install

# Copia todos os arquivos para o contêiner
COPY . .

# Instala o mermaid-cli globalmente
RUN npm install -g @mermaid-js/mermaid-cli

# Expõe a porta que a API usará
EXPOSE 3000

# Comando para rodar a API
CMD ["node", "server.js"]
