class Weather extends Service {
    private _temperatureWeather: number | null;
    private _tooltip: string | null;

    static {
        Service.register(this);
    }

    constructor() {
        super();
        this._temperatureWeather = null;
        this._tooltip = null;
        globalThis.weather = this;
    }

    get weatherData(): void {
        console.log('weatherData')
        Utils.execAsync(['bash', '-c', "~/.config/scripts/openweathermap.sh ags"]).catch(console.error);
    }

    get temperatureWeather(): number | null {
        console.log(this._temperatureWeather)
        return this._temperatureWeather;
    }

    setTemperatureWeather(temp: number): void {
        this._temperatureWeather = temp;
        this.emit('changed');
    }

    get tooltip(): string | null {
        return this._tooltip;
    }

    setTooltip(text: string): void {
        this._tooltip = text;
    }
}

export default new Weather();