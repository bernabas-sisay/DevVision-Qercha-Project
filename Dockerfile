# Build frontend assets
FROM node:22-slim AS client-builder
WORKDIR /app/client
COPY client/package*.json ./
RUN npm ci
COPY client/ ./
RUN npm run build

# Production server runtime
FROM node:22-slim
WORKDIR /app

# Install OpenSSL for Prisma
RUN apt-get update -y && apt-get install -y openssl && rm -rf /var/lib/apt/lists/*

# Copy package manifests
COPY package*.json ./
COPY server/package*.json ./server/

# Install server dependencies
WORKDIR /app/server
RUN npm ci

# Copy Prisma schema and generate client
COPY server/prisma ./prisma
RUN npx prisma generate

# Copy server code
COPY server/src ./src

# Copy built frontend assets
WORKDIR /app
COPY --from=client-builder /app/client/dist ./client/dist

EXPOSE 3000

ENV NODE_ENV=production
ENV PORT=3000

CMD ["npm", "start"]
