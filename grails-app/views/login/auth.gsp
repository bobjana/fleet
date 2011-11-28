<head>
    <meta name='layout' content='main'/>
    <title>Login</title>

    <style type="text/css">

    #login {
        vertical-align: middle;
        width: 270;
        margin: 50 auto;
        text-align: left;
        background-color: #ffffff;
    }

    .inner td {
        padding-left: 15;
        background-color: transparent;
    }

    </style>
</head>

<body>
<div id='login'>
    <div class='inner'>
        <div class="sectionHeading">
            <h6><g:message code="login.heading.label"/></h6>
        </div>
        <g:if test='${flash.message}'>
            <div class="errors">${flash.message}</div>
        </g:if>
        <form action='${postUrl}' method='POST' id='loginForm' class='cssform' autocomplete='off'>
            <table>
                <tr>
                    <td><label for='username'>Email</label></td>
                    <td><input type='text' class='text_' name='j_username' id='username'/></td>
                </tr>
                <tr>
                    <td><label for='password'>Password</label></td>
                    <td><input type='password' class='text_' name='j_password' id='password'/></td>
                </tr>
                <tr>
                    <td><label for='remember_me'>Remember me</label></td>
                    <td><input type='checkbox' class='chk' name='${rememberMeParameter}' id='remember_me'
                        <g:if test='${hasCookie}'>checked='checked'</g:if>/></td>
                </tr>
                <tr class="buttons">
                    <td colspan="2">
                        <input type='submit' value='Login' style="padding-left:0px; background-color: transparent;"/>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
<script type='text/javascript'>
    <!--
    (function() {
        document.forms['loginForm'].elements['j_username'].focus();
    })();
    // -->
</script>
</body>
