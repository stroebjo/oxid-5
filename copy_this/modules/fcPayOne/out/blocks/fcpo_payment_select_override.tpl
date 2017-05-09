[{assign var="aFcPoCCPaymentMetaData" value=$oView->fcpoGetCCPaymentMetaData()}]
[{assign var="aFcPoOnlinePaymentMetaData" value=$oView->fcpoGetOnlinePaymentMetaData()}]
[{assign var="dynvalue" value=$oView->getDynValue()}]
[{assign var="sFcPoTemplatePath" value=$oView->fcpoGetActiveThemePath()}]

[{if $sPaymentID == "fcpocreditcard" && $oView->fcpoGetCreditcardType() == "ajax"}]
    [{assign var="sFcPoTemplatePath" value=$sFcPoTemplatePath|cat:'/fcpo_payment_creditcard_ajax.tpl'}]
    [{include file=$oViewConf->fcpoGetAbsModuleTemplateFrontendPath($sFcPoTemplatePath)}]
[{elseif $sPaymentID == "fcpocreditcard" && $oView->fcpoGetCreditcardType() == "hosted"}]
    [{assign var="sFcPoTemplatePath" value=$sFcPoTemplatePath|cat:'/fcpo_payment_creditcard_hosted.tpl'}]
    [{include file=$oViewConf->fcpoGetAbsModuleTemplateFrontendPath($sFcPoTemplatePath)}]
[{elseif $sPaymentID == "fcpodebitnote"}]
    [{assign var="sFcPoTemplatePath" value=$sFcPoTemplatePath|cat:'/fcpo_payment_debitnote.tpl'}]
    [{include file=$oViewConf->fcpoGetAbsModuleTemplateFrontendPath($sFcPoTemplatePath)}]
[{elseif $sPaymentID == "fcpoonlineueberweisung"}]
    [{assign var="sFcPoTemplatePath" value=$sFcPoTemplatePath|cat:'/fcpo_payment_onlinetransfer.tpl'}]
    [{include file=$oViewConf->fcpoGetAbsModuleTemplateFrontendPath($sFcPoTemplatePath)}]
[{elseif $sPaymentID == "fcpoklarna"}]
    [{assign var="sFcPoTemplatePath" value=$sFcPoTemplatePath|cat:'/fcpo_payment_klarna.tpl'}]
    [{include file=$oViewConf->fcpoGetAbsModuleTemplateFrontendPath($sFcPoTemplatePath)}]
[{elseif $sPaymentID == "fcpopo_bill"}]
    [{assign var="sFcPoTemplatePath" value=$sFcPoTemplatePath|cat:'/fcpo_payment_payolution_bill.tpl'}]
    [{include file=$oViewConf->fcpoGetAbsModuleTemplateFrontendPath($sFcPoTemplatePath)}]
[{elseif $sPaymentID == "fcpopo_debitnote"}]
    [{assign var="sFcPoTemplatePath" value=$sFcPoTemplatePath|cat:'/fcpo_payment_payolution_debitnote.tpl'}]
    [{include file=$oViewConf->fcpoGetAbsModuleTemplateFrontendPath($sFcPoTemplatePath)}]
[{elseif $sPaymentID == "fcpopo_installment"}]
    [{assign var="sFcPoTemplatePath" value=$sFcPoTemplatePath|cat:'/fcpo_payment_payolution_installment.tpl'}]
    [{include file=$oViewConf->fcpoGetAbsModuleTemplateFrontendPath($sFcPoTemplatePath)}]
[{elseif $sPaymentID == "fcporp_bill"}]
    [{assign var="sFcPoTemplatePath" value=$sFcPoTemplatePath|cat:'/fcpo_payment_ratepay_bill.tpl'}]
    [{include file=$oViewConf->fcpoGetAbsModuleTemplateFrontendPath($sFcPoTemplatePath)}]
[{else}]
    [{$smarty.block.parent}]
[{/if}]
