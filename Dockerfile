FROM node:latest
LABEL description="cardepass 卡系统API文档"
WORKDIR /docs
RUN npm install -g docsify-cli@latest
EXPOSE 3000/tcp
ENTRYPOINT docsify serve .
