#include "dashboardcontroller.h"

DashboardController::DashboardController(QObject *parent) : QObject(parent) {}

void DashboardController::setEngineOn(bool on) { if (m_engineOn != on) { m_engineOn = on; emit engineOnChanged(on); } }
void DashboardController::setBatteryLow(bool low) { if (m_batteryLow != low) { m_batteryLow = low; emit batteryLowChanged(low); } }
void DashboardController::setOilLow(bool low) { if (m_oilLow != low) { m_oilLow = low; emit oilLowChanged(low); } }
void DashboardController::setSeatbeltOn(bool on) { if (m_seatbeltOn != on) { m_seatbeltOn = on; emit seatbeltOnChanged(on); } }
void DashboardController::setLeftSignalOn(bool on) { if (m_leftSignalOn != on) { m_leftSignalOn = on; emit leftSignalOnChanged(on); } }
void DashboardController::setRightSignalOn(bool on) { if (m_rightSignalOn != on) { m_rightSignalOn = on; emit rightSignalOnChanged(on); } }

void DashboardController::toggleLeftSignal() { setLeftSignalOn(!m_leftSignalOn); }
void DashboardController::toggleRightSignal() { setRightSignalOn(!m_rightSignalOn); }
