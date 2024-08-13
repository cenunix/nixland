import PanelButton from "../PanelButton";
import { cpu } from "lib/variables";
import icons from "lib/icons";

export default () =>
  PanelButton({
    class_name: "sysinfo",
    visible: true,
    child: Widget.Box({
      children: [
        Widget.Icon(icons.system.cpu),
        Widget.Label({
            label: cpu.bind() + "%",
        }),
      ],
    }),
  });
