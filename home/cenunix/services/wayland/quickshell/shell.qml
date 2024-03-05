import QtQuick
import Quickshell

ShellRoot {
  PanelWindow {
    anchors {
      left: true
      bottom: true
      right: true
    }

    Text {
      anchors.centerIn: parent
      text: "Hello!"
    }
  }
}
