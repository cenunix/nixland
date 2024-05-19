import Weather from 'service/weather';
// import Widget from 'resource:///com/github/Aylur/ags/widget.js';
// import App from 'resource:///com/github/Aylur/ags/app.js';

interface TemperatureIndicatorProps {
    class_name?: string;
}

export const TemperatureIndicator = () => Widget.Stack({
    children: {
        true: PannelButton(),
        false: Widget.Label(),
    },
    setup: (self: any) => self.hook(Weather, () => {
        self.shown = Weather.temperatureWeather ? true : false;
    }),
});

export const PannelButton = (props?: TemperatureIndicatorProps) => Widget.Button({
    ...props,
    class_name: 'weather panel-button',
    child: Temperature(),
    on_clicked: () => App.toggleWindow('weather-menu'),
    on_secondary_click: () => Weather.weatherData,
    setup: (self: any) => self
        .hook(App, (_: any, win: string, visible: boolean) => {
            self.toggleClassName('active', win === 'weather-menu' && visible);
        }),
});

export const Temperature = (props?: TemperatureIndicatorProps) => Widget.Label({
    ...props,
    setup: (self: any) => self.hook(Weather, () => {
        console.log("Temperature function");

        if (Weather.temperatureWeather && self.label !== Weather.temperatureWeather) {
            self.label = Weather.temperatureWeather.toString();
        }
    }),
});

function weatherBackgroundStyle(icon: string, box: any): void {
    switch (icon) {
        case "🌇": {
            box.setCss(`
                background: linear-gradient(to bottom, #ff6f61, #ffca58, #f0e68c);
                color: #000000;
            `);
            break;
        }
        case "🌄": {
            box.setCss(`
                background: linear-gradient(to bottom, #ffcc00, #ff6f61, #ff5e62, #d55f74);
                color: #000000;
            `);
            break;
        }
        case "": {
            box.setCss(`
                background: linear-gradient(to bottom, #80b3ff, #ffffff, #ffdb4d);
                color: #000000;
            `);
            break;
        }
        case "󰖓": {
            box.setCss(`
                background: linear-gradient(to bottom, #0c0e23, #1a1c38, #121320, #0c0e23);
                color: #ffffff;
            `);
            break;
        }
        case "": {
            box.setCss(`
                background: linear-gradient(to bottom, #2c3e50, #1a2533);
                color: #ffffff;
            `);
            break;
        }
        case "": {
            box.setCss(`
                background: linear-gradient(to bottom, #001f3f, #002f4f, #003f5f, #004f6f, #005f7f);
                color: #ffffff;
            `);
            break;
        }
        case "": {
            box.setCss(`
                background: linear-gradient(to bottom, #ffeb99, #ffe580, #ffd866, #ffcf4c, #ffc333);
                color: #000000;
            `);
            break;
        }
        case "":
        case "": {
            box.setCss(`
                background: linear-gradient(to bottom, #c4c4c4, #d1d1d1, #dedede, #ebebeb, #f8f8f8);
                color: #000000;
            `);
            break;
        }
        case "": {
            box.setCss(`
                background: linear-gradient(to bottom, #1c2331, #212a38, #263141, #2b3749, #303d51);
                color: #ffffff;
            `);
            break;
        }
        case "": {
            box.setCss(`
                background: linear-gradient(to bottom, #d8d8d8, #e2e2e2, #ececec, #f6f6f6, #ffffff);
                color: #000000;
            `);
            break;
        }
        case "": {
            box.setCss(`
                background: linear-gradient(to bottom, #1c2331, #1c2331, #1c2331, #293547, #38475f);
                color: #ffffff;
            `);
            break;
        }
        case "⛈️": {
            box.setCss(`
                background: linear-gradient(to bottom, #2c3e50, #34495e, #2c3e50, #34495e, #2c3e50);
                color: #000000;
            `);
            break;
        }
        case "󰙾": {
            box.setCss(`
                background: linear-gradient(to bottom, #050818, #070b1d, #0a0e22, #0d1126, #10152b);
                color: #ffffff;
            `);
            break;
        }
        case "": {
            box.setCss(`
                background: linear-gradient(to bottom, #547aad, #6692b8, #78a9c3, #8abfd0, #9cd7dd);
                color: #000000;
            `);
            break;
        }
        case "": {
            box.setCss(`
                background: linear-gradient(to bottom, #0e1620, #121c2a, #162133, #18273c, #1c2c46);
                color: #ffffff;
            `);
            break;
        }
        case "⛅": {
            box.setCss(`
                background: linear-gradient(to bottom, #a8c9f0, #c4dfea, #f0f0cc, #ffd700, #f0f0cc, #c4dfea, #a8c9f0);
                color: #000000;
            `);
            break;
        }
        case "": {
            box.setCss(`
                background: linear-gradient(to bottom, #040d1c, #081427, #0c1a32, #101f3d, #142348);
                color: #ffffff;
            `);
            break;
        }
        case "": {
            box.setCss(`
                background: linear-gradient(to bottom, #5e7d99, #6a8ba6, #7698b3, #87a5bf, #97b3cb, #a6c0d8, #b4cedf);
                color: #000000;
            `);
            break;
        }
        case "": {
            box.setCss(`
                background: linear-gradient(to bottom, #050818, #070b1d, #0a0e22, #0d1126, #10152b);
                color: #ffffff;
            `);
            break;
        }
        case "": {
            box.setCss(`
                background: linear-gradient(to bottom, #d0e6ec, #e0f0f5, #f0f5f9, #f5fafd, #ffffff);
                color: #000000;
            `);
            break;
        }
        case "": {
            box.setCss(`
                background: linear-gradient(to bottom, #0e1620, #162133, #1c263f, #232c4c, #293259);
                color: #ffffff;
            `);
            break;
        }
        case "🌨️": {
            box.setCss(`
                background: linear-gradient(to bottom, #d0e6ec, #e0f0f5, #f0f5f9, #ffffff, #f0f5f9, #e0f0f5, #d0e6ec);
                color: #000000;
            `);
            break;
        }
        case "": {
            box.setCss(`
                background: linear-gradient(to bottom, #050818, #08142a, #0c1d3b, #101f47, #142556);
                color: #ffffff;
            `);
            break;
        }
        default: {
            box.setCss(`
                background: red;
                color: blue;
            `);
            break;
        }
    }
}

