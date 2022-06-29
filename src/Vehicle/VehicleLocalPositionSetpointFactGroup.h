/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

#pragma once

#include "FactGroup.h"
#include "QGCMAVLink.h"

class VehicleLocalPositionSetpointFactGroup : public FactGroup
{
    Q_OBJECT

public:
    VehicleLocalPositionSetpointFactGroup(QObject* parent = nullptr);

    Q_PROPERTY(Fact* x     READ x    CONSTANT)
    Q_PROPERTY(Fact* y     READ y    CONSTANT)
    Q_PROPERTY(Fact* z     READ z    CONSTANT)
    Q_PROPERTY(Fact* vx    READ vx   CONSTANT)
    Q_PROPERTY(Fact* vy    READ vy   CONSTANT)
    Q_PROPERTY(Fact* vz    READ vz   CONSTANT)
    Q_PROPERTY(Fact* accltz    READ accltz   CONSTANT)
    Q_PROPERTY(Fact* acclz    READ acclz   CONSTANT)

    Fact* x    () { return &_xFact; }
    Fact* y    () { return &_yFact; }
    Fact* z    () { return &_zFact; }
    Fact* vx   () { return &_vxFact; }
    Fact* vy   () { return &_vyFact; }
    Fact* vz   () { return &_vzFact; }
    Fact* accltz   () { return &_accltzFact; }
    Fact* acclz   () { return &_acclzFact; }
    // Overrides from FactGroup
    void handleMessage(Vehicle* vehicle, mavlink_message_t& message) override;

    static const char* _xFactName;
    static const char* _yFactName;
    static const char* _zFactName;
    static const char* _vxFactName;
    static const char* _vyFactName;
    static const char* _vzFactName;
    static const char* _accltzFactName;
    static const char* _acclzFactName;

private:
    Fact _xFact;
    Fact _yFact;
    Fact _zFact;
    Fact _vxFact;
    Fact _vyFact;
    Fact _vzFact;
    Fact _accltzFact;
    Fact _acclzFact;
};
