import { PopupContent } from "./Weather";
// import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import PopupWindow from "widget/PopupWindow";
// import options from 'options';

// interface PopupWindowSetup {
//     anchor: string[];
//     transition: string;
//     hook(position: any, callback: () => void): void;
// }

export const WeatherMenu = () =>
  PopupWindow({
    name: "weather-menu",
    class_names: ["weather-popup", "popup-window"],
    exclusivity: "exclusive",
    transition: "slide_down",
    layout: "top",
    child: PopupContent(),
  });

export function setupWeatherPopup() {
  App.addWindow(WeatherMenu());

  // const updateWeatherPopup = () => {
  //   App.removeWindow("weather-menu");
  //   App.advdWindow(WeatherMenu());
  // };
}
// export default () => PopupWindow({
//     name: 'weather',
//     setup: (self: PopupWindowSetup) => self.hook(options.bar.position, () => {
//         self.anchor = [options.bar.position.value];
//         if (options.bar.position.value === 'top') {
//             self.transition = 'slide_down';
//         }

//         if (options.bar.position.value === 'bottom') {
//             self.transition = 'slide_up';
//         }
//     }),
//     child: Widget.Box({
//         class_name: 'dashboard',
//         children: [
//             PopupContent(),
//         ],
//     }),
// });
