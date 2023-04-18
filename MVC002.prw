#include "protheus.ch"
#include "parmtype.ch"
#include "FwMvcDef.ch"

User Function MVC002()
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
   
    Local aRotina  := FWMvcMenu("MVC002")

Return aRotina

//Criando a ModelDef

static Function ModelDef()
    Local oModel :=  MPFormModel():New("XMVC003", , , ,)
    Local oStpai:= FwFormStruct(1,"ZZB")
    Local oStFilho:= FwFormStruct(1,"ZZA")
  

    oModel :AddFields("ZZBMASTER", ,oStpai)
    oModel :AddGrid("ZZADETAIL","ZZBMASTER",oStFilho , , , , ,)

    oModel:SetRelation("ZZADETAIL",{{'ZZA_FILIAL','xFilial("ZZA")'},{'ZZA_CODALB','ZZB_COD'}},ZZA->(INDEXKEY( 1 )))
    oModel:SetPrimaryKey({"ZZA_FILIAL",""})
    oModel:SetDescription("Modelo 3")
    oModel:GetModel("ZZBMASTER"):SetDescription("Modelo Albuns")
    oModel:GetModel("ZZADETAIL"):SetDescription("Modelo Músicas")

   

Return oModel


//Criando a ViewDef
static Function ViewDef()
    //Local aStruZZB  :=ZZB->(DbStruct())
    Local oView     := Nil
    Local oModel    := FWLoadModel("MVC002")
    Local oStPai   :=FwFormStruct(2,"ZZB")
    Local oStFilho    :=FwFormStruct(2,"ZZA")

    oView :=FWFormView():New()
    oView:SetModel(oModel)

    oView:AddField("VIEW_ZZB",oStpai,"ZZBMASTER")
    oView:AddGrid("VIEW_ZZA",oStFilho,"ZZADETAIL")

     oView:CreateHorizontalBox("CABEC",40)
     oView:CreateHorizontalBox("GRID",60)

    oView:SetOwnerView("VIEW_ZZB","CABEC")
    oView:SetOwnerView("VIEW_ZZA","GRID")

     oView:EnableTitleView("VIEW_ZZB","CABEÇALHO")
     oView:EnableTitleView("VIEW_ZZA","GRID")

    

Return oView


