<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/Site1.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="FEHMS_Code_Co_Falcon.Presentation.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <style>
    :root {
        --ccf-navy: #0F2843;
        --ccf-dark: #1a3a52;
        --ccf-blue: #0084d4;
        --ccf-light-blue: #00A8E8;
        --ccf-light: #F5F5F5;
        --ccf-white: #FFFFFF;
        --ccf-text-dark: #333333;
    }

    /* LOGIN PAGE SPECIFIC STYLES */
    .login-wrapper {
        min-height: calc(100vh - 160px);
        display: flex;
        align-items: center;
        justify-content: center;
        background: linear-gradient(135deg, var(--ccf-navy) 0%, var(--ccf-dark) 100%);
        padding: 40px 20px;
        position: relative;
        overflow: hidden;
    }

    .login-wrapper::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -50%;
        width: 500px;
        height: 500px;
        background: rgba(0, 168, 232, 0.03);
        border-radius: 50%;
        pointer-events: none;
    }

    .login-wrapper::after {
        content: '';
        position: absolute;
        bottom: -30%;
        left: -30%;
        width: 400px;
        height: 400px;
        background: rgba(0, 132, 212, 0.02);
        border-radius: 50%;
        pointer-events: none;
    }

    .login-container {
        background: var(--ccf-white);
        border-radius: 12px;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        width: 100%;
        max-width: 450px;
        padding: 50px 40px;
        position: relative;
        z-index: 1;
        animation: slideUp 0.6s ease;
    }

    @keyframes slideUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* LOGO SECTION */
    .logo-section {
        text-align: center;
        margin-bottom: 40px;
    }

    .logo-wrapper {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 15px;
        margin-bottom: 20px;
    }

    .logo-wrapper img {
        height: 60px;
        width: auto;
        filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.1));
    }

    .logo-section h1 {
        color: var(--ccf-navy);
        font-size: 32px;
        font-weight: 700;
        margin: 0;
        letter-spacing: -1px;
    }

    .logo-section .brand-subtitle {
        color: var(--ccf-blue);
        font-size: 13px;
        font-weight: 600;
        letter-spacing: 2px;
        text-transform: uppercase;
        margin-top: 5px;
    }

    .logo-section p {
        color: #999;
        font-size: 14px;
        margin: 15px 0 0 0;
        font-weight: 500;
    }

    /* FORM STYLING */
    .login-form {
        position: relative;
    }

    .form-group {
        margin-bottom: 24px;
    }

    .form-group label {
        display: block;
        color: var(--ccf-text-dark);
        font-weight: 600;
        margin-bottom: 10px;
        font-size: 14px;
    }

    .form-group input[type="email"],
    .form-group input[type="password"] {
        width: 100%;
        padding: 12px 16px;
        border: 2px solid #e0e0e0;
        border-radius: 8px;
        font-size: 14px;
        transition: all 0.3s ease;
        font-family: inherit;
        background-color: #fafafa;
    }

    .form-group input[type="email"]:focus,
    .form-group input[type="password"]:focus {
        outline: none;
        border-color: var(--ccf-blue);
        background-color: var(--ccf-white);
        box-shadow: 0 0 0 4px rgba(0, 132, 212, 0.1);
    }

    .form-group input::placeholder {
        color: #bbb;
    }

    /* ERROR MESSAGE */
    .error-message {
        background: linear-gradient(135deg, #fee 0%, #fdd 100%);
        color: #c00;
        padding: 14px 16px;
        border-radius: 8px;
        margin-bottom: 24px;
        border-left: 4px solid #c00;
        font-size: 14px;
        display: none;
        animation: slideDown 0.3s ease;
    }

    .error-message.show {
        display: block;
    }

    @keyframes slideDown {
        from {
            opacity: 0;
            transform: translateY(-10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* REMEMBER & FORGOT */
    .remember-forgot {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 28px;
        gap: 15px;
        flex-wrap: wrap;
    }

    .checkbox-group {
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .checkbox-group input[type="checkbox"] {
        cursor: pointer;
        width: 18px;
        height: 18px;
        accent-color: var(--ccf-blue);
        border-radius: 4px;
    }

    .checkbox-group label {
        margin: 0;
        cursor: pointer;
        color: #555;
        font-weight: 500;
        font-size: 14px;
    }

    .forgot-link {
        color: var(--ccf-blue);
        text-decoration: none;
        font-weight: 600;
        font-size: 14px;
        transition: all 0.3s ease;
    }

    .forgot-link:hover {
        color: var(--ccf-dark);
        text-decoration: underline;
    }

    /* LOGIN BUTTON */
    .btn-login {
        width: 100%;
        padding: 14px 20px;
        background: linear-gradient(135deg, var(--ccf-blue) 0%, var(--ccf-light-blue) 100%);
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        text-transform: uppercase;
        letter-spacing: 1px;
        box-shadow: 0 6px 20px rgba(0, 132, 212, 0.3);
    }

    .btn-login:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 28px rgba(0, 132, 212, 0.4);
    }

    .btn-login:active {
        transform: translateY(0);
    }

    .btn-login:disabled {
        opacity: 0.6;
        cursor: not-allowed;
        transform: none;
    }

    /* SIGNUP LINK */
    .divider {
        text-align: center;
        color: #999;
        font-size: 14px;
        margin-top: 28px;
        padding-top: 24px;
        border-top: 1px solid #e0e0e0;
    }

    .divider a {
        color: var(--ccf-blue);
        text-decoration: none;
        font-weight: 700;
        transition: color 0.3s ease;
    }

    .divider a:hover {
        color: var(--ccf-dark);
        text-decoration: underline;
    }

    /* LOCKED PANEL */
    .locked-panel {
        text-align: center;
        padding: 40px 20px;
        display: none;
    }

    .locked-panel.show {
        display: block;
        animation: slideUp 0.6s ease;
    }

    .lock-icon {
        font-size: 64px;
        margin-bottom: 20px;
        color: #ff6b6b;
    }

    .locked-panel h3 {
        color: var(--ccf-navy);
        margin-bottom: 15px;
        font-size: 24px;
        font-weight: 700;
    }

    .locked-panel p {
        color: #666;
        font-size: 15px;
        line-height: 1.7;
        margin-bottom: 12px;
    }

    .locked-panel .retry-info {
        background: #fff3cd;
        color: #856404;
        padding: 15px;
        border-radius: 8px;
        margin-top: 20px;
        font-weight: 500;
        font-size: 14px;
    }

    /* VALIDATION MESSAGES */
    .validation-error {
        color: #c00;
        font-size: 12px;
        margin-top: 6px;
        display: none;
    }

    .validation-error.show {
        display: block;
    }

    /* RESPONSIVE */
    @media (max-width: 480px) {
        .login-container {
            padding: 40px 25px;
        }

        .logo-section h1 {
            font-size: 28px;
        }

        .logo-wrapper img {
            height: 50px;
        }

        .remember-forgot {
            flex-direction: column;
            align-items: flex-start;
        }

        .btn-login {
            padding: 12px 16px;
            font-size: 14px;
        }
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
           <div class="login-wrapper">
        <div class="login-container">
            <!-- Logo Section -->
            <div class="logo-section">
                <div class="logo-wrapper">
                     <img src="/Images/logo.png" alt="Code & Co. Falcon Logo" />
                </div>
                <h1>Forte Event Hire</h1>
                <div class="brand-subtitle">Code & Co. Falcon</div>
                <p>Required to fill in to login</p>
            </div>

            <!-- Login Form Panel -->
            <asp:Panel ID="pnlLogin" runat="server" CssClass="login-form">
                <!-- Error Message -->
                <asp:Label ID="lblError" runat="server" CssClass="error-message" Visible="false"></asp:Label>

                <!-- Email Field -->
                <div class="form-group">
                    <label for="<%= txtEmail.ClientID %>">Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" 
                        placeholder="Enter your email address" required="required"></asp:TextBox>
                    <asp:RequiredFieldValidator 
                        ControlToValidate="txtEmail" 
                        ErrorMessage="Email is required" 
                        Display="None" 
                        runat="server" />
                    <asp:RegularExpressionValidator 
                        ControlToValidate="txtEmail" 
                        ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" 
                        ErrorMessage="Please enter a valid email address" 
                        Display="None" 
                        runat="server" />
                </div>

                <!-- Password Field -->
                <div class="form-group">
                    <label for="<%= txtPassword.ClientID %>">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" 
                        placeholder="Enter your password" required="required"></asp:TextBox>
                    <asp:RequiredFieldValidator 
                        ControlToValidate="txtPassword" 
                        ErrorMessage="Password is required" 
                        Display="None" 
                        runat="server" />
                </div>

                <!-- Remember Me & Forgot Password -->
                <div class="remember-forgot">
                    <div class="checkbox-group">
                        <asp:CheckBox ID="chkRemember" runat="server" />
                        <label for="<%= chkRemember.ClientID %>">Remember me</label>
                    </div>
                    <a href="ForgotPassword.aspx" class="forgot-link">Forgot Password?</a>
                </div>

                <!-- Login Button -->
                <asp:Button ID="BtnLogin" runat="server" Text="Sign In" 
                    CssClass="btn-login" OnClick="BtnLogin_Click" />

                <!-- Sign Up Link -->
                <div class="divider">
                    Don't have an account? <a href="Register.aspx">Create one now</a>
                </div>
            </asp:Panel>

            <!-- Account Locked Panel -->
            <asp:Panel ID="pnlLocked" runat="server" CssClass="locked-panel show" Visible="false">
                <div class="lock-icon">🔒</div>
                <h3>Account Temporarily Locked</h3>
                <p>Too many failed login attempts have been detected.</p>
                <p>For security reasons, your account has been temporarily locked.</p>
                <div class="retry-info">
                    ⏱️ Please try again in 15 minutes
                </div>
                <p style="margin-top: 20px;">
                    <a href="ForgotPassword.aspx" class="forgot-link">Reset your password →</a>
                </p>
            </asp:Panel>
        </div>
    </div>

    <script>
        // Show error message with animation
        function showError() {
            var errorLabel = document.getElementById('<%= lblError.ClientID %>');
            if (errorLabel && errorLabel.innerText.trim() !== '') {
                errorLabel.classList.add('show');
                errorLabel.style.display = 'block';
            }
        }

        // Run on page load
        document.addEventListener('DOMContentLoaded', showError);
    </script>
</asp:Content>
