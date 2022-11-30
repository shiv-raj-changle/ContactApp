import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2

Window {
    id:rootId
    visible: true
    x:500;y:50
    width: 375
    height: 667
    title: qsTr("Contacts")


    property int pKey;



    ///////// ------------- background ---------- /////////////
    Rectangle{
        height:parent.height
        width:parent.width
        color:"red"
        opacity: 0.2
        Image {
            source: "file:///F:/QtQuickExample(Advance)/Contacts/bg1.png"
            height: parent.height
            width: parent.width
        }
    }
    Rectangle{
        width: rootId.width
        height: rootId.height/10
        color: "green"
        opacity: 0.8
        border.color: "white"
    }
    //////////// ------------ main window -------- ////////////////
    Column{
        spacing: 5
        id:phoneId
        Item{
            width: rootId.width
            height: rootId.height/10
            Row{
                spacing: 10
                Item{
                    height: rootId.height/10
                    width: rootId.width/2

                    Text {
                        text: qsTr("Phone")
                        font.pointSize: 25
                        color: "white"
                        anchors.centerIn: parent
                    }
                }
                Item{
                    height: rootId.height/10
                    width: rootId.width /2
                    Text{
                        text:"create"
                        color: "white"
                        anchors.right: parent.right
                        anchors.rightMargin: 50
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 10
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                mListViewId.visible=false
                                phoneId.visible=false
                                mContactAddWindow.visible=true
                            }
                        }
                    }
                }
            }
        }

        /// ------------------------ search item ----------------------- ///////
        TextField{
            id:mSearchButtonID
            placeholderText: "Search contact ... "
            font.pointSize: 10
            focus:true
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width-30
            height: 30
            background: Rectangle{
                id:serchRctId
                width:parent.width
                height: parent.height
                color: "transparent"
                radius: 30
                border.color: "gray"
            }

            onTextChanged: {
                console.log("text changed to : "+mSearchButtonID.text )
                Wrapper.searchQuery(mSearchButtonID.text)
            }
            onPressed: {
                serchRctId.border.color="black"
            }
        }

        //////// ------------ list view ------------- ////////////
        Item{
            width:rootId.width
            height: rootId.height/1.2

            ListView{
                clip:true
                id:mListViewId
                anchors.fill: parent
                model:Wrapper.mypersons
                highlight: Rectangle{
                    id:mHighLightId
                    color: "blue"
                    opacity: 0.1
                    radius: 20
                }
                delegate: rectContactListId;
            }
        }
    }
    ///////// ------------------- add contact icon ------ ////////////
    Rectangle{
        id:addContactId
        height:50
        width:50
        x:rootId.width/1.3
        y:rootId.height/1.2
        radius: 30
        color:"green"
        Text {
            id: addId
            text: qsTr("+")
            font.pointSize: 25
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill:parent
            onClicked: {
                mListViewId.visible=false
                phoneId.visible=false
                mContactAddWindow.visible=true
            }

        }
    }
    //////////// ----------------- component --------------------- ///////// /
    Component {
        id:rectContactListId
        Rectangle{
            id:rectId
            height: 50
            width: parent.width
            color:"transparent"
            Row{
                spacing: 5
                width:parent.width
                Item{
                    height: 50
                    width: rectId.width/4
                    anchors.verticalCenter: parent.verticalCenter
                    Rectangle{
                        height: 40
                        width:40
                        radius: 50
                        color: "gray"
                        anchors.centerIn: parent
                        Text {
                            id: firstLatterId
                            text:modelData.names[0].toUpperCase()
                            anchors.centerIn: parent
                            font.pointSize: 13
                        }
                    }
                }
                Column{
                    anchors.verticalCenter: parent.verticalCenter
                    width:parent.width
                    Item{
                        height: namesId.implicitHeight
                        width: namesId.implicitWidth+10
                        Text {
                            id:namesId
                            text: modelData.names
                            anchors.centerIn: parent
                            font.pointSize: 13
                        }
                    }
                    Item{
                        x:1
                        height: numberId.implicitHeight+5
                        width: numberId.implicitWidth+10
                        Text {
                            id:numberId
                            text: modelData.number
                            anchors.centerIn: parent
                            font.pointSize: 9
                        }
                    }
                    HorizontalRule{}
                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    mListViewId.currentIndex=index
                    mContactCallWindow.visible=true
                    mListViewId.visible=false
                    phoneId.visible=false
                    mHelloNameId.text=modelData.names
                    mNameIdEdit.text=modelData.names
                    mNumberIdEdit.text=modelData.number
                    pKey=modelData.pKey
                }
            }
        }
    }
    /////// -------------------- contact call window ----------------------- ////////////////

    Rectangle{
        id:mContactCallWindow
        visible: false
        width: rootId.width
        height: rootId.height

        Rectangle{
            height:parent.height
            width:parent.width
            color:"red"
            opacity: 0.1
            Image {
                source: "file:///F:/QtQuickExample(Advance)/Contacts/bg.png"
                height: parent.height
                width: parent.width
            }
        }

        Column{
            spacing: 10
            width: parent.width
            height: parent.height
            Item{
                width:parent.width
                height:100
                Image {
                    source: "file:///F:/QtQuickExample(Advance)/Contacts/back.png"
                    height:40
                    width:40
                    x:10
                    y:10
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            mContactCallWindow.visible=false
                            mListViewId.visible=true
                            phoneId.visible=true
                        }
                    }
                }
                Rectangle{
                    id:nameFirstLattercall
                    height: 60
                    width:60
                    color:"blue"
                    anchors.centerIn: parent
                    radius: 30
                    Text {
                        id:firstLatterCall
                        text:mHelloNameId.text?mHelloNameId.text[0].toUpperCase():" "
                        font.pointSize: 20
                        anchors.centerIn: parent
                    }
                }
                Text{
                    id:mEditIdButton
                    text:"Edit"
                    font.pointSize: 10
                    anchors.top:parent.top
                    anchors.right: parent.right
                    anchors.rightMargin: 30
                    anchors.topMargin: 15
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            mContactCallWindow.visible=false
                            mContactEditWindow.visible=true
                            console.log("edit clicked...")
                        }
                    }
                }
            }

            Item{
                width:parent.width
                height:mHelloNameId.implicitHeight+5

                Text {
                    id:mHelloNameId
                    text:"Hello "
                    font.pointSize: 17
                    anchors.centerIn: parent
                }
            }

            Rectangle{
                width:parent.width-30
                height: 2
                color: "gray"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Item{
                width:parent.width
                height:40
                Row{
                    spacing: parent.width/3.5
                    anchors.horizontalCenter: parent.horizontalCenter
                    Rectangle{
                        width:callId.width+10
                        height:callId.height+!0
                        rotation: 315
                        color: "transparent"
                        Image {
                            id:callId
                            source: "file:///F:/QtQuickExample(Advance)/Contacts/1.png"
                            height:40
                            width:15
                        }
                    }
                    Image {
                        source: "file:///F:/QtQuickExample(Advance)/Contacts/msg.png"
                        height:40
                        width:40
                    }
                }
            }

            Rectangle{
                width:parent.width-30
                height: 2
                color: "gray"
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    ////// ---------------- contact add window ----------- ///////////
    Rectangle{
        id:mContactAddWindow
        visible: false
        width: rootId.width
        height: rootId.height

        Rectangle{
            height:parent.height
            width:parent.width
            color:"red"
            opacity: 0.1
            Image {
                source: "file:///F:/QtQuickExample(Advance)/Contacts/bg.png"
                height: parent.height
                width: parent.width
            }
        }

        Column{
            spacing: 10
            width: parent.width
            height: parent.height
            Item{
                width:parent.width
                height:100
                Rectangle{
                    id:nameFirstLatter
                    height: 60
                    width:60
                    color:"blue"
                    anchors.centerIn: parent
                    radius: 30
                    Text {
                        id:firstLatter
                        text:mNameId.text?mNameId.text[0].toUpperCase():" "
                        font.pointSize: 20
                        anchors.centerIn: parent
                    }
                }
            }
            Item{
                width:parent.width
                height:70
                Row{
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    Image {
                        source: "file:///F:/QtQuickExample(Advance)/Contacts/book.png"
                        height:40
                        width:40
                    }
                    TextField{
                        id:mNameId
                        text:""
                        font.pointSize: 10
                        focus:true
                    }
                }
            }
            Item{
                width:parent.width
                height:70
                Row{
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    Rectangle{
                        width:callId1.width+10
                        height:callId1.height+10
                        rotation: 315
                        color: "transparent"
                        Image {
                            id:callId1
                            source: "file:///F:/QtQuickExample(Advance)/Contacts/1.png"
                            height:40
                            width:15
                        }
                    }
                    TextField{
                        id:mNumberId
                        text:""
                        font.pointSize: 10
                    }
                }
            }
            Item{
                width:parent.width
                height:70
                Row{
                    spacing: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    Button{
                        text:"save"
                        font.pointSize: 13
                        onClicked: {
                            if(mNameId.text=="" || mNumberId.text==""){
                                console.log("values are wrong")
                                messageDialog.open()
                            }
                            else if(mNameId.text.length>0 && mNameId.text.length<30 && mNumberId.text.length>2 && mNumberId.text.length<15){
                                Wrapper.addPerson(mNameId.text,mNumberId.text);
                                console.log(mNameId.text+" "+mNumberId.text)
                                mNameId.text=""
                                mNumberId.text=""
                                mNameId.focus=true
                                mListViewId.visible=true
                                phoneId.visible=true
                                mContactAddWindow.visible=false
                            }else{
                                messageNewDialog.open()
                            }

                        }
                    }
                    Button{
                        text:"cancel"
                        font.pixelSize: 15
                        onClicked: {
                            console.log("Contact Not Created.")
                            mContactAddWindow.visible=false
                            mListViewId.visible=true
                            phoneId.visible=true
                            mNameId.text=""
                            mNumberId.text=""
                            mNameId.focus=true
                        }
                    }
                }
            }
        }
    }
    //////// ----------------- dialog for error ---------------- /////////////////
    Dialog{
        id:messageDialog
        title:"Message"
        Label{
            text:'Entered values are wrong.  '
        }
    }
    //////// ----------------- dialog for error ---------------- /////////////////
    Dialog{
        id:messageNewDialog
        title:"Message"
        Label{
            text:'Enter 2-15 characters of values.'
        }
    }

    ////// ---------------- contact edit window ----------- ///////////
    Rectangle{
        id:mContactEditWindow
        visible: false
        width: rootId.width
        height: rootId.height

        Rectangle{
            height:parent.height
            width:parent.width
            color:"red"
            opacity: 0.1
            Image {
                source: "file:///F:/QtQuickExample(Advance)/Contacts/bg.png"
                height: parent.height
                width: parent.width
            }
        }

        Column{
            spacing: 10
            width: parent.width
            height: parent.height
            Item{
                width:parent.width
                height:100
                Rectangle{
                    id:nameFirstLatterEdit
                    height: 60
                    width:60
                    color:"blue"
                    anchors.centerIn: parent
                    radius: 30
                    Text {
                        id:firstLatterEdit
                        text:mNameIdEdit.text?mNameIdEdit.text[0].toUpperCase():" "
                        font.pointSize: 20
                        anchors.centerIn: parent
                    }
                }
            }
            Item{
                width:parent.width
                height:70
                Row{
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    Image {
                        source: "file:///F:/QtQuickExample(Advance)/Contacts/book.png"
                        height:40
                        width:40
                    }
                    TextField{
                        id:mNameIdEdit
                        text:""
                        font.pointSize: 10
                    }
                }
            }
            Item{
                width:parent.width
                height:70
                Row{
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    Rectangle{
                        width:callId.width+10
                        height:callId.height+10
                        rotation: 315
                        color: "transparent"
                        Image {
                            id:callId2
                            source: "file:///F:/QtQuickExample(Advance)/Contacts/1.png"
                            height:40
                            width:15
                        }
                    }
                    TextField{
                        id:mNumberIdEdit
                        text:""
                        font.pointSize: 10
                    }
                }
            }
            Item{
                width:parent.width
                height:70
                Row{
                    spacing: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    Button{
                        text:"save"
                        font.pointSize: 13
                        onClicked: {
                            if(mNameIdEdit.text==""||mNumberIdEdit.text==""){
                                console.log("you can not edit it")
                                messageDialog.open()
                            }
                            else if(mNameIdEdit.text.length>0 && mNameIdEdit.text.length<30 && mNumberIdEdit.text.length>2 && mNumberIdEdit.text.length<15){
                                Wrapper.setValues(pKey,mNameIdEdit.text,mNumberIdEdit.text)
                                // Wrapper.setNumber(oldNumber,mNumberIdEdit.text)
                                mHelloNameId.text=mNameIdEdit.text
                                mContactEditWindow.visible=false
                                mContactCallWindow.visible=true
                            }
                            else{
                                messageNewDialog.open()
                            }
                        }
                    }
                    Button{
                        text:"cancel"
                        font.pixelSize: 15
                        onClicked: {
                            mContactEditWindow.visible = false
                            mContactCallWindow.visible = true
                            console.log("Contact not edited.")
                        }
                    }
                }
            }
            Item{
                width:parent.width
                height:70
                Button{
                    anchors.centerIn: parent
                    text:"Delete"
                    font.pointSize: 13
                    onClicked: {
                        Wrapper.deleteContact(pKey)
                        mNameIdEdit.text=""
                        mNumberIdEdit.text=""
                        mContactEditWindow.visible=false
                        mListViewId.visible=true
                        phoneId.visible=true
                    }
                }
            }
        }
    }
}
