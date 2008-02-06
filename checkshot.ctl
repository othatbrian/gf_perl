gal_GeneralInfo GenInfo_665766631 (
    AbsentValue = "-999.25",
    Comment = "",
    RecordLength = 256,
    StringDelimiter  = "\t",
    StartRow = 1,
    GFVersionNumber = "3.5",
  );

gal_SelectDI BH (
    DIType = "Borehole",
    ContainerType = "Well",
    Attributes = "UWI",
    Operators = "=",
    Values = {BH.GetStrDataValue()[0]},
    DataValues = {
        gal_String(,,"\t",),
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
        gal_NextString(,,"\t",),
    },
    ContinueTest = 1
);

gal_CreateString CheckshotName
(
    Values = {CheckshotName.GetStrDataValue()[3]},
    DataValues = {
        gal_String(,,"\t"),
        gal_String(,,"\t"),
        gal_String(,,"\t"),
        gal_String(,,"\t"),
    },
    ContinueTest = 1,
);

gal_CreateString NextCSName
(
    Values = {NextCSName.GetStrDataValue()[3]},
    DataValues = {
        gal_NextString(,,"\t"),
        gal_NextString(,,"\t"),
        gal_NextString(,,"\t"),
        gal_NextString(,,"\t"),
    },
    ContinueTest = 1,
);

gal_CreateWellCheckshot CheckshotData_665766631 (
    EndOfData = 0,
    Container = {BoreholeDI,BH}[BH.SelectSuccessful],
    PreEndOfData = CurrentBoreholeUWI != NextBoreholeUWI || CheckshotName != NextCSName,
    UWIColPosLen = {1},
    DataValues = {
        gal_Number(,,"\t","%g"),
        gal_Number(,,"\t","%g"),
        gal_Number(,,"\t","%g"),
        gal_Number(,,"\t","%g"),
    },
    ArrayCodes = {
        "",
        "TWOTIM",
        "TVD",
        "",
    },
    ArrayUnits = {
        "",
        "ms",
        "ft",
        "",
    },
    ArrayFields = {
        2,
        1,
    },
    CSName = {CheckshotName,4},
);