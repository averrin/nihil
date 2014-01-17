import QtQuick 2.1

Rectangle {
    color: parent.color
    height: parent.height
    width: 24
    anchors {top: parent.top; right: parent.right}
    property color active_color: "red"
    //property alias onClicked: ma.onClicked

    MouseArea {
        id: ma
        hoverEnabled: true
        anchors.fill: parent
        
        property bool hovered
        hovered: false
        onEntered: { hovered = true }
        onExited: { hovered = false }
        
        states: State {
            name: "active"; when: parent.hovered
            PropertyChanges { 
                target: parent.parent.parent
                color: parent.parent.parent.active_color
            }
        }
        
        transitions: Transition {
            ColorAnimation { duration: 300 }
        }
    }
}