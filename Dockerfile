FROM node:18
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
EXPOSE 81
CMD ["npm", "start"]
