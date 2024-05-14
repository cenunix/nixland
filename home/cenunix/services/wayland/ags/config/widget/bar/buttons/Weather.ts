import PanelButton from "../PanelButton";
import weather from "service/weather";
import options from "options";
import icons from "icons";
export default () =>
  PanelButton({
    class_name: "weather",
    // on_clicked: () => screenrecord.start(),
    visible: true,
    child: Widget.Box({
      children: [
        // Widget.Icon(icons.recorder.recording),
        Widget.Label({
          label: screenrecord.bind("timer").as((time) => {
            const sec = time % 60;
            const min = Math.floor(time / 60);
            return `${min}:${sec < 10 ? "0" + sec : sec}`;
          }),
        }),
      ],
    }),
  });
