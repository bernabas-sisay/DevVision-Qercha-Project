# Qercha - Group-Buying Telegram Mini App

Qercha is a localized group-buying and wholesale pool platform designed for Telegram Mini Apps in Ethiopia.

## Architecture

This project is structured as a **Modular Monolith**:
- `server/`: Express 5 + Node.js 22 LTS API with modular business boundaries (`src/modules/*`) and cross-cutting capabilities (`src/shared/*`).
- `client/`: React 18 + Vite Telegram Mini App built with feature-driven architecture (`src/features/*`), role-based dashboards (`src/app/shells/*`), and a shared design kit (`src/shared/ui/*`).
- `postman/`: API collection and environment definitions for continuous testing and automated Newman runs.
- `.github/workflows/`: CI pipeline validating backend and frontend on every pull request, plus scheduled production backups.

## Getting Started

### Prerequisites
- Node.js 22 LTS
- Docker and Docker Compose

### 1. Start Local Services
Launch PostgreSQL 16 and Valkey 8:
```bash
docker compose up -d
docker compose ps
```

Create test database:
```bash
docker compose exec postgres createdb -U qercha qercha_test
```

### 2. Environment Configuration
Copy `.env.example` to `server/.env` and `client/.env`:
```bash
cp .env.example server/.env
cp client/.env.example client/.env
```

### 3. Server Setup
```bash
cd server
npm install
npx prisma migrate dev
npm run dev
```

### 4. Client Setup
```bash
cd client
npm install
npm run dev
```

## Branch & Commit Guidelines
- Commit messages follow Conventional Commits format (e.g. `feat(front): ...`, `feat(back): ...`, `chore(ci): ...`).
- All changes must go through pull requests against `main`.
