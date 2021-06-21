using System;

namespace mission_01
{
    enum Option { Exit = 0, Sum, Subtraction, Division, Multiplication, EvenOrOdd };

    class Program
    {
        static void Main(string[] args)
        {
            WriteMenu();

            Console.Write("Digite a opção: ");
            var option = ReadOption();

            if (option.Equals(Option.Exit))
            {
                Environment.Exit(0);
            }

            Console.Write(" - Digite o primeiro número: ");
            var a = ReadNumber();

            Console.Write(" - Digite o segundo número: ");
            var b = ReadNumber();

            Run(option, a, b);

            Main(args);
        }

        private static void WriteMenu()
        {
            Console.WriteLine("Missão 01");
            Console.WriteLine($"[{(int)Option.Exit}] Sair");
            Console.WriteLine($"[{(int)Option.Sum}] Some de A e B");
            Console.WriteLine($"[{(int)Option.Subtraction}] Subtração de A por B");
            Console.WriteLine($"[{(int)Option.Division}] Divisão de B por A");
            Console.WriteLine($"[{(int)Option.Multiplication}] Multiplicação de A por B");
            Console.WriteLine($"[{(int)Option.EvenOrOdd}] Mostrar se os valores de entrada são pares ou ímpares");
            Console.WriteLine("");
        }

        private static Option ReadOption()
        {
            var option = Option.Exit;
            while (!Enum.TryParse<Option>(Console.ReadLine(), out option)) ;
            return option;
        }

        private static double ReadNumber()
        {
            var number = 0.0;
            while (!double.TryParse(Console.ReadLine(), out number)) ;
            return number;
        }

        private static void Run(Option option, double a, double b)
        {
            switch (option)
            {
                case Option.Sum:
                    Console.WriteLine($" - A soma de {a} e {b} é {a + b}.");
                    break;
                case Option.Subtraction:
                    Console.WriteLine($" - A subtração de {a} por {b} é {a - b}.");
                    break;
                case Option.Division:
                    Console.WriteLine($" - A divisão de {b} por {a} é {b / a}.");
                    break;
                case Option.Multiplication:
                    Console.WriteLine($" - A multiplicação de {a} por {b} é {a * b}.");
                    break;
                case Option.EvenOrOdd:
                    Console.WriteLine($" - {a} é " + ((a % 2 == 0) ? "par" : "ímpar"));
                    Console.WriteLine($" - {b} é " + ((b % 2 == 0) ? "par" : "ímpar"));
                    break;
                default:
                    Console.WriteLine($" - A opção {option} não é válida. Digite uma opção válida.");
                    break;
            }

            Console.WriteLine("");
        }
    }
}
