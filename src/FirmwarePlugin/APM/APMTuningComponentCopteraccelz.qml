
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
    property Fact _mcaccelzMode:       controller.getParameterFact(-1, "MPC_ACCELZ_MODE", false)

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
            property string name: qsTr("accelz")
            property string plotTitle: qsTr("accelz)")
            property var plot: [
                { name: "Response", value: globals.activeVehicle.localPosition.z.value },
                { name: "Setpoint", value: globals.activeVehicle.localPositionSetpoint.z.value }
            ]
            property var params: ListModel {
                ListElement {
                    title:          qsTr("PSC_ACCZ_P")
                    description:    qsTr("accelzp")
                    param:          "PSC_ACCZ_P"
                    min:            0.2
                    max:            1.5
                    step:           0.05
                }
                ListElement {
                    title:          qsTr("PSC_ACCZ_I")
                    description:    qsTr("accelzi")
                    param:          "PSC_ACCZ_I"
                    min:            0.0
                    max:            3
                    step:           0.1
                }
                ListElement {
                    title:          qsTr("PSC_ACCZ_D")
                    description:    qsTr("accelzd")
                    param:          "PSC_ACCZ_D"
                    min:            0.0
                    max:            0.4
                    step:           0.02
                }
            }
        }
        title: "accelz"
        tuningMode: Vehicle.ModeDisabled
        unit: "cm/s/s"
        axis: [accelz]
    }
}


