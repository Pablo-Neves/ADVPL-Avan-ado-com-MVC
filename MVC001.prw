#include "protheus.ch"
#include "parmtype.ch"
#include "FwMvcDef.ch"

User Function MVC001()
    Local oBrowse := FwMBrowse():New()

    oBrowse:SetAlias("ZZB")
    oBrowse:SetDescription("Albuns")

    //Legendas
    oBrowse:AddLegend("ZZB->ZZB_TIPO == '1'","GREEN","CD")
    oBrowse:AddLegend("ZZB->ZZB_TIPO == '2'","BLUE","DVD")

    oBrowse:Activate()
Return

//Construção da MenuDef
/*
1-Pesquisar
2-Visualizar
3-Incluir
4-Alterar
5-Excluir
7-Copiar
*/
static function MenuDef()
    Local aRotAux   := FWMvcMenu("MVC001 ")
    Local aRotina :={}
    Local nX
     //Adicionar as demais operacoes ao menu 

     For nX:=1 To Len(aRotAux)
        AADD(aRotina,aRotAux[nX])
     Next


        Add OPTION aRotina TITLE 'Informação' ACTION 'u_InfMvc()' OPERATION 6 ACCESS 0
        // Add OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.MVC001' OPERATION 2 ACCESS 0
        // Add OPTION aRotina TITLE 'Incluir'  ACTION 'VIEWDEF.MVC001' OPERATION 3 ACCESS 0
        // Add OPTION aRotina TITLE 'Alterar'  ACTION 'VIEWDEF.MVC001' OPERATION 4 ACCESS 0
        // Add OPTION aRotina TITLE 'Excluir'  ACTION 'VIEWDEF.MVC001' OPERATION 5 ACCESS 0
        // Add OPTION aRotina TITLE 'Copiar'  ACTION 'VIEWDEF.MVC001' OPERATION 7 ACCESS 0
Return aRotina

//Criando a ModelDef

static Function ModelDef()
    Local oModel := NIL
    Local oStZZB := FwFormStruct(1,"ZZB")

    //instanciando o modelo de dados
    oModel:= MPFormModel():New("ZMODELM", , , ,)

    oModel:AddFields("FORMZZB", ,oStZZB)
    oModel:SetPrimaryKey({"ZZB_FILIAL","ZZB_COD"})

    //Adicionando descricao ao modelo de dados
    oModel:SetDescription("Modelo de Dados")
    oModel:GetModel("FORMZZB"):SetDescription("Formulário de Cadastro")

Return oModel


//Criando a ViewDef
static Function ViewDef()
    //Local aStruZZB  :=ZZB->(DbStruct())
    Local oView     := Nil
    Local oModel    := FWLoadModel("MVC001")
    Local oStZZB    :=FwFormStruct(2,"ZZB")

    oView   :=  FWFormView():New() // Construindo o modelo de dados 
    oView:SetModel(oModel) // passando o modelo de dados informado
    // Ao adicionar o ID FORMZZB informamos que os dados da MODEL FORMZZB serão exibidos nessa VIEW

    // Removendo campo da view 
    oStZZB:RemoveField("ZZB_USER") // Remove campo da estrutura para o usuário não


    oView:AddField("VIEW_ZZB",oStZZB,"FORMZZB")

    oView:CreateHorizontalBox("TELA",100)
    oView:EnableTitleView("VIEW_ZZB","Dados View")
    oView:SetCloseOnOK({||.T.}) // Força o fechamento da tela
    oView:SetOwnerView("VIEW_ZZB","TELA")


Return oView


user Function InfMvc()

MSGALERT( "Atenção", "Menu Customizado MVC" )
Return
