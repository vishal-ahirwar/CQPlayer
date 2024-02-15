import QtQuick
import com.vishal.SearchList 1.0
import com.vishal.MusicPlayerController 1.0
Item {
    Rectangle
    {

        width: parent.width-10
        height: parent.height-100
        radius: 12
        color:"#44111111"
        TextInput
        {
            id:textInput
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            font.pixelSize: 18
            horizontalAlignment: Qt.AlignHCenter
            width: parent.width
            anchors.margins: 20
            Text{
                text:parent.text.length<=0?"Search song over the internet ...":""
                anchors.centerIn: parent
                font.pixelSize: 18
                color: "white"

            }
            color: "white"

            onAccepted:{
                            console.log("searching song : "+textInput.text)
                           SearchList.searchSong(textInput.text)

                       }
        }

        ListView
        {
            anchors.top:textInput.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 50
            spacing: 10

            model:SearchList

            delegate:Rectangle
            {
                color:"#66999999"
                radius:9
                id:delegate
                required property string audioTitle
                required property string authorName
                required property url imageSource
                required property url audioSource
                required property url videoSource
                required property int index
                width:parent.width
                height:50
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
                        PlayerController.addAudio(delegate.audioTitle,delegate.authorName,delegate.audioSource,delegate.imageSource,delegate.videoSource)
                    }
                }
            }

            }
        }
}
