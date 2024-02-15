import QtQuick
import com.vishal.MusicPlayerController 1.0
import com.vishal.SearchList 1.0
Item {
    width: parent.width*0.2
    height: parent.height*0.8
    anchors.verticalCenter: parent.verticalCenter
    Text {
        id: topText
        horizontalAlignment: Qt.AlignHCenter
        anchors.top: bg.top
        anchors.right: bg.right
        anchors.topMargin: 10
        anchors.left: bg.left
        text: qsTr("Playlist")
        font.pixelSize: 18
        color: "white"

    }
    Rectangle
    {
        property int count:0
        id:bg
        width: parent.width
        height: parent.height
        radius: 32
        color: "#55111111"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        ListView
        {
            width: parent.width
            height: parent.height*0.8
            anchors.centerIn: parent
            spacing: 10
            model: PlayerController
            delegate:Rectangle
                {
                    clip:true
                    id:delegate
                    required property string audioTitle
                    required property string authorName
                    required property url imageSource
                    required property url audioSource
                    required property url videoSource
                    required property int index
                    width:parent.width
                    height:50
                    color:"#44999999"
                    radius:9
                    Image{
                        id:image
                        source: delegate.imageSource
                        anchors.left: parent.left
                        anchors.margins: 10
                        verticalAlignment: Qt.AlignVCenter
                        width: 50
                        height: 50
                    }

                    Text {
                        id: title
                        anchors.left: image.right
                        anchors.leftMargin: 20
                        text: delegate.audioTitle
                        color: "white"
                        font.pixelSize: 14
                    }
                    Text {
                        id: author
                        anchors.top: title.bottom
                        anchors.left: image.right
                        anchors.leftMargin: 20
                        text: delegate.authorName
                        color: "gray"
                        font.pixelSize: 14
                    }

                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked:
                        {
                            PlayerController.switchToAudioByIndex(delegate.index)
                        }
                    }

        }

        TextButton
        {
            id:addBtn
            text: "+"
            font.pixelSize: 35
            fontColor: "white"
            btnRadius: 18
            width: 50
            height: 35
            font.bold: true
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                searchPanel.visible=!searchPanel.visible
            }
        }
    }
}
}
