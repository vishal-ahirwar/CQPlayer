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
        PlayerController.changeAudioSource(firstSong.audioSource    )
    }



    Image {
        id: bg
        source: "qrc:/images/res/dark.jpg"
        width: parent.width
        height: parent.height

    }

    TextButton
    {
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

    AudioInfoBox
    {
        id:firstSong
        audioSource:"/home/soloknight/Music/y2mate.com - Call Aundi Song SlowedReverb Yo Yo honey Singh.mp3"
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
        songIndex: 0
        title: "Call Aundi Song SlowedReverb Yo Yo honey Singh"
        authorName: "Yo Yo honey Singh"
        // imageSource: "qrc:/images/res/icon.png"
    }
    AudioInfoBox
    {
        id:secondSong
        audioSource:"/home/soloknight/Music/Honthon Pe Bas _ Zaara Yesmin, Parth Samthaan _ Seepi Jha, Sameer Khan _ Raaj Aashoo _ Tips Official.mp3"
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
        songIndex: 0
        title: "Honthon Pe Bas"
        authorName: "Zaara Yesmin, Parth Samthaan"
        // imageSource: "qrc:/images/res/icon.png"
    }
    AudioInfoBox
    {
        id:thirdSong
        audioSource: "/home/soloknight/Music/Hare Krishna Hare Rama - Mahamantra - Lofi ! Hindi.mp3"
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
        songIndex: 0
        title: "Hare Krishna Hare Rama"
        authorName: "Mahamantra"
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
            PlayerController.changeAudioSource(songs[PlayerController.current_song_index])
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
            PlayerController.changeAudioSource(songs[PlayerController.current_song_index])
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

    property var songs:[
        "/home/soloknight/Music/y2mate.com - Call Aundi Song SlowedReverb Yo Yo honey Singh.mp3",
        "/home/soloknight/Music/Honthon Pe Bas _ Zaara Yesmin, Parth Samthaan _ Seepi Jha, Sameer Khan _ Raaj Aashoo _ Tips Official.mp3",
        "/home/soloknight/Music/Hare Krishna Hare Rama - Mahamantra - Lofi ! Hindi.mp3"
    ]
}
