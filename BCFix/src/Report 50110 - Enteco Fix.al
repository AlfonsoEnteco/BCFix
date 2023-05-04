report 50110 "Enteco Fix"
{
    Caption = 'Enteco Fix';
    ProcessingOnly = true;
    UsageCategory = Lists;
    ApplicationArea = All;

    trigger OnPreReport()
    begin
        if (UserId() <> UPPERCASE('d.oton')) and (UserId() <> UPPERCASE('a.garcia')) and (UserId() <> UPPERCASE('a.millan')) then
            Error('Uso exclusivo de Tecnología. No tiene permiso');

        //cuTestWS.FunEjecutarWSExistencias('M14XF00601204', '', '');
        //Report.Run(Report::"Enteco Cierre de OT", false, false);

        //cu50018.FunBorrarPedido('1102023001660');
        RecItem.Get('P35Z21800007');
        RecItem.Delete(true);
    end;

    var
        RecItem: Record Item;
        cuWS: Codeunit "Enteco Web Services";
        cuTestWS: Codeunit "Enteco Test Web Service XML";
        cuInterfazOracle: Codeunit "Enteco Interfaz Oracle";
        cu50018: Codeunit "Enteco Correcciones ENTECO";

    local procedure ObligarPassword()
    var
        Usuarios: Record User;
    begin
        Usuarios.SetFilter("User Name", '<>%1', 'PRUEBA');
        Usuarios.ModifyAll("Change Password", true);
    end;

    local procedure FunPasarPSPDefinitivo(p_CodPSP: Code[20])
    var
        RecItem: Record Item;
    begin
        RecItem.Get(p_CodPSP);
        if not RecItem."Enteco PSP" then
            Error('No es un PSP');
        RecItem."Enteco Estado Ficha Tecnica" := RecItem."Enteco Estado Ficha Tecnica"::Definitivo;
        RecItem.Modify(true);
    end;
}