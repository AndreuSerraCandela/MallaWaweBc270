var __ViewerFrame;
var __ViewerOrigin;
var controlAddIn
function InitializeControl() {
    // Usar el iframe local en lugar del externo
    __ViewerOrigin = '*';
    window.addEventListener("message", onMessage);
    controlAddIn = document.getElementById('controlAddIn');
    
    // Crear un iframe con contenido HTML básico que incluya el visor de imágenes
    var iframeContent = `
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="UTF-8">
            <title>Image Viewer</title>
            <style>
                body { margin: 0; padding: 0; width: 100%; height: 100%; overflow: hidden; }
                #image-viewer-container {
                    width: 100%;
                    height: 100%;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    background-color: #f5f5f5;
                    overflow: hidden;
                }
                .image-container img {
                    max-width: 100%;
                    max-height: 100%;
                    object-fit: contain;
                    display: block;
                }
            </style>
        </head>
        <body>
            <div id="image-viewer-container">
                <div class="image-container">
                    <img id="current-image" src="" alt="Imagen" style="display: none;">
                </div>
            </div>
            <script>
                // Variables globales
                var currentImageIndex = 0;
                var images = [];
                var container = document.getElementById('image-viewer-container');
                var currentImage = document.getElementById('current-image');
                
                // Mostrar una imagen
                function displayImage(imageData) {
                    console.log('Función displayImage llamada con:', imageData);
                    
                    if (imageData.content) {
                        console.log('Configurando imagen con src:', imageData.content.substring(0, 100) + '...');
                        currentImage.src = imageData.content;
                        currentImage.alt = imageData.description || 'Imagen';
                        currentImage.style.display = 'block';
                        
                        currentImage.onload = function() {
                            console.log('Imagen cargada exitosamente');
                        };
                        
                        currentImage.onerror = function() {
                            console.error('Error al cargar la imagen:', imageData.content);
                            container.innerHTML = '<div style="color: red; text-align: center; padding: 20px;">Error al cargar la imagen</div>';
                        };
                    } else {
                        console.error('No se encontró content en imageData:', imageData);
                    }
                }
                
                // Listener para mensajes del padre
                window.addEventListener('message', function(event) {
                    console.log('Mensaje recibido en iframe:', event.data);
                    console.log('Origen del mensaje:', event.origin);
                    
                    if (event.data.func === 'BCLoadDocument') {
                        var data = event.data.message;
                        console.log('Procesando datos en iframe:', data);
                        
                        if (data.type === 'imageLoad' && data.data && data.data.length > 0) {
                            console.log('Mostrando imagen desde imageLoad');
                            displayImage(data.data[0]);
                            images = data.data;
                            currentImageIndex = 0;
                        } else if (data.type === 'image' || data.content) {
                            console.log('Mostrando imagen individual');
                            displayImage(data);
                        } else {
                            console.warn('Formato de datos no reconocido:', data);
                        }
                    } else {
                        console.log('Mensaje recibido pero no es BCLoadDocument:', event.data);
                    }
                });
                
                console.log('Image viewer inicializado');
            </script>
        </body>
        </html>
    `;
    
    // Crear el iframe con el contenido
    controlAddIn.innerHTML = '<iframe id="viewer" style="border-style: none; margin: 0px; padding: 0px; height: 100%; width: 100%" allowFullScreen></iframe>';
    __ViewerFrame = document.getElementById('viewer');
    __ViewerFrame.addEventListener("load", ViewerReady);
    
    // Cargar el contenido en el iframe
    __ViewerFrame.src = 'data:text/html;charset=utf-8,' + encodeURIComponent(iframeContent);
}

function getViewerOrigin(url) {
    if (isIE()) {
        var l = document.createElement("a");
        l.href = url;
        return (l.protocol + "//" + l.hostname);
    } else {
        return (new URL(url)).origin;
    }
}

function isIE() {
    ua = navigator.userAgent;
    /* MSIE used to detect old browsers and Trident used to newer ones*/
    var is_ie = ua.indexOf("MSIE ") > -1 || ua.indexOf("Trident/") > -1;
    
    return is_ie; 
  }


  function onMessage(event) {
    if (event.origin !== __ViewerOrigin) {
        console.log('Blocked invalid cross-domain call');
        return;
    }

    var data = event.data;

    if (typeof(window[data.func]) == "function") {
        window[data.func].call(null, data.message);
    }
}

function ViewerReady(message) {
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('OnViewerReady', null);
}

function LoadDocument(data,textdata) {
    //var x = document.getElementById("viewer").contentWindow; 
   data=JSON.parse(textdata);
    console.dir(JSON.stringify(data));
    
    // Crear una estructura estándar para imágenes
    var imageData = {
        type: "imageLoad",
        data: []
    };
    
    // Si es una URL directa
    if (typeof data === 'string' && (data.startsWith('http') || data.startsWith('data:image'))) {
        imageData.data.push({
            type: "image",
            content: data,
            description: "Imagen"
        });
    }
    // Si es un objeto con src
    else if (data.src) {
        imageData.data.push({
            type: "image",
            content: data.src,
            description: data.alt || "Imagen"
        });
    }
    // Si es un objeto con content (base64)
    else if (data.content) {
        imageData.data.push({
            type: "image",
            content: data.content,
            description: data.description || "Imagen"
        });
    }
    // Si es un objeto con action y data
    else if (data.action === "loadImage" && data.data && data.data.src) {
        imageData.data.push({
            type: "image",
            content: data.data.src,
            description: "Imagen"
        });
    }
    // Si ya tiene la estructura correcta
    else if (data.type === "imageLoad" && data.data) {
        imageData = data;
    }
    // Por defecto, tratar como imagen
    else {
        imageData.data.push({
            type: "image",
            content: JSON.stringify(data),
            description: "Imagen"
        });
    }
    
    console.log("Enviando datos de imagen:", imageData);
    console.log("Origen del iframe:", __ViewerOrigin);
    console.log("Iframe disponible:", __ViewerFrame);
    
    // Enviar al iframe
    try {
        __ViewerFrame.contentWindow.postMessage({
            'func': 'BCLoadDocument',
            'message': imageData
        }, __ViewerOrigin);
        console.log("Mensaje enviado al iframe");
    } catch (error) {
        console.error("Error al enviar mensaje:", error);
    }
}
function Ampliar(){
    var x=window.top.document.getElementsByClassName("designer-client-frame")[0].contentWindow.document.body.getElementsByClassName("ms-nav-cardpartform ms-nav-noCommandBar control-addin-form vertical-stretch")[1];
    console.log(x);
    x.style.width="100%";
    x.style.height="100%";
    x=x.children[0];
    x.style.height="100%";
}

// Función de prueba para verificar el sistema
function testImageLoad() {
    console.log("Probando carga de imagen...");
    
    var testData = {
        "type": "image",
        "content": "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8cmVjdCB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgZmlsbD0iIzMzY2NmZiIvPgogIDx0ZXh0IHg9IjEwMCIgeT0iMTAwIiBmb250LWZhbWlseT0iQXJpYWwiIGZvbnQtc2l6ZT0iMjAiIGZpbGw9IndoaXRlIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBkeT0iLjNlbSI+VGVzdCBJbWFnZTwvdGV4dD4KPC9zdmc+",
        "description": "Imagen de prueba"
    };
    
    var jsonString = JSON.stringify(testData);
    LoadDocument(testData, jsonString);
}