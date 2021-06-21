using System;

namespace mission_03
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Missão 03");

            var number = 1;
            while (number <= 100)
            {
                if (number % 3 == 0)
                {
                    Console.WriteLine($"O número {number} é multíplo de {3}.");
                }
                number++;
            }
        }
    }
}
