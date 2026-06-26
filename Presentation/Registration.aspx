<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/Site1.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="FEHMS_Code_Co_Falcon.Presentation.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
          <style>
    :root {
        --ccf-navy: #0F2438;
        --ccf-blue: #0099CC;
        --ccf-bright-blue: #00B8E6;
        --ccf-white: #FFFFFF;
        --ccf-light-grey: #F0F4F8;
        --ccf-dark-grey: #4A5568;
    }
    
    * {
        box-sizing: border-box;
    }
    
    .registration-container {
        min-height: 100vh;
        background: linear-gradient(135deg, var(--ccf-navy) 0%, #0a1f2e 50%, #142e42 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 40px 20px;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        position: relative;
        overflow: hidden;
    }
    
    .registration-container::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: 
            linear-gradient(135deg, transparent 0%, rgba(0, 153, 204, 0.05) 100%),
            linear-gradient(45deg, transparent 30%, rgba(0, 184, 230, 0.03) 70%);
        pointer-events: none;
    }

    .reg-wrapper {
        display: flex;
        max-width: 1100px;
        width: 100%;
        background: var(--ccf-white);
        box-shadow: 0 30px 80px rgba(0, 0, 0, 0.4), 0 0 40px rgba(0, 153, 204, 0.1);
        overflow: hidden;
        position: relative;
        z-index: 1;
    }

    .reg-branding {
        background: linear-gradient(135deg, var(--ccf-navy) 0%, #0a2540 100%);
        color: white;
        padding: 60px 50px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        text-align: center;
        min-width: 380px;
        position: relative;
        overflow: hidden;
    }
    
    .reg-branding::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -50%;
        width: 500px;
        height: 500px;
        background: linear-gradient(135deg, rgba(0, 184, 230, 0.15) 0%, transparent 70%);
        border-radius: 50%;
        pointer-events: none;
    }
    
    .reg-branding::after {
        content: '';
        position: absolute;
        bottom: -100px;
        left: -100px;
        width: 300px;
        height: 300px;
        background: linear-gradient(45deg, rgba(0, 153, 204, 0.1) 0%, transparent 60%);
        clip-path: polygon(0 0, 100% 0, 0 100%);
        pointer-events: none;
    }

    .reg-branding h2 {
        font-size: 36px;
        margin-bottom: 4px;
        color: var(--ccf-white);
        font-weight: 800;
        letter-spacing: -0.5px;
        position: relative;
        z-index: 2;
    }
    
    .reg-branding .brand-highlight {
        font-size: 36px;
        color: var(--ccf-bright-blue);
        font-weight: 800;
        letter-spacing: -0.5px;
        position: relative;
        z-index: 2;
    }

    .reg-branding p {
        font-size: 14px;
        line-height: 1.8;
        opacity: 0.85;
        margin: 12px 0 0 0;
        position: relative;
        z-index: 2;
    }

    .reg-badge {
        background: rgba(0, 184, 230, 0.15);
        border: 2px solid var(--ccf-bright-blue);
        border-radius: 4px;
        padding: 12px 16px;
        font-size: 11px;
        color: var(--ccf-bright-blue);
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 1.2px;
        margin-top: 28px;
        position: relative;
        z-index: 2;
    }

    .reg-card {
        flex: 1;
        padding: 50px 45px;
        overflow-y: auto;
        background: var(--ccf-white);
    }

    .reg-header {
        margin-bottom: 32px;
    }

    .reg-header h1 {
        color: var(--ccf-navy);
        font-size: 28px;
        font-weight: 700;
        margin-bottom: 8px;
        letter-spacing: -0.3px;
    }

    .reg-header p {
        color: var(--ccf-dark-grey);
        font-size: 14px;
        font-weight: 500;
    }

    .form-group {
        margin-bottom: 22px;
    }

    .form-group label {
        color: var(--ccf-navy);
        font-weight: 600;
        margin-bottom: 8px;
        font-size: 13px;
        display: block;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .form-control {
        width: 100%;
        border: 2px solid #e5e7eb;
        border-radius: 6px;
        padding: 12px 14px;
        font-size: 14px;
        transition: all 0.3s ease;
        box-sizing: border-box;
        font-family: inherit;
        background: var(--ccf-light-grey);
        color: var(--ccf-navy);
    }

    .form-control:focus {
        outline: none;
        border-color: var(--ccf-bright-blue);
        background: var(--ccf-white);
        box-shadow: 0 0 0 4px rgba(0, 184, 230, 0.1);
    }

    .form-control.is-invalid {
        border-color: #ef4444;
        background: #fef2f2;
    }

    .invalid-feedback {
        color: #ef4444;
        font-size: 12px;
        margin-top: 6px;
        display: block;
        font-weight: 500;
    }

    .password-strength {
        height: 5px;
        border-radius: 3px;
        margin-top: 10px;
        background: #e5e7eb;
        overflow: hidden;
    }

    .password-strength-meter {
        height: 100%;
        width: 0%;
        transition: all 0.3s ease;
        background: #ef4444;
    }

    .password-strength-meter.weak { 
        width: 33%; 
        background: #ef4444; 
    }

    .password-strength-meter.fair { 
        width: 66%; 
        background: #f59e0b; 
    }

    .password-strength-meter.strong { 
        width: 100%; 
        background: var(--ccf-bright-blue); 
    }

    .password-hint {
        font-size: 12px;
        color: var(--ccf-dark-grey);
        margin-top: 8px;
        line-height: 1.6;
    }

    .password-hint::before {
        content: '';
        display: inline-block;
        width: 4px;
        height: 4px;
        background: var(--ccf-bright-blue);
        border-radius: 50%;
        margin-right: 6px;
        vertical-align: middle;
    }

    .form-check {
        display: flex;
        align-items: flex-start;
        margin-bottom: 24px;
        padding: 12px;
        background: var(--ccf-light-grey);
        border-radius: 6px;
        border-left: 4px solid var(--ccf-bright-blue);
    }

    .form-check input {
        margin-top: 4px;
        margin-right: 12px;
        cursor: pointer;
        width: 18px;
        height: 18px;
        accent-color: var(--ccf-bright-blue);
        flex-shrink: 0;
    }

    .form-check label {
        margin: 0;
        font-size: 13px;
        color: var(--ccf-navy);
        cursor: pointer;
        line-height: 1.5;
        font-weight: 500;
    }

    .form-check a {
        color: var(--ccf-bright-blue);
        text-decoration: none;
        font-weight: 600;
    }

    .form-check a:hover {
        text-decoration: underline;
    }

    .btn-register {
        background: linear-gradient(135deg, var(--ccf-bright-blue) 0%, var(--ccf-blue) 100%);
        color: var(--ccf-white);
        border: none;
        padding: 14px 24px;
        font-weight: 700;
        border-radius: 6px;
        width: 100%;
        cursor: pointer;
        transition: all 0.3s ease;
        font-size: 15px;
        text-transform: uppercase;
        letter-spacing: 0.6px;
        box-shadow: 0 4px 15px rgba(0, 153, 204, 0.3);
    }

    .btn-register:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(0, 153, 204, 0.5);
    }

    .btn-register:active {
        transform: translateY(0);
    }

    .alert {
        border-radius: 6px;
        margin-bottom: 20px;
        padding: 14px 16px;
        font-size: 14px;
        display: none;
        border-left: 4px solid;
    }

    .alert.show {
        display: block;
    }

    .alert-success {
        background: #ecfdf5;
        color: #065f46;
        border-left-color: #10b981;
    }

    .alert-danger {
        background: #fef2f2;
        color: #7f1d1d;
        border-left-color: #ef4444;
    }

    .alert-warning {
        background: #fefce8;
        color: #713f12;
        border-left-color: #eab308;
    }

    .login-link {
        text-align: center;
        margin-top: 28px;
        font-size: 13px;
        color: var(--ccf-dark-grey);
        font-weight: 500;
    }

    .login-link a {
        color: var(--ccf-bright-blue);
        text-decoration: none;
        font-weight: 700;
    }

    .login-link a:hover {
        text-decoration: underline;
    }

    .validation-summary {
        margin-bottom: 20px;
    }

    @media (max-width: 768px) {
        .reg-wrapper {
            flex-direction: column;
        }

        .reg-branding {
            min-width: 100%;
            padding: 40px 30px;
        }

        .reg-card {
            padding: 35px 25px;
        }

        .reg-branding h2,
        .reg-branding .brand-highlight {
            font-size: 28px;
        }

        .reg-header h1 {
            font-size: 24px;
        }
    }
