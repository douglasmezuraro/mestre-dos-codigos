using System;
using System.Collections.Generic;
using System.Linq;

namespace mission_02
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Missão 02");
            var employees = new List<KeyValuePair<string, double>>();

            Console.WriteLine("Digite a quantidade de funcionários");
            var quantity = ReadQuantity();

            for (int index = 1; index < quantity + 1; index++)
            {
                Console.Write($"Digite o nome do funcionário #{index}: ");
                var name = ReadName();

                Console.Write($"Digite o salário do funcionário #{index}: ");
                var salary = ReadSalary();

                Console.WriteLine("");
                employees.Add(new KeyValuePair<string, double>(name, salary));
            }

            var lower = employees.OrderBy(e => e.Value).First();
            Console.WriteLine($"O funcionário {lower.Key} possui o menor salário com R${lower.Value:F2}.");

            var higher = employees.OrderBy(e => e.Value).Last();
            Console.WriteLine($"O funcionário {higher.Key} possui o maior salário com R${higher.Value:F2}.");
        }

        static string ReadName()
        {
            var name = string.Empty;
            do { name = Console.ReadLine(); } while (String.IsNullOrEmpty(name));
            return name;
        }

        static double ReadSalary()
        {
            var salary = double.MinValue;
            while (!double.TryParse(Console.ReadLine(), out salary)) ;
            return salary;
        }

        static int ReadQuantity()
        {
            var quantity = int.MinValue;
            while (!int.TryParse(Console.ReadLine(), out quantity)) ;
            return quantity;
        }
    }
}
