import { defineConfig } from 'vite'
import { tamaguiPlugin } from '@tamagui/vite-plugin'
import { one } from 'one/vite'

export default defineConfig({
  plugins: [
    one({
      web: {
        defaultRenderMode: 'spa',
      },
    }),

    tamaguiPlugin({
      optimize: process.env.NODE_ENV === 'production',
      components: ['tamagui'],
      config: './src/tamagui/tamagui.config.ts',
      outputCSS: './src/tamagui/tamagui.css',
    }),
  ],
  resolve: {
    alias: {
      '~': '/src',
    },
  },
  build: {
    target: 'esnext',
    commonjsOptions: {
      transformMixedEsModules: true,
    },
    rollupOptions: {
      external: [
        '@react-navigation/elements',
        '@react-navigation/native',
        '@react-navigation/stack',
        '@react-navigation/core',
        'react-native',
        'react-native-web',
      ],
    },
  },
  optimizeDeps: {
    include: ['@react-navigation/elements'],
    esbuildOptions: {
      mainFields: ['module', 'main'],
      resolveExtensions: ['.web.js', '.js', '.ts', '.jsx', '.tsx'],
    },
  },
})
