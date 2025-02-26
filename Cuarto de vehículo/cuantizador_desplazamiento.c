#define S_FUNCTION_NAME  cuantizador_desplazamiento
#define S_FUNCTION_LEVEL 2

#include "simstruc.h"
#include <math.h>  

#define BITS_SALIDA 16
#define BITS_RESOLUCION 15
#define RANGO 0.5  // Ajusta según el rango real del sensor

/* Función de cuantización */
double cuantizar_desplazamiento(double signal) {
    double escala = (1 << BITS_SALIDA) / RANGO;
    int signal_cuantizada = round(signal * escala);  

    // Extraer el bit de guarda (LSB)
    int bit_guardado = signal_cuantizada & 1;  

    // Redondeo hacia arriba si el bit de guarda es 1
    int signal_16_bits = (signal_cuantizada >> 1) + bit_guardado;

    // Convertir de nuevo a desplazamiento real
    double escala_15_bits = (1 << BITS_RESOLUCION) / RANGO;
    return (signal_16_bits / escala_15_bits);
}

static void mdlInitializeSizes(SimStruct *S) {
    ssSetNumContStates(S, 0);
    ssSetNumDiscStates(S, 0);
    
    if (!ssSetNumInputPorts(S, 1)) return;
    if (!ssSetNumOutputPorts(S, 1)) return;
    
    ssSetInputPortWidth(S, 0, 1);
    ssSetOutputPortWidth(S, 0, 1);
    
    ssSetInputPortDirectFeedThrough(S, 0, 1);
    
    ssSetNumSampleTimes(S, 1);
}

static void mdlInitializeSampleTimes(SimStruct *S) {
    ssSetSampleTime(S, 0, INHERITED_SAMPLE_TIME);
    ssSetOffsetTime(S, 0, 0.0);
}

static void mdlOutputs(SimStruct *S, int_T tid) {
    InputRealPtrsType uPtrs = ssGetInputPortRealSignalPtrs(S, 0);
    real_T *y = ssGetOutputPortRealSignal(S, 0);
    
    *y = cuantizar_desplazamiento(*uPtrs[0]);
}

static void mdlTerminate(SimStruct *S) {}

#ifdef MATLAB_MEX_FILE
#include "simulink.c"
#else
#include "cg_sfun.h"
#endif
