// Made by Tom16 to generate index.json

const { readdir, readFile, writeFile, stat } = require("fs/promises");
const crypto = require("crypto");
const path = require("path");

console.log("ARGV:", process.argv);

if (!process.argv[0].endsWith("node") && !process.argv[0].endsWith("node.exe"))
  __dirname = path.dirname(process.execPath);

console.log("DIRNAME:", __dirname);

const oldIndex = require("../../index.json");

(async () => {
  // Modules
  const modules = await readdir(path.join(__dirname, "../../Modules"));
  const moduleIndex = await Promise.all(
    modules.map(async (moduleFile) => {
      const oldModule = oldIndex.modules.find((x) => x.file === moduleFile);
      const moduleContent = await readFile(path.join(__dirname, "../../Modules", moduleFile)).then((x) => x.toString());

      const moduleName = moduleContent.match(/name\s*=\s*(['"])(.*?[^\\])\1/)[2];

      const moduleDesc = (moduleContent.match(/description\s*=\s*(['"])(.*?[^\\])\1/)?.[2] ?? "").replace(/\s+/g, " ");

      const moduleDeps = (moduleContent.match(/importLib\s*\(\s*['"]([^'"]+)['"]\s*\)/g) ?? []).map((x) =>
        x.match(/(['"])(.*?[^\\])\1/)[2].replace(/\.lua$/, "")
      );

      const moduleCommands = (moduleContent.match(/registerCommand\s*\((['"])(.*?[^\\])\1/g) ?? []).map(
        (x) => x.match(/(['"])(.+?)\1/)[2]
      );

      const moduleHash = crypto.createHash("md5").update(moduleContent).digest().toString("hex");
      const moduleLastUpdated = oldModule?.hash === moduleHash ? oldModule?.lastUpdated ?? new Date() : new Date();

      return {
        name: moduleName,
        description: moduleDesc,
        file: moduleFile,
        url: "https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/Modules/" + moduleFile,
        libs: moduleDeps,
        commands: moduleCommands,
        hash: moduleHash,
        lastUpdated: moduleLastUpdated,
      };
    })
  );

  // Commands
  const commands = await readdir(path.join(__dirname, "../../Commands"));
  const commandIndex = await Promise.all(
    commands.map(async (commandFile) => {
      const oldCommand = oldIndex.commands.find((x) => x.file === commandFile);
      const commandContent = await readFile(path.join(__dirname, "../../Commands", commandFile)).then((x) =>
        x.toString()
      );

      const commandName = commandContent.match(/command\s*=\s*(['"])(.*?[^\\])\1/)[2];

      const commandDesc = (commandContent.match(/help_message\s*=\s*(['"])(.*[^\\])\1/)?.[2] ?? "").replace(
        /\s+/g,
        " "
      );

      const commandDeps = (commandContent.match(/importLib\s*\(\s*['"]([^'"]+)['"]\s*\)/g) ?? []).map((x) =>
        x.match(/(['"])(.*?[^\\])\1/)[2].replace(/\.lua$/, "")
      );

      const commandHash = crypto.createHash("md5").update(commandContent).digest().toString("hex");
      const commandLastUpdated = oldCommand?.hash === commandHash ? oldCommand?.lastUpdated ?? new Date() : new Date();

      return {
        name: commandName,
        file: commandFile,
        description: commandDesc,
        url: "https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/Commands/" + commandFile,
        libs: commandDeps,
        hash: commandHash,
        lastUpdated: commandLastUpdated,
      };
    })
  );

  // Libs
  // 
  const libs = await readdir(path.join(__dirname, "../../Libs"));
  const libIndex = await Promise.all(
    libs.map(async (libFile) => {
      const oldLib = oldIndex.libs.find((x) => x.file === libFile);

      // temp, ill add this later but its here to make sure it still works if theres a folder before i code it
      if ((await stat(path.join(__dirname, "../../Libs", libFile))).isDirectory()) return;

      const libContent = await readFile(path.join(__dirname, "../../Libs", libFile));

      const libHash = crypto.createHash("md5").update(libContent).digest().toString("hex");
      const libLastUpdated = oldLib?.hash === libHash ? oldLib?.lastUpdated ?? new Date() : new Date();

      return {
        name: libFile.replace(/\.lua$/, ""),
        file: libFile,
        url: "https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/Libs/" + libFile,
        hash: libHash,
        lastUpdated: libLastUpdated,
      };
    }).filter(x => x)
  );

  //autocomplete
  const acConfigHash = crypto
    .createHash("md5")
    .update(await readFile(path.join(__dirname, "../../AutoComplete/config.lua")))
    .digest()
    .toString("hex");

  const acConfigLastUpdated =
    oldIndex.autocomplete.config.hash === acConfigHash
      ? oldIndex.autocomplete.config.lastUpdated ?? new Date()
      : new Date();

  const autocompleteConfig = {
    file: "config.lua",
    url: "https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/AutoComplete/config.lua",
    hash: acConfigHash,
    lastUpdated: acConfigLastUpdated,
  };

  const autocomplete = await readdir(path.join(__dirname, "../../AutoComplete/library"));
  const autocompleteIndex = await Promise.all(
    autocomplete.map(async (acFile) => {
      const oldACFile = oldIndex.autocomplete.library.find((x) => x.file === acFile);
      const acContent = await readFile(path.join(__dirname, "../../AutoComplete/library", acFile));

      const acHash = crypto.createHash("md5").update(acContent).digest().toString("hex");
      const acLastUpdated = oldACFile?.hash === acHash ? oldACFile?.lastUpdated ?? new Date() : new Date();

      return {
        file: acFile,
        url:
          "https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/AutoComplete/library/" +
          acFile,
        hash: acHash,
        lastUpdated: acLastUpdated,
      };
    })
  );

  const index = {
    modules: moduleIndex.sort((a, b) => a.name.localeCompare(b.name)),
    commands: commandIndex.sort((a, b) => a.name.localeCompare(b.name)),
    libs: libIndex.sort((a, b) => a.name.localeCompare(b.name)),
    autocomplete: {
      config: autocompleteConfig,
      library: autocompleteIndex.sort((a, b) => a.file.localeCompare(b.file)),
    },
  };

  await writeFile(path.join(__dirname, "../../index.json"), JSON.stringify(index, null, 2));

  return console.dir(index, { depth: null });
})();
