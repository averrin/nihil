import QtQuick 2.1

Rectangle {
    width: 80
    height: titlebar.height
    
    color: "green"
    
    property alias title: t.text
    
    Text {
        id: t
        text: "test"
    }
}