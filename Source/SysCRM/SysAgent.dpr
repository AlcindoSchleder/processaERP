program SysAgent;

uses
  Forms,
  DlgMsg in 'DlgMsg.pas' {DlgMessage},
  DlgTaskView in 'DlgTaskView.pas',
  DlgWeekView in 'DlgWeekView.pas',
  mSysCrm in 'mSysCrm.pas' {dmSysCrm: TDataModule},
  TrnspMem in 'TrnspMem.pas',
  uContct in 'uContct.pas' {frmContact},
  uSchedule in 'uSchedule.pas' {frmSchedule},
  UTask in 'UTask.pas' {frmTasks},
  ArqCnstCrm in 'ArqCnstCrm.pas',
  ArqSqlCrm in 'ArqSqlCrm.pas',
  CadAgenda in 'CadAgenda.pas' {CdAgenda},
  CadCntct in 'CadCntct.pas' {CdContacts},
  CadEvent in 'CadEvent.pas' {CdEvents},
  CadTask in 'CadTask.pas' {CdTasks},
  CadWeek in 'CadWeek.pas' {frmWeek},
  CrmAgent in 'CrmAgent.pas',
  UnitRsc_pt in '..\Comum\UnitRsc_pt.pas',
  Autor in '..\Comum\Autor.pas' {frmAuthor},
  CadMod in '..\Comum\CadMod.pas' {CdModelo},
  Dado in '..\Comum\Dado.pas' {Dados: TDataModule},
  DualMod in '..\Comum\DualMod.pas' {DualOrder},
  Funcoes in '..\Comum\Funcoes.pas',
  FuncoesDB in '..\Comum\FuncoesDB.pas',
  InputData in '..\Comum\InputData.pas',
  ModelTyp in '..\Comum\ModelTyp.pas',
  Ovo in '..\Comum\Ovo.pas' {frmEgg},
  PopUpText in '..\Comum\PopUpText.pas' {frmMemo},
  PrcDBInfo in '..\Comum\PrcDBInfo.pas',
  PrcIBFBInfo in '..\Comum\PrcIBFBInfo.pas',
  PrcSysTypes in '..\Comum\PrcSysTypes.pas',
  SelEmpr in '..\Comum\SelEmpr.pas' {SelEmpresa},
  Sobre in '..\Comum\Sobre.pas' {frmAboutProcessa},
  SqlComm in '..\Comum\SqlComm.pas',
  TSysCad in '..\Comum\TSysCad.pas',
  TSysCadAux in '..\Comum\TSysCadAux.pas',
  TSysCrmAux in '..\Comum\TSysCrmAux.pas',
  TSysMan in '..\Comum\TSysMan.pas',
  TSysManAux in '..\Comum\TSysManAux.pas',
  uMonitor in '..\Comum\uMonitor.pas' {frmMonitor};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Processa Schedule Open Source';
  Application.CreateForm(TCdAgenda, CdAgenda);
  Application.Run;
end.
