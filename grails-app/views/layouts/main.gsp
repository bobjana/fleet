<html>
<head>
    <title><g:layoutTitle default="Cibecs Audit Tool"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>
    <link rel="shortcut icon" href="http://cibecs.com/wp-content/themes/cibecs/favicon.ico" type="image/x-icon"/>
    <g:layoutHead/>
    <g:javascript library="application"/>
</head>

<body>
<div id="spinner" class="spinner" style="display:none;">
    <img src="${resource(dir: 'images', file: 'spinner.gif')}"
         alt="${message(code: 'spinner.alt', default: 'Loading...')}"/>
</div>

<div class="wrapper">
    <div class="mainBanner">
        <div class="mainBannerTitle">
            <h1>BED Fleet Management</h1>
        </div>

        <div class="mainBannerLogo">
            <img src="${resource(dir: 'images', file: 'logo.png')}" alt="${message(code: 'logo.alt',
                    default: 'Logo')}"/>
        </div>
    </div>
    <g:layoutBody/>
</div>

<div class="footer">Version: 1.0 ALPHA</div>
</body>
</html>