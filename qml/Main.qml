import Felgo 3.0
import QtQuick 2.0

GameWindow {
    id: gameWindow

    // You get free licenseKeys from https://felgo.com/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://felgo.com/licenseKey>"

    activeScene: scene

    // the size of the Window can be changed at runtime by pressing Ctrl (or Cmd on Mac) + the number keys 1-8
    // the content of the logical scene size (480x320 for landscape mode by default) gets scaled to the window size based on the scaleMode
    // you can set this size to any resolution you would like your project to start with, most of the times the one of your main target device
    // this resolution is for iPhone 4 & iPhone 4S
    screenWidth: 1080
    screenHeight: 1920

    Scene {
        id: scene

        // the "logical size" - the scene content is auto-scaled to match the GameWindow size
        width: 1920
        height: 1080

        // 0 - init
        // 1 - waiting angry bear
        // 2 - angry bear
        // 3 - feed the bear

        property int st: 0
        x: 0
        y: 0

        Image {
            id: bear
            width: 1080
            height: 1920
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 0
            sourceSize.width: 1080
            anchors.centerIn: parent
            source: "qrc:/Bear.png"
            transform: Rotation {origin.x: 540; origin.y: 960; angle: -90}
        }

        Image {
            id: angryBear
            width: 1080
            height: 1920
            anchors.fill: bear
            source: "qrc:/Angry_bear.png"
            transform: Rotation {origin.x: 540; origin.y: 960; angle: -90}
            opacity: 0
        }

        Timer{
            id: randomTimer
            running: false

            onTriggered: {
                timeTimer.start()
                angryBear.opacity = 1
                parent.st = 2
            }
        }

        MouseArea{
            anchors.fill: bear

            onClicked: {
                if(parent.st == 0)
                {
                    parent.st = 1
                    randomTimer.interval = Math.floor(Math.random() * (15000 - 1000) + 1000)
                    randomTimer.start()
                }
                else if(parent.st == 1)
                {
                    randomTimer.stop()
                    parent.st = 0
                }
                else if(parent.st == 2)
                {
                    timeTimer.stop()
                    parent.st = 3
                }
                else if(parent.st == 3)
                {
                    timeTimer.curTime = 0
                    parent.st = 0
                    angryBear.opacity = 0
                }
            }
        }

        Timer{
            id: timeTimer
            interval: 10
            repeat: true
            running: false

            property int curTime: 0

            onTriggered: {
                curTime += 1;
            }

        }

        Text {
            id: score
            width: 502
            text: parent.st == 0 ? "Ready?" : parent.st == 1 ? "" : timeTimer.curTime
            anchors.top: parent.top
            anchors.topMargin: 791
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -341
            anchors.left: parent.left
            anchors.leftMargin: 109
            horizontalAlignment: Text.AlignHCenter
            font.family: "Source Sans Pro Black"
            font.bold: true
            font.pixelSize: 100
            color: "#000000"
            transform: Rotation {angle: -90}
            anchors.horizontalCenter: bear.top
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:8;anchors_height:128;anchors_width:502;anchors_x:40;anchors_y:748}
}
##^##*/
