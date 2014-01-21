import QtQuick 2.1

ListView {
    orientation: Qt.Horizontal
    id: tab_row
    objectName: "Tabs"
    //anchors {top: parent.top; left: parent.left; leftMargin: logo.width}
    height: titlebar.height
    model: TabModel
    width: 200
    clip: true
    
    delegate: Rectangle {
        height: parent.height
        width: 40
        color: model.modelData.color
        Text { text: name }
        
        MouseArea {
            anchors.fill: parent
            onClicked: TabModel.append({"color": "orange", "name":"Pizza"})
        }
    }
}