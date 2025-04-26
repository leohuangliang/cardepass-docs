# 使用官方 Node.js 镜像作为基础镜像
FROM node:14-alpine

# 设置工作目录
WORKDIR /app

# 复制 package.json 和 package-lock.json 文件
COPY package*.json ./

# 安装项目依赖
RUN npm install

# 复制项目文件
COPY . .

# 暴露端口
EXPOSE 4000

# 启动 GitBook 服务
CMD ["gitbook", "serve"]