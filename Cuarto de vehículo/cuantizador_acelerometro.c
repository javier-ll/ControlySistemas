#define S_FUNCTION_NAME  cuantizador_acelerometro
#define S_FUNCTION_LEVEL 2

#include "simstruc.h"
#include <math.h>  

#define BITS_SALIDA 16
#define BITS_RESOLUCION 12
#define RANGO (6 * 9.81) // Rango de medición del acelerómetro

/* Función de cuantización */
double cuantizar(double signal) {
    double escala = (1 << BITS_SALIDA) / (2 * RANGO);  
    int signal_cuantizada = round((signal + RANGO) * escala); 

    // Extraer los 4 bits de guarda
    int bits_guardados = signal_cuantizada & 0b1111; 
    int primer_bit = (bits_guardados >> 3) & 1;
    int otros_bits = bits_guardados & 0b0111;

    // Regla de redondeo
    int redondear_arriba = (primer_bit == 1) && ((otros_bits > 0) || ((otros_bits == 0) && ((signal_cuantizada >> 4) & 1)));
    
    // Ajuste a 12 bits
    int signal_12_bits = (signal_cuantizada >> 4) + redondear_arriba;

    // Convertir de nuevo a aceleración real
    double escala_12_bits = (1 << BITS_RESOLUCION) / (2 * RANGO);
    return (signal_12_bits / escala_12_bits) - RANGO;
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
    
    *y = cuantizar(*uPtrs[0]);
}

static void mdlTerminate(SimStruct *S) {}

#ifdef MATLAB_MEX_FILE
#include "simulink.c"
#else
#include "cg_sfun.h"
#endif

