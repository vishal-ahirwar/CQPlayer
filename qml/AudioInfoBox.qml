import QtQuick
import com.vishal.MusicPlayerController 1.0
Item {
    id:root

    required property int songIndex
    property alias title:titleText.text
    property alias authorName: authorText.text
    property alias imageSource: albumImage.source
    required property url audioSource
    Image
    {
        id:albumImage
        anchors
        {
            verticalCenter:parent.verticalCenter
            left:parent.left
        }


    }
    Text {
        id: titleText
        text: qsTr("Tere liye")
        anchors
        {
            bottom:parent.verticalCenter
            left:albumImage.right
            margins:20
            right:parent.right
        }
        color: "white"
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        font.pixelSize: 20
        font.bold: true
    }

    Text {
        id: authorText
        text: qsTr("unknown")
        anchors
        {
            bottom:parent.verticalCenter
            left:titleText.left
            topMargin:5
            right:parent.right
        }
        color: "gray"
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        font.pixelSize: 16
        font.bold: false
    }
    Text {
        id: status
        text: PlayerController.b_playing?"Playing... :)":"Paused... :("
        anchors
        {
            left:authorText.left
            top:authorText.top
            topMargin:25
            right:parent.right
        }
        color: "gray"
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        font.pixelSize: 14
        font.bold: false
    }
}
