unit Test.Operations;

interface

uses
  DUnitX.TestFramework, Impl.Operations, System.SysUtils;

type
  [TestFixture]
  TOperationsTest = class sealed(TObject)
  strict private
    FOperations: TOperations;
  public
    [Setup]
    procedure Setup;

    [TearDown]
    procedure TearDown;

    [Test]
    [TestCase('Word with blank space', 'ioqwpe bxk bcx,bbceikopqwxx')]
    [TestCase('Sorted word', 'abcdef,abcdef')]
    [TestCase('Inverted word', 'fedcab,abcdef')]
    [TestCase('GUID', '37949A6222ED4ACEBB71112835863823,111222223333445667788899AABBCDEE')]
    procedure TestSortLetters(const AText, AExpected: string);

    [Test]
    [TestCase('Count "e" letter', 'paralelepipedo,e,3')]
    [TestCase('Count "l" letter', 'paralelepipedo,l,2')]
    [TestCase('Count "o" letter', 'paralelepipedo,o,1')]
    [TestCase('Count "x" letter', 'paralelepipedo,x,0')]
    procedure TestCountOccurrences(const AText: string; const AChar: Char; const AExpected: UInt64);

    [Test]
    [TestCase('Empty text', ',a')]
    [TestCase('Empty value', 'a, ')]
    [TestCase('Empty text and value', ', ')]
    procedure TestCountOcurrencesException(const AText: string; const AChar: Char);

    [Test]
    [TestCase('Empty word', ',')]
    [TestCase('Acute accent', 'paraná,parana')]
    [TestCase('Grave accent', 'àquela,aquela')]
    [TestCase('Circumflex accent', 'metrô,metro')]
    [TestCase('Tilde accent', 'cão,cao')]
    procedure TestRemoveAccents(const AText, AExpected: string);

    [Test]
    [TestCase('Word with dot', 'something.')]
    [TestCase('Word with exclamation', 'something!')]
    [TestCase('Word with interrogation', 'something?')]
    procedure TestRemoveAccentsException(const AText: string);
  end;

implementation

procedure TOperationsTest.Setup;
begin
  FOperations := TOperations.Create;
end;

procedure TOperationsTest.TearDown;
begin
  FOperations.Free;
end;

procedure TOperationsTest.TestCountOccurrences(const AText: string; const AChar: Char; const AExpected: UInt64);
var
  LActual: UInt64;
begin
  LActual := FOperations.CountOccurrences(AText, AChar);
  Assert.AreEqual(AExpected, LActual);
end;

procedure TOperationsTest.TestCountOcurrencesException(const AText: string; const AChar: Char);
begin
  Assert.WillRaise(procedure
                   begin
                     FOperations.CountOccurrences(AText, AChar);
                   end,
                   EArgumentException);
end;

procedure TOperationsTest.TestRemoveAccentsException(const AText: string);
begin
  Assert.WillRaise(procedure
                   begin
                     FOperations.RemoveAccents(AText);
                   end,
                   EInvalidCharacter);
end;

procedure TOperationsTest.TestRemoveAccents(const AText, AExpected: string);
var
  LActual: string;
begin
  LActual := FOperations.RemoveAccents(AText);
  Assert.AreEqual(AExpected, LActual);
end;

procedure TOperationsTest.TestSortLetters(const AText, AExpected: string);
var
  LActual: string;
begin
  LActual := FOperations.SortLetters(AText);
  Assert.AreEqual(AExpected, LActual);
end;

initialization
  TDUnitX.RegisterTestFixture(TOperationsTest);

end.

