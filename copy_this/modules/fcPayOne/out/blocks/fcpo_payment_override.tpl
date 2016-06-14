[{if method_exists($oViewConf, 'getActiveTheme') && $oViewConf->getActiveTheme() == 'mobile'}]
    [{include file="fcpayone_mobile_payment.tpl"}]
[{else}]
    [{assign var="iPayError" value=$oView->getPaymentError() }]
    [{ if $iPayError == -20}]
        <div class="status error">[{ $oView->getPaymentErrorText() }]</div>
    [{/if}]

    [{oxscript include=$oViewConf->fcpoGetModuleJsPath('fcPayOne.js')}]
    <script type="text/javascript" src="https://secure.pay1.de/client-api/js/ajax.js"></script>
    <style type="text/css">
        .fcpo_check_error, #fcpo_elv_error, #fcpo_elv_error_blocked, #fcpo_cc_error, #fcpo_ou_error {
            display: none;
        }

        .errorbox {
             background-color: red;
             color: white;
        }
    </style>

    [{oxscript include="js/widgets/oxpayment.js" priority=10 }]
    [{oxscript add="$( '#payment' ).oxPayment();"}]
    [{oxscript include="js/widgets/oxinputvalidator.js" priority=10 }]
    [{capture name="oxValidate"}]
    if (!((document.all && !document.querySelector) || (document.all && document.querySelector && !document.addEventListener))) {
        $('form.js-oxValidate').oxInputValidator();
    }
    [{/capture}]
    [{oxscript add=$smarty.capture.oxValidate}]
    <form autocomplete="off" action="[{ $oViewConf->getSslSelfLink() }]" class="js-oxValidate payment" id="payment" name="order" method="post" onsubmit="return fcCheckPaymentSelection();">
        <div>
            [{ $oViewConf->getHiddenSid() }]
            [{ $oViewConf->getNavFormParams() }]
            <input type="hidden" name="cl" value="[{ $oViewConf->getActiveClassName() }]">
            <input type="hidden" name="fnc" value="validatepayment">

            <input type="hidden" name="fcpo_mid" value="[{$oView->getMerchantId()}]">
            <input type="hidden" name="fcpo_portalid" value="[{$oView->getPortalId()}]">
            <input type="hidden" name="fcpo_encoding" value="[{$oView->getEncoding()}]">
            <input type="hidden" name="fcpo_aid" value="[{$oView->getSubAccountId()}]">
            <input type="hidden" name="fcpo_amount" value="[{$oView->getAmount()}]">
            <input type="hidden" name="fcpo_currency" value="[{ $currency->name}]">
            <input type="hidden" name="fcpo_tpllang" value="[{$oView->getTplLang()}]">
            <input type="hidden" name="fcpo_bill_country" value="[{$oView->fcGetBillCountry()}]">
            <input type="hidden" name="dynvalue[fcpo_pseudocardpan]" value="">
            <input type="hidden" name="dynvalue[fcpo_ccmode]" value="">
            <input type="hidden" name="fcpo_checktype" value="[{$oView->getChecktype()}]">
            <input type="hidden" name="fcpo_hashelvWith" value="[{$oView->getHashELVWithChecktype()}]">
            <input type="hidden" name="fcpo_hashelvWithout" value="[{$oView->getHashELVWithoutChecktype()}]">

            <input type="hidden" name="fcpo_integratorid" value="[{$oView->getIntegratorid()}]">
            <input type="hidden" name="fcpo_integratorver" value="[{$oView->getIntegratorver()}]">
            <input type="hidden" name="fcpo_integratorextver" value="[{$oView->getIntegratorextver()}]">
        </div>

        [{if $oView->getPaymentList()}]
            <h3 id="paymentHeader" class="blockHead">[{ oxmultilang ident="FCPO_TYPE_OF_PAYMENT" }]</h3>
            [{ assign var="inptcounter" value="-1"}]
            [{foreach key=sPaymentID from=$oView->getPaymentList() item=paymentmethod name=PaymentSelect}]
                [{ assign var="inptcounter" value="`$inptcounter+1`"}]
                [{block name="select_payment"}]
                    [{if $sPaymentID == "oxidcashondel"}]
                        [{include file="page/checkout/inc/payment_oxidcashondel.tpl"}]
                    [{elseif $sPaymentID == "oxidcreditcard"}]
                        [{include file="page/checkout/inc/payment_oxidcreditcard.tpl"}]
                    [{elseif $sPaymentID == "oxiddebitnote"}]
                        [{include file="page/checkout/inc/payment_oxiddebitnote.tpl"}]
                    [{else}]
                        [{include file="page/checkout/inc/payment_other.tpl"}]
                    [{/if}]
                [{/block}]
            [{/foreach}]

            [{* TRUSTED SHOPS BEGIN *}]
            [{include file="page/checkout/inc/trustedshops.tpl"}]
            [{* TRUSTED SHOPS END *}]

            [{block name="checkout_payment_nextstep"}]
            [{if $oView->isLowOrderPrice()}]
                <div class="lineBox clear">
                <div><b>[{ oxmultilang ident="FCPO_MIN_ORDER_PRICE" }] [{ $oView->getMinOrderPrice() }] [{ $currency->sign }]</b></div>
                </div>
            [{else}]
                <div class="lineBox clear">
                    <a href="[{ oxgetseourl ident=$oViewConf->getOrderLink() }]" class="prevStep submitButton largeButton" id="paymentBackStepBottom">[{ oxmultilang ident="FCPO_PREVIOUS_STEP" }]</a>
                    <button type="submit" name="userform" class="submitButton nextStep largeButton" id="paymentNextStepBottom">[{ oxmultilang ident="FCPO_CONTINUE_TO_NEXT_STEP" }]</button>
                </div>
            [{/if}]
            [{/block}]

        [{elseif $oView->getEmptyPayment()}]
            [{block name="checkout_payment_nopaymentsfound"}]
            <div class="lineBlock"></div>
            <h3 id="paymentHeader" class="blockHead">[{ oxmultilang ident="FCPO_PAYMENT_INFORMATION" }]</h3>
            [{ oxmultilang ident="FCPO_PAGE_CHECKOUT_PAYMENT_EMPTY_TEXT" }]
            <input type="hidden" name="paymentid" value="oxempty">
            <div class="lineBox clear">
                <a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=user" }]" class="prevStep submitButton largeButton">[{ oxmultilang ident="FCPO_PREVIOUS_STEP" }]</a>
                <button type="submit" name="userform" class="submitButton nextStep largeButton" id="paymentNextStepBottom">[{ oxmultilang ident="FCPO_CONTINUE_TO_NEXT_STEP" }]</button>
            </div>
            [{/block}]
        [{/if}]
    </form>
    <script type="text/javascript">
        if(document.getElementById('fcpoCreditcard') && typeof PayoneRequest == 'function') {
            document.getElementById('fcpoCreditcard').style.display = '';
        }
    </script>
[{/if}]