</style>

<div class="registration-container">
    <div class="reg-wrapper">
        <!-- Left: Branding -->
        <div class="reg-branding">
            <h2>CODE & CO.<span class="brand-highlight">FALCON</span></h2>
            <p>Forte Event Hire Management System</p>
            <p style="font-size: 12px; opacity: 0.75; margin-top: 8px;">Professional event management platform</p>
            <div class="reg-badge">Modern • Reliable • Fast</div>
        </div>

        <!-- Right: Registration Form -->
        <div class="reg-card">
            <div class="reg-header">
                <h1>Create Account</h1>
                <p>Join Forte Event Hire and start managing events today</p>
            </div>

            <asp:Panel ID="pnlForm" runat="server">
                <!-- Success Alert -->
                <asp:Label ID="lblSuccess" runat="server" CssClass="alert alert-success" Visible="false" />

                <!-- Error Alert -->
                <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger" Visible="false" />

                <!-- Validation Summary -->
                <asp:ValidationSummary ID="valSummary" runat="server" 
                    CssClass="alert alert-warning validation-summary" 
                    DisplayMode="BulletList" 
                    Visible="false" />

                <!-- Full Name -->
                <div class="form-group">
                    <label for="txtFullName">Full Name *</label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="John Doe" />
                    <asp:RequiredFieldValidator ID="rfvFullName" runat="server" 
                        ControlToValidate="txtFullName"
                        ErrorMessage="Full name is required"
                        CssClass="invalid-feedback"
                        Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revFullName" runat="server"
                        ControlToValidate="txtFullName"
                        ValidationExpression="^[a-zA-Z\s]{3,}$"
                        ErrorMessage="Name must contain only letters and spaces (minimum 3 characters)"
                        CssClass="invalid-feedback"
                        Display="Dynamic" />
                </div>

                <!-- Email -->
                <div class="form-group">
                    <label for="txtEmail">Email Address *</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="you@example.com" />
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                        ControlToValidate="txtEmail"
                        ErrorMessage="Email is required"
                        CssClass="invalid-feedback"
                        Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revEmail" runat="server"
                        ControlToValidate="txtEmail"
                        ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                        ErrorMessage="Please enter a valid email address"
                        CssClass="invalid-feedback"
                        Display="Dynamic" />
                </div>

                <!-- Phone -->
                <div class="form-group">
                    <label for="txtPhone">Phone Number</label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" TextMode="Phone" placeholder="+27 123 456 7890" />
                    <asp:RegularExpressionValidator ID="revPhone" runat="server"
                        ControlToValidate="txtPhone"
                        ValidationExpression="^[\+]?[0-9]{10,}$"
                        ErrorMessage="Phone must be at least 10 digits"
                        CssClass="invalid-feedback"
                        Display="Dynamic" />
                </div>

                <!-- Password -->
                <div class="form-group">
                    <label for="txtPassword">Password *</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Create a strong password" />
                    <div class="password-strength">
                        <div id="passwordMeter" class="password-strength-meter"></div>
                    </div>
                    <div class="password-hint">
                        Minimum 8 characters, uppercase, lowercase, and number
                    </div>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                        ControlToValidate="txtPassword"
                        ErrorMessage="Password is required"
                        CssClass="invalid-feedback"
                        Display="Dynamic" />
                    <asp:CustomValidator ID="cvPassword" runat="server"
                        ControlToValidate="txtPassword"
                        OnServerValidate="ValidatePassword"
                        ErrorMessage="Password does not meet requirements (8+ chars with uppercase, lowercase, and number)"
                        CssClass="invalid-feedback"
                        Display="Dynamic" />
                </div>

                <!-- Confirm Password -->
                <div class="form-group">
                    <label for="txtConfirmPassword">Confirm Password *</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Re-enter password" />
                    <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server"
                        ControlToValidate="txtConfirmPassword"
                        ErrorMessage="Please confirm your password"
                        CssClass="invalid-feedback"
                        Display="Dynamic" />
                    <asp:CompareValidator ID="cvConfirmPassword" runat="server"
                        ControlToCompare="txtPassword"
                        ControlToValidate="txtConfirmPassword"
                        Operator="Equal"
                        ErrorMessage="Passwords do not match"
                        CssClass="invalid-feedback"
                        Display="Dynamic" />
                </div>

                <!-- Terms & Conditions -->
                <div class="form-check">
                    <asp:CheckBox ID="chkTerms" runat="server" />
                    <label for="chkTerms">
                        I agree to the <a href="/Terms" target="_blank">Terms & Conditions</a> and <a href="/Privacy" target="_blank">Privacy Policy</a>
                    </label>
                </div>

                <!-- Submit Button -->
                <asp:Button ID="btnRegister" runat="server" Text="Create Account" CssClass="btn-register" OnClick="BtnRegister_Click" />
            </asp:Panel>

            <div class="login-link">
                Already have an account? <a href="Login.aspx">Sign in here</a>
            </div>
        </div>
    </div>
</div>

<script>
    // Password strength meter
    document.getElementById('<%= txtPassword.ClientID %>').addEventListener('keyup', function() {
        const password = this.value;
        const meter = document.getElementById('passwordMeter');
        let strength = 0;

        if (password.length >= 8) strength++;
        if (/[A-Z]/.test(password)) strength++;
        if (/[a-z]/.test(password)) strength++;
        if (/[0-9]/.test(password)) strength++;

        meter.className = 'password-strength-meter';
        
        if (strength <= 1) {
            meter.classList.add('weak');
        } else if (strength === 2 || strength === 3) {
            meter.classList.add('fair');
        } else if (strength === 4) {
            meter.classList.add('strong');
        }
    });

    // Show validation summary if there are validation errors
    if (document.querySelectorAll('.invalid-feedback:visible').length > 0) {
        const summary = document.getElementById('<%= valSummary.ClientID %>');
        if (summary) summary.style.display = 'block';
    }
</script>
</asp:Content>


