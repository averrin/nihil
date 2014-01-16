import QtQuick 2.1


Rectangle {
    width: 800
    height: 600
    color: "#111"
    id: screen
    objectName: "Screen"
    
    signal move(int x, int y)
    signal toggleMax()
    signal close()
    
    Rectangle {
        id: titlebar
        objectName: "Titlebar"
        height: 24
        width: parent.width
        color: "#1f1f1f"        
        
        Rectangle {
            color: "red"
            id: close_button
            objectName: "CloseButton"
            height: parent.height
            width: 24
            anchors {top: parent.top; right: parent.right}
            MouseArea {
                id: close_button_mouse
                anchors.fill: parent
                objectName: "CloseButtonMouse"
                onClicked: screen.close()
            }
        }
        
        MouseArea {
            id: titlebar_mouse
            objectName: "TitlebarMouse"
            anchors.fill: parent
            anchors.rightMargin: close_button.width
            
            Text {
                color: "#eee"
                id: pos_info
                text: "vX:" + viewerPosition.x + " vY:" + viewerPosition.y
            
            }
            
            property variant previousPosition
            property variant delta  
            onDoubleClicked : screen.toggleMax()
            onPressed: {
                previousPosition = Qt.point(mouse.x, mouse.y)
            }
            onPositionChanged: {
                if (pressedButtons == Qt.LeftButton) {
                    delta = Qt.point(mouse.x - previousPosition.x, mouse.y - previousPosition.y)
                    //pos_info.text = "dX:" + delta.x + " dY:" + delta.y
                    screen.move(delta.x, delta.y)
                }
            }
        }
    }
    
    Rectangle {
    
        id: panel
        objectName: "Panel"
        width: parent.width
        height: parent.height - titlebar.height
        property int padding
        padding: 6
        anchors { horizontalCenter: parent.horizontalCenter; top: parent.top; topMargin: titlebar.height}
        color: parent.color
        property alias text1: test_text.text

        Text {
            id: test_text
            anchors {fill: parent; leftMargin: parent.padding; topMargin: parent.padding}
            objectName: "testText"
            text: '<font color="gray">00</font><font color="lightblue">1</font>'
            font.pointSize: 10
            textFormat: Text.StyledText
            color: "#eee"
        }
    
    }
}

