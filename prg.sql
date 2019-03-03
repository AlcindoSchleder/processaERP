update PROGRAMAS set 
       FK_LINGUAGENS = :fklinguagens , 
       FK_MODULOS = :fkmodulos , 
       FK_ROTINAS = :fkrotinas , 
       PK_PROGRAMAS = :pkprogramas , 
       DSC_PRG = :dscprg , 
       NOM_LIB = :nomlib , 
       NOM_FRM = :nomfrm , 
       FLAG_VIS = :flagvis , 
       FLAG_REL = :flagrel 
 where FK_LINGUAGENS = :Oldfklinguagens
   and FK_MODULOS = :Oldfkmodulos
   and FK_ROTINAS = :Oldfkrotinas
   and PK_PROGRAMAS = :Oldpkprogramas
