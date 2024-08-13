// import PanelButton from "../PanelButton";
// import weather from "service/weather";
// import options from "options";
// import icons from "icons";
// // import WeatherPopup from "../../weather/WeatherPopup";

// export default () => {
//   const label = Widget.Label({
//     label: "Loading...",
//   });

//   // const popup = WeatherPopup();

//   // Update label with the current temperature when the forecasts change
//   weather.connect("changed", () => {
//     const forecasts = weather.forecasts;
//     if (forecasts.length > 0) {
//       const currentForecast = forecasts[0]; // Assuming you want the first city's forecast
//       const currentTemp = currentForecast.list[0].main.temp; // Get the current temperature
//       label.label = `Current Temperature: ${currentTemp}°${
//         options.datemenu.weather.unit.value === "metric" ? "C" : "F"
//       }`;
//     } else {
//       label.label = "No data available.";
//     }
//   });

//   // Ensure the weather service is instantiated and fetching data
//   if (weather.forecasts.length === 0) {
//     console.log("Waiting for weather data...");
//   }

//   return PanelButton({
//     class_name: "weather",
//     visible: true,
//     child: Widget.Box({
//       children: [label],
//     }),
//     on_clicked: () => {
//       App.toggleWindow("weather-menu");
//     },
//   });
// };
