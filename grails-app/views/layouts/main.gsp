<html>
<head>

    <title><g:layoutTitle default="B.E.D Fleet Management"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>
    <link rel="shortcut icon" href="${resource(dir: '/', file: 'favicon.ico')}" type="image/x-icon"/>
    <g:javascript library="jquery" plugin="jquery"/>
    <jqui:resources themeCss="${resource(dir: 'css/themes/smoothness', file: 'jquery-ui-1.8.15.custom.css')}"/>
    <script src="${resource(dir: 'js/tipsy', file: 'jquery.tipsy.js')}" type="text/javascript"></script>
    <jqueryui:javascript/>
    <g:layoutHead/>
    <!--[if !IE 7]>
	<style type="text/css">
		#wrap {display:table;height:100%}
	</style>
    <![endif]-->
</head>

<body>
<div id="spinner" class="spinner" style="display:none;">
    <img src="${resource(dir: 'images', file: 'spinner.gif')}"
         alt="${message(code: 'spinner.alt', default: 'Loading...')}"/>
</div>

<div class="mainBanner">
        <img src="${resource(dir: 'images', file: 'logo.png')}" alt="${message(code: 'logo.alt',
                default: 'Logo')}"/>
</div>

<div class="wrapper">
    <g:layoutBody/>
</div>
%{--<div class="footer">Version: 1.0 ALPHA</div>--}%

</body>
</html>