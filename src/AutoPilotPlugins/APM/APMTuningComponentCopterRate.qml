/****************************************************************************
 *
 * (c) 2021 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

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
    property Fact _airmode:           controller.getParameterFact(-1, "MC_AIRMODE", false)
    property Fact _thrustModelFactor: controller.getParameterFact(-1, "THR_MDL_FAC", false)
    property alias autotuningEnabled: pidTuning.autotuningEnabled

    GridLayout {
        columns: 2

        QGCLabel {
            textFormat:         Text.RichText
            text:               qsTr("Airmode (disable during tuning) <b><a href=\"https://docs.px4.io/master/en/config_mc/pid_tuning_guide_multicopter.html#airmode-mixer-saturation\">?</a></b>:")
            onLinkActivated:    Qt.openUrlExternally(link)
            visible:            _airmode
        }
        FactComboBox {
            fact:               _airmode
            indexModel:         false
            visible:            _airmode
        }

        QGCLabel {
            textFormat:         Text.RichText
            text:               qsTr("Thrust curve <b><a href=\"https://docs.px4.io/master/en/config_mc/pid_tuning_guide_multicopter.html#thrust-curve\">?</a></b>:")
            onLinkActivated:    Qt.openUrlExternally(link)
            visible:            _thrustModelFactor
        }
        FactTextField {
            fact:               _thrustModelFactor
            visible:            _thrustModelFactor
        }
    }
    PIDTuning {
        width: availableWidth
        id:    pidTuning

        property var roll: QtObject {
            property string name: qsTr("Roll")
            property var plot: [
                { name: "Response", value: globals.activeVehicle.rollRate.value },
                { name: "Setpoint", value: globals.activeVehicle.setpoint.rollRate.value }
            ]
            property var params: ListModel {
                ListElement {
                    title:          qsTr("Roll axis rate controller P gain")
                    param:          "ATC_RAT_RLL_P"
                    description:    ""
                    min:            0.0
                    max:            0.35
                    step:           0.01
                }
                ListElement {
                    title:          qsTr("Roll axis rate controller I gain")
                    param:          "ATC_RAT_RLL_I"
                    description:    ""
                    min:            0.0
                    max:            0.6
                    step:           0.02
                }
                ListElement {
                    title:          qsTr("Roll axis rate controller D gain")
                    param:          "ATC_RAT_RLL_D"
                    description:    ""
                    min:            0.0
                    max:            0.03
                    step:           0.001
                }
            }
        }
        property var pitch: QtObject {
            property string name: qsTr("Pitch")
            property var plot: [
                { name: "Response", value: globals.activeVehicle.pitchRate.value },
                { name: "Setpoint", value: globals.activeVehicle.setpoint.pitchRate.value }
            ]
            property var params: ListModel {
                ListElement {
                    title:          qsTr("Pitch axis rate controller P gain")
                    param:          "ATC_RAT_PIT_P"
                    description:    ""
                    min:            0.0
                    max:            0.35
                    step:           0.01
                }
                ListElement {
                    title:          qsTr("Pitch axis rate controller I gain")
                    param:          "ATC_RAT_PIT_I"
                    description:    ""
                    min:            0.0
                    max:            0.6
                    step:           0.02
                }
                ListElement {
                    title:          qsTr("Pitch axis rate controller D gain")
                    param:          "ATC_RAT_PIT_D"
                    description:    ""
                    min:            0.0
                    max:            0.03
                    step:           0.001
                }
            }
        }
        property var yaw: QtObject {
            property string name: qsTr("Yaw")
            property var plot: [
                { name: "Response", value: globals.activeVehicle.yawRate.value },
                { name: "Setpoint", value: globals.activeVehicle.setpoint.yawRate.value }
            ]
            property var params: ListModel {
                ListElement {
                    title:          qsTr("Yaw axis rate controller P gain")
                    param:          "ATC_RAT_YAW_P"
                    description:    ""
                    min:            0.18
                    max:            0.6
                    step:           0.01
                }
                ListElement {
                    title:          qsTr("Yaw axis rate controller I gain")
                    param:          "ATC_RAT_YAW_I"
                    description:    ""
                    min:            0.01
                    max:            0.2
                    step:           0.005
                }
            }
        }
        title: "Rate"
        tuningMode: Vehicle.ModeDisabled
        unit: "deg/s"
        axis: [ roll, pitch, yaw ]
        chartDisplaySec: 3
        showAutoModeChange: true
        showAutoTuning:     true
    }
}

