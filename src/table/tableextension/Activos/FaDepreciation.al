/// <summary>
/// TableExtension FA Depreciation BookKuara (ID 80281) extends Record FA Depreciation Book.
/// </summary>
tableextension 80281 "FA Depreciation BookKuara" extends "FA Depreciation Book"
{
    fields
    {
        field(50004; "Old Depreciation Starting Date"; Date) { }
        field(50006; "Old No. of Depreciation Years"; Decimal) { MinValue = 0; }
        field(50007; Bloqueado; Boolean) { }
        field(50008; Inactivo; Boolean) { }
    }
}
