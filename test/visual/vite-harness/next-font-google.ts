/**
 * Stub for next/font/google - used by parity tests in Vite (no Next.js runtime).
 * Returns a minimal font descriptor so components that use next/font can render.
 */
function createFontStub(_config?: { subsets?: string[] }) {
  return {
    className: "",
    style: {},
    variable: undefined,
  }
}

// Re-export common fonts - return the stub for any font name
export const Inter = createFontStub
export const Vazirmatn = createFontStub
export const Noto_Sans_Arabic = createFontStub
export const Geist = createFontStub
export const Geist_Mono = createFontStub
export const Roboto = createFontStub
export const JetBrains_Mono = createFontStub
export const Figtree = createFontStub
export const Nunito_Sans = createFontStub
export const Noto_Sans = createFontStub
