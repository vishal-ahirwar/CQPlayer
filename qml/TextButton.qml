import QtQuick

Item {
    id:root
    property color color:  "gray"
    property alias text: btnText.text
    property alias font: btnText.font
    property alias fontColor: btnText.color
    property int btnRadius:0
    signal clicked()
    Rectangle
    {
        id:bg
        anchors.fill: parent
        color: if(buttonMouseArea.containsPress)
               {
                   return Qt.lighter(root.color)
               }else if(buttonMouseArea.containsMouse)
                    {
                        return Qt.darker(root.color)
                   }else
               {
                   return root.color
               }
        radius: btnRadius
        Text {
            id: btnText
            width: bg.width
            height: bg.heights
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    MouseArea
    {
        id:buttonMouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked:
        {
            root.clicked()
        }
    }
}
