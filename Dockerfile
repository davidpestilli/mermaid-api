# Usa uma imagem oficial do Node.js 18
FROM node:18

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia os arquivos package.json e package-lock.json para instalar as dependências primeiro (cache eficiente)
COPY package.json package-lock.json ./

# Instala todas as dependências, incluindo @mermaid-js/mermaid-cli
RUN npm install

# Adiciona permissão de execução para o mmdc
RUN chmod +x ./node_modules/.bin/mmdc

# Copia todos os arquivos do projeto para o contêiner
COPY . .

# Testa se o mmdc está funcionando dentro do contêiner
RUN npx mmdc -V

# Expõe a porta da API
EXPOSE 3000

# Comando para rodar a API
CMD ["node", "server.js"]
