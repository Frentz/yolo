import { betterAuth } from 'better-auth'
import { bearer, jwt } from 'better-auth/plugins'
import * as PG from 'pg'

export const auth = betterAuth({
  database: new PG.Pool({
    connectionString: 'postgresql://user:password@localhost:5432/postgres',
  }),

  plugins: [
    jwt({
      jwt: {
        expirationTime: '3y',
      },

      jwks: {
        // default
        keyPairConfig: { alg: 'EdDSA', crv: 'Ed25519' },
      },
    }),

    bearer(),
  ],

  socialProviders: {
    github: {
      clientId: process.env.GITHUB_CLIENT_ID as string,
      clientSecret: process.env.GITHUB_CLIENT_SECRET as string,
      callbackURL: 'http://localhost:8081/api/auth/callback/github',
      scope: ['user:email'],
    },
  },

  // Add explicit configuration for callbacks
  callbacks: {
    redirect: {
      success: 'http://localhost:8081/',
      error: 'http://localhost:8081/error',
    },
  },
})
