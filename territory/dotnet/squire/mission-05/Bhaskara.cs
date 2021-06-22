using System;

namespace mission_05
{
    public class Bhaskara
    {
        public readonly double X1;
        public readonly double X2;

        public Bhaskara(int a, int b, int c)
        {
            var delta = (b * b) - (4 * a * c);
            X1 = (-b + Math.Sqrt(delta)) / (2 * a);
            X2 = (-b - Math.Sqrt(delta)) / (2 * a);
        }

        public override string ToString() => $"X' = {X1} - X'' = {X2}";
    }
}