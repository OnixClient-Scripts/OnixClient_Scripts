// Made by Tom16 to generate index.json

const { readdir, readFile, writeFile } = require("fs/promises");
const path = require("path");

(async () => {
    //modules
    const modules = await readdir(path.join(__dirname, "Modules"));
    const moduleIndex = await Promise.all(
        modules.map(async (moduleFile) => {
            const moduleContent = await readFile(path.join(__dirname, "Modules", moduleFile)).then((x) => x.toString());
            const moduleName = moduleContent.match(/name( *?)=( *?)(.+?)(\r|\n)/g)[0].match(/(('|")(.+?)('|"))/)[3];
            const moduleDesc = moduleContent
                .match(/description( *?)=( *?)(.+?)(\r|\n)/g)[0]
                .match(/(('|")(.+?)('|"))/)?.[3];
            const moduleDeps =
                moduleContent
                    .match(/importLib( *?)\(( *?)("|')(.+?)("|')\)/g)
                    ?.map?.((x) => x.match(/(('|")(.+?)('|"))/)[3].replace(/\.lua$/, "")) ?? [];
            const moduleCommands =
                moduleContent
                    .match(/registerCommand( *?)\(('|")(.+?)('|")/g)
                    ?.map?.((x) => x.match(/(('|")(.+?)('|"))/)[3]) ?? [];
            return {
                name: moduleName,
                file: moduleFile,
                description: moduleDesc,
                url:
                    "https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/Modules/" +
                    moduleFile,
                libs: moduleDeps,
                commands: moduleCommands,
            };
        })
    );

    //commands
    const commands = await readdir(path.join(__dirname, "Commands"));
    const commandIndex = await Promise.all(
        commands.map(async (commandFile) => {
            const commandContent = await readFile(path.join(__dirname, "Commands", commandFile)).then((x) =>
                x.toString()
            );
            const commandName = commandContent
                .match(/command( *?)=( *?)(.+?)(\r|\n)/g)[0]
                .match(/(('|")(.+?)('|"))/)[3];
            const commandDesc = commandContent
                .match(/help_message( *?)=( *?)(.+?)(\r|\n)/g)[0]
                .match(/(('|")(.+?)('|"))/)?.[3];
            const commandDeps =
                commandContent
                    .match(/importLib( *?)\(( *?)("|')(.+?)("|')\)/g)
                    ?.map?.((x) => x.match(/(('|")(.+?)('|"))/)[3].replace(/\.lua$/, "")) ?? [];

            return {
                name: commandName,
                file: commandFile,
                description: commandDesc,
                url:
                    "https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/Commands/" +
                    commandFile,
                libs: commandDeps,
            };
        })
    );

    //libs
    const libs = await readdir(path.join(__dirname, "Libs"));
    const libIndex = libs.map((libFile) => ({
        name: libFile.replace(/\.lua$/, ""),
        file: libFile,
        url: "https://raw.githubusercontent.com/OnixClient-Scripts/OnixClient_Scripts/master/Libs/" + libFile,
    }));

    const index = {
        modules: moduleIndex,
        commands: commandIndex,
        libs: libIndex,
    };
    await writeFile("./index.json", JSON.stringify(index, null, 2));
    console.dir(index, { depth: 2 });
})();
