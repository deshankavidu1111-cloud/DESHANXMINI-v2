FROM node:20-alpine
WORKDIR /usr/src/app
RUN apk add --no-cache python3 make g++ git ffmpeg curl
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp && chmod a+rx /usr/local/bin/yt-dlp
COPY package*.json ./
RUN npm install --legacy-peer-deps --ignore-scripts
COPY . .
RUN mkdir -p frontend/dist/assets && cp index.html frontend/dist/index.html; mv index-*.js frontend/dist/assets/ 2>/dev/null; mv index-*.css frontend/dist/assets/ 2>/dev/null; true
EXPOSE 8000
CMD ["node", "index.js"]
