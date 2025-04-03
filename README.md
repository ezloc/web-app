# Ezloc Web Application

## Overview
This is a cloud-native Vue.js application built with best practices for security, performance, and maintainability.

## Tech Stack
- Vue.js 3 with Composition API
- TypeScript
- Vuex for state management
- Vue Router for routing
- SCSS for styling
- Jest for unit testing
- Cypress for E2E testing
- ESLint + Prettier for code quality
- Docker for containerization
- GitHub Actions for CI/CD
- SonarQube for code quality analysis

## Project Structure
The project follows a feature-based organization pattern to enhance maintainability and scalability. See [Project Structure](#project-structure) for details.

```bash
web-app/
├── .github/
│   └── workflows/
│       ├── ci.yml
│       ├── cd-staging.yml
│       └── cd-production.yml
├── public/
│   ├── favicon.ico
│   └── index.html
├── src/
│   ├── assets/              # Static assets
│   ├── components/          # Reusable Vue components
│   │   ├── common/          # Common UI components
│   │   └── domain/          # Business domain components
│   ├── composables/         # Vue 3 composition API functions
│   ├── config/              # App configuration
│   ├── router/              # Vue Router
│   │   └── index.ts
│   ├── services/            # API and third-party service integrations
│   │   ├── api.service.ts
│   │   └── auth.service.ts
│   ├── store/               # Vuex store modules
│   │   ├── index.ts
│   │   └── modules/
│   ├── types/               # TypeScript type definitions
│   ├── utils/               # Utility functions
│   ├── views/               # Page components
│   ├── App.vue              # Root component
│   └── main.ts              # Application entry point
├── tests/
│   ├── unit/                # Jest unit tests
│   └── e2e/                 # Cypress end-to-end tests
├── .commitlintrc.js         # Commit message linting
├── .editorconfig            # Editor configuration
├── .env                     # Environment variables
├── .env.development
├── .env.production
├── .eslintrc.js             # ESLint configuration
├── .gitignore
├── .huskyrc.js              # Git hooks
├── .prettierrc.js           # Code formatting
├── babel.config.js
├── cypress.json             # E2E testing config
├── docker-compose.yml       # Local development
├── Dockerfile               # Production build
├── jest.config.js           # Unit testing config
├── package.json
├── README.md
├── sonar-project.properties # SonarQube configuration
├── tsconfig.json            # TypeScript configuration
└── vue.config.js            # Vue CLI configuration
```

## Getting Started

### Prerequisites
- Node.js 16+
- npm 7+
- Docker and Docker Compose (optional for containerized development)

### Installation
```bash
# Clone the repository
git clone https://github.com/ezloc/web-app.git
cd web-app

# Install dependencies
npm install

# Set up environment variables
cp .env.development .env

# Start development server
npm run serve
```

### Using Docker

* Launch in background
```bash
# Build and start containers
docker compose up -d

# View logs
docker compose logs -f
```

* Build and launch in foreground
```bash
docker compose -f docker-compose.e2e.yml up --build
```

## Development Workflow

### Code Style and Linting
The project uses ESLint and Prettier for code quality. Configuration can be found in `.eslintrc.js` and `.prettierrc.js`.

To lint your code:
```bash
npm run lint
```

### Commit Guidelines
We use Conventional Commits to standardize commit messages. This helps with automated versioning and changelog generation.

Format: `type(scope): subject`

Types:
- feat: A new feature
- fix: A bug fix
- docs: Documentation changes
- style: Code style changes (formatting, missing semi-colons, etc)
- refactor: Code changes that neither fix a bug nor add a feature
- perf: Performance improvements
- test: Adding or fixing tests
- chore: Changes to build process or auxiliary tools

### Testing

Unit tests with Jest:
```bash
npm run test:unit
```

E2E tests with Cypress:
```bash
npm run test:e2e
```

Using Docker:
```bash
docker compose -f docker-compose.e2e.yml up --build
```

## Deployment
The application uses GitHub Actions for CI/CD. When code is pushed to the main branch, it automatically:
1. Runs tests and linting
2. Performs SonarQube analysis
3. Builds a Docker image
4. Deploys to AWS ECS

## Security Best Practices
- Content Security Policy implementation
- Input sanitization
- HTTPS enforcement
- Secure cookie configuration
- Regular dependency updates
- Authentication and authorization

## API Documentation
[Link to API documentation]

## Component Documentation
[Link to component documentation]
