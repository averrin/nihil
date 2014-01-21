import QtQuick 2.1

Rectangle {
    //color: "white"
    height: titlebar.height
    width: 24
    property color active_color: "red"
    signal clicked
    id: btn
    
    property bool hovered
    hovered: false
    state: "normal"
    color: titlebar.color
    
    states: [
        State {
            name: "active"; when: hovered
            PropertyChanges { target: btn; color: btn.active_color}
        },
        State {
            name: "normal"; when: !hovered
            PropertyChanges { target: btn; color: titlebar.color}
        }
        ]
    /*
    Text {
        text: parent.state
        color: "red"
    }
    */
    
    transitions: Transition {
        ColorAnimation { duration: 300 }
    }

    MouseArea {
        hoverEnabled: true
        anchors.fill: parent
        onClicked: parent.clicked()
        
        
        onEntered: { parent.hovered = true }
        onExited: { parent.hovered = false }
        
    }
}