/// <summary>
/// ControlAddIn KuaraFirmas.
/// </summary>
controladdin KuaraFirmas
{
    StartupScript = 'Scripts/startupOcr.js';
    Scripts = 'https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js', 'Scripts/wobocr.js';
    StyleSheets = 'Scripts/web_skin.css';

    HorizontalShrink = true;
    HorizontalStretch = true;
    VerticalShrink = true;
    VerticalStretch = true;
    MinimumWidth = 800;



    /// <summary>
    /// OnControlAddInReady.
    /// </summary>
    event OnControlAddInReady();
    procedure InitializeControl(url: Text);
    /// <summary>
    /// OnClick.
    /// </summary>
    procedure OnClick();
    procedure Clic();

}