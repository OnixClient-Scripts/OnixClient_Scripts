// This needs to be run in the website (in console or something) not in nodejs

const files = [];

for (const child of document.querySelector(
  "#repo-content-turbo-frame > react-app > div > div > div.Box-sc-g0xbh4-0.fSWWem > div > div > main > div.Box-sc-g0xbh4-0.hlUAHL > div > div:nth-child(3) > div.Box-sc-g0xbh4-0.yfPnm > div > div > table > tbody"
).children)
  files.push({
    file: [...child.children].at(1)?.innerText,
    lastUpdated: [...child.children].at(-1).children[0].children[0]?.getAttribute?.("datetime"),
  });

console.log(JSON.stringify(files.filter((x) => x.file).map((x) => ({ ...x, file: x.file.split("\n")[0] }))));
