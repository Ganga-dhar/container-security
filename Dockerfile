# =========================
# Build stage
# =========================
FROM node:24-bookworm-slim AS builder

WORKDIR /app

COPY package.json ./

RUN npm install --omit=dev

COPY app.js .


# =========================
# Runtime stage
# =========================
FROM node:24-bookworm-slim

WORKDIR /app

# Create non-root application user
RUN groupadd --system appuser && \
    useradd --system \
    --gid appuser \
    --create-home appuser

# Copy only what is required at runtime
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/app.js ./app.js

# Give application user ownership
RUN chown -R appuser:appuser /app

# Run application as non-root
USER appuser

EXPOSE 3000

CMD ["node", "app.js"]