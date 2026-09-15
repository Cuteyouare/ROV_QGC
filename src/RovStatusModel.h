#pragma once

#include <QObject>
#include <QTimer>

class RovStatusModel final : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double depth READ depth NOTIFY telemetryChanged)
    Q_PROPERTY(double heading READ heading NOTIFY telemetryChanged)
    Q_PROPERTY(double roll READ roll NOTIFY telemetryChanged)
    Q_PROPERTY(double pitch READ pitch NOTIFY telemetryChanged)
    Q_PROPERTY(double voltage READ voltage NOTIFY telemetryChanged)
    Q_PROPERTY(double current READ current NOTIFY telemetryChanged)
    Q_PROPERTY(double temperature READ temperature NOTIFY telemetryChanged)
    Q_PROPERTY(QString linkState READ linkState NOTIFY linkStateChanged)
    Q_PROPERTY(bool connected READ connected NOTIFY linkStateChanged)
public:
    explicit RovStatusModel(QObject *parent = nullptr);
    double depth() const { return m_depth; }
    double heading() const { return m_heading; }
    double roll() const { return m_roll; }
    double pitch() const { return m_pitch; }
    double voltage() const { return m_voltage; }
    double current() const { return m_current; }
    double temperature() const { return m_temperature; }
    QString linkState() const;
    bool connected() const { return m_connected; }

    Q_INVOKABLE void toggleConnection();
    Q_INVOKABLE void sendCommand(const QString &command);

signals:
    void telemetryChanged();
    void linkStateChanged();
    void commandSent(const QString &message);

private:
    void updateSimulation();
    QTimer m_timer;
    bool m_connected = false;
    double m_phase = 0.0, m_depth = 0.0, m_heading = 0.0;
    double m_roll = 0.0, m_pitch = 0.0, m_voltage = 24.0, m_current = 0.0, m_temperature = 19.0;
};
