gal_GeneralInfo GenInfo_853359191 (
    AbsentValue = "",
    Comment = "",
    RecordLength = 256,
    StringDelimiter  = ",",
    StartRow = 1,
    GFVersionNumber = "4.4",
  );

gal_SelectDI BH (
    DIType = "Borehole",
    ContainerType = "Well",
    Attributes = "UWI",
    Operators = "=",
    Values = {BH.GetStrDataValue()[0]},
    DataValues = {
        gal_String(,,",",),
    },
    ContinueTest = 1
);


gal_CreateWellDI WellDI (
    Precondition = BH.SelectSuccessful == 0,
    DIType = "Well",
    Attributes = {"UWI"},
    Values = {BH.GetStrDataValue()[0]},
    ContinueTest = 1
);


gal_CreateBoreholeDI BoreholeDI (
    Precondition = BH.SelectSuccessful == 0,
    DIType = "Borehole",
    Container = WellDI,
    Attributes = {"UWI"},
    Values = {BH.GetStrDataValue()[0]},
    ContinueTest = 1
);


gal_CreateString CurrentBoreholeUWI (
    Values = {BH.GetStrDataValue()[0]},
    ContinueTest = 1
);

gal_CreateString NextBoreholeUWI (
    Values = {NextBoreholeUWI.GetStrDataValue()[0]},
    DataValues = {
        gal_NextString(,,",",),
    },
    ContinueTest = 1
);

gal_CreateWellDeviation WellDeviationData_853359191 (
    EndOfData = 0,
    AzimRef = "GRID",
    MagneticDecl = 0,
    MagDeclUnits = "deg",
    Container = {BoreholeDI,BH}[BH.SelectSuccessful],
    PreEndOfData = CurrentBoreholeUWI != NextBoreholeUWI,
    UWIColPosLen = {1},
    DataValues = {
        gal_Number(,,",","%g"),
        gal_Number(,,",","%g"),
        gal_Number(,,",","%g"),
        gal_Number(,,",","%g"),
    },
    ArrayCodes = {
        "MD",
        "DX",
        "DY",
        "",
    },
    ArrayUnits = {
        "ft",
        "ft",
        "ft",
        "",
    },
    ArrayFields = {
        1,
        2,
        3,
        -1,
    },
);