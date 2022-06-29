import QtQuick          2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts  1.2

import QGroundControl               1.0
import QGroundControl.Controls      1.0
import QGroundControl.FactSystem    1.0
import QGroundControl.FactControls  1.0
import QGroundControl.ScreenTools   1.0
import QGroundControl.Vehicle       1.0

ColumnLayout {
    width: availableWidth
    anchors.fill: parent
    property alias autotuningEnabled: pidTuning.autotuningEnabled

    PIDTuning {
        width: availableWidth
        id:    pidTuning

        property var roll: QtObject {
            property string name: qsTr("Roll")
            property var plot: [
                { name: "Response", value: globals.activeVehicle.roll.value },
                { name: "Setpoint", value: globals.activeVehicle.setpoint.roll.value }
            ]
            property var params: ListModel {
                ListElement {
                    title:          qsTr("Roll axis angle controller P gain")
                    param:          "ATC_ANG_RLL_P"
                    description:    ""
                    min:            3
                    max:            12
                    step:           0.2
                }
            }
        }
        property var pitch: QtObject {
            property string name: qsTr("Pitch")
            property var plot: [
                { name: "Response", value: globals.activeVehicle.pitch.value },
                { name: "Setpoint", value: globals.activeVehicle.setpoint.pitch.value }
            ]
            property var params: ListModel {
                ListElement {
                    title:          qsTr("Pitch axis angle controller P gain")
                    param:          "ATC_ANG_PIT_P"
                    description:    ""
                    min:            3
                    max:            12
                    step:           0.2
                }
            }
        }
        property var yaw: QtObject {
            property string name: qsTr("Yaw")
            property var plot: [
                { name: "Response", value: globals.activeVehicle.heading.value },
                { name: "Setpoint", value: globals.activeVehicle.setpoint.yaw.value }
            ]
            property var params: ListModel {
                ListElement {
                    title:          qsTr("Yaw axis angle controller P gain")
                    param:          "ATC_ANG_YAW_P"
                    description:    ""
                    min:            3
                    max:            12
                    step:           0.2
                }
            }
        }
        title: "Attitude"
        tuningMode: Vehicle.ModeDisabled
        unit: "deg"
        axis: [ roll, pitch, yaw ]
        showAutoModeChange: true
        showAutoTuning:     true
    }
}

