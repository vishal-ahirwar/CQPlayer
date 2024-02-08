import QtQuick
import com.vishal.MusicPlayerController 1.0

Window {
    width: 1200
    height: 680
    visible: true
    title: "OpenSource Music Player"/*Application.name*/
    id:rootWindow
    color: "black"
    flags: "FramelessWindowHint"
    Component.onCompleted:
    {
        PlayerController.changeAudioSource(firstSong.audioinfo.audioSource)
    }



    Image {
        id: bg
        source: "qrc:/images/res/dark.jpg"
        width: parent.width
        height: parent.height

    }

    TextButton
    {
        id:closeButton
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        text: "X"
        font.pixelSize: 34
        fontColor: "white"
        color: "transparent"
        btnRadius: 1
        width: 56
        height: width
        onClicked:
        {
            Qt.quit()
        }
    }
    TextButton
    {
        anchors.right: closeButton.left
        anchors.rightMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        text: "-"
        font.pixelSize: 34
        fontColor: "white"
        color: "transparent"
        btnRadius: 1
        width: 56
        height: width
        onClicked:
        {
            showMinimized()
        }
    }
    AudioInfoBox
    {
        id:firstSong
        audioinfo.audioSource:"C:/Users/Vishal Ahirwar/Downloads/DILBARA _ Official Video _ Ipsitaa _ Aditya Dev _ Rashmi Virag _ Charit Desai _ Jjust Music.mp3"
        visible: PlayerController.current_song_index==0
        anchors
        {
            verticalCenter:parent.verticleCenter
            left:parent.left
            right:parent.right
            top:parent.top
            bottom:parent.bottom
            margins:20
        }
        audioinfo.songIndex: 0
        audioinfo.title: "Dilbara"
        audioinfo.authorName: "Ipsitaa"
        // imageSource: "qrc:/images/res/icon.png"
    }
    AudioInfoBox
    {
        id:secondSong
        audioinfo.audioSource:"C:/Users/Vishal Ahirwar/Downloads/Vilen - Jawani (Official Audio).mp3"
        visible: PlayerController.current_song_index==1
        anchors
        {
            verticalCenter:parent.verticleCenter
            left:parent.left
            right:parent.right
            top:parent.top
            bottom:parent.bottom
            margins:20
        }
        audioinfo.songIndex: 0
        audioinfo.title: "Jawani (Official Audio)"
        audioinfo.authorName: "Vilen"
        // imageSource: "qrc:/images/res/icon.png"
    }
    AudioInfoBox
    {
        id:thirdSong
        audioinfo.audioSource: "C:/Users/Vishal Ahirwar/Downloads/संपूर्ण गीता & MAHABHARAT  in 9 Minutes RAP _ FULL VERSION 🔥 _ AbbyViral 🔥 Kavi Amit Sharma.mp3"
        visible: PlayerController.current_song_index==2
        anchors
        {
            verticalCenter:parent.verticleCenter
            left:parent.left
            right:parent.right
            top:parent.top
            bottom:parent.bottom
            margins:20
        }
        audioinfo.songIndex: 0
        audioinfo.title: "संपूर्ण गीता & MAHABHARAT  in 9 Minutes RAP"
        audioinfo.authorName: "AbbyViral"
        // imageSource: "qrc:/images/res/icon.png"
    }

    TextButton
    {
        id:next
        anchors.left: playPause.right
        anchors.margins: 20
        width: height*4
        text: ">"
        fontColor: "white"
        font.pixelSize: 34
        anchors.bottom: parent.bottom
        height: parent.height*0.03
        color: "transparent"
        btnRadius: 8
        onClicked:
        {
            PlayerController.switchToNextSong()
        }
    }



    TextButton
    {
        id:prev
        anchors.right: playPause.left
        anchors.margins: 20
        width: height*4
        fontColor: "white"
        font.pixelSize: 34
        height: parent.height*0.03
        color: "transparent"
        text: "<"
        anchors.bottom: parent.bottom
        btnRadius: 8
        onClicked:
        {
            PlayerController.switchToPreviousSong()
        }
    }
    TextButton
    {
        id:playPause
        anchors.bottom: parent.bottom
        anchors.margins: 20
        width: height*4
        fontColor: "white"
        font.pixelSize: 34
        height: parent.height*0.03
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        text: PlayerController.b_playing?"o":"||"
        btnRadius: 8
        onClicked: {
            PlayerController.togglePlayPause()
        }
    }
}
