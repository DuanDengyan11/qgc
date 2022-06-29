
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
            text:               qsTr("ACCELZ_PID")
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
        property var accelz: QtObject {
            property string name: qsTr("accelz")
            property string plotTitle: qsTr("accelz")
            property var plot: [
                { name: "Response", value: globals.activeVehicle.localPositionSetpoint.acclz.value },
                { name: "Setpoint", value: globals.activeVehicle.localPositionSetpoint.accltz.value }
            ]
            property var params: ListModel {
                ListElement {
                    title:          qsTr("Proportional gain (PSC_ACCZ_P)")
                    description:    qsTr("Increase for more responsiveness, reduce if the velocity overshoots (and increasing D does not help).")
                    param:          "PSC_ACCZ_P"
                    min:            0.2
                    max:            1.5
                    step:           0.05
                }
                ListElement {
                    title:          qsTr("Integral gain (PSC_ACCZ_I)")
                    description:    qsTr("Increase to reduce steady-state error (e.g. wind)")
                    param:          "PSC_ACCZ_I"
                    min:            0
                    max:            3
                    step:           0.1
                }
                ListElement {
                    title:          qsTr("Differential gain (PSC_ACCZ_D)")
                    description:    qsTr("Damping: increase to reduce overshoots and oscillations, but not higher than really needed.")
                    param:          "PSC_ACCZ_D"
                    min:            0.0
                    max:            0.4
                    step:           0.02
                }
            }
        }
        property var horizontal: QtObject {
            property string name: qsTr("Horizontal")
            property string plotTitle: qsTr("Horizontal (Y direction, sidewards)")
            property var plot: [
                { name: "Response", value: globals.activeVehicle.localPosition.y.value },
                { name: "Setpoint", value: globals.activeVehicle.localPositionSetpoint.y.value }
            ]
            property var params: ListModel {
                ListElement {
                    title:          qsTr("Proportional gain (PSC_POSXY_P)")
                    description:    qsTr("Increase for more responsiveness, reduce if the position overshoots (there is only a setpoint when hovering, i.e. when centering the stick).")
                    param:          "PSC_POSXY_P"
                    min:            0
                    max:            2
                    step:           0.05
                }
            }
        }
        property var vertical: QtObject {
            property string name: qsTr("Vertical")
            property var plot: [
                { name: "Response", value: globals.activeVehicle.localPosition.z.value },
                { name: "Setpoint", value: globals.activeVehicle.localPositionSetpoint.z.value }
            ]
            property var params: ListModel {
                ListElement {
                    title:          qsTr("Proportional gain (PSC_POSZ_P)")
                    description:    qsTr("Increase for more responsiveness, reduce if the position overshoots (there is only a setpoint when hovering, i.e. when centering the stick).")
                    param:          "PSC_POSZ_P"
                    min:            0
                    max:            3
                    step:           0.1
                }
            }
        }
        title: "Accelz"
        tuningMode: Vehicle.ModeDisabled
        unit: "cm/s/s"
        axis: [ accelz, horizontal, vertical]
    }
}




