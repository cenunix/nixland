import GLib from "gi://GLib";
import icons from "lib/icons";
import { dependencies, sh, bash } from "lib/utils";

const now = () => GLib.DateTime.new_now_local().format("%Y-%m-%d_%H-%M-%S");

class Recorder extends Service {
  static {
    Service.register(
      this,
      {},
      {
        timer: ["int"],
        recording: ["boolean"],
      },
    );
  }

  #recordings = Utils.HOME + "/Videos/Screencasting";
  #screenshots = Utils.HOME + "/Pictures/Screenshots";
  #file = "";
  #interval = 0;

  recording = false;
  timer = 0;

  async start() {
    if (!dependencies("gpu-screen-recorder")) return;

    if (this.recording) {
      this.stop();
      return;
    }

    Utils.ensureDirectory(this.#recordings);
    this.#file = `${this.#recordings}/${now()}.mp4`;
    bash(
      // `gpu-screen-recorder -w "$(hyprctl -j monitors | jq -r '.[] | select(.focused == true) | .name')" -a "$(pactl get-default-sink).monitor|$(pactl get-default-source)" -o ${this.#file} -f 60 -c mkv -k hevc -q very_high`,
      `gpu-screen-recorder -w "$(hyprctl -j monitors | jq -r '.[] | select(.focused == true) | .name')" -a "$(pactl get-default-sink).monitor" -o ${this.#file} -f 60 -c mkv -k hevc -q very_high`,
      // `wf - recorder - g "${await sh("slurp")}" - f ${
      // this.#file
      // } --pixel-format yuv420p`,
    );

    this.recording = true;
    this.changed("recording");

    this.timer = 0;
    this.#interval = Utils.interval(1000, () => {
      this.changed("timer");
      this.timer++;
    });
  }

  async stop() {
    if (!this.recording) return;

    await bash("killall -SIGINT .gpu-screen-rec");
    this.recording = false;
    this.timer = 0;
    this.changed("recording");
    this.changed("timer");
    GLib.source_remove(this.#interval);

    Utils.notify({
      iconName: icons.fallback.video,
      summary: "Screenrecord",
      body: this.#file,
      actions: {
        "Show in Files": () => sh(`xdg-open ${this.#recordings}`),
        View: () => sh(`xdg-open ${this.#file}`),
      },
    });
  }

  async screenshot(full = false) {
    if (!dependencies("grimblast", "satty")) return;

    const file = `${this.#screenshots}/${now()}.png`;
    Utils.ensureDirectory(this.#screenshots);

    if (full) {
      await bash(`grimblast save output ${file}`);
    } else {
      // const size = await sh("slurp");
      // if (!size) return;

      await bash(`grimblast save area ${file}`);
      console.log("GRIMBLAST FINISHED");
    }

    bash(`wl-copy < ${file}`);

    Utils.notify({
      image: file,
      summary: "Screenshot",
      body: file,
      actions: {
        "Show in Files": () => sh(`xdg-open ${this.#screenshots}`),
        View: () => sh(`xdg-open ${file}`),
        Edit: () => {
          if (dependencies("satty")) sh(`satty -f ${file}`);
        },
      },
    });
  }
}

const recorder = new Recorder();
Object.assign(globalThis, { recorder });
export default recorder;
