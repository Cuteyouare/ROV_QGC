#include "RovStatusModel.h"
#include <QtMath>

RovStatusModel::RovStatusModel(QObject *parent) : QObject(parent)
{
    m_timer.setInterval(250);
    connect(&m_timer, &QTimer::timeout, this, &RovStatusModel::updateSimulation);
}

QString RovStatusModel::linkState() const { return m_connected ? QStringLiteral("已连接 · 模拟链路") : QStringLiteral("未连接"); }

void RovStatusModel::toggleConnection()
{
    m_connected = !m_connected;
    m_connected ? m_timer.start() : m_timer.stop();
    emit linkStateChanged();
    emit commandSent(m_connected ? QStringLiteral("遥测链路已建立") : QStringLiteral("遥测链路已断开"));
}

void RovStatusModel::sendCommand(const QString &command)
{
    if (!m_connected) { emit commandSent(QStringLiteral("请先连接 ROV")); return; }
    emit commandSent(QStringLiteral("已发送指令：%1").arg(command));
}

void RovStatusModel::updateSimulation()
{
    m_phase += 0.08;
    m_depth = 12.4 + qSin(m_phase) * 1.8;
    m_heading = qFmod(m_phase * 14.0, 360.0);
    m_roll = qSin(m_phase * 1.7) * 5.5;
    m_pitch = qCos(m_phase * 1.3) * 3.2;
    m_voltage = 24.1 + qSin(m_phase * .4) * .3;
    m_current = 4.8 + qAbs(qSin(m_phase * 1.2)) * 1.7;
    m_temperature = 19.6 + qSin(m_phase * .2) * .5;
    emit telemetryChanged();
}