interface WeatherData {
    date: string;
    hour: string;
    icon: string;
    temperature: string;
    rain: string;
    maxTemp: string;
    minTemp: string;
}

export const WeatherInfo = (weatherData: WeatherData) => Widget.Box({
    class_name: 'weather-info',
    vertical: true,
    children: [
        Widget.Label({ label: weatherData.date.substring(0, 3).toUpperCase() }),
        Widget.Label({ label: weatherData.hour + 'h' }),
        Widget.Label({ label: weatherData.icon, class_name: 'weather-icon' }),
        Widget.Label({ label: weatherData.temperature, class_name: 'weather-temperature' }),
        Widget.Box({ vexpand: true }),
        weatherData.rain !== '0 mm' ? Widget.Label({ label: weatherData.rain }) : null,
        Widget.Label({ label: '↑ ' + weatherData.maxTemp, class_name: 'weather-max' }),
        Widget.Label({ label: '↓ ' + weatherData.minTemp, class_name: 'weather-min' }),
    ],
    setup: (self: any) => self.hook(Weather, () => {
        weatherBackgroundStyle(weatherData.icon, self);
    }),
});

function getMostCommon(arr: string[]): string {
    return arr.sort((a, b) =>
        arr.filter(v => v === a).length - arr.filter(v => v === b).length
    ).pop() as string;
}

