
import QtQuick          2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts  1.2

import QGroundControl               1.0
import QGroundControl.Controls      1.0
import QGroundControl.FactSystem    1.0
import QGroundControl.FactControls  1.0
import QGroundControl.ScreenTools   1.0
import QGroundControl.Vehicle       1.0

//列布局
ColumnLayout {
    width: availableWidth
    anchors.fill: parent //子控件的大小设置与父控件大小一样
    property Fact _mcPosMode:       controller.getParameterFact(-1, "MPC_POS_MODE", false)

    GridLayout {
        columns: 2

        QGCLabel {
            text:               qsTr("Position control mode (set this to 'simple' during tuning):")
            visible:            _mcPosMode
        }
        FactComboBox {
            fact:               _mcPosMode
            indexModel:         false
            visible:            _mcPosMode
        }
    }

    PIDTuning {
        width: availableWidth
        property var horizontal: QtObject {
            property string name: qsTr("Horizontal")
            property string plotTitle: qsTr("Horizontal (Y direction, sidewards)")
            property var plot: [
                { name: "Response", value: globals.activeVehicle.localPosition.vy.value },
                { name: "Setpoint", value: globals.activeVehicle.localPositionSetpoint.vy.value }
            ]
            property var params: ListModel {
                ListElement {
                    title:          qsTr("Proportional gain (PSC_VELXY_P)")
                    description:    qsTr("Increase for more responsiveness, reduce if the velocity overshoots (and increasing D does not help).")
                    param:          "PSC_VELXY_P"
                    min:            0.1
                    max:            6
                    step:           0.2
                }
                ListElement {
                    title:          qsTr("Integral gain (PSC_VELXY_I)")
                    description:    qsTr("Increase to reduce steady-state error (e.g. wind)")
                    param:          "PSC_VELXY_I"
                    min:            0.02
                    max:            2
                    step:           0.05
                }
                ListElement {
                    title:          qsTr("Differential gain (PSC_VELXY_D)")
                    description:    qsTr("Damping: increase to reduce overshoots and oscillations, but not higher than really needed.")
                    param:          "PSC_VELXY_D"
                    min:            0.0
                    max:            1.0
                    step:           0.02
                }
            }
        }
        property var vertical: QtObject {
            property string name: qsTr("Vertical")
            property var plot: [
                { name: "Response", value: globals.activeVehicle.localPosition.vz.value },
                { name: "Setpoint", value: globals.activeVehicle.localPositionSetpoint.vz.value }
            ]
            property var params: ListModel {
                ListElement {
                    title:          qsTr("Proportional gain (PSC_VELZ_P)")
                    description:    qsTr("Increase for more responsiveness, reduce if the velocity overshoots (and increasing D does not help).")
                    param:          "PSC_VELZ_P"
                    min:            0
                    max:            15
                    step:           0.5
                }
                ListElement {
                    title:          qsTr("Integral gain (PSC_VELZ_I)")
                    description:    qsTr("Increase to reduce steady-state error")
                    param:          "PSC_VELZ_I"
                    min:            0
                    max:            3
                    step:           0.1
                }
                ListElement {
                    title:          qsTr("Differential gain (PSC_VELZ_D)")
                    description:    qsTr("Damping: increase to reduce overshoots and oscillations, but not higher than really needed.")
                    param:          "PSC_VELZ_D"
                    min:            0
                    max:            2
                    step:           0.05
                }
            }
        }
        title: "Velocity"
        tuningMode: Vehicle.ModeDisabled
        unit: "m/s"
        axis: [ horizontal, vertical ]
    }
}


