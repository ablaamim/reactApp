FROM node:20-alpine
RUN mkdir /react-hello-world/
WORKDIR /react-hello-world/
COPY /public/ /react-hello-world/public
COPY /src/ /react-hello-world/src/
COPY package.json package-lock.json .
RUN npm install 
CMD ["npm","start"]