export const WeatherBoxChild = (w: WeatherData) => Widget.Box({
    class_name: 'qs-weather-box-child',
    vertical: true,
    hexpand: true,
    children: [
        Widget.Label({ label: w.hour + 'h', class_name: 'weather-hour' }),
        Widget.Label({ label: w.icon, class_name: 'weather-icon' }),
        Widget.Label({ label: w.temperature, class_name: 'weather-temperature' }),
        Widget.Box({ vexpand: true }),
        w.rain !== '0 mm' ? Widget.Label({ label: w.rain, class_name: 'weather-rain' }) : null,
        Widget.Label({ label: "  " + Math.round(parseInt(w.wind.replace(/mph$/, ''))) + ' mph', class_name: 'weather-wind' }),
    ],
});

export const WeatherBoxChildWrapper = (w: WeatherData, temperatureDataPerDay: any, totalWeatherForecastDataArray: WeatherData[]) => Widget.Box({
    class_name: 'qs-weather-box-child-wrapper',
    hexpand: true,
    setup: (self: any) => self.hook(Weather, () => {
        let useTotalInstead = false;

        if (totalWeatherForecastDataArray.length) {
            useTotalInstead = true;

            totalWeatherForecastDataArray.forEach(totalEl => {
                self.add(
                    WeatherBoxChild(totalEl),
                );
            });
        }

        if (!useTotalInstead && w && temperatureDataPerDay && temperatureDataPerDay[w.date.substring(0, 3).toUpperCase()].data.length) {
            temperatureDataPerDay[w.date.substring(0, 3).toUpperCase()].data.forEach((el: WeatherData) => {
                self.add(
                    WeatherBoxChild(el),
                );
            });
        }
    }),
});

export const WeatherMainWidget = (widgetIcon: string, widgetDate: string, rain: string, temperatureDataPerDay: any, w: WeatherData, totalWeatherForecastDataArray: WeatherData[] = []) => Widget.Box({
    class_name: 'qsweather-widget',
    vertical: true,
    hexpand: true,
    children: [
        Widget.Box({
            class_name: 'qs-weather-box-main',
            children: [
                Widget.Label({ label: widgetIcon, class_name: 'weather-icon' }),
                rain != '0' ? Widget.Label({ label: rain + 'mm', class_name: 'weather-rain' }) : null,
                Widget.Box({ hexpand: true }),
                Widget.Label({ label: '↑ ' + temperatureDataPerDay[widgetDate.substring(0, 3).toUpperCase()].maxTemp + '  ', class_name: 'weather-max' }),
                Widget.Label({ label: '↓ ' + temperatureDataPerDay[widgetDate.substring(0, 3).toUpperCase()].minTemp + '  ', class_name: 'weather-min' }),
                Widget.Label({ label: widgetDate.substring(0, 3).toUpperCase(), class_name: 'weather-hour' }),
            ]
        }),
        WeatherBoxChildWrapper(w, temperatureDataPerDay, totalWeatherForecastDataArray)
    ],
    setup: (self: any) => self.hook(Weather, () => {
        weatherBackgroundStyle(widgetIcon, self);
    }),
});

