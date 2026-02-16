using System;
using System.Collections.Generic;

namespace TestNamespace
{
    public class Calculator
    {
        // Propiedades y campos
        private double _result;
        public int Counter { get; set; }
        
        // Literales numéricos en C#
        int entero = 42;
        double flotante = 3.14159;
        float floatF = 2.5f;        // f suffix en C#
        decimal decimalM = 19.95m;  // m suffix en C#
        long largo = 1234567890L;   // L suffix en C#
        
        // Hexadecimales
        int hex1 = 0xFF;
        uint hex2 = 0xABCDu;        // u suffix en C#
        
        // Notación científica
        double cientifico = 1.5e10;
        
        // Operadores específicos de C#
        string nullCoalescing = valor ?? "default";  // ??
        int? nullable = null;                        // ?
        
        /* Comentario multilínea
           en C# funciona igual
           que en Java */
           
        // Comentario de línea en C#
        
        // Cadenas en C#
        string normal = "Cadena normal";
        string verbatim = @"C:\Path\To\File";       // @ verbatim string
        string interpolated = $"Resultado: {result}"; // $ interpolated string
        
        // Métodos
        public double Add(double x, double y)
        {
            return x + y;
        }
        
        public bool Compare(int a, int b)
        {
            return (a >= b) && (a != 0) || !IsNegative(a);
        }
        
        private bool IsNegative(int value)
        {
            return value < 0;
        }
    }
}