# Yolo Chat

A real-time chat application built with Tauri, React, and PostgreSQL, featuring live synchronization between web and native interfaces.

## Features

- Real-time message synchronization
- GitHub authentication
- Native desktop app (Tauri) and web interface
- PostgreSQL backend with logical replication
- Modern UI with Tamagui

## Prerequisites

- Node.js
- Yarn
- Docker
- Rust (for Tauri)

## Installation

1. Clone the repository:
```sh
git clone https://github.com/Frentz/yolo.git
cd yolo
```

2. Install dependencies:
```sh
yarn
```

3. Set up GitHub OAuth:
   - [Create a new Github App](https://docs.github.com/en/apps/creating-github-apps/registering-a-github-app/registering-a-github-app#registering-a-github-app)
   - Copy `.env.example` to `.env`
   - Fill in `GITHUB_CLIENT_ID` and `GITHUB_CLIENT_SECRET`

## Development

Run these commands in separate terminals:

1. Start PostgreSQL and seeder:
```sh
yarn docker up
```

2. Start Zero server:
```sh
yarn zero
```

3. Start Tauri development:
```sh
yarn dev:tauri
```

Or for web-only development:
```sh
yarn dev
```

### Note for Mac Users

On Mac, deep links don't work in dev mode. For testing authentication:
1. Build the production app: `yarn build:web && yarn tauri build`
2. Move the built app to Applications
3. Run from there while keeping development servers running

## Reset Data

To reset all data:
```sh
yarn docker:start:clean
```

## License

MIT
