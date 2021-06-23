using System;

namespace mission_07
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Missão 7");

            Console.Write("Digite o primeiro valor: ");
            var a = ReadValidInt();

            Console.Write("Digite o segundo valor: ");
            var b = ReadValidInt();

            Console.Write("Digite o terceiro valor: ");
            var c = ReadValidInt();

            Console.Write("Digite o quarto valor: ");
            var d = ReadValidInt();

            var sum = SumOnlyEvens(new int[] { a, b, c, d });
            Console.WriteLine($"Soma dos números pares: {sum}");
        }

        private static int ReadValidInt()
        {
            var value = int.MinValue;
            while (!int.TryParse(Console.ReadLine(), out value)) ;
            return value;
        }

        private static int SumOnlyEvens(int[] values)
        {
            var sum = 0;

            foreach (var value in values)
            {
                if (value % 2 == 0)
                {
                    sum += value;
                }
            }

            return sum;
        }
    }
}
