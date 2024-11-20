import { Variable, exec } from "astal";

const weatherCommand = [
	"curl",
	"https://api.weatherapi.com/v1/forecast.json?key=caefc3e178484e2da38112101240404&q=Perm&days=1&aqi=no&alerts=no",
];

export const weather = Variable<any | null>(null).poll(
	30_000,
	weatherCommand,
	(out, prev) => JSON.parse(out),
);
