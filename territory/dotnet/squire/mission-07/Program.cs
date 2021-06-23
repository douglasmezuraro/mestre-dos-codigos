using System;

namespace mission_07
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Missão 7");

            var length = args.Length == 2 ? int.Parse(args[1]) : 4;
            var values = new int[length];

            for (int index = 0; index < length; index++)
            {
                Console.Write($"Digite o {index + 1}º número: ");
                values[index] = ReadValidInt();
            }

            var sum = SumOnlyEvens(values);
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
