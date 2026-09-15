import { configDefaults, defineConfig } from "vitest/config"

export default defineConfig({
  test: {
    exclude: [
      ...configDefaults.exclude,
      "**/node_modules/**",
      "**/fixtures/**",
      "**/templates/**",
    ],
    testTimeout: 8000,
    // Async Markdown highlighting can race capture under parallel load.
    maxConcurrency: 1,
  },
  plugins: [],
})
