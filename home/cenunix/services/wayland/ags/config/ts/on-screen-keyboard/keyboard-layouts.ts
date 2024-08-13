// TODO: right Ctrl https://handwiki.org/wiki/images/4/41/KB_Canadian_Multilingual_Standard.svg

export const defaultOskLayout = 'qwerty_custom';
export const oskLayouts = {
    qwerty_custom: {
        name: 'QWERTY - Custom',
        name_short: 'CSA',
        comment: 'Like physical keyboard',
        // A normal key looks like this: {label: "a", labelShift: "A", shape: "normal", keycode: 30, type: "normal"}
        // A modkey looks like this: {label: "Ctrl", shape: "control", keycode: 29, type: "modkey"}
        // key types are: normal, tab, caps, shift, control, fn (normal w/ half height), space, expand
        keys: [
            [
                {
                    keytype: 'normal',
                    label: 'Esc',
                    shape: 'fn',
                    keycode: 1,
                },
                {
                    keytype: 'normal',
                    label: 'F1',
                    shape: 'fn',
                    keycode: 59,
                },
                {
                    keytype: 'normal',
                    label: 'F2',
                    shape: 'fn',
                    keycode: 60,
                },
                {
                    keytype: 'normal',
                    label: 'F3',
                    shape: 'fn',
                    keycode: 61,
                },
                {
                    keytype: 'normal',
                    label: 'F4',
                    shape: 'fn',
                    keycode: 62,
                },
                {
                    keytype: 'normal',
                    label: 'F5',
                    shape: 'fn',
                    keycode: 63,
                },
                {
                    keytype: 'normal',
                    label: 'F6',
                    shape: 'fn',
                    keycode: 64,
                },
                {
                    keytype: 'normal',
                    label: 'F7',
                    shape: 'fn',
                    keycode: 65,
                },
                {
                    keytype: 'normal',
                    label: 'F8',
                    shape: 'fn',
                    keycode: 66,
                },
                {
                    keytype: 'normal',
                    label: 'F9',
                    shape: 'fn',
                    keycode: 67,
                },
                {
                    keytype: 'normal',
                    label: 'F10',
                    shape: 'fn',
                    keycode: 68,
                },
                {
                    keytype: 'normal',
                    label: 'F11',
                    shape: 'fn',
                    keycode: 87,
                },
                {
                    keytype: 'normal',
                    label: 'F12',
                    shape: 'fn',
                    keycode: 88,
                },
                {
                    keytype: 'normal',
                    label: 'Home',
                    shape: 'fn',
                    keycode: 110,
                },
                {
                    keytype: 'normal',
                    label: 'End',
                    shape: 'fn',
                    keycode: 115,
                },
                {
                    keytype: 'normal',
                    label: 'Del',
                    shape: 'fn',
                    keycode: 111,
                },
            ],
            [
                {
                    keytype: 'normal',
                    label: '/',
                    labelShift: '\\',
                    labelAltGr: '|',
                    shape: 'normal',
                    keycode: 41,
                },
                {
                    keytype: 'normal',
                    label: '1',
                    labelShift: '!',
                    shape: 'normal',
                    keycode: 2,
                },
                {
                    keytype: 'normal',
                    label: '2',
                    labelShift: '@',
                    shape: 'normal',
                    keycode: 3,
                },
                {
                    keytype: 'normal',
                    label: '3',
                    labelShift: '#',
                    labelAltGr: '¤',
                    shape: 'normal',
                    keycode: 4,
                },
                {
                    keytype: 'normal',
                    label: '4',
                    labelShift: '$',
                    shape: 'normal',
                    keycode: 5,
                },
                {
                    keytype: 'normal',
                    label: '5',
                    labelShift: '%',
                    shape: 'normal',
                    keycode: 6,
                },
                {
                    keytype: 'normal',
                    label: '6',
                    labelShift: '?',
                    shape: 'normal',
                    keycode: 7,
                },
                {
                    keytype: 'normal',
                    label: '7',
                    labelShift: '&',
                    labelAltGr: '{',
                    shape: 'normal',
                    keycode: 8,
                },
                {
                    keytype: 'normal',
                    label: '8',
                    labelShift: '*',
                    labelAltGr: '}',
                    shape: 'normal',
                    keycode: 9,
                },
                {
                    keytype: 'normal',
                    label: '9',
                    labelShift: '(',
                    labelAltGr: '[',
                    shape: 'normal',
                    keycode: 10,
                },
                {
                    keytype: 'normal',
                    label: '0',
                    labelShift: ')',
                    labelAltGr: ']',
                    shape: 'normal',
                    keycode: 11,
                },
                {
                    keytype: 'normal',
                    label: '-',
                    labelShift: '_',
                    shape: 'normal',
                    keycode: 12,
                },
                {
                    keytype: 'normal',
                    label: '=',
                    labelShift: '+',
                    labelAltGr: '¬',
                    shape: 'normal',
                    keycode: 13,
                },
                {
                    keytype: 'normal',
                    label: 'Backspace',
                    shape: 'expand',
                    keycode: 14,
                },
            ],
            [
                {
                    keytype: 'normal',
                    label: 'Tab',
                    shape: 'tab',
                    keycode: 15,
                },
                {
                    keytype: 'normal',
                    label: 'q',
                    labelShift: 'Q',
                    shape: 'normal',
                    keycode: 16,
                },
                {
                    keytype: 'normal',
                    label: 'w',
                    labelShift: 'W',
                    shape: 'normal',
                    keycode: 17,
                },
                {
                    keytype: 'normal',
                    label: 'e',
                    labelShift: 'E',
                    labelAltGr: '€',
                    shape: 'normal',
                    keycode: 18,
                },
                {
                    keytype: 'normal',
                    label: 'r',
                    labelShift: 'R',
                    shape: 'normal',
                    keycode: 19,
                },
                {
                    keytype: 'normal',
                    label: 't',
                    labelShift: 'T',
                    shape: 'normal',
                    keycode: 20,
                },
                {
                    keytype: 'normal',
                    label: 'y',
                    labelShift: 'Y',
                    shape: 'normal',
                    keycode: 21,
                },
                {
                    keytype: 'normal',
                    label: 'u',
                    labelShift: 'U',
                    shape: 'normal',
                    keycode: 22,
                },
                {
                    keytype: 'normal',
                    label: 'i',
                    labelShift: 'I',
                    shape: 'normal',
                    keycode: 23,
                },
                {
                    keytype: 'normal',
                    label: 'o',
                    labelShift: 'O',
                    shape: 'normal',
                    keycode: 24,
                },
                {
                    keytype: 'normal',
                    label: 'p',
                    labelShift: 'P',
                    shape: 'normal',
                    keycode: 25,
                },
                {
                    keytype: 'normal',
                    label: '^',
                    labelShift: '"',
                    labelAltGr: '`',
                    shape: 'normal',
                    keycode: 26,
                },
                {
                    keytype: 'normal',
                    label: 'ç',
                    labelShift: 'Ç',
                    labelAltGr: '~',
                    shape: 'normal',
                    keycode: 27,
                },
                {
                    keytype: 'normal',
                    label: 'à',
                    labelShift: 'À',
                    shape: 'expand',
                    keycode: 43,
                },
            ],
            [
                {
                    keytype: 'normal',
                    label: 'Caps',
                    shape: 'caps',
                    keycode: 58,
                },
                {
                    keytype: 'normal',
                    label: 'a',
                    labelShift: 'A',
                    shape: 'normal',
                    keycode: 30,
                },
                {
                    keytype: 'normal',
                    label: 's',
                    labelShift: 'S',
                    shape: 'normal',
                    keycode: 31,
                },
                {
                    keytype: 'normal',
                    label: 'd',
                    labelShift: 'D',
                    shape: 'normal',
                    keycode: 32,
                },
                {
                    keytype: 'normal',
                    label: 'f',
                    labelShift: 'F',
                    shape: 'normal',
                    keycode: 33,
                },
                {
                    keytype: 'normal',
                    label: 'g',
                    labelShift: 'G',
                    shape: 'normal',
                    keycode: 34,
                },
                {
                    keytype: 'normal',
                    label: 'h',
                    labelShift: 'H',
                    shape: 'normal',
                    keycode: 35,
                },
                {
                    keytype: 'normal',
                    label: 'j',
                    labelShift: 'J',
                    shape: 'normal',
                    keycode: 36,
                },
                {
                    keytype: 'normal',
                    label: 'k',
                    labelShift: 'K',
                    shape: 'normal',
                    keycode: 37,
                },
                {
                    keytype: 'normal',
                    label: 'l',
                    labelShift: 'L',
                    shape: 'normal',
                    keycode: 38,
                },
                {
                    keytype: 'normal',
                    label: ';',
                    labelShift: ':',
                    labelAltGr: '°',
                    shape: 'normal',
                    keycode: 39,
                },
                {
                    keytype: 'normal',
                    label: 'è',
                    labelShift: 'È',
                    shape: 'normal',
                    keycode: 40,
                },
                {
                    keytype: 'normal',
                    label: 'Enter',
                    shape: 'expand',
                    keycode: 28,
                },
            ],
            [
                {
                    keytype: 'modkey',
                    label: 'Shift',
                    shape: 'shift',
                    keycode: 42,
                },
                {
                    keytype: 'normal',
                    label: 'z',
                    labelShift: 'Z',
                    labelAltGr: '«',
                    shape: 'normal',
                    keycode: 44,
                },
                {
                    keytype: 'normal',
                    label: 'x',
                    labelShift: 'X',
                    labelAltGr: '»',
                    shape: 'normal',
                    keycode: 45,
                },
                {
                    keytype: 'normal',
                    label: 'c',
                    labelShift: 'C',
                    shape: 'normal',
                    keycode: 46,
                },
                {
                    keytype: 'normal',
                    label: 'v',
                    labelShift: 'V',
                    shape: 'normal',
                    keycode: 47,
                },
                {
                    keytype: 'normal',
                    label: 'b',
                    labelShift: 'B',
                    shape: 'normal',
                    keycode: 48,
                },
                {
                    keytype: 'normal',
                    label: 'n',
                    labelShift: 'N',
                    shape: 'normal',
                    keycode: 49,
                },
                {
                    keytype: 'normal',
                    label: 'm',
                    labelShift: 'M',
                    shape: 'normal',
                    keycode: 50,
                },
                {
                    keytype: 'normal',
                    label: ',',
                    labelShift: "'",
                    labelAltGr: '<',
                    shape: 'normal',
                    keycode: 51,
                },
                {
                    keytype: 'normal',
                    label: '.',
                    labelShift: '"',
                    labelAltGr: '>',
                    shape: 'normal',
                    keycode: 52,
                },
                {
                    keytype: 'normal',
                    label: 'é',
                    labelShift: 'É',
                    shape: 'normal',
                    keycode: 53,
                },
                {
                    keytype: 'modkey',
                    label: 'Shift',
                    shape: 'expand',
                    keycode: 54,
                },
            ],
            [
                {
                    keytype: 'modkey',
                    label: 'Ctrl',
                    shape: 'control',
                    keycode: 29,
                },
                {
                    keytype: 'modkey',
                    label: 'Super',
                    shape: 'normal',
                    keycode: 125,
                },
                {
                    keytype: 'modkey',
                    label: 'Alt',
                    shape: 'normal',
                    keycode: 56,
                },
                {
                    keytype: 'normal',
                    label: 'Space',
                    shape: 'space',
                    keycode: 57,
                },
                {
                    keytype: 'normal',
                    label: 'Space',
                    shape: 'space',
                    keycode: 57,
                },
                {
                    keytype: 'modkey',
                    label: 'AltGr',
                    shape: 'normal',
                    keycode: 100,
                },
                {
                    keytype: 'normal',
                    label: 'PrtSc',
                    shape: 'fn',
                    keycode: 99,
                },
                {
                    keytype: 'modkey',
                    label: 'Ctrl',
                    shape: 'control',
                    keycode: 97,
                },
            ],
        ],
    },
};
