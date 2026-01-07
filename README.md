# Upload Widget Server

## Overview

Upload Widget Server is a TypeScript-based REST API for managing file uploads and exports. It provides a robust backend service for handling image uploads to cloud storage (Cloudflare R2), retrieving upload records from a PostgreSQL database, and exporting upload data in CSV format. The server is built with modern tooling and follows best practices for type safety, validation, and testing.

## Running Locally

### Prerequisites

- Node.js 22.x or higher
- Docker and Docker Compose
- PostgreSQL 15+ (via Docker Compose)

### Setup Steps

1. **Clone the repository and install dependencies:**
   ```bash
   npm install
   ```

2. **Set up environment variables:**
   Create a `.env` file in the project root with the following variables:
   ```
   PORT=3333
   NODE_ENV=development
   DATABASE_URL=postgresql://docker:docker@localhost:5432/upload
   CLOUDFLARE_ACCOUNT_ID=your_account_id
   CLOUDFLARE_ACCESS_KEY_ID=your_access_key
   CLOUDFLARE_SECRET_ACCESS_KEY=your_secret_key
   CLOUDFLARE_BUCKET_NAME=your_bucket_name
   CLOUDFLARE_PUBLIC_URL=https://your-cdn-url.com
   ```

3. **Start the PostgreSQL database:**
   ```bash
   docker-compose up -d
   ```

4. **Run database migrations:**
   ```bash
   npm run db:migrate
   ```

5. **Start the development server:**
   ```bash
   npm run dev
   ```

   The server will run on `http://localhost:3333` with Swagger documentation available at `http://localhost:3333/docs`.

### Available Commands

- `npm run dev` - Start the development server with hot reload
- `npm test` - Run the test suite
- `npm run test:watch` - Run tests in watch mode
- `npm run db:generate` - Generate database migrations
- `npm run db:migrate` - Run pending migrations
- `npm run db:studio` - Open Drizzle Studio for database management

## Tech Stack

### Core Framework
- **[Fastify](https://www.fastify.io/)** (v5.6.2) - High-performance Node.js web framework with low overhead and minimal dependencies. Chosen for its speed and excellent plugin ecosystem.

### Database & ORM
- **[Drizzle ORM](https://orm.drizzle.team/)** (v0.45.0) - Lightweight TypeScript ORM with type safety and zero runtime overhead. Provides SQL builder capabilities and database schema management.
- **[postgres](https://github.com/porsager/postgres)** (v3.4.7) - Fast PostgreSQL client for Node.js with seamless async/await support.
- **[Drizzle Kit](v0.31.8)** - CLI tool for managing database migrations and schema generation.

### Validation & Type Safety
- **[Zod](https://zod.dev/)** (v4.1.13) - Runtime schema validation library for TypeScript. Ensures type safety at runtime and API request validation.
- **[fastify-type-provider-zod](v6.1.0)** - Integration between Fastify and Zod for automatic request/response validation with swagger schema generation.

### Cloud Storage
- **[@aws-sdk/client-s3](v3.948.0)** - AWS S3 client SDK for interacting with S3-compatible storage providers (Cloudflare R2).
- **[@aws-sdk/lib-storage](v3.948.0)** - High-level storage library for simplified upload/download operations.

### API Documentation
- **[@fastify/swagger](v9.6.1)** - Generates OpenAPI/Swagger schemas from Fastify routes.
- **[@fastify/swagger-ui](v5.2.3)** - Serves interactive Swagger UI for API documentation.

### Utilities
- **[csv-stringify](v6.6.0)** - Convert data to CSV format for export functionality.
- **[dayjs](v1.11.19)** - Lightweight date manipulation library for handling timestamps.
- **[uuidv7](v1.1.0)** - Generate UUID v7 identifiers for unique upload tracking.

### CORS
- **[@fastify/cors](v11.1.0)** - Enable Cross-Origin Resource Sharing for API access from different domains.

### File Handling
- **[@fastify/multipart](v9.3.0)** - Handle multipart form data for file uploads.

### Development Tools
- **[TypeScript](v5.9.3)** - Adds static type checking to JavaScript.
- **[tsx](v4.21.0)** - TypeScript executor for running ts files directly with hot reload support.
- **[Vitest](v4.0.15)** - Fast unit test framework with Vite integration.
- **[@types/node](v24.10.1)** - Type definitions for Node.js.
- **[@biomejs/biome](v2.3.8)** - Fast linter and formatter for code quality.
- **[dotenv-cli](v11.0.0)** - Load environment variables from .env files in CLI commands.
