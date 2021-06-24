using System;
using System.Collections.Generic;

namespace mission_08
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Missão 8");

            Console.Write("Digite o número de números: ");
            var quantity = ReadValidDecimal();

            if (quantity < decimal.One)
            {
                Environment.Exit(0);
            }

            var numbers = new List<decimal>();
            for (int index = 0; index < quantity; index++)
            {
                Console.Write($"Digite o {index + 1}º número: ");
                numbers.Add(ReadValidDecimal());
            }

            numbers.Sort();
            Console.WriteLine($"Ordem crescente: {String.Join<decimal>(", ", numbers)}");

            numbers.Reverse();
            Console.WriteLine($"Ordem decrescente: {String.Join<decimal>(", ", numbers)}");
        }

        private static decimal ReadValidDecimal()
        {
            var value = decimal.MinValue;
            while (!decimal.TryParse(Console.ReadLine(), out value)) ;
            return value;
        }
    }
}
