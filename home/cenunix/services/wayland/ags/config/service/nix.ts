import icons from "lib/icons";
import { bash, dependencies } from "lib/utils";
import options from "options";

const CACHE = `${Utils.CACHE_DIR}/nixpkgs`;
const PREFIX = "legacyPackages.x86_64-linux.";
const MAX = options.launcher.nix.max;
const nixpkgs = options.launcher.nix.pkgs;

export type Nixpkg = {
  name: string;
  description: string;
  pname: string;
  version: string;
};

class Nix extends Service {
  static {
    Service.register(
      this,
      {},
      {
        available: ["boolean", "r"],
        ready: ["boolean", "rw"],
      },
    );
  }

  #db: { [name: string]: Nixpkg } = {};
  #ready = true;

  private set ready(r: boolean) {
    this.#ready = r;
    this.changed("ready");
  }

  get db() {
    // console.log(this.#db);
    return this.#db;
  }
  get ready() {
    return this.#ready;
  }
  get available() {
    return Utils.exec(
      "which nix",
      () => true,
      () => false,
    );
  }

  constructor() {
    super();
    if (!this.available) return this;
    this.#updateList();
    console.log("updating nix");
    nixpkgs.connect("changed", this.#updateList);
  }

  query = async (filter: string) => {
    if (!dependencies("fzf", "nix") || !this.#ready) {
      console.log("NOT FOUND FZF OR NIX");
      return [] as string[];
    }
    return bash(`cat ${CACHE} | fzf -f ${filter} -e | head -n ${MAX} `).then(
      (str) => str.split("\n").filter((i) => i),
    );
  };

  nix(cmd: string, bin: string, args: string) {
    return Utils.execAsync(
      `kitty nix ${cmd} ${nixpkgs}#${bin} --impure ${args}`,
    );
  }

  run = async (input: string) => {
    if (!dependencies("nix")) return;

    try {
      const [bin, ...args] = input.trim().split(/\s+/);

      this.ready = false;
      await this.nix("shell", bin, "--command sh -c 'exit'");
      this.ready = true;

      this.nix("run", bin, ["--", ...args].join(" "));
    } catch (err) {
      if (typeof err === "string")
        Utils.notify("NixRun Error", err, icons.nix.nix);
      else logError(err);
    } finally {
      this.ready = true;
    }
  };

  #updateList = async () => {
    if (!dependencies("nix")) return;

    console.log("updating list function hit");

    this.ready = false;
    this.#db = {};

    const search = await bash(`nix search ${nixpkgs} --json`);
    // const search = "";
    if (!search) {
      console.log("no search");
      this.ready = true;
      return;
    }

    const json = Object.entries(
      JSON.parse(search) as {
        [name: string]: Nixpkg;
      },
    );

    for (const [pkg, info] of json) {
      const name = pkg.replace(PREFIX, "");
      this.#db[name] = { ...info, name };
    }

    console.log("generating list");
    const list = Object.keys(this.#db).join("\n");
    console.log("list writing to file");
    await Utils.writeFile(list, CACHE);
    this.ready = true;
    // Utils.notify("NixRun Ready");
  };
}

export default new Nix();
