unit Test.Operations;

interface

uses
  DUnitX.TestFramework, Impl.Operations, System.SysUtils;

type
  [TestFixture]
  TOperationsTest = class sealed(TObject)
  private
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
    procedure TestSortLetters(const Text, Expected: string);

    [Test]
    [TestCase('Count "e" letter', 'paralelepipedo,e,3')]
    [TestCase('Count "l" letter', 'paralelepipedo,l,2')]
    [TestCase('Count "o" letter', 'paralelepipedo,o,1')]
    [TestCase('Count "x" letter', 'paralelepipedo,x,0')]
    procedure TestCountOccurrences(const Text: string; const Value: Char; const Expected: Word);

    [Test]
    [TestCase('Empty text', ',a')]
    [TestCase('Empty value', 'a, ')]
    [TestCase('Empty text and value', ', ')]
    procedure TestCountOcurrencesException(const Text: string; const Value: Char);

    [Test]
    [TestCase('Empty word', ',')]
    [TestCase('Acute accent', 'paraná,parana')]
    [TestCase('Grava accent', 'àquela,aquela')]
    [TestCase('Circumflex accent', 'metrô,metro')]
    [TestCase('Tilde accent', 'cão,cao')]
    procedure TestRemoveAccents(const Text, Expected: string);

    [Test]
    [TestCase('Word with dot', 'something.')]
    [TestCase('Word with exclamation', 'something!')]
    [TestCase('Word with interrogation', 'something?')]
    procedure TestRemoveAccentsException(const Text: string);
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

procedure TOperationsTest.TestCountOccurrences(const Text: string; const Value: Char; const Expected: Word);
var
  Actual: Word;
begin
  Actual := FOperations.CountOccurrences(Text, Value);
  Assert.AreEqual(Expected, Actual);
end;

procedure TOperationsTest.TestCountOcurrencesException(const Text: string; const Value: Char);
begin
  Assert.WillRaise(procedure
                   begin
                     FOperations.CountOccurrences(Text, Value);
                   end,
                   EArgumentException);
end;

procedure TOperationsTest.TestRemoveAccentsException(const Text: string);
begin
  Assert.WillRaise(procedure
                   begin
                     FOperations.RemoveAccents(Text);
                   end,
                   EInvalidCharacter);
end;

procedure TOperationsTest.TestRemoveAccents(const Text, Expected: string);
var
  Actual: string;
begin
  Actual := FOperations.RemoveAccents(Text);
  Assert.AreEqual(Expected, Actual);
end;

procedure TOperationsTest.TestSortLetters(const Text, Expected: string);
var
  Actual: string;
begin
  Actual := FOperations.SortLetters(Text);
  Assert.AreEqual(Expected, Actual);
end;

initialization
  TDUnitX.RegisterTestFixture(TOperationsTest);

end.

