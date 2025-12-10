"use strict"

var timerInterval;
var timerObject;
var isInitialized = false;

function initializeControlAddIn(id) {
    try {
        var controlAddIn = document.getElementById(id);
        
        if (!controlAddIn) {
            console.error('ControlAddIn element not found');
            return;
        }

        controlAddIn.innerHTML =
            '<div id="my-timer">' +
            '</div>';
        pageLoaded();

        isInitialized = true;
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ControlAddInReady', null);
    } catch (error) {
        console.error('Error initializing ControlAddIn:', error);
        try {
            Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('TimerError', [error.message || 'Error initializing control']);
        } catch (e) {
            console.error('Error invoking TimerError:', e);
        }
    }
}

function pageLoaded() {
}

function SetTimerInterval(milliSeconds) {
    if (milliSeconds != null && milliSeconds > 0) {
        timerInterval = milliSeconds;
    }
}

function StartTimer() {
    try {
        if (!isInitialized) {
            console.warn('ControlAddIn not initialized yet');
            return;
        }

        if (timerInterval == null || timerInterval == undefined || timerInterval <= 0) {
            var errorMsg = 'No timer interval set.';
            try {
                Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('TimerError', [errorMsg]);
            } catch (e) {
                console.error('Error invoking TimerError:', e);
            }
            return;
        }

        // Stop any existing timer before starting a new one
        if (timerObject) {
            clearInterval(timerObject);
        }

        timerObject = window.setInterval(ExecuteTimer, timerInterval);
    } catch (error) {
        console.error('Error in StartTimer:', error);
        try {
            Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('TimerError', [error.message || 'Error starting timer']);
        } catch (e) {
            console.error('Error invoking TimerError:', e);
        }
    }
}

function StopTimer() {
    try {
        if (timerObject) {
            clearInterval(timerObject);
            timerObject = null;
        }
    } catch (error) {
        console.error('Error in StopTimer:', error);
    }
}

function ExecuteTimer() {
    try {
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('TimerElapsed', null);
    } catch (error) {
        console.error('Error in ExecuteTimer:', error);
        StopTimer();
    }
}