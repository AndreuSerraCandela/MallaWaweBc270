/// <summary>
/// ControlAddIn MyPingPong.
/// </summary>
controladdin MyTimer
{
    Scripts = 'Scripts/MyTimer.js';

    StartupScript = 'Scripts/MyTimerMain.js';

    HorizontalShrink = true;
    HorizontalStretch = true;
    MinimumHeight = 1;
    MinimumWidth = 1;
    RequestedHeight = 1;
    RequestedWidth = 1;
    VerticalShrink = true;
    VerticalStretch = true;

    procedure SetTimerInterval(milliSeconds: Integer);

    procedure StartTimer();

    procedure StopTimer();

    /// <summary>
    /// ControlAddInReady.
    /// </summary>
    event ControlAddInReady();

    /// <summary>
    /// PingPongError.
    /// </summary>
    event PingPongError();

    /// <summary>
    /// TimerElapsed.
    /// </summary>
    event TimerElapsed();
}