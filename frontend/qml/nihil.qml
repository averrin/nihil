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
        color: "#151515"
            
        Row {
            id: container
            width: parent.width
            spacing: 0
            
            Rectangle {
                id: logo
                height: parent.height
                width: parent.height
                //AnimatedImage { id: animation; source: "animation.gif" }
                color: "#111"
            }
            
            Tabbar {
                id: tab_row
            }
        
            Rectangle {
                height: parent.height
                width: parent.width - logo.width - tab_row.width - btn_row.width
                color: titlebar.color

                MouseArea {
                    id: titlebar_mouse
                    objectName: "TitlebarMouse"
                    anchors {fill: parent;}
                    
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
        
            Row {
                id: btn_row
                //anchors {top: parent.top; right: parent.right}
                spacing: 0
                height: titlebar.height
                
                WMButton {
                    id: min_button
                    objectName: "MinButton"
                    active_color: "#E4C078"
                }   
                WMButton {
                    id: close_button
                    objectName: "CloseButton"
                    active_color: "#C64040"
                }
            }
        
        }
    }
    
    Rectangle {
    
        id: panel
        objectName: "Panel"
        width: parent.width
        height: parent.height - titlebar.height - statusbar.height
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
    
    Rectangle {
        id: statusbar
        objectName: "Statusbar"
        color: "#151515"
        height: 24
        width: parent.width
        anchors { horizontalCenter: parent.horizontalCenter; bottom: parent.bottom }
        property int padding
        padding: 4
    
        Text {
            id: statusbar_text
            anchors {fill: parent; leftMargin: parent.padding; topMargin: parent.padding}
            objectName: "testText"
            //text: '<font color="lightblue">Status</font>'
            text: "Window position: " + "X:" + viewerPosition.x + " Y:" + viewerPosition.y
            font.pointSize: 10
            textFormat: Text.StyledText
            color: "#496DA5"
        }
    
    }
}

