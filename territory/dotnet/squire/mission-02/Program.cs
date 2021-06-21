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
            var employees = new List<Employee>();

            Console.WriteLine("Digite a quantidade de funcionários");
            var quantity = ReadQuantity();

            for (int index = 1; index < quantity + 1; index++)
            {
                var employee = new Employee();

                Console.Write($"Digite o nome do funcionário #{index}: ");
                employee.name = ReadName();

                Console.Write($"Digite o salário do funcionário #{index}: ");
                employee.salary = ReadSalary();

                Console.WriteLine("");
                employees.Add(employee);
            }

            var lower = employees.OrderBy(e => e.salary).First();
            Console.WriteLine($"Funcionário com salário mais baixo -> {lower}.");

            var higher = employees.OrderBy(e => e.salary).Last();
            Console.WriteLine($"Funcionário com salário mais alto -> {higher}.");
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
