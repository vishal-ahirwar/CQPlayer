import QtQuick
import com.vishal.MusicPlayerController 1.0
import com.vishal.AudioInfo 1.0
Item {
    id:root
    readonly property AudioInfo audioinfo:AudioInfo{}
    Image
    {
        id:albumImage
        source: audioinfo.imageSource
        anchors
        {
            verticalCenter:parent.verticalCenter
            left:parent.left
        }


    }
    Text {
        id: titleText
        text: audioinfo.title
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
        text: audioinfo.authorName
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
    onVisibleChanged:
    {
        if(visible)
        {
            PlayerController.changeAudioSource(audioinfo.audioSource)
        }
    }
    Component.onCompleted:
    {
        if(PlayerController.current_song_index==audioinfo.songIndex)
        {
            PlayerController.changeAudioSource(audioinfo.audioSource)
        }
    }
}
