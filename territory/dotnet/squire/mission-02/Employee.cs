namespace mission_02
{
    class Employee
    {
        public string name { get; set; }
        public double salary { get; set; }

        public override string ToString() => $"Nome: {this.name} - Salário: {this.salary:F2}";
    }
}