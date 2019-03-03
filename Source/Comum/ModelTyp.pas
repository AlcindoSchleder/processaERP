unit ModelTyp;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 10/04/2003 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for datails                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

type
  TModelCnstNames = (tcModFile1, tcModFile2, tcFile, tcIsClosed, tcSelectOrderNow,
    tcErrorLevel, tcLevelOpe, tcModelRetTransaction, tcFindReg, tcQtdRegTmp,
    tcSemRegTmp, tcSQLTxt, tcTabOrder, tcAppTitle, tcDeleteInfo, tcDeleteTitl,
    tcDeleteError, tcmiFile, tcmiPrint, tcmiClose, tcmiOperations, tcmiInsert,
    tcmiDelete, tcmiCancel, tcmiPost, tcmiRefresh, tcmiFind, tcmiNavigator,
    tcmiFirst, tcmi_5Reg, tcmiPrior, tcmiNext, tcmi5Reg, tcmiLast, tcmiTools,
    tcmiShowSql, tcmiOrderSql, tcmiHelp, tcmiTopics, tcmiContent,
    tcmiAbout, tcmiSendMail, tcmiVisibleEntrp, tctbClose, tctbPrint, tctbHelp, tctbFind,
    tctbInsert, tctbDelete, tctbCancel, tctbPost, tctbRefresh, tctsDataAware,
    tctsTable, tcHintbClose, tcHintbPrint, tcHintbHelp, tcHintbFind,
    tcHintbInsert, tcHintbDelete, tcHintbCancel, tcHintbPost, tcHintbRefresh,
    tcHintdbNavigatorBtn1, tcHintdbNavigatorBtn2, tcHintdbNavigatorBtn3,
    tcHintdbNavigatorBtn4, tcHintlNameEntrp, tcErrTransSqlCntAct,
    tcErrMainFileNameNull, tcQtdRegs, tcErrCalcCount, tcIsOpen, tcHintbEntrp,
    tcOrderFields, tcmiSelOperator, tcpmEqual, tcpmNoEqual, tcpmLessThan,
    tcpmLessEQ, tcpmGreaterThan, tcpmGreaterEQ, tcpmStartWith, tcpmNoStartWith,
    tcpmFinishWith, tcpmNoFinishWith, tcpmContaining, tcpmNoContaining,
    tcpmComplete, tcpmDay, tcpmMonth, tcpmYear, tcpmAddOrder, tcpmOrderSql,
    tcpmFlagFilter, tcpmDates, tcSelection, tcFalse, tcTrue, tcDataSetInsError,
    tcmiInsertSQL, tcmiDeleteSQL, tcmiUpdateSQL, tcmiRefreshSQL, tcmiReportSQL);

const
  ModelConstants: array [0..Integer(High(TModelCnstNames))] of string =
   ('sModFile1', 'sModFile2', 'sFile', 'sIsClosed', 'sSelectOrderNow',
    'sErrorLevel', 'sLevelOpe', 'sModelRetTransaction', 'sFindReg', 'sQtdRegTmp',
    'sSemRegTmp', 'sSQLTxt', 'sTabOrder', 'sAppTitle', 'sDeleteInfo', 'sDeleteTitl',
    'sDeleteError', 'smiFile', 'smiPrint', 'smiClose', 'smiOperations', 'smiInsert',
    'smiDelete', 'smiCancel', 'smiPost', 'smiRefresh', 'smiFind', 'smiNavigator',
    'smiFirst', 'smi_5Reg', 'smiPrior', 'smiNext', 'smi5Reg', 'smiLast', 'smiTools',
    'smiShowSql', 'smiOrderSql', 'smiHelp', 'smiTopics', 'smiContent',
    'smiAbout', 'smiSendMail', 'smiVisibleEntrp', 'stbClose', 'stbPrint', 'stbHelp', 'stbFind',
    'stbInsert', 'stbDelete', 'stbCancel', 'stbPost', 'stbRefresh', 'stsDataAware',
    'stsTable', 'sHintbClose', 'sHintbPrint', 'sHintbHelp', 'sHintbFind',
    'sHintbInsert', 'sHintbDelete', 'sHintbCancel', 'sHintbPost', 'sHintbRefresh',
    'sHintdbNavigatorBtn1', 'sHintdbNavigatorBtn2', 'sHintdbNavigatorBtn3',
    'sHintdbNavigatorBtn4', 'sHintlNameEntrp', 'sErrTransSqlCntAct',
    'sErrMainFileNameNull', 'sQtdRegs', 'sErrCalcCount', 'sIsOpen', 'sHintbEntrp',
    'sOrderFields', 'smiSelOperator', 'spmEqual', 'spmNoEqual', 'spmLessThan',
    'spmLessEQ', 'spmGreaterThan', 'spmGreaterEQ', 'spmStartWith', 'spmNoStartWith',
    'spmFinishWith', 'spmNoFinishWith', 'spmContaining', 'spmNoContaining',
    'spmComplete', 'spmDay', 'spmMonth', 'spmYear', 'spmAddOrder', 'spmOrderSql',
    'spmFlagFilter', 'spmDates', 'sSelection', 'sFalse', 'sTrue', 'sDataSetInsError',
    'smiInsertSQL', 'smiDeleteSQL', 'smiUpdateSQL', 'smiRefreshSQL', 'smiReportSQL'
);

var
  VarModel: array of string;

implementation

end.
