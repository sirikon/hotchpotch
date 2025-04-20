import { readFile, writeFile, mkdir } from "fs/promises";

import * as esbuild from "esbuild";
import { sassPlugin } from "esbuild-sass-plugin";

const UI_PORT = parseInt(process.env.UI_PORT);
const HP_VERSION = process.env.HP_VERSION || "dev";

const CONFIG = {
  entryPoints: ["src/main.ts"],
  bundle: true,
  outdir: "dist",
  plugins: [sassPlugin()],
  loader: { ".ttf": "file" },
};

const commands = {
  build,
  serve,
};

async function main() {
  await generateIndex();
  await commands[process.argv[2]]();
}

async function build() {
  await esbuild.build({
    ...CONFIG,
    minify: true,
  });
}

async function serve() {
  const ctx = await esbuild.context({
    ...CONFIG,
    sourcemap: true,
  });

  await ctx.serve({
    servedir: "dist",
    port: UI_PORT,
  });
}

async function generateIndex() {
  let indexContent = await readFile("src/index.html", {
    encoding: "utf-8",
  });
  indexContent = indexContent.replace(
    /__HP_VERSION__/g,
    HP_VERSION
  );
  await mkdir("dist", { recursive: true });
  await writeFile("dist/index.html", indexContent);
}

await main();
