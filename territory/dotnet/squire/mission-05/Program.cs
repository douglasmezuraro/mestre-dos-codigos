using System;

namespace mission_05
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Missão 05");

            Console.Write("Digite o valor de a: ");
            var a = ReadInt();

            Console.Write("Digite o valor de b: ");
            var b = ReadInt();

            Console.Write("Digite o valor de c: ");
            var c = ReadInt();

            Console.WriteLine(new Bhaskara(a, b, c).ToString());
        }

        static int ReadInt()
        {
            var value = int.MinValue;
            while (!int.TryParse(Console.ReadLine(), out value)) ;
            return value;
        }
    }
}
