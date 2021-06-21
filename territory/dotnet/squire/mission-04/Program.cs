using System;
using System.Collections.Generic;

namespace mission_04
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Missão 04");
            var students = new List<Student>();

            Console.Write("Digite a quantidade de alunos: ");
            var quantity = ReadQuantity();

            for (int index = 1; index < quantity + 1; index++)
            {
                var student = new Student();

                Console.Write($"Digite o nome do aluno #{index}: ");
                student.name = ReadName();

                Console.Write($"Digite a nota do aluno #{index}: ");
                student.grade = ReadGrade();

                Console.WriteLine("");
                students.Add(student);
            }

            students.ForEach(student =>
                {
                    if (student.grade >= 7.0)
                    {
                        Console.WriteLine(student);
                    }
                }
            );
        }

        static string ReadName()
        {
            var name = string.Empty;
            do { name = Console.ReadLine(); } while (String.IsNullOrEmpty(name));
            return name;
        }

        static double ReadGrade()
        {
            var grade = double.MinValue;
            while (!double.TryParse(Console.ReadLine(), out grade)) ;
            return grade;
        }

        static int ReadQuantity()
        {
            var quantity = int.MinValue;
            while (!int.TryParse(Console.ReadLine(), out quantity)) ;
            return quantity;
        }
    }
}
