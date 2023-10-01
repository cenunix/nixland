import PanelButton from '../PanelButton.js';
import Recorder from '../../services/screenrecord.js';
import icons from '../../icons.js';
const { Box, Icon, Label } = ags.Widget;

export default () => PanelButton({
    className: 'recorder',
    onClicked: Recorder.check,
    // binds: [['visible', Recorder, 'recording']],
    child: Box({
        children: [
            Icon(icons.recorder.recording),
            Label({
                connections: [[Recorder, (label, time) => {
                    if (isNaN(time) || time == 0) {
                        label.label = "Not recording"
                    } else {
                        const sec = time % 60;
                        const min = Math.floor(time / 60);
                        label.label = `${min}:${sec < 10 ? '0' + sec : sec}`;
                    }

                }, 'timer']],
            }),
        ],
    }),
});
