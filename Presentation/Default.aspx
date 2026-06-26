<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/Site1.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="FEHMS_Code_Co_Falcon.Presentation.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <style>
    :root {
        --ccf-navy: #0F2438;
        --ccf-blue: #0099CC;
        --ccf-bright-blue: #00B8E6;
        --ccf-white: #FFFFFF;
        --ccf-light-grey: #F0F4F8;
        --ccf-dark-grey: #4A5568;
        --ccf-medium-grey: #6B7280;
    }

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    /* HERO SECTION */
    .hero-section {
        background: linear-gradient(135deg, var(--ccf-navy) 0%, #0a1f2e 50%, #142e42 100%);
        color: white;
        padding: 120px 0 100px;
        text-align: center;
        margin: -40px 0 0 0;
        position: relative;
        overflow: hidden;
    }

    .hero-section::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: 
            linear-gradient(135deg, transparent 0%, rgba(0, 184, 230, 0.08) 100%),
            linear-gradient(45deg, transparent 30%, rgba(0, 153, 204, 0.05) 70%);
        pointer-events: none;
    }

    .hero-section::after {
        content: '';
        position: absolute;
        bottom: -200px;
        right: -200px;
        width: 600px;
        height: 600px;
        background: linear-gradient(135deg, rgba(0, 184, 230, 0.1) 0%, transparent 70%);
        border-radius: 50%;
        pointer-events: none;
    }

    .hero-content {
        position: relative;
        z-index: 2;
        max-width: 850px;
        margin: 0 auto;
        padding: 0 20px;
    }

    .hero-title {
        font-size: 3.8rem;
        font-weight: 800;
        margin-bottom: 20px;
        color: var(--ccf-white);
        letter-spacing: -1px;
    }

    .hero-title .highlight {
        color: var(--ccf-bright-blue);
        display: block;
    }

    .hero-subtitle {
        font-size: 1.25rem;
        margin-bottom: 40px;
        opacity: 0.9;
        line-height: 1.8;
        color: rgba(255, 255, 255, 0.9);
    }

    .hero-cta {
        display: flex;
        gap: 20px;
        justify-content: center;
        flex-wrap: wrap;
    }

    .btn-cta {
        padding: 16px 36px;
        font-size: 1rem;
        font-weight: 700;
        border-radius: 6px;
        transition: all 0.3s ease;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 10px;
        cursor: pointer;
        border: none;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .btn-primary-cta {
        background: linear-gradient(135deg, var(--ccf-bright-blue) 0%, var(--ccf-blue) 100%);
        color: var(--ccf-white);
        box-shadow: 0 6px 20px rgba(0, 153, 204, 0.4);
    }

    .btn-primary-cta:hover {
        transform: translateY(-3px);
        box-shadow: 0 12px 35px rgba(0, 184, 230, 0.6);
    }

    .btn-secondary-cta {
        background-color: transparent;
        color: white;
        border: 2px solid white;
        box-shadow: none;
    }

    .btn-secondary-cta:hover {
        background-color: white;
        color: var(--ccf-navy);
        transform: translateY(-3px);
    }

    /* BADGE */
    .badge-ccf {
        display: inline-block;
        background: rgba(0, 184, 230, 0.15);
        border: 2px solid var(--ccf-bright-blue);
        color: var(--ccf-bright-blue);
        padding: 10px 18px;
        border-radius: 4px;
        font-size: 0.85rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 1px;
        margin-bottom: 24px;
    }

    /* FEATURES SECTION */
    .features-section {
        padding: 80px 0;
        background-color: var(--ccf-white);
    }

    .section-title {
        text-align: center;
        font-size: 2.8rem;
        margin-bottom: 60px;
        color: var(--ccf-navy);
        font-weight: 800;
        position: relative;
        padding-bottom: 0;
        letter-spacing: -0.5px;
    }

    .section-title::after {
        content: '';
        position: absolute;
        width: 100px;
        height: 5px;
        background: linear-gradient(90deg, var(--ccf-bright-blue) 0%, var(--ccf-blue) 100%);
        bottom: -20px;
        left: 50%;
        transform: translateX(-50%);
        border-radius: 3px;
    }

    .feature-card {
        background: white;
        border-radius: 8px;
        padding: 45px 35px;
        text-align: center;
        transition: all 0.3s ease;
        border: 2px solid #e5e7eb;
        height: 100%;
        position: relative;
        overflow: hidden;
    }

    .feature-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: linear-gradient(90deg, var(--ccf-bright-blue) 0%, var(--ccf-blue) 100%);
        transform: scaleX(0);
        transform-origin: left;
        transition: transform 0.3s ease;
    }

    .feature-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 20px 50px rgba(0, 153, 204, 0.15);
        border-color: var(--ccf-bright-blue);
    }

    .feature-card:hover::before {
        transform: scaleX(1);
    }

    .feature-icon {
        font-size: 3.5rem;
        margin-bottom: 25px;
        display: block;
        transition: transform 0.3s ease;
    }

    .feature-card:hover .feature-icon {
        transform: scale(1.1);
    }

    .feature-card h3 {
        font-size: 1.5rem;
        margin-bottom: 15px;
        color: var(--ccf-navy);
        font-weight: 700;
    }

    .feature-card p {
        color: var(--ccf-medium-grey);
        line-height: 1.7;
        font-size: 0.95rem;
    }

    /* HOW IT WORKS SECTION */
    .how-section {
        padding: 80px 0;
        background: linear-gradient(135deg, var(--ccf-light-grey) 0%, #ffffff 100%);
    }

    .steps {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
        gap: 40px;
        margin-top: 60px;
    }

    .step {
        position: relative;
        padding: 40px 35px;
        background: white;
        border-radius: 8px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        border-left: 5px solid var(--ccf-bright-blue);
        transition: all 0.3s ease;
    }

    .step:hover {
        transform: translateY(-8px);
        box-shadow: 0 12px 35px rgba(0, 153, 204, 0.2);
    }

    .step-number {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 60px;
        height: 60px;
        background: linear-gradient(135deg, var(--ccf-bright-blue) 0%, var(--ccf-blue) 100%);
        color: white;
        border-radius: 50%;
        font-weight: 800;
        font-size: 1.8rem;
        margin-bottom: 20px;
        box-shadow: 0 4px 15px rgba(0, 153, 204, 0.3);
    }

    .step h4 {
        color: var(--ccf-navy);
        margin-bottom: 12px;
        font-size: 1.2rem;
        font-weight: 700;
    }

    .step p {
        color: var(--ccf-medium-grey);
        font-size: 0.95rem;
        line-height: 1.7;
    }

    /* STATS SECTION */
    .stats-section {
        padding: 80px 0;
        background: linear-gradient(135deg, var(--ccf-navy) 0%, #0a2540 100%);
        color: white;
        text-align: center;
        position: relative;
        overflow: hidden;
    }

    .stats-section::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -50%;
        width: 600px;
        height: 600px;
        background: linear-gradient(135deg, rgba(0, 184, 230, 0.1) 0%, transparent 70%);
        border-radius: 50%;
        pointer-events: none;
    }

    .stat-card {
        padding: 50px 30px;
        position: relative;
        z-index: 2;
    }

    .stat-number {
        font-size: 3.2rem;
        font-weight: 800;
        color: var(--ccf-bright-blue);
        margin-bottom: 15px;
        letter-spacing: -1px;
    }

    .stat-label {
        font-size: 1.1rem;
        opacity: 0.9;
        font-weight: 600;
    }

    /* CTA BANNER SECTION */
    .cta-banner {
        padding: 80px 0;
        background: white;
        text-align: center;
    }

    .cta-banner h2 {
        font-size: 2.8rem;
        margin-bottom: 25px;
        color: var(--ccf-navy);
        font-weight: 800;
        letter-spacing: -0.5px;
    }

    .cta-banner p {
        font-size: 1.1rem;
        color: var(--ccf-medium-grey);
        margin-bottom: 40px;
        max-width: 650px;
        margin-left: auto;
        margin-right: auto;
        line-height: 1.8;
    }

    .cta-banner-buttons {
        display: flex;
        gap: 20px;
        justify-content: center;
        flex-wrap: wrap;
    }

    .btn-banner {
        padding: 14px 32px;
        font-size: 1rem;
        font-weight: 700;
        border-radius: 6px;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        cursor: pointer;
        border: none;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        transition: all 0.3s ease;
    }

    .btn-banner-primary {
        background: linear-gradient(135deg, var(--ccf-bright-blue) 0%, var(--ccf-blue) 100%);
        color: white;
        box-shadow: 0 6px 20px rgba(0, 153, 204, 0.4);
    }

    .btn-banner-primary:hover {
        transform: translateY(-3px);
        box-shadow: 0 12px 35px rgba(0, 184, 230, 0.6);
    }

    .btn-banner-secondary {
        background: transparent;
        color: var(--ccf-bright-blue);
        border: 2px solid var(--ccf-bright-blue);
    }

    .btn-banner-secondary:hover {
        background: var(--ccf-bright-blue);
        color: white;
        transform: translateY(-3px);
    }

    /* RESPONSIVE */
    @media (max-width: 1024px) {
        .hero-title {
            font-size: 2.8rem;
        }

        .section-title {
            font-size: 2.2rem;
        }

        .cta-banner h2 {
            font-size: 2.2rem;
        }
    }

    @media (max-width: 768px) {
        .hero-section {
            padding: 80px 0 60px;
        }

        .hero-title {
            font-size: 2.2rem;
        }

        .hero-subtitle {
            font-size: 1rem;
            margin-bottom: 30px;
        }

        .section-title {
            font-size: 1.8rem;
            margin-bottom: 40px;
        }

        .hero-cta,
        .cta-banner-buttons {
            flex-direction: column;
            gap: 15px;
        }

        .btn-cta,
        .btn-banner {
            width: 100%;
            justify-content: center;
        }

        .steps {
            gap: 25px;
        }

        .stat-number {
            font-size: 2.2rem;
        }

        .stat-card {
            padding: 30px 15px;
        }

        .feature-card {
            padding: 30px 20px;
        }

        .cta-banner p {
            font-size: 1rem;
        }
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <!-- HERO SECTION -->
 <section class="hero-section">
     <div class="hero-content">
         <div class="logo-section">
    <div class="logo-wrapper">
         <img src="/Images/logo.png" alt="Code & Co. Falcon Logo" />
    </div> 
             </div> 
         <span class="badge-ccf">Built by Code & Co. Falcon</span>
         <h1 class="hero-title">Forte Event Hire</h1>
         <p class="hero-subtitle">
             Your ultimate platform for managing, booking, and hosting unforgettable events.
             <br />
             Connect with top event professionals in your area.
         </p>
         <div class="hero-cta">
             <a href="~/Presentation/Registration.aspx" runat="server" class="btn-cta btn-primary-cta">
                 <i class="fas fa-rocket"></i> Get Started Now
             </a>
             <a href="#features" class="btn-cta btn-secondary-cta">
                 <i class="fas fa-play-circle"></i> Learn More
             </a>
         </div>
     </div>
 </section>

 <!-- FEATURES SECTION -->
 <section class="features-section" id="features">
     <div class="container">
         <h2 class="section-title">Why Choose Forte Event Hire?</h2>
         
         <div class="row">
             <div class="col-md-4 mb-4">
                 <div class="feature-card">
                     <span class="feature-icon">🎯</span>
                     <h3>Easy Booking</h3>
                     <p>
                         Browse and book event services with just a few clicks. 
                         Our intuitive platform makes event planning simple and stress-free.
                     </p>
                 </div>
             </div>
             <div class="col-md-4 mb-4">
                 <div class="feature-card">
                     <span class="feature-icon">⭐</span>
                     <h3>Trusted Vendors</h3>
                     <p>
                         Access verified event professionals and service providers. 
                         Read reviews and ratings from real customers.
                     </p>
                 </div>
             </div>
             <div class="col-md-4 mb-4">
                 <div class="feature-card">
                     <span class="feature-icon">💬</span>
                     <h3>24/7 Support</h3>
                     <p>
                         Our dedicated support team is here to help you 24/7. 
                         Get answers and resolve issues in minutes.
                     </p>
                 </div>
             </div>
         </div>

         <div class="row mt-4">
             <div class="col-md-4 mb-4">
                 <div class="feature-card">
                     <span class="feature-icon">🔒</span>
                     <h3>Secure Payments</h3>
                     <p>
                         Safe and secure payment processing. 
                         Your financial information is always protected.
                     </p>
                 </div>
             </div>
             <div class="col-md-4 mb-4">
                 <div class="feature-card">
                     <span class="feature-icon">📱</span>
                     <h3>Mobile Friendly</h3>
                     <p>
                         Manage your events on the go. 
                         Full mobile support for iOS and Android devices.
                     </p>
                 </div>
             </div>
             <div class="col-md-4 mb-4">
                 <div class="feature-card">
                     <span class="feature-icon">🎨</span>
                     <h3>Customizable</h3>
                     <p>
                         Tailor services to your specific needs. 
                         Create the perfect event experience.
                     </p>
                 </div>
             </div>
         </div>
     </div>
 </section>

 <!-- HOW IT WORKS SECTION -->
 <section class="how-section">
     <div class="container">
         <h2 class="section-title">How It Works</h2>
         
         <div class="steps">
             <div class="step">
                 <div class="step-number">1</div>
                 <h4><i class="fas fa-user-plus"></i> Create Account</h4>
                 <p>Sign up in seconds and create your Forte Event Hire account with your email.</p>
             </div>
             <div class="step">
                 <div class="step-number">2</div>
                 <h4><i class="fas fa-search"></i> Browse Services</h4>
                 <p>Explore our wide range of event services and vendors near you.</p>
             </div>
             <div class="step">
                 <div class="step-number">3</div>
                 <h4><i class="fas fa-calendar"></i> Book Event</h4>
                 <p>Select your preferred date and confirm your booking with ease.</p>
             </div>
             <div class="step">
                 <div class="step-number">4</div>
                 <h4><i class="fas fa-party-horn"></i> Enjoy Event</h4>
                 <p>Sit back and enjoy your perfectly planned event with professionals!</p>
             </div>
         </div>
     </div>
 </section>

 <!-- STATS SECTION -->
 <section class="stats-section">
     <div class="container">
         <div class="row">
             <div class="col-md-3 col-sm-6 stat-card">
                 <div class="stat-number">1000+</div>
                 <div class="stat-label">Events Hosted</div>
             </div>
             <div class="col-md-3 col-sm-6 stat-card">
                 <div class="stat-number">500+</div>
                 <div class="stat-label">Verified Vendors</div>
             </div>
             <div class="col-md-3 col-sm-6 stat-card">
                 <div class="stat-number">5000+</div>
                 <div class="stat-label">Happy Customers</div>
             </div>
             <div class="col-md-3 col-sm-6 stat-card">
                 <div class="stat-number">4.9★</div>
                 <div class="stat-label">Average Rating</div>
             </div>
         </div>
     </div>
 </section>

 <!-- CTA BANNER -->
 <section class="cta-banner">
     <div class="container">
         <h2>Ready to Plan Your Next Event?</h2>
         <p>
             Join thousands of satisfied customers who have made their events unforgettable 
             with Forte Event Hire. Get started today!
         </p>
         <div>
             <a href="~/Presentation/Registration.aspx" runat="server" class="btn btn-primary btn-lg">
                 <i class="fas fa-sign-in-alt"></i> Sign Up Now
             </a>
             <a href="~/Contact.aspx" runat="server" class="btn btn-outline-primary btn-lg ms-3">
                 <i class="fas fa-envelope"></i> Get in Touch
             </a>
         </div>
     </div>
 </section>
</asp:Content>
