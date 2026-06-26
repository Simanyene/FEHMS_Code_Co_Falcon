<%@ Page Title="" Language="C#" MasterPageFile="~/Presentation/Site1.Master" AutoEventWireup="true" CodeBehind="CustomerDashboard.aspx.cs" Inherits="FEHMS_Code_Co_Falcon.Presentation.WebForm4" %>
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
        background: var(--ccf-navy);
    }

    .dashboard-header {
        background: linear-gradient(135deg, var(--ccf-navy) 0%, #0a1f2e 100%);
        color: white;
        padding: 40px 0;
        margin-bottom: 40px;
        border-bottom: 4px solid var(--ccf-bright-blue);
    }

    .dashboard-header h1 {
        font-size: 2.5rem;
        font-weight: 800;
        margin-bottom: 10px;
        letter-spacing: -0.5px;
    }

    .dashboard-header p {
        font-size: 1rem;
        opacity: 0.9;
        margin: 0;
    }

    .dashboard-wrapper {
        background: var(--ccf-white);
        border-radius: 10px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        overflow: hidden;
    }

    /* TABS STYLING */
    .nav-pills {
        background: var(--ccf-navy);
        padding: 0;
        margin: 0;
        border-radius: 0;
        border-bottom: 2px solid #e5e7eb;
        flex-wrap: nowrap;
        overflow-x: auto;
    }

    .nav-pills .nav-link {
        color: var(--ccf-dark-grey);
        font-weight: 600;
        border-radius: 0;
        border-bottom: 4px solid transparent;
        padding: 16px 24px;
        margin: 0;
        white-space: nowrap;
        transition: all 0.3s ease;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        font-size: 0.9rem;
    }

    .nav-pills .nav-link:hover {
        background: rgba(0, 184, 230, 0.1);
        color: var(--ccf-bright-blue);
    }

    .nav-pills .nav-link.active {
        background: transparent;
        color: var(--ccf-bright-blue);
        border-bottom-color: var(--ccf-bright-blue);
    }

    .tab-content {
        padding: 40px;
    }

    .tab-pane {
        animation: fadeIn 0.3s ease;
    }

    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }

    /* HOME TAB */
    .dashboard-cards {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 24px;
        margin-bottom: 40px;
    }

    .stat-box {
        background: linear-gradient(135deg, var(--ccf-bright-blue) 0%, var(--ccf-blue) 100%);
        color: white;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 4px 15px rgba(0, 153, 204, 0.2);
    }

    .stat-box h3 {
        font-size: 2.2rem;
        font-weight: 800;
        margin: 0 0 8px 0;
    }

    .stat-box p {
        margin: 0;
        opacity: 0.9;
        font-weight: 500;
    }

    .recent-events {
        margin-top: 30px;
    }

    .event-item {
        background: var(--ccf-light-grey);
        padding: 20px;
        border-radius: 8px;
        border-left: 4px solid var(--ccf-bright-blue);
        margin-bottom: 15px;
        transition: all 0.3s ease;
    }

    .event-item:hover {
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        transform: translateX(4px);
    }

    .event-item h4 {
        color: var(--ccf-navy);
        margin: 0 0 8px 0;
        font-weight: 700;
    }

    .event-item p {
        color: var(--ccf-medium-grey);
        margin: 4px 0;
        font-size: 0.9rem;
    }

    .event-badge {
        display: inline-block;
        background: var(--ccf-bright-blue);
        color: white;
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 600;
        margin-top: 10px;
    }

    /* PROFILE TAB */
    .profile-section {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 30px;
    }

    .profile-avatar {
        text-align: center;
        padding: 30px;
        background: var(--ccf-light-grey);
        border-radius: 8px;
        grid-column: 1 / -1;
    }

    .avatar-circle {
        width: 120px;
        height: 120px;
        background: linear-gradient(135deg, var(--ccf-bright-blue) 0%, var(--ccf-blue) 100%);
        border-radius: 50%;
        margin: 0 auto 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 3rem;
        color: white;
    }

    .profile-avatar h2 {
        color: var(--ccf-navy);
        margin: 0 0 5px 0;
    }

    .profile-avatar p {
        color: var(--ccf-medium-grey);
        margin: 0;
    }

    .form-group {
        margin-bottom: 20px;
    }

    .form-group label {
        display: block;
        color: var(--ccf-navy);
        font-weight: 600;
        margin-bottom: 8px;
        font-size: 0.9rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .form-group input,
    .form-group textarea {
        width: 100%;
        padding: 12px 14px;
        border: 2px solid #e5e7eb;
        border-radius: 6px;
        font-family: inherit;
        font-size: 0.95rem;
        transition: all 0.3s ease;
    }

    .form-group input:focus,
    .form-group textarea:focus {
        outline: none;
        border-color: var(--ccf-bright-blue);
        box-shadow: 0 0 0 4px rgba(0, 184, 230, 0.1);
    }

    .btn-update {
        background: linear-gradient(135deg, var(--ccf-bright-blue) 0%, var(--ccf-blue) 100%);
        color: white;
        padding: 12px 32px;
        border: none;
        border-radius: 6px;
        font-weight: 700;
        cursor: pointer;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(0, 153, 204, 0.3);
    }

    .btn-update:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(0, 184, 230, 0.5);
    }

    /* CATEGORIES TAB */
    .categories-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
        gap: 20px;
    }

    .category-card {
        background: var(--ccf-light-grey);
        padding: 25px;
        border-radius: 8px;
        text-align: center;
        cursor: pointer;
        transition: all 0.3s ease;
        border: 2px solid transparent;
    }

    .category-card:hover {
        border-color: var(--ccf-bright-blue);
        transform: translateY(-6px);
        box-shadow: 0 8px 20px rgba(0, 184, 230, 0.2);
    }

    .category-icon {
        font-size: 2.5rem;
        margin-bottom: 12px;
        display: block;
    }

    .category-card h3 {
        color: var(--ccf-navy);
        margin: 0 0 8px 0;
        font-weight: 700;
    }

    .category-card p {
        color: var(--ccf-medium-grey);
        margin: 0;
        font-size: 0.9rem;
    }

    /* BOOKING TAB */
    .booking-list {
        display: grid;
        gap: 20px;
    }

    .booking-card {
        background: var(--ccf-light-grey);
        padding: 25px;
        border-radius: 8px;
        border-left: 5px solid var(--ccf-bright-blue);
    }

    .booking-header {
        display: flex;
        justify-content: space-between;
        align-items: start;
        margin-bottom: 15px;
    }

    .booking-header h3 {
        color: var(--ccf-navy);
        margin: 0;
        font-weight: 700;
    }

    .booking-status {
        display: inline-block;
        padding: 6px 14px;
        border-radius: 20px;
        font-size: 0.85rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .booking-status.active {
        background: #d1fae5;
        color: #065f46;
    }

    .booking-status.pending {
        background: #fef3c7;
        color: #92400e;
    }

    .booking-status.completed {
        background: #dbeafe;
        color: #0c2d6b;
    }

    .booking-details {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 15px;
        color: var(--ccf-medium-grey);
        font-size: 0.95rem;
    }

    .booking-detail-item strong {
        color: var(--ccf-navy);
        display: block;
        margin-bottom: 3px;
        font-weight: 600;
    }

    .booking-actions {
        display: flex;
        gap: 10px;
        margin-top: 15px;
    }

    .btn-action {
        padding: 8px 16px;
        border: 2px solid var(--ccf-bright-blue);
        background: transparent;
        color: var(--ccf-bright-blue);
        border-radius: 4px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        font-size: 0.85rem;
        text-transform: uppercase;
        letter-spacing: 0.4px;
    }

    .btn-action:hover {
        background: var(--ccf-bright-blue);
        color: white;
    }

    /* ORDER HISTORY TAB */
    .orders-table {
        width: 100%;
        border-collapse: collapse;
    }

    .orders-table thead {
        background: var(--ccf-light-grey);
    }

    .orders-table th {
        color: var(--ccf-navy);
        font-weight: 700;
        padding: 15px;
        text-align: left;
        border-bottom: 2px solid #e5e7eb;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        font-size: 0.85rem;
    }

    .orders-table td {
        padding: 15px;
        border-bottom: 1px solid #e5e7eb;
        color: var(--ccf-medium-grey);
    }

    .orders-table tbody tr:hover {
        background: var(--ccf-light-grey);
    }

    .order-id {
        color: var(--ccf-bright-blue);
        font-weight: 600;
    }

    /* RESPONSIVE */
    @media (max-width: 768px) {
        .dashboard-header h1 {
            font-size: 1.8rem;
        }

        .profile-section {
            grid-template-columns: 1fr;
        }

        .dashboard-cards {
            grid-template-columns: 1fr;
        }

        .nav-pills {
            flex-wrap: wrap;
        }

        .nav-pills .nav-link {
            padding: 12px 16px;
            font-size: 0.8rem;
        }

        .tab-content {
            padding: 25px;
        }

        .booking-header {
            flex-direction: column;
            gap: 10px;
        }

        .booking-details {
            grid-template-columns: 1fr;
        }

        .categories-grid {
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
        }
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <div>

           <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                 <li class="nav-item" role="presentation">
                 <button class="nav-link active" id="pills-profile-tab" data-bs-toggle="pill" data-bs-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile" aria-selected="true">Profile</button>
           </li>

           <li class="nav-item" role="presentation">
                <button class="nav-link" id="pills-catergories-tab" data-bs-toggle="pill" data-bs-target="#pills-catergories" type="button" role="tab" aria-controls="pills-catergories" aria-selected="false">Catergories</button>
           </li>

           <li class="nav-item" role="presentation">
                <button class="nav-link" id="pills-orderHistory-tab" data-bs-toggle="pill" data-bs-target="#pills-orderHistory" type="button" role="tab" aria-controls="pills-orderHistory" aria-selected="false">Order History</button>
           </li>

           <li class="nav-item" role="presentation">
                <button class="nav-link" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-home" type="button" role="tab" aria-controls="pills-home" aria-selected="false">Home</button>
           </li>

           <li class="nav-item" role="presentation">
                <button class="nav-link" id="pills-booking-tab" data-bs-toggle="pill" data-bs-target="#pills-booking" type="button" role="tab" aria-controls="pills-booking" aria-selected="false">Booking</button>
           </li>

           <li class="nav-item" role="presentation">
                <button class="nav-link" id="pills-LogOut-tab" data-bs-toggle="pill" data-bs-target="#pills-Logout" type="button" role="tab" aria-controls="pills-Logout" aria-selected="false">LogOut</button>
           </li>
  
        </ul>
<div class="tab-content" id="pills-tabContent">
  <div class="tab-pane fade show active" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab" tabindex="0">...</div>
  <div class="tab-pane fade" id="pills-categories" role="tabpanel" aria-labelledby="pills-categories-tab" tabindex="0">...</div>
  <div class="tab-pane fade" id="pills-orderHistory" role="tabpanel" aria-labelledby="pills-orderHistory-tab" tabindex="0">...</div>
  <div class="tab-pane fade" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab" tabindex="0">...</div>
  <div class="tab-pane fade" id="pills-booking" role="tabpanel" aria-labelledby="pills-booking-tab" tabindex="0">...</div>
  <div class="tab-pane fade" id="pills-Logout" role="tabpanel" aria-labelledby="pills-Logout-tab" tabindex="0">...</div>

</div>
        </div>
</asp:Content>
