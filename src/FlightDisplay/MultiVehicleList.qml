/****************************************************************************
 *
 *   (c) 2009-2016 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick          2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts  1.2

import QGroundControl               1.0
import QGroundControl.ScreenTools   1.0
import QGroundControl.Controls      1.0
import QGroundControl.Palette       1.0
import QGroundControl.Vehicle       1.0
import QGroundControl.FlightMap     1.0

Item {
    property var guidedActionsController

    property real   _margin:        ScreenTools.defaultFontPixelWidth / 2
    property real   _widgetHeight:  ScreenTools.defaultFontPixelHeight * 3
    property color  _textColor:     "black"
    property real   _rectOpacity:   0.8

    QGCPalette { id: qgcPal }

    Rectangle {
        id:             mvCommands
        anchors.left:   parent.left
        anchors.right:  parent.right
        height:         mvCommandsColumn.height + (_margin *2)
        color:          qgcPal.missionItemEditor
        opacity:        _rectOpacity
        radius:         _margin

        DeadMouseArea {
            anchors.fill: parent
        }

        Column {
            id:                 mvCommandsColumn
            anchors.margins:    _margin
            anchors.top:        parent.top
            anchors.left:       parent.left
            anchors.right:      parent.right
            spacing:            _margin
            QGCLabel {
                anchors.left:   parent.left
                anchors.right:  parent.right
                text:           qsTr("The following commands will be applied to selected vehicles")
                color:          _textColor
                wrapMode:       Text.WordWrap
                font.pointSize: ScreenTools.smallFontPointSize
            }
            Row{
                spacing:        _margin
                QGCCheckBox{
                    id:         selectedAll
                    checked:    false
                    onCheckedChanged:{
                        if(checked){
                            guidedActionsController.selectedVehicleCtl(0 , 1)
                        }else{
                            guidedActionsController.selectedVehicleCtl(0 , 0)
                        }
                    }
                }

                QGCLabel {
                    text:           qsTr("all")
                    color:          _textColor
                    wrapMode:       Text.WordWrap
                    font.pointSize: ScreenTools.smallFontPointSize
                }

            }

            Row{
                spacing:            _margin
                QGCButton {
                    text:       qsTr("arm")
                    onClicked:  {
                        guidedActionsController.confirmAction(guidedActionsController.actionMVArm)
                    }
                }
                QGCButton {
                    text:       qsTr("disarm")
                    onClicked:  {
                        guidedActionsController.confirmAction(guidedActionsController.actionMVDisarm)
                    }
                }
                QGCButton {
                    text:       qsTr("EmergencyStop")
                    onClicked:  guidedActionsController.confirmAction(guidedActionsController.actionMVEmergencyStop)
                }

            }

            Row{
                spacing:            _margin
                QGCButton {
                    text:       qsTr("Takeoff")
                    onClicked:  {
                        guidedActionsController.confirmAction(guidedActionsController.actionMVTakeoff)
                    }
                }
                QGCButton {
                    text:       qsTr("Land")
                    onClicked:{
                        guidedActionsController.confirmAction(guidedActionsController.actionMVLand)
                        }
                }
                QGCButton {
                    text:       qsTr("RTL")
                    onClicked:  guidedActionsController.confirmAction(guidedActionsController.actionMVRTL)
                }
            }

            Row {
                spacing:            _margin
                QGCButton {
                    text:       qsTr("Pause")
                    onClicked:  guidedActionsController.confirmAction(guidedActionsController.actionMVPause)
                }

                QGCButton {
                    text:       qsTr("Mission")
                    onClicked:  guidedActionsController.confirmAction(guidedActionsController.actionMVStartMission)
                }
            }
            Row {
                spacing:            _margin
                QGCButton {
                    text:       qsTr("SlingTakeoff")
                    onClicked:  guidedActionsController.confirmAction(guidedActionsController.actionSlingTakeoff)
                }

                QGCButton {
                    text:       qsTr("SlingGuided")
                    onClicked:  guidedActionsController.confirmAction(guidedActionsController.actionSlingGuided)
                }
            }
        }
    }

    QGCListView {
        id:                 missionItemEditorListView
        anchors.left:       parent.left
        anchors.right:      parent.right
        anchors.topMargin:  _margin
        anchors.top:        mvCommands.bottom
        anchors.bottom:     parent.bottom
        spacing:            ScreenTools.defaultFontPixelHeight / 2
        orientation:        ListView.Vertical
        model:              QGroundControl.multiVehicleManager.vehicles
        cacheBuffer:        _cacheBuffer < 0 ? 0 : _cacheBuffer
        clip:               true

        property real _cacheBuffer:     height * 2

        delegate: Rectangle {
            width:      parent.width
            height:     innerColumn.y + innerColumn.height + _margin
            color:      qgcPal.missionItemEditor
            opacity:    _rectOpacity
            radius:     _margin

            property var    _vehicle:   object

            ColumnLayout {
                id:                 innerColumn
                anchors.margins:    _margin
                anchors.top:        parent.top
                anchors.left:       parent.left
                anchors.right:      parent.left
                spacing:            _margin

                RowLayout {
                    Layout.fillWidth:       true

                    QGCCheckBox{
                        id: singleSelector
                        onCheckedChanged:{
                            if(checked)
                                guidedActionsController.selectedVehicleCtl(_vehicle.id , 1)
                            else
                                guidedActionsController.selectedVehicleCtl(_vehicle.id , 0)
                        }

                        Connections{
                            target:  selectedAll
                            onCheckedChanged:{
                                singleSelector.checked = selectedAll.checked
                            }
                        }
                    }
                    QGCLabel {
                        Layout.alignment:   Qt.AlignTop
                        text:               _vehicle.id
                        color:              _textColor
                    }

                    ColumnLayout {
                        Layout.alignment:   Qt.AlignCenter
                        spacing:            _margin

                        FlightModeMenu {
                            Layout.alignment:           Qt.AlignHCenter
                            font.pointSize:             ScreenTools.largeFontPointSize
                            color:                      _textColor
                            activeVehicle:              _vehicle
                        }

                        QGCLabel {
                            Layout.alignment:           Qt.AlignHCenter
                            text:                       _vehicle.armed ? qsTr("Armed") : qsTr("Disarmed")
                            color:                      _textColor
                        }
                    }

                    QGCCompassWidget {
                        size:       _widgetHeight
                        vehicle:    _vehicle
                    }

                    QGCAttitudeWidget {
                        size:       _widgetHeight
                        vehicle:    _vehicle
                    }
                } // RowLayout

                Row {
                    spacing: ScreenTools.defaultFontPixelWidth

                    QGCButton {
                        text:       "Arm"
                        visible:    !_vehicle.armed
                        onClicked:  _vehicle.armed = true
                    }

                    QGCButton {
                        text:       "Start Mission"
                        visible:    _vehicle.armed && _vehicle.flightMode !== _vehicle.missionFlightMode
                        onClicked:  _vehicle.startMission()
                    }

                    QGCButton {
                        text:       "Pause"
                        visible:    _vehicle.armed && _vehicle.pauseVehicleSupported
                        onClicked:  _vehicle.pauseVehicle()
                    }

                    QGCButton {
                        text:       "RTL"
                        visible:    _vehicle.armed && _vehicle.flightMode !== _vehicle.rtlFlightMode
                        onClicked:  _vehicle.flightMode = _vehicle.rtlFlightMode
                    }

                    QGCButton {
                        text:       "Take control"
                        visible:    _vehicle.armed && _vehicle.flightMode !== _vehicle.takeControlFlightMode
                        onClicked:  _vehicle.flightMode = _vehicle.takeControlFlightMode
                    }
                } // Row
            } // ColumnLayout
        } // delegate - Rectangle
    } // QGCListView
} // Item
