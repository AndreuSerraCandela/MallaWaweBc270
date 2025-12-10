// Check if jQuery is available, otherwise use DOMContentLoaded
if (typeof $ !== 'undefined' && $.fn && $.fn.ready) {
    $(document).ready(function() {
        initializeControlAddIn('controlAddIn');
    });
} else {
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', function() {
            initializeControlAddIn('controlAddIn');
        });
    } else {
        // DOM already loaded
        initializeControlAddIn('controlAddIn');
    }
}