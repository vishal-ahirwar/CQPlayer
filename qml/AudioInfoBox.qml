import QtQuick
import com.vishal.MusicPlayerController 1.0
import com.vishal.AudioInfo 1.0
Item {
    id:root

    Image
    {
        id:albumImage
        source: PlayerController.current_song?PlayerController.current_song.imageSource:""
        anchors
        {
            verticalCenter:parent.verticalCenter
            left:parent.left
        }
        width: 100
        height: 100
    }
    Text {
        id: titleText
        text: PlayerController.current_song?PlayerController.current_song.title:""
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
        text: PlayerController.current_song?PlayerController.current_song.authorName:""
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
        text: PlayerController.current_song?PlayerController.b_playing?"Playing... :)":"Paused... :(":"Click + Button to Search Songs"
        anchors
        {
            left:PlayerController.current_song?authorText.left:root.left
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
