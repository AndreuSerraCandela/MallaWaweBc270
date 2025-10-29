/// <summary>
/// ControlAddIn ImagesViewer.
/// </summary>
controladdin ImagesViewer
{
    Scripts = 'Scripts/Kuara.js';
    StartupScript = 'Scripts/startupKuara.js';




    // MaximumWidth = 1920;
    // MaximumHeight = 1080;
    // RequestedHeight = 900;
    // RequestedWidth = 1500;
    VerticalShrink = true;
    HorizontalShrink = true;
    VerticalStretch = true;
    HorizontalStretch = true;



    procedure LoadDocument(data: JsonObject; texdata: Text);
    procedure InitializeControl();
    /// <summary>
    /// OnViewerReady.
    /// </summary>
    event OnViewerReady();
    /// <summary>
    /// OnControlAddInReady.
    /// </summary>
    event OnControlAddInReady();
    procedure Ampliar();


}