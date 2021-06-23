using System;

namespace mission_06
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Missão 6");

            // "x" não precisa ter valor atribuído
            int x;
            Out(out x);
            Console.WriteLine($"x = {x}");

            // "y" precisa ter valor atribuído
            int y = 1023;
            Ref(ref y);
            Console.WriteLine($"y = {y}");
        }

        private static void Out(out int a)
        {
            // "a" precisa ter valor atribuído
            a = 512;
        }

        private static void Ref(ref int b)
        {
            // "b" não precisa ter valor atribuído
            b++;
        }
    }
}
