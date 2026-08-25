# FROM node:24-bookworm-slim

# WORKDIR /app

# COPY package.json ./

# RUN npm install --omit=dev

# COPY app.js .

# EXPOSE 3000

# USER node

# CMD ["node", "app.js"]


# FROM node:24-bookworm-slim

# WORKDIR /app

# RUN groupadd --system appuser && \
#     useradd --system --gid appuser --create-home appuser

# COPY package.json ./

# RUN npm install --omit=dev

# COPY app.js .

# RUN chown -R appuser:appuser /app

# USER appuser

# EXPOSE 3000

# CMD ["node", "app.js"]



FROM node:24-bookworm-slim as builder

WORKDIR /app

RUN groupadd --system appuser && \
    useradd --system --gid appuser --create-home appuser

COPY package.json ./

RUN npm install --omit=dev

COPY . .

#runtime

FROM node:25-slim

COPY --from=builder /build/node_modules ./node_modules

COPY --from=builder /build/app.js ./app.js

RUN chown -R appuser:appuser /app

USER appuser

EXPOSE 3000

CMD ["node", "app.js"]