export const Tooltip = (total: number | null = null) => Widget.Box({
    setup: (self: any) => self.hook(Weather, () => {
        let tooltip = Weather.tooltip;

        if (tooltip) {
            self.get_children().forEach((ch: any) => ch.destroy());

            let prevDayName = null;
            let temperatureDataPerDay: any = {};
            let weatherStatusIconArray: string[] = [];
            let weatherForecastDataArray: WeatherData[] = [];
            let totalWeatherForecastDataArray: WeatherData[] = [];

            let totalWeatherForecastsCounter = total;
            let forecastWidgetsNumber = 0;

            tooltip.forEach((w: WeatherData) => {
                if (w.date !== prevDayName) {
                    weatherStatusIconArray = [];
                    prevDayName = w.date;
                    forecastWidgetsNumber = 0;
                    weatherForecastDataArray = [];
                }

                const date = w.date.substring(0, 3).toUpperCase();
                const temperature = parseInt(w.temperature);

                const rain = w.rain.replace(/ mm$/, '');
                forecastWidgetsNumber += 1;

                weatherForecastDataArray.push(w);

                if (total && totalWeatherForecastsCounter && totalWeatherForecastsCounter > 0) {
                    totalWeatherForecastDataArray.push(w);
                    totalWeatherForecastsCounter -= 1;
                }

                if (!temperatureDataPerDay[date]) {
                    temperatureDataPerDay[date] = {
                        minTemp: temperature,
                        maxTemp: temperature,
                        rain: rain,
                        icons: [],
                        widgetsNumber: forecastWidgetsNumber,
                        data: weatherForecastDataArray,
                    };
                } else {
                    temperatureDataPerDay[date].minTemp = Math.min(temperatureDataPerDay[date].minTemp, temperature);
                    temperatureDataPerDay[date].maxTemp = Math.max(temperatureDataPerDay[date].maxTemp, temperature);
                    temperatureDataPerDay[date].rain = Math.max(temperatureDataPerDay[date].rain, rain);
                    temperatureDataPerDay[date].icons = weatherStatusIconArray;
                    temperatureDataPerDay[date].widgetsNumber = forecastWidgetsNumber;
                    temperatureDataPerDay[date].data = weatherForecastDataArray;
                }

                if (w.hour >= 7 && w.hour <= 19) {
                    weatherStatusIconArray.push(w.icon);
                }
            });

            prevDayName = null;

            let widgetIcon: string | null = null;
            let widgetDate: string | null = null;

            let w: WeatherData | null = null;
            for (let i = 0; i < tooltip.length; i++) {
                w = tooltip[i];

                if (total && total >= 0) {

                    if (!widgetIcon) {
                        widgetIcon = w.icon;
                    }

                    if (!widgetDate) {
                        widgetDate = w.date;
                    }

                    const rain = temperatureDataPerDay[widgetDate.substring(0, 3).toUpperCase()].rain;

                    self.add(
                        WeatherMainWidget(widgetIcon, widgetDate, rain, temperatureDataPerDay, w, totalWeatherForecastDataArray)
                    );
                    break;
                }

                if (w.date !== prevDayName && i > 0) {
                    self.add(
                        Widget.Box({
                            children: [
                                Widget.Label({ label: ' ', class_name: 'weather-spacing' }),
                            ],
                        }),
                    );
                }

                if (temperatureDataPerDay[w.date.substring(0, 3).toUpperCase()].widgetsNumber === 1) {
                    prevDayName = w.date;

                    self.add(WeatherInfo(w));
                    continue;
                }

                if (w.date !== prevDayName) {
                    const rain = temperatureDataPerDay[w.date.substring(0, 3).toUpperCase()].rain;
                    let icon = getMostCommon(temperatureDataPerDay[w.date.substring(0, 3).toUpperCase()].icons);
                    widgetDate = w.date;

                    if (!icon) {
                        icon = w.icon;
                    }

                    widgetIcon = icon;

                    self.add(
                        WeatherMainWidget(widgetIcon, widgetDate, rain, temperatureDataPerDay, w)
                    );
                }

                prevDayName = w.date;
            };
        }
    }),
});

export const ResetTimer = (props?: any) => Widget.Label({
    ...props,
    setup: (self: any) => {
        self.poll(600000, () => {
            Weather.weatherData;
        });
    },
});

export const Forecast = () => Widget.Box({
    class_name: 'datemenu',
    vertical: true,
    children: [
        Widget.Box({
            class_name: 'tooltip',
            children: [
                ResetTimer(),
                Tooltip(),
            ]
        })
    ]
});

export const PopupContent = () => Widget.Box({
    class_name: 'weather',
    vexpand: false,
    children: [
        Widget.Box({
            vertical: true,
            children: [
                Forecast(),
                RefreshButton(),
            ]
        })
    ]
});

export const RefreshButton = (props?: any) => Widget.Button({
    ...props,
    class_name: 'weather-refresh',
    child: Widget.Icon({
        icon: 'view-refresh-symbolic',
        hpack: 'end',
    }),
    on_clicked: () => {
        Weather.weatherData;
    },
});