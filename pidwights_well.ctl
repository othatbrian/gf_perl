gal_GeneralInfo GenInfo_1580952834 (
    AbsentValue = "-999.25",
    Comment = "",
    RecordLength = 256,
    StringDelimiter  = "|",
    StartRow = 1,
    GFVersionNumber = "3.5",
  );

gal_CreateWellDI GFDataItem_1580952834 (
    DIType = "Well",
    Attributes = {
        "UWI",
        "Name",
        "Lease_Name",
        "Operator",
        "Spud_Date",
    },
    Units = {
        " ",
        " ",
        " ",
        " ",
        " ",
    },
    Values = {
        GFDataItem_1580952834.GetStrDataValue()[0],
        GFDataItem_1580952834.GetStrDataValue()[1],
        GFDataItem_1580952834.GetStrDataValue()[2],
        GFDataItem_1580952834.GetStrDataValue()[6],
        GFDataItem_1580952834.GetStrDataValue()[7],
    },
    DataValues = {
        gal_String(,,"|",),
        gal_String(,,"|",),
        gal_String(,,"|",),
        gal_String(,,"|",),
        gal_String(,,"|",),
        gal_String(,,"|",),
        gal_String(,,"|",),
        gal_Date(,,"|","dd-MMM-yyyy H:M:S",),
        gal_Number(,,"|","%g"),
        gal_Number(,,"|","%g"),
        gal_Number(,,"|","%d"),
    },
    ContinueTest = 1
);


gal_CreateDI GFDataItem_1580952834_Pos (
    DIType = "Position",
    Container = GFDataItem_1580952834,
    Attributes = {
	"Code",
	"Storage_Coord1",
	"Storage_Coord2",
	"Unit",
	"Property_Code",
	"Measurement"
	},
    DataValues = {
        gal_String(,,"|",),
        gal_String(,,"|",),
        gal_String(,,"|",),
        gal_String(,,"|",),
        gal_String(,,"|",),
        gal_String(,,"|",),
        gal_String(,,"|",),
        gal_Date(,,"|","dd-MMM-yyyy H:M:S",),
        gal_Number(,,"|","%g"),
        gal_Number(,,"|","%g"),
        gal_Number(,,"|","%d"),
    },
   Values = {
	"Surface_Location",
	GFDataItem_1580952834.GetStrDataValue()[5],
	GFDataItem_1580952834.GetStrDataValue()[4],
	"deg",
	"Surface_Location",
	"GeographicalDistance"
	 },
    Units = {" ",
             "deg",
             "deg",
             " ",
             " ",
             " "},
	ContinueTest = 1
);


gal_CreateBoreholeDI GFDataItem_1580952834_BH (
    DIType = "Borehole",
    Container = GFDataItem_1580952834,
    WorkingDatum = { "KB" },
    WellSymbolType = { "IESX" },
    Attributes = {
        "UWI",
        "Name",
        "Short_Name",
        "KB",
        "Bottom_Depth",
        "Well_Symbol",
    },
    DataValues = {
        gal_String(,,"|",),
        gal_String(,,"|",),
        gal_String(,,"|",),
        gal_String(,,"|",),
        gal_String(,,"|",),
        gal_String(,,"|",),
        gal_String(,,"|",),
        gal_Date(,,"|","dd-MMM-yyyy H:M:S",),
        gal_Number(,,"|","%g"),
        gal_Number(,,"|","%g"),
        gal_Number(,,"|","%d"),
    },
    Units = {
        " ",
        " ",
        " ",
        "ft",
        "ft",
        " ",
    },
    Values = {
        GFDataItem_1580952834.GetStrDataValue()[0],
        GFDataItem_1580952834.GetStrDataValue()[1],
        GFDataItem_1580952834.GetStrDataValue()[3],
        GFDataItem_1580952834.GetNumDataValue()[8],
        GFDataItem_1580952834.GetNumDataValue()[9],
        GFDataItem_1580952834.GetNumDataValue()[10],
    },

);