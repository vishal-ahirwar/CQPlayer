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

    Image {
        id: bg
        source: "qrc:/images/res/dark.jpg"
        width: parent.width
        height: parent.height

    }
    Rectangle
    {
        property  bool b_pressed:false
        id:titleBar
        anchors
        {
            top:parent.top
            left:parent.left
            right:parent.right
        }
        height: parent.height*0.05
        width: parent.width
        color: "transparent"
        MouseArea
        {
            anchors.fill: parent
            onPressed:
            {
                titleBar.b_pressed=true
            }
            onReleased:
            {
                titleBar.b_pressed=false
            }
            onMouseXChanged:
            {
                if(titleBar.b_pressed)
                {
                    var x=((mouseX-rootWindow.x)-rootWindow.width/4)*0.3
                    rootWindow.x+=x
                    console.log("x is "+x)
                }
            }
            onMouseYChanged:
            {
                if(titleBar.b_pressed)
                {
                    var y=((mouseY-rootWindow.y)-rootWindow.height/24)*0.3
                    rootWindow.y+= y
                    console.log("y is "+y)
                }

            }


        }
    }

    TextButton
    {
        id:closeButton
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        text: "X"
        font.pixelSize: 16
        fontColor: "white"
        color: "transparent"
        btnRadius: 1
        width: 18
        height: width
        onClicked:
        {
            Qt.quit()
        }
    }
    TextButton
    {
        anchors.right: maximizeButton.left
        anchors.rightMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        text: "-"
        font.pixelSize: 34
        fontColor: "white"
        color: "transparent"
        btnRadius: 1
        width: 18
        height: width
        onClicked:
        {
            showMinimized()
        }
    }
    TextButton
    {
        property bool b_maximized:false
        id:maximizeButton
        anchors.right: closeButton.left
        anchors.rightMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        text: "="
        font.pixelSize: 34
        fontColor: "white"
        color: "transparent"
        btnRadius: 1
        width: 18
        height: width
        onClicked:
        {
            if(b_maximized)
            {
               showNormal()
                b_maximized=false
            }else
            {
                showFullScreen()
                b_maximized=true
            }


        }
    }
    AudioInfoBox
    {
        visible: !searchPanel.visible
        id:songInfo
        anchors
        {
            verticalCenter:parent.verticleCenter
            left:parent.left
            right:parent.right
            top:parent.top
            bottom:parent.bottom
            margins:20
        }
    }
    TextButton
    {
        visible: !searchPanel.visible
        id:next
        anchors.left: playPause.right
        anchors.margins: 20
        width: height*2
        text: ">"
        fontColor: "white"
        font.pixelSize: 34
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        height: parent.height*0.05
        color:  "transparent"
        btnRadius: 32
        onClicked:
        {
            PlayerController.switchToNextSong()
        }
    }
    TextButton
    {
        visible: !searchPanel.visible
        id:prev
        anchors.right: playPause.left
        anchors.margins: 20
        width: height*2
        fontColor: "white"
        font.pixelSize: 34
        height: parent.height*0.05
        color:"transparent"
        text: "<"
        anchors.bottom: parent.bottom
        btnRadius:32
            anchors.bottomMargin: 50
        onClicked:
        {
            PlayerController.switchToPreviousSong()
        }
    }
    TextButton
    {
        visible: !searchPanel.visible
        id:playPause
        anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
        anchors.margins: 20
        width: height*2
        fontColor: "white"
        font.pixelSize: 34
        height: parent.height*0.05
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        text: PlayerController.b_playing?"o":"<>"
        btnRadius: 32
        onClicked: {
            PlayerController.togglePlayPause()
        }
    }
    PlaylistPanel
    {
        id:playlistPanel
        anchors.right: parent.right
        anchors.top: closeButton.bottom
        anchors.topMargin: 20
        anchors.rightMargin: 20
    }
    SearchPanel
    {
        id:searchPanel
        visible: false
        anchors.right: playlistPanel.left
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: playlistPanel.top
        width: parent.width-playlistPanel.width
        height: parent.height
        clip: true
    }

}
