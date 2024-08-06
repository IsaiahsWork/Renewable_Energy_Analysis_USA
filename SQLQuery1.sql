use DataB
SELECT Description,YYYYMM,Unit, Value FROM PROD where Description = 'Total Renewable Energy Production' and YYYYMM >= 200901 and value < 1;