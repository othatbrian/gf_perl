gal_GeneralInfo GenInfo_31634 (
    AbsentValue = "0",
    Comment = "",
    RecordLength = 256,
    StringDelimiter  = " ",
    StartRow = 1,
    GFVersionNumber = "3.5",
  );

gal_SelectDI BH (
    DIType = "Borehole",
    ContainerType = "Well",
    Attributes = "UWI",
    Operators = "=",
    Values  = {
               BH.GetStrDataValue()[0],
    },
    DataValues = {
        gal_String(,," ",),
        gal_Number(,," ","%d"),
        gal_String(,," ",),
    },
    ContinueTest = 1
);

gal_CreateWellDI WellDI (
    Precondition = BH.SelectSuccessful == 0,
    DIType = "Well",
    Attributes = "UWI",
    Values  = {
               BH.GetStrDataValue()[0],
    },
    ContinueTest = 1
);

gal_CreateBoreholeDI BoreholeDI (
    Precondition = BH.SelectSuccessful == 0,
    DIType = "Borehole",
    ContainerType = "Well",
    Attributes = "UWI",
    Values  = {
               BH.GetStrDataValue()[0],
    },
    ContinueTest = 1
);

gal_WellMarkerDI GFDataItem_31634 (
    DIType = "Strat_Marker",
    IndexType = "MD",
    UWICheck = "YES",
    ValueUnit = "ft",
    Attributes = {
        "Borehole_UWI",
        "Value",
        "Name",
    },
    Units = {
        " ",
        " ",
        " ",
    },
    Values = {
        GFDataItem_31634.GetStrDataValue()[0],
        GFDataItem_31634.GetNumDataValue()[1],
        GFDataItem_31634.GetStrDataValue()[2],
    },
    DataValues = {
        gal_String(,," ",),
        gal_Number(,," ","%d"),
        gal_String(,," ",),
    },
);