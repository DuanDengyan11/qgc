/****************************************************************************
 *
 *   (c) 2009-2016 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/


#pragma once

#include <QObject>
#include <QStringListModel>
#include <QUrl>
#include <QFile>

// Hackish way to force only this translation unit to have public ctor access
#ifndef _LOG_CTOR_ACCESS_
#define _LOG_CTOR_ACCESS_ private
#endif


class AppMessages
{
public:
    static void installHandler();
};
