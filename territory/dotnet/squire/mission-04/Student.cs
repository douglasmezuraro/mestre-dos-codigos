namespace mission_04
{
    class Student
    {
        public string name { get; set; }
        public double grade { get; set; }

        public override string ToString() => $"Nome: {this.name} - Nota: {this.grade:F2}";
    }
}