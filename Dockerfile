# Usa uma imagem Node.js oficial
FROM node:18

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia os arquivos do projeto para o contêiner
COPY package.json package-lock.json ./
RUN npm install

# Copia todos os arquivos para o contêiner
COPY . .

# Instala o Mermaid CLI como dependência local
RUN npm install @mermaid-js/mermaid-cli --save

# Testa se o mmdc está funcionando
RUN /app/node_modules/.bin/mmdc -V

# Expõe a porta que a API usará
EXPOSE 3000

# Comando para rodar a API
CMD ["node", "server.js"]
