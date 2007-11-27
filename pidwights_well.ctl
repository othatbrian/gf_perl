gal_GeneralInfo GenInfo_1306478401 (
    AbsentValue = "-999.25",
    Comment = "",
    RecordLength = 256,
    StringDelimiter  = "\t",
    StartRow = 1,
    GFVersionNumber = "3.5",
  );

gal_CreateWellDI GFDataItem_1306478401 (
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
        GFDataItem_1306478401.GetStrDataValue()[0],
        GFDataItem_1306478401.GetStrDataValue()[1],
        GFDataItem_1306478401.GetStrDataValue()[2],
        GFDataItem_1306478401.GetStrDataValue()[6],
        GFDataItem_1306478401.GetStrDataValue()[7],
    },
    DataValues = {
        gal_String(,,"\t",),
        gal_String(,,"\t",),
        gal_String(,,"\t",),
        gal_String(,,"\t",),
        gal_String(,,"\t",),
        gal_String(,,"\t",),
        gal_String(,,"\t",),
        gal_Date(,,"\t","dd-MMM-yyyy H:M:S",),
        gal_Number(,,"\t","%g"),
        gal_Number(,,"\t","%g"),
        gal_Number(,,"\t","%d"),
    },
    ContinueTest = 1
);


gal_CreateDI GFDataItem_1306478401_Pos (
    DIType = "Position",
    Container = GFDataItem_1306478401,
    Attributes = {
	"Code",
	"Storage_Coord1",
	"Storage_Coord2",
	"Unit",
	"Property_Code",
	"Measurement"
	},
    DataValues = {
        gal_String(,,"\t",),
        gal_String(,,"\t",),
        gal_String(,,"\t",),
        gal_String(,,"\t",),
        gal_String(,,"\t",),
        gal_String(,,"\t",),
        gal_String(,,"\t",),
        gal_Date(,,"\t","dd-MMM-yyyy H:M:S",),
        gal_Number(,,"\t","%g"),
        gal_Number(,,"\t","%g"),
        gal_Number(,,"\t","%d"),
    },
   Values = {
	"Surface_Location",
	GFDataItem_1306478401.GetStrDataValue()[5],
	GFDataItem_1306478401.GetStrDataValue()[4],
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


gal_CreateBoreholeDI GFDataItem_1306478401_BH (
    DIType = "Borehole",
    Container = GFDataItem_1306478401,
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
        gal_String(,,"\t",),
        gal_String(,,"\t",),
        gal_String(,,"\t",),
        gal_String(,,"\t",),
        gal_String(,,"\t",),
        gal_String(,,"\t",),
        gal_String(,,"\t",),
        gal_Date(,,"\t","dd-MMM-yyyy H:M:S",),
        gal_Number(,,"\t","%g"),
        gal_Number(,,"\t","%g"),
        gal_Number(,,"\t","%d"),
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
        GFDataItem_1306478401.GetStrDataValue()[0],
        GFDataItem_1306478401.GetStrDataValue()[1],
        GFDataItem_1306478401.GetStrDataValue()[3],
        GFDataItem_1306478401.GetNumDataValue()[8],
        GFDataItem_1306478401.GetNumDataValue()[9],
        GFDataItem_1306478401.GetNumDataValue()[10],
    },

);