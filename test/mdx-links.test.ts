import { describe, expect, it } from "vitest";
import fs from "node:fs";
import path from "node:path";

const rootDir = path.join(__dirname, "..");
const contentDir = path.join(rootDir, "content", "base");
const examplesDir = path.join(rootDir, "registry", "base", "examples");
const uiDir = path.join(rootDir, "registry", "base", "ui");

function toPascalCase(name: string): string {
  return name
    .split("-")
    .map((part) => part.charAt(0).toUpperCase() + part.slice(1))
    .join("");
}

function collectFullTag(lines: string[], startIndex: number): string {
  let tag = lines[startIndex];
  let j = startIndex;
  while (!tag.includes("/>") && j < lines.length - 1) {
    j++;
    tag += " " + lines[j];
  }
  return tag;
}

function extractComponentPreviewNames(
  content: string,
  file: string
): Array<{ name: string; file: string; line: number }> {
  const results: Array<{ name: string; file: string; line: number }> = [];
  const lines = content.split("\n");

  for (let i = 0; i < lines.length; i++) {
    if (!lines[i].includes("<ComponentPreview")) continue;
    const tag = collectFullTag(lines, i);
    const nameMatch = tag.match(/name="([^"]+)"/);
    if (nameMatch) {
      results.push({ name: nameMatch[1], file, line: i + 1 });
    }
  }

  return results;
}

type ComponentSourceRef =
  | { kind: "src"; src: string; file: string; line: number }
  | { kind: "name"; name: string; file: string; line: number };

function extractComponentSourceRefs(
  content: string,
  file: string
): Array<ComponentSourceRef> {
  const results: Array<ComponentSourceRef> = [];
  const lines = content.split("\n");

  for (let i = 0; i < lines.length; i++) {
    if (!lines[i].includes("<ComponentSource")) continue;
    const tag = collectFullTag(lines, i);
    const srcMatch = tag.match(/src="([^"]+)"/);
    const nameMatch = tag.match(/name="([^"]+)"/);
    if (srcMatch) {
      results.push({ kind: "src", src: srcMatch[1], file, line: i + 1 });
    } else if (nameMatch) {
      results.push({ kind: "name", name: nameMatch[1], file, line: i + 1 });
    }
  }

  return results;
}

const mdxFiles = fs
  .readdirSync(contentDir)
  .filter((f) => f.endsWith(".mdx"));

describe("MDX ComponentPreview references", () => {
  const allPreviews: Array<{ name: string; file: string; line: number }> = [];

  for (const file of mdxFiles) {
    const content = fs.readFileSync(path.join(contentDir, file), "utf8");
    allPreviews.push(...extractComponentPreviewNames(content, file));
  }

  it.each(allPreviews)(
    '$file:$line — ComponentPreview name="$name" has a matching example .res file',
    ({ name }) => {
      const pascalName = toPascalCase(name);
      const resFile = path.join(examplesDir, pascalName + ".res");
      expect(
        fs.existsSync(resFile),
        `Expected ${resFile} to exist for ComponentPreview name="${name}"`
      ).toBe(true);
    }
  );
});

describe("MDX ComponentSource references", () => {
  const allSources: Array<ComponentSourceRef> = [];

  for (const file of mdxFiles) {
    const content = fs.readFileSync(path.join(contentDir, file), "utf8");
    allSources.push(...extractComponentSourceRefs(content, file));
  }

  const srcRefs = allSources.filter(
    (r): r is Extract<ComponentSourceRef, { kind: "src" }> => r.kind === "src"
  );
  const nameRefs = allSources.filter(
    (r): r is Extract<ComponentSourceRef, { kind: "name" }> => r.kind === "name"
  );

  if (srcRefs.length > 0) {
    it.each(srcRefs)(
      '$file:$line — ComponentSource src="$src" points to an existing file',
      ({ src }) => {
        const filePath = path.join(rootDir, src);
        expect(
          fs.existsSync(filePath),
          `Expected ${filePath} to exist for ComponentSource src="${src}"`
        ).toBe(true);
      }
    );
  }

  if (nameRefs.length > 0) {
    it.each(nameRefs)(
      '$file:$line — ComponentSource name="$name" has a matching UI .res file',
      ({ name }) => {
        const pascalName = toPascalCase(name);
        const resFile = path.join(uiDir, pascalName + ".res");
        expect(
          fs.existsSync(resFile),
          `Expected ${resFile} to exist for ComponentSource name="${name}"`
        ).toBe(true);
      }
    );
  }
});
