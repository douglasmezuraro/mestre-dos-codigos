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

                employees.Add(new KeyValuePair<string, double>(name, salary));

                Console.WriteLine("");
            }

            var lower = employees.Where(e => e.Value == employees.Min(s => s.Value)).First();
            Console.WriteLine($"O funcionário {lower.Key} possui o menor salário que é R${lower.Value}.");

            var higher = employees.Where(e => e.Value == employees.Max(s => s.Value)).First();
            Console.WriteLine($"O funcionário {higher.Key} possui o maior salário que é R${higher.Value}.");
        }

        static string ReadName()
        {
            var name = "";
            name = Console.ReadLine();
            return name;
        }

        static double ReadSalary()
        {
            var salary = 0.0;
            while (!double.TryParse(Console.ReadLine(), out salary)) ;
            return salary;
        }

        static int ReadQuantity()
        {
            var quantity = 0;
            while (!int.TryParse(Console.ReadLine(), out quantity)) ;
            return quantity;
        }
    }
}
