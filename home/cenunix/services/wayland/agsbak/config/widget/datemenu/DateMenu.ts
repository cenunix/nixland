import type Gtk from "gi://Gtk?version=3.0"
import PopupWindow from "widget/PopupWindow";
import NotificationColumn from "./NotificationColumn";
import DateColumn from "./DateColumn";
import { PopupContent } from "widget/weather/Weather";
import options from "options";

const { bar, datemenu } = options;
const pos = bar.position.bind();
const layout = Utils.derive(
  [bar.position, datemenu.position],
  (bar, qs) => `${bar}-${qs}` as const,
);

const Row = (
  toggles: Array<() => Gtk.Widget> = [],
  menus: Array<() => Gtk.Widget> = [],
) => Widget.Box({
  vertical: true,
  children: [
      Widget.Box({
          homogeneous: true,
          class_name: "row horizontal",
          children: toggles.map(w => w()),
      }),
      ...menus.map(w => w()),
  ],
})

const Settings = () =>
  Widget.Box({
    class_name: "datemenu horizontal",
    vexpand: false,
    children: [
      // NotificationColumn(),
      // Widget.Separator({ orientation: 1 }),
      // DateColumn(),
      // Widget.Separator({ }),
      Row(
        [NotificationColumn, DateColumn],
        [PopupContent],
    ),
      // PopupContent(),
    ],
  });

const DateMenu = () =>
  PopupWindow({
    name: "datemenu",
    exclusivity: "exclusive",
    transition: pos.as((pos) => (pos === "top" ? "slide_down" : "slide_up")),
    layout: layout.value,
    child: Settings(),
  });

export function setupDateMenu() {
  App.addWindow(DateMenu());
  layout.connect("changed", () => {
    App.removeWindow("datemenu");
    App.addWindow(DateMenu());
  });
}
