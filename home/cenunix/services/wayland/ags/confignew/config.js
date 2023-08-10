var config = {
    windows: [
        {
            name: 'test',
            child: {
                type: 'label',
                label: 'test',
                style: 'min-width: 100px; min-height: 100px;'
            }
        }
    ]
}
ags.Service.Applications.instance;
ags.Service.Audio.instance;
ags.Service.Battery.instance;
ags.Service.Bluetooth.instance;
ags.Service.Hyprland.instance;
ags.Service.Mpris.instance;
ags.Service.Network.instance;
ags.Service.Notifications.